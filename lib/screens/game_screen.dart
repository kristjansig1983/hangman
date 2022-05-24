import 'package:flutter/material.dart';
import 'package:hangman/components/words.dart';

class HangMan extends StatefulWidget {
  @override
  _HangmanState createState() => _HangmanState
}

class _HangmanState extends State<HangMan> {
  late bool newGame;
  late bool gameOver;
  int lives = 0;
  int image = 0;
  late Set<String> wrongLetters;
  late Set<String> rightLetters;
  String guessWord = '';
  late bool isWon;

  @override
  void initState() {
    startGame();
    super.initState();
  }

  void startGame() {
    newGame = true;
    gameOver = true;
    isWon = false;
    lives = 5;
    wrongLetters = Set();
    rightLetters = Set();
    guessWord = randomWord().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createGameScreen(),
    );
  }

  Widget gameScreen() {
    if(gameOver) {
      return gameOverScreen();
    }
    if (newGame) {
      return newGameScreen;
    }
    return Container(
      color: Colors.red,
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Icon(
                    Icons.favorite,
                    color: Colors.blue,
                    size: 80,
                  ),
                  Text(
                    lives.toString(),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            createImage(),
            createGuessWord(),
            createKeyboard(),
          ],
        ),
      ),
    );
  }

  Widget createImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 20),
      child: Image.asset(
        'images/$image.png',
        height:  135.0,
      ),
    );
  }

  String createFormattedWord() {
    String formattedWord = '';
    for(int i = 0; i < guessWord.length; i++) {
      String letter = guessWord.substring(i, i + 1).toUpperCase();
      if(rightLetters.contains(letter)) {
        formattedWord += letter.toUpperCase();
      } else {
        formattedWord += '_';
      } if(i < guessWord.length - 1) {
        formattedWord += ' ';
      }
    }
    return formattedWord;
  }

  Widget createGuessWord() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        createFormattedWord(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 50,
        ),
      ),
    );
  }

  void updateGame(String guessLetter) {
    guessLetter = guessLetter.toUpperCase();
    if(guessWord.contains(guessLetter)) {
      rightLetters.add(guessLetter);
      isWon = true;
      for(int i = 0; i < guessWord.length; i++) {
        if(!rightLetters.contains(guessLetter.substring(i, i + 1))) {
          isWon = false;
          break;
        }
      }
      if(isWon) {
        newGame = true;
      }
    } else {
      wrongLetters.add(guessLetter);
      lives -= 1;
      image += 1;
      if(lives <=0) {
        lives = 0;
        image = 6;
        gameOver = true;
        isWon = false;
      }
    }
    setState(() {});
  }
  Widget gameOverScreen() {
    String text = '';
    if(isWon) {
      text = 'Winner!';
    } else {
      text = 'Loser!';
    }
    return Container(
      color: Colors.red,
      constraints: BoxConstraints.expand(),
      child: Column(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          ),
          Container(
            width: 250,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                startGame();
                newGame = false;
                setState(() {});
              },
              child: Text(
                'New Game',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Smokum',
                  color: Colors.white,

                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  MaterialColor buttonColor(String guessLetter) {
    if (rightLetters.contains(guessLetter)) {
      return Colors.blueGrey;
    } else if(wrongLetters.contains(guessLetter)) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }
  //Needs more work
  Widget createKeyboard() {
    String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return GridView.count(
      crossAxisCount: 7,
    shrinkWrap: true,
    children: List.generate(
        alphabet.length,
            (index) => Container(
              padding: EdgeInsets.all(5),
              child: ElevatedButton(
                child: Text(
                  alphabet.substring(index, index +1),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Smokum',
                    fontSize: 20
                  ),
                ),
              ),
            )),)
  }
}