import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hangman/components/letterButton.dart';
import 'package:hangman/screens/welcome_screen.dart';
import 'package:hangman/utilities/alphabet.dart';
import 'package:hangman/game_engine.dart';
import 'package:hangman/utilities/constants.dart';


Alphabet alphabetEng = Alphabet();

class GameScreen extends StatefulWidget {
  late final GameScreen _engine;

  GameScreen(this._engine);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late bool _showNewGame;
  late String _activeImage;
  late String _activeWord;

  @override
  void initState() {
    super.initState();

    widget._engine.onChange.listen(this._updateWordDisplay);
    widget._engine.onWrong.listen(this._updateGallowsImage);
    widget._engine.onWin.listen(this._win);
    widget._engine.onLose.listen(this._gameOver);

    this._newGame;
  }

  void _updateWordDisplay(String word) {
    setState(() {
      _activeWord = word;
    });
  }

  void _updateGallowsImage(int wrongGuessCount) {
    setState(() {
      _activeImage = wordList[wrongGuessCount];
    });
  }


  Widget createButton(index) {
    return Center(
      child: Container(
        child: Center(
          child: LetterButton(
            buttonTitle: alphabetEng.alphabet[index].toUpperCase(),
            onPress: () {},
          ),
        ),
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
