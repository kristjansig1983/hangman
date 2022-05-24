import 'package:flutter/material.dart';
import 'package:hangman/components/words.dart';

class HangMan extends StatefulWidget {
  @override
  _HangManState createState() => _HangManState();
}

class _HangManState extends State<HangMan> {
  late bool newGame;
  late bool gameOver;
  int livesLeft = 0;
  int imageNum = 0;
  late Set<String> wrongLetters;
  late Set<String> rightLetters;
  String guessWord = '';
  late bool isWon;

  @override
  void initState() {
    startNewGame();
    super.initState();
  }

  void startNewGame() {
    newGame = true;
    gameOver = false;
    isWon = false;
    livesLeft = 6;
    imageNum = 0;
    wrongLetters = new Set();
    rightLetters = new Set();
    guessWord = randomWord().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gameScreen(),
    );
  }

  Widget gameScreen() {
    if (gameOver) {
      return gameOverScreen();
    }
    if (newGame) {
      return welcomeScreen();
    }
    return Container(
      color: Colors.deepPurpleAccent,
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 80,
                  ),
                  Text(
                    livesLeft.toString(),
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )
                ],
              ),
            ),
            hangManImage(),
            GuessWord(),
            gameKeyboard()
          ],
        ),
      ),
    );
  }

  Widget hangManImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 20),
      child: Image.asset(
        'images/$imageNum.png',
        height: 135,
      ),
    );
  }

  String formattedWord() {
    String formattedWord = "";
    for (int i = 0; i < guessWord.length; i++) {
      String letter = guessWord.substring(i, i + 1).toUpperCase();
      if (rightLetters.contains(letter)) {
        formattedWord += letter.toUpperCase();
      } else {
        formattedWord += "_";
      }
      if (i < guessWord.length - 1) {
        formattedWord += " ";
      }
    }
    return formattedWord;
  }

  Widget GuessWord() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        formattedWord(),
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
    );
  }

  void updateGame(String guessLetter) {
    guessLetter = guessLetter.toUpperCase();
    if (guessWord.contains(guessLetter)) {
      rightLetters.add(guessLetter);
      isWon = true;
      for (int i = 0; i < guessWord.length; i++) {
        if (!rightLetters.contains(guessWord.substring(i, i + 1))) {
          isWon = false;
          break;
        }
      }
      if(isWon){
        gameOver = true;
      }
    } else {
      wrongLetters.add(guessLetter);
      livesLeft -= 1;
      imageNum += 1;
      if (livesLeft <= 0) {
        livesLeft = 0;
        imageNum = 6;
        gameOver = true;
        isWon = false;
      }
    }
    // Will now update UI
    setState(() {});
  }

  Widget gameOverScreen() {
    String text = "";
    if (isWon) {
      text = "You Won!";
    } else {
      text = "You Lost";
    }
    return Container(
      color: Colors.deepPurpleAccent,
      constraints: BoxConstraints.expand(),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          ),
          Image.asset('assets/images/gallow.png'),
          Container(
            width: 250,
            height: 60,
            child: RaisedButton(
              onPressed: () {
                startNewGame();
                newGame = false;
                setState(() {});
              },
              child: Text(
                "Play Again",
                style: TextStyle(fontSize: 25),
              ),
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
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
    } else if (wrongLetters.contains(guessLetter)) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  Widget gameKeyboard() {
    String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        children: List.generate(
            alphabet.length,
                (index) => Container(
              padding: EdgeInsets.all(5),
              child: RaisedButton(
                color: buttonColor(alphabet.substring(index, index + 1)),
                onPressed: () {
                  String guessLetter = alphabet.substring(index, index + 1);
                  if (!(rightLetters.contains(guessLetter) ||
                      wrongLetters.contains(guessLetter))) {
                    updateGame(guessLetter);
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  alphabet.substring(index, index + 1),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )));
  }

  Widget welcomeScreen() {
    return Container(
      color: Colors.deepPurpleAccent,
      constraints: BoxConstraints.expand(),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text(
              "HANGMAN",
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          ),
          Image.asset('assets/images/gallow.png'),
          Container(
            width: 150,
            height: 50,
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  newGame = false;
                });
              },
              child: Text(
                "Start",
                style: TextStyle(fontSize: 25),
              ),
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
