import 'package:flutter/material.dart';
import 'package:hangman/screens/game_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF2E3064),
        scaffoldBackgroundColor: Color(0xFF2E3064),
      ),
      home: HangMan(),
    );
  }
}