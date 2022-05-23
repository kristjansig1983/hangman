import 'package:flutter/material.dart';
import 'package:hangman/screens/game_screen.dart';

import '../ui/hangman_page.dart';




class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);



  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late HangmanGame _engine;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Hang Man',
          style: TextStyle(
            fontFamily: 'Smokum',
          ),),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome To Hangman! A life is on the line and it\'s your job to save it!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Smokum',
                fontSize: 50.0,
              ),
            ),
            const SizedBox(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HangmanPage(_engine);
                    },
                  ),
                );
              },
              child: const Text(
                'Press To Start',
                style: TextStyle(
                  fontFamily: 'Smokum',
                  fontSize: 25.0,
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xFF319F48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}