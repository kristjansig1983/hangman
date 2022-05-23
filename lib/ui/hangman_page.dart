import 'package:flutter/material.dart';
import 'package:hangman/screens/game_screen.dart';

const List<String> progressImages = [
  'images/0.png',
  'images/1.png',
  'images/2.png',
  'images/3.png',
  'images/4.png',
  'images/5.png',
  'images/6.png',
];

const String victoryImage = 'images/victory.png';

const List<String> alphabet = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
];
//word to guess
const TextStyle activeWordStyle = TextStyle(
  color: Colors.white,
  fontSize: 30.0,
  letterSpacing: 5.0,
);

class HangmanPage extends StatefulWidget {
  final HangmanGame _engine;

  const HangmanPage(this._engine);

  @override
  State<StatefulWidget> createState() => _HangmanPageState();
}

class _HangmanPageState extends State<HangmanPage> {
  late bool _showNewGame;
  late String _activeImage = '';
  late String _activeWord = '';

  @override
  void initState() {
    super.initState();

    widget._engine.onChange.listen(_updateWordDisplay);
    widget._engine.onWrong.listen(_updateGallowsImage);
    widget._engine.onWin.listen(_win);
    widget._engine.onLose.listen(_gameOver);

    _newGame();
  }

  void _updateWordDisplay(String word) {
    setState(() {
      _activeWord = word;
    });
  }

  void _updateGallowsImage(int wrongGuessCount) {
    setState(() {
      _activeImage = progressImages[wrongGuessCount];
    });
  }

  void _win([_]) {
    setState(() {
      _activeImage = victoryImage;
      _gameOver();
    });
  }

  void _gameOver([_]) {
    setState(() {
      _showNewGame = true;
    });
  }

  void _newGame() {
    widget._engine.newGame();

    setState(() {
      _activeWord = '';
      _activeImage = progressImages[0];
      _showNewGame = false;
    });
  }

  Widget _renderBottomContent() {
    if (_showNewGame) {
      return RaisedButton(
        child: const Text('New Game'),
        onPressed: _newGame,
      );
    } else {
      final Set<String> lettersGuessed = widget._engine.lettersGuessed;
//keyboard
      return Wrap(
        spacing: 1.0,
        runSpacing: 1.0,
        alignment: WrapAlignment.center,
        children: alphabet.map((letter) => MaterialButton(
          child: Text(letter,
            style: const TextStyle(
              color: Colors.white,
            ),),
          padding: const EdgeInsets.all(2.0),
          onPressed: lettersGuessed.contains(letter) ? null : () {
            widget._engine.guessLetter(letter);
          },
        )).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Hangman'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image
            Expanded(
              child: Image.asset(_activeImage),
            ),
            // Word
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(_activeWord, style: activeWordStyle,
                ),
              ),
            ),
            // Controls
            Expanded(
              child: Center(
                child: _renderBottomContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}