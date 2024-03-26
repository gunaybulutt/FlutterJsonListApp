import 'package:flutter/material.dart';
import 'package:flutter_basic_json_list_app/FirstPage.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}
