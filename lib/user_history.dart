import 'package:flutter/material.dart';

class User_history extends StatefulWidget {
  const User_history({Key? key}) : super(key: key);

  @override
  _User_historyState createState() => _User_historyState();
}

class _User_historyState extends State<User_history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
    );
  }
}
