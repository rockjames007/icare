import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
Future<Post> fetchPost() async {
  final response =
  await http.get('https://icanhazdadjoke.com/',headers:{"Accept":"application/json"});

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
class Post {
  final String joke;

  Post({this.joke});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      joke: json['joke'],
    );
  }
}

void main() => runApp(PayStatement());

class PayStatement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Post>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.joke,style: TextStyle(color: Colors.red),);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}



final List<CardViewModel> demoCards = [
  new CardViewModel(
    joke:"hello"
  ),
  new CardViewModel(
      joke:"hamma"
  )
];

class CardViewModel {
  final String joke;
  CardViewModel({
    this.joke
  });
}