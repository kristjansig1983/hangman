import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'game_screen.dart';

class WelcomeScreen extends StatefulWidget {


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Hang Man',
          style: TextStyle(
            fontFamily: 'Smokum',
            fontSize: 40.0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome To Hangman! A life is on the line and it\'s your job to save it!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Smokum',
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(

                    ),
                  ),
                );
              },
              child: Text(
                'Press To Start',
                style: TextStyle(
                  fontFamily: 'Smokum',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
