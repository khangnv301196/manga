import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:manga_reader/Util/apiservice.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HometabState createState() {
    // TODO: implement createState
    return _HometabState();
  }
}

class _HometabState extends State<HomeTab> {
  PageController _pageController;
  Isolate newIsolate;
  SendPort newIsolateSendPort;
  static List<String> link = [
    "http://45.76.186.111/resources/client/img/slide_1.jpeg",
    "http://45.76.186.111/resources/client/img/slide_2.jpeg",
    "http://45.76.186.111/resources/client/img/slide_3.jpeg",
    "http://45.76.186.111/resources/client/img/slide_4.jpeg"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var param = {
      'pageSize': '5',
      'order': '1',
    };
    ApiService.getSearch(param);
    _pageController = PageController(
      initialPage: link.length,
    );
    _callerCreateIsolate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: PageView.builder(
                    controller: _pageController,
                    itemCount: link.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white,
                        child: Image.network(
                          link[index],
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: <Widget>[
              Text('Truyện mới cập nhật'),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return _itemRow("omega", context);
                    }),
              )
            ],
          )),
    );
  }

  Widget _itemRow(String key, BuildContext context) {
    return new Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FadeInImage.assetNetwork(
                width: 200.0,
                height: 100.0,
                placeholder: 'images/giphy.gif',
                image:
                    'https://www.hlj.com/media/catalog/product/cache/image/700x700/e9c3970ab036de70892d86c6d221abfe/b/a/bann18384_0.jpg',
              ),
              Flexible(
                child: Text("Music by Julie Gable. Lyrics by Sidney Stein"),
              ),
            ],
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _callerCreateIsolate() {
    ReceivePort receivePort = ReceivePort();
    Isolate.spawn(_loop, receivePort.sendPort);

    receivePort.listen((onData) {
      _pageController.animateToPage(int.parse(onData),
          duration: const Duration(milliseconds: 500), curve: Curves.easeInQuart);
    });
  }

  static void _loop(SendPort newPort) {
    ReceivePort newIsolateReceivePort = ReceivePort();
    while (true) {
      for (int i = 0; i < link.length; i++) {
        sleep(Duration(seconds: 3));
        log(i.toString());
        newPort.send(i.toString());
      }
    }
  }
}
