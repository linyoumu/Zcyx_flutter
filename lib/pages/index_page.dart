import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'youth_page.dart';
import 'campus_page.dart';
import 'message_page.dart';
import 'mine_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => new _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.home),
        title:Text('首页')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.book),
        title:Text('青年')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.eye),
        title:Text('校园')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.info),
        title:Text('消息')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.profile_circled),
        title:Text('我的')
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    YouthPage(),
    CampusPage(),
    MessagePage(),
    MinePage()
  ];

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
            setState(() {
              currentIndex = index;
            });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}

