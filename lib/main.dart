import 'package:flutter/material.dart';
import 'package:hangman/screens/game_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman',
      home: HangMan(),
    );
  }
}