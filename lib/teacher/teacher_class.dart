import 'package:flutter/material.dart';

class TeacherClass extends StatelessWidget {
  const TeacherClass({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: const Text('教师发布消息'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text('发布'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.pink),
    );
  }
}
