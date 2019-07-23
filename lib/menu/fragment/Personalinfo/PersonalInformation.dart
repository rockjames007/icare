import 'package:flutter/material.dart';
import 'package:icare/menu/fragment/Personalinfo/info/info.dart';
import 'package:icare/menu/fragment/Personalinfo/Qualification/qualification.dart';
import 'package:icare/menu/fragment/Personalinfo/document/Document.dart';
import 'package:icare/menu/fragment/Personalinfo/bankDetails/BankDetails.dart';
import 'package:icare/menu/fragment/Personalinfo/fixedAsset/FixedAsset.dart';
import 'package:icare/menu/fragment/Personalinfo/family/Family.dart';
import 'package:icare/menu/fragment/Personalinfo/TrainingDetails/TrainingDetailsFragment.dart';
void main() => runApp(PersonalInformation());
class PersonalInformation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserInfoState();
  }
}

class _UserInfoState extends State<PersonalInformation>
{
  int _currentIndex = 0;
  final List<Widget> _children = [PlaceholderWidget(0),
  PlaceholderWidget(1),
  PlaceholderWidget(2),
  PlaceholderWidget(3),
  PlaceholderWidget(4),
  PlaceholderWidget(5),
  PlaceholderWidget(6),
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar
        (
        type: BottomNavigationBarType.fixed,// new
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, //
        items:
        [
          BottomNavigationBarItem
            (
            icon: new Icon(Icons.info),
            title: new Text('Basic Info', textScaleFactor: 0.5,),
          ),
          BottomNavigationBarItem
            (
            icon: new Icon(Icons.school),
            title: new Text('Qualification', textScaleFactor: 0.5,),
          ),
          BottomNavigationBarItem
            (
              icon: Icon(Icons.picture_as_pdf),
              title: Text('Document', textScaleFactor: 0.5,)
          ),
          BottomNavigationBarItem
            (
              icon: Icon(Icons.account_balance),
              title: Text('Bank Details', textScaleFactor: 0.5,)
          ),
          BottomNavigationBarItem
            (
              icon: Icon(Icons.verified_user),
              title: Text('Fixed Asset', textScaleFactor: 0.5,)
          ),
          BottomNavigationBarItem
            (
              icon: Icon(Icons.people),
              title: Text('Family', textScaleFactor: 0.5,)
          ),
          BottomNavigationBarItem
            (
              icon: Icon(Icons.assignment),
              title: Text('Training Details', textScaleFactor: 0.5,)
          ),
        ],

      ),
    ) ;
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
class PlaceholderWidget extends StatelessWidget {
  int _selectedBottomIndex;
  PlaceholderWidget(int pos) {
    _selectedBottomIndex=pos;
  }
  @override
  Widget build(BuildContext context) {

    switch (_selectedBottomIndex) {
      case 0:
        return new Info();
      case 1:
        return new Qualification();
      case 2:
        return new Document();
      case 3:
        return new BankDetails();
      case 4:
        return new FixedAsset();
      case 5:
        return new Family();
      case 6:
        return new TrainingDetailsFragment();
    }
    }
  }