import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:flutter/material.dart';
import 'package:data_plugin/data_plugin.dart';
import 'package:flutter_bmob/model/LoginUserModel.dart';
import 'package:flutter_bmob/student/student_class.dart';
import 'package:flutter_bmob/my/my_setting.dart';
import 'package:flutter_bmob/teacher/teacher_class.dart';
import 'package:flutter_bmob/utils/share_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  final currentUser = LoginUserModel();
  Bmob.init(
      "6190525c2d38ba9be4369cbd1ad8c9da", "f5ba935995568ab48d07973c8b175299");
  runApp(Provider<BmobUser>.value(
      value: null,
      child: ChangeNotifierProvider.value(
        value: currentUser,
        child: MyApp(),
      )));
}
/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    LocalDataHelper().getShareInstance();
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  var _pageController = new PageController(initialPage: 0);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    StudentClass(),
    TeacherClass(),
    MySetting(),
  ];

  void _onItemTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('预约课程'),
      ),
      body: new PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          itemCount: _widgetOptions.length,
          onPageChanged: _pageChange,
          itemBuilder: (BuildContext context, int index) {
            return _widgetOptions[index];
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text('学生课程'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            title: Text('教师课程'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text('个人设置'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _pageChange(int index) {
    setState(() {
      if (index != _selectedIndex) {
        _selectedIndex = index;
      }
    });
  }
}
