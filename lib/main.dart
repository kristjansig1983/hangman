import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(hangMan());

class hangMan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}
