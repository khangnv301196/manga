import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget{
  ProfileTab({Key key}) : super(key:key);
  @override
  _ProfileTabState createState() {
    // TODO: implement createState
    return _ProfileTabState();
  }
}

class _ProfileTabState extends State<ProfileTab>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Text('New Omega'),
      ),
      );
  }

}