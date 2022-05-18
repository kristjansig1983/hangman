import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hangman/components/letterButton.dart';
import 'package:hangman/screens/welcome_screen.dart';
import 'package:hangman/utilities/alphabet.dart';
import 'package:hangman/utilities/words.dart';


class GameScreen extends StatefulWidget {
  GameScreen({required this.hangmanObject});

  final Words hangmanObject;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int lives = 5;
  Alphabet alphabetEng = Alphabet();
  late String word;
  late String hiddenWord;
  List<String> wordList = [];
  late List<bool> buttonStatus;
  int gallows = 0;
  int wordCount = 0;
  bool gameOver = false;
  bool gameReset = false;

  void startGame() {
    setState(() {
      widget.hangmanObject.resetGame();
      alphabetEng = Alphabet();
      lives = 5;
      wordCount = 0;
      gameOver = false;
      gameReset = false;
    });
  }

  void returnWelcomeScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
        ModalRoute.withName('welcomeScreen'));
  }

  void initWords() {
    gameOver = false;
    gameReset = false;
    gallows = 0;
    buttonStatus = List.generate(26, (index) {
      return true;
    });
    wordList = [];
    word = widget.hangmanObject.getWord()!;
    print('this is word' + word);
    if (word.length != 0) {
      hiddenWord = widget.hangmanObject.getHiddenWord(word.length);
    } else {
      returnWelcomeScreen();
    }

    for (int i = 0; i < word.length; i++) {
      wordList.add(word[i]);
    }
  }

  void endGame(int index) {
    if (lives == 0) {
      returnWelcomeScreen();
    }
    if (gameOver) {
      setState(() {
        gameReset = true;
      });
      return;
    }
    bool check = false;
    setState(() {
      for (int i = 0; i < wordList.length; i++) {
        if (wordList[i] == alphabetEng.alphabet[index]) {
          check = true;
          wordList[i] = '';
          hiddenWord = hiddenWord.replaceFirst(RegExp('_'), word[i], i);
        }
      }
      if (!check) {
        gallows += 1;
      }
      if (gallows == 6) {
        gameOver = true;
        lives -= 1;
      }
    });
  }

  Widget createButton(index) {
    return Center(
      child: LetterButton(
        buttonTitle: alphabetEng.alphabet[index].toUpperCase(),
        onPress: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Hang Man'),
      ),
      body: Container(
        color: Colors.blueGrey,
        alignment: Alignment.bottomCenter,
        child: Table(
          textBaseline: TextBaseline.alphabetic,
          children: [
            TableRow(
              children: [
                TableCell(
                  child: createButton(0),
                ),
                TableCell(
                  child: createButton(1),
                ),
                TableCell(
                  child: createButton(2),
                ),
                TableCell(
                  child: createButton(3),
                ),
                TableCell(
                  child: createButton(4),
                ),
                TableCell(
                  child: createButton(5),
                ),
                TableCell(
                  child: createButton(6),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: createButton(7),
                ),
                TableCell(
                  child: createButton(8),
                ),
                TableCell(
                  child: createButton(9),
                ),
                TableCell(
                  child: createButton(10),
                ),
                TableCell(
                  child: createButton(11),
                ),
                TableCell(
                  child: createButton(12),
                ),
                TableCell(
                  child: createButton(13),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: createButton(14),
                ),
                TableCell(
                  child: createButton(15),
                ),
                TableCell(
                  child: createButton(16),
                ),
                TableCell(
                  child: createButton(17),
                ),
                TableCell(
                  child: createButton(18),
                ),
                TableCell(
                  child: createButton(19),
                ),
                TableCell(
                  child: createButton(20),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: createButton(21),
                ),
                TableCell(
                  child: createButton(22),
                ),
                TableCell(
                  child: createButton(23),
                ),
                TableCell(
                  child: createButton(24),
                ),
                TableCell(
                  child: createButton(25),
                ),
                TableCell(
                  child: Text(''),
                ),
                TableCell(
                  child: Text(''),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
