import 'package:flutter/material.dart';
import 'package:manga_reader/UI/tab/hometab.dart';
import 'package:manga_reader/UI/tab/categorytab.dart';
import 'package:manga_reader/UI/tab/profiletab.dart';

class MainController extends StatefulWidget {
  @override
  MainControllerState createState() {
    // TODO: implement createState
    return MainControllerState();
  }
}

class MainControllerState extends State<MainController> {
  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');
  final Key keyThree = PageStorageKey('pageThree');
  List<Widget> _pages;
  int _currentIndex = 0;
  Widget _currentPage;
  final PageStorageBucket bucket = PageStorageBucket();

  HomeTab home;
  CategoryTab categoryTab;
  ProfileTab profileTab;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    home = HomeTab(key: keyOne);
    categoryTab = CategoryTab(key: keyTwo);
    profileTab = ProfileTab(key: keyThree);
    _pages = [home, categoryTab, profileTab];
    _currentPage = home;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageStorage(bucket: bucket, child: _currentPage),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        onTap: onTabTapped,
        currentIndex: _currentIndex,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }
}
