import 'dart:async';
import 'package:flutter/material.dart';
import 'package:note_caster/signup.dart';
import 'option_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String name;
  HomePage(String name)
  {
    this.name=name;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(name),
      ),
    );
  }
}