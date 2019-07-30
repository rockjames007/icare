import 'dart:math';
import 'dart:ui' show lerpDouble;
import 'dart:async';
import 'package:icare/menu/fun/card_data.dart';
import 'package:flutter/material.dart';

final List<CardViewModel> demoCards = [];

class FunActivity extends StatefulWidget {
  @override
  _FunActivityState createState() => new _FunActivityState();
}

Future sleep1() {
  return new Future.delayed(const Duration(seconds: 2), () => "2");
}

Future<Post> getProjectDetails() async {
  Post pt = await fetchPost();
  CardViewModel cardViewModel = new CardViewModel();
  cardViewModel.joke = pt.joke;
  demoCards.add(cardViewModel);
}

class _FunActivityState extends State<FunActivity> {
  double scrollPercent = 0.0;

  @override
  void initState() {
    super.initState();
    demoCards.clear();
    for (int i = 0; i < 4; i++) getProjectDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Spacer for status bar
          new Container(
            width: double.infinity,
            height: 20.0,
          ),

          // Cards
          new FutureBuilder<Post>(
              future: fetchPost(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new Expanded(
                    child: new CardFlipper(
                        cards: demoCards,
                        onScroll: (double scrollPercent) {
                          setState(() {
                            this.scrollPercent = scrollPercent;
                          });
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner
                return CircularProgressIndicator();
              }),

          // Scroll Indicator
          new BottomBar(
            cardCount: demoCards.length,
            scrollPercent: scrollPercent,
          ),
        ],
      ),
    );
  }
}

class CardFlipper extends StatefulWidget {
  final List<CardViewModel> cards;
  final Function onScroll;

  CardFlipper({
    this.cards,
    this.onScroll,
  });

  @override
  _CardFlipperState createState() => new _CardFlipperState();
}

