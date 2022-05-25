import 'package:flutter/material.dart';
import 'package:hangman/components/words.dart';
import 'package:hangman/components/constants.dart';
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
    wrongLetters = Set();
    rightLetters = Set();
    guessWord = randomWord().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gameScreen(),
    );
  }
//game screen
  Widget gameScreen() {
    if (gameOver) {
      return gameOverScreen();
    }
    if (newGame) {
      return welcomeScreen();
    }
    return Container(
      constraints: const BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 80,
                  ),
                  Text(
                    livesLeft.toString(),
                    style: const TextStyle(fontSize: 25, color: Colors.white,),
                  )
                ],
              ),
            ),
            hangManImage(),
            createGuessWord(),
            gameKeyboard()
          ],
        ),
      ),
    );
  }
//progress of gallows
  Widget hangManImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 20),
      child: Image.asset(
        'images/$imageNum.png',
        height: 135,
        color: kTextColor,
      ),
    );
  }
//gets word to guess
  String hiddenWord() {
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

  Widget createGuessWord() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        hiddenWord(),
        style: const TextStyle(color: kTextColor, fontSize: 50,
        fontFamily: 'Smokum',
        ),
      ),
    );
  }
//progress of guessing
  void updateGame(String guessLetter) {
    //prints word to guess in console for testing
    print(guessWord);
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
//screen appears when game ends
  Widget gameOverScreen() {
    String text = "";
    if (isWon) {
      text = "You Won! A person is now in your debt for life!";
    } else {
      text = "You Lost! Maybe go read a dictionary.";
    }
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kTextColor,
                  fontSize: 45,
                fontFamily: 'Smokum',
              ),
            ),
          ),
          SizedBox(
            width: 250,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                startNewGame();
                newGame = false;
                setState(() {});
              },
              child: const Text(
                "Play Again",
                style: TextStyle(fontSize: 40,
                fontFamily: 'Smokum',
                color: kTextColor,),
              ),
              style: ElevatedButton.styleFrom(
              primary: kButtonColor,
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
//letter on keyboard changes color according to right or wrong guess.
  Color buttonColor(String guessLetter) {
    if (rightLetters.contains(guessLetter)) {
      return Colors.blueGrey;
    } else if (wrongLetters.contains(guessLetter)) {
      return Colors.red;
    } else {
      return kButtonColor;
    }
  }
//keyboard
  Widget gameKeyboard() {
    String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        children: List.generate(
            alphabet.length,
                (index) => Container(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: buttonColor(alphabet.substring(index, index + 1)),
                    shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
                ),
                onPressed: () {
                  String guessLetter = alphabet.substring(index, index + 1);
                  if (!(rightLetters.contains(guessLetter) ||
                      wrongLetters.contains(guessLetter))) {
                    updateGame(guessLetter);
                  }
                },
                child: Text(
                  alphabet.substring(index, index + 1),
                  style: const TextStyle(color: kTextColor,
                    fontSize: 30,
                  fontFamily: 'Smokum',
                  ),
                ),
              ),
            )));
  }
//starting screen
  Widget welcomeScreen() {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text(
             'Welcome To Hangman! A Life Is On The Line And It\s Your Job To Save It!',
              textAlign: TextAlign.center,
              style: TextStyle(color: kTextColor,
                fontSize: 45,
              fontFamily: 'Smokum',),
            ),
          ),
          SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  newGame = false;
                });
              },
              child: const Text(
                "Start",
                style: TextStyle(fontSize: 40,
                color: kTextColor,
                fontFamily: 'Smokum'),
              ),
              style: ElevatedButton.styleFrom(
              primary: kButtonColor,
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
}