class _CardFlipperState extends State<CardFlipper>
    with TickerProviderStateMixin {
  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollController;

  @override
  void initState() {
    super.initState();

    finishScrollController = new AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          scrollPercent = lerpDouble(
              finishScrollStart, finishScrollEnd, finishScrollController.value);
          if (widget.onScroll != null) {
            widget.onScroll(scrollPercent);
          }
        });
      })
      ..addStatusListener((AnimationStatus status) {});
  }

  void _onPanStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    final singleCardDragPercent = dragDistance / context.size.width;
    setState(() {
      scrollPercent = (startDragPercentScroll +
              (-singleCardDragPercent / widget.cards.length))
          .clamp(0.0, 1.0 - (1 / widget.cards.length));
      print('percentScroll: $scrollPercent');

      if (widget.onScroll != null) {
        widget.onScroll(scrollPercent);
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    finishScrollStart = scrollPercent;
    finishScrollEnd =
        (scrollPercent * widget.cards.length).round() / widget.cards.length;
    finishScrollController.forward(from: 0.0);
    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
      if (scrollPercent > 0.7) {
        Navigator.pop(context);
        sleep1();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FunActivity()));
      }
    });
  }

  List<Widget> _buildCards() {
    int index = -1;
    return widget.cards.map((CardViewModel viewModel) {
      ++index;
      return _buildCard(viewModel, index, widget.cards.length, scrollPercent);
    }).toList();
  }

  Matrix4 _buildCardProjection(double scrollPercent) {
    // Pre-multiplied matrix of a projection matrix and a view matrix.
    //
    // Projection matrix is a simplified perspective matrix
    // http://web.iitd.ac.in/~hegde/cad/lecture/L9_persproj.pdf
    // in the form of
    // [[1.0, 0.0, 0.0, 0.0],
    //  [0.0, 1.0, 0.0, 0.0],
    //  [0.0, 0.0, 1.0, 0.0],
    //  [0.0, 0.0, -perspective, 1.0]]
    //
    // View matrix is a simplified camera view matrix.
    // Basically re-scales to keep object at original size at angle = 0 at
    // any radius in the form of
    // [[1.0, 0.0, 0.0, 0.0],
    //  [0.0, 1.0, 0.0, 0.0],
    //  [0.0, 0.0, 1.0, -radius],
    //  [0.0, 0.0, 0.0, 1.0]]
    final perspective = 0.002;
    final radius = 1.0;
    final angle = scrollPercent * pi / 8;
    final horizontalTranslation = 0.0;
    Matrix4 projection = new Matrix4.identity()
      ..setEntry(0, 0, 1 / radius)
      ..setEntry(1, 1, 1 / radius)
      ..setEntry(3, 2, -perspective)
      ..setEntry(2, 3, -radius)
      ..setEntry(3, 3, perspective * radius + 1.0);

    // Model matrix by first translating the object from the origin of the world
    // by radius in the z axis and then rotating against the world.
    final rotationPointMultiplier = angle > 0.0 ? angle / angle.abs() : 1.0;
    print('Angle: $angle');
    projection *= new Matrix4.translationValues(
            horizontalTranslation + (rotationPointMultiplier * 300.0),
            0.0,
            0.0) *
        new Matrix4.rotationY(angle) *
        new Matrix4.translationValues(0.0, 0.0, radius) *
        new Matrix4.translationValues(
            -rotationPointMultiplier * 300.0, 0.0, 0.0);

    return projection;
  }

  Widget _buildCard(
    CardViewModel viewModel,
    int cardIndex,
    int cardCount,
    double scrollPercent,
  ) {
    final cardScrollPercent = scrollPercent / (1 / cardCount);
    final parallax = scrollPercent - (cardIndex / widget.cards.length);

    return new FractionalTranslation(
      translation: new Offset(cardIndex - cardScrollPercent, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Transform(
          transform: _buildCardProjection(cardScrollPercent - cardIndex),
          child: new CardModified(
            viewModel: viewModel,
            parallaxPercent: parallax,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onPanStart,
      onHorizontalDragUpdate: _onPanUpdate,
      onHorizontalDragEnd: _onPanEnd,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: _buildCards(),
      ),
    );
  }
}

class CardModified extends StatelessWidget {
  final CardViewModel viewModel;
  final double
      parallaxPercent; // [0.0, 1.0] (0.0 for all the way right, 1.0 for all the way left)

  CardModified({
    this.viewModel,
    this.parallaxPercent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Card(
          child: Center(
            child: SingleChildScrollView(
              child: ListTile(
                title: Text(
                  '${viewModel.joke}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomBar extends StatelessWidget {
  final int cardCount;
  final double scrollPercent;

  BottomBar({
    this.cardCount,
    this.scrollPercent,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      child: new Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Center(
                child: new Icon(
                  Icons.fast_rewind,
                  color: Colors.white,
                ),
              ),
            ),
            new Expanded(
              child: new Center(
                child: new Container(
                  width: double.infinity,
                  height: 5.0,
                  child: new ScrollIndicator(
                    cardCount: cardCount,
                    scrollPercent: scrollPercent,
                  ),
                ),
              ),
            ),
            new Expanded(
              child: new Center(
                child: new Icon(
                  Icons.fast_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollIndicator extends StatelessWidget {
  final int cardCount;
  final double scrollPercent;

  ScrollIndicator({
    this.cardCount,
    this.scrollPercent,
  });

  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
      painter: new ScrollIndicatorPainter(
        cardCount: cardCount,
        scrollPercent: scrollPercent,
      ),
      child: new Container(),
    );
  }
}

class ScrollIndicatorPainter extends CustomPainter {
  final int cardCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;

  ScrollIndicatorPainter({
    this.cardCount,
    this.scrollPercent,
  })  : trackPaint = new Paint()
          ..color = const Color(0xFF444444)
          ..style = PaintingStyle.fill,
        thumbPaint = new Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw track
    canvas.drawRRect(
      new RRect.fromRectAndCorners(
        new Rect.fromLTWH(
          0.0,
          0.0,
          size.width,
          size.height,
        ),
        topLeft: new Radius.circular(3.0),
        topRight: new Radius.circular(3.0),
        bottomLeft: new Radius.circular(3.0),
        bottomRight: new Radius.circular(3.0),
      ),
      trackPaint,
    );

    // Draw thumb
    final thumbWidth = size.width / cardCount;
    final thumbLeft = scrollPercent * size.width;

    Path thumbPath = new Path();
    thumbPath.addRRect(
      new RRect.fromRectAndCorners(
        new Rect.fromLTWH(
          thumbLeft,
          0.0,
          thumbWidth,
          size.height,
        ),
        topLeft: new Radius.circular(3.0),
        topRight: new Radius.circular(3.0),
        bottomLeft: new Radius.circular(3.0),
        bottomRight: new Radius.circular(3.0),
      ),
    );

    // Thumb shape
    canvas.drawPath(
      thumbPath,
      thumbPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
