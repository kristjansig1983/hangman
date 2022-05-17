import 'dart:async';

import 'package:hangman/utilities/constants.dart';

class HangmanGame {
  //number of guesses before hanged
  static const int hanged = 5;
  //list of words to guess
  final List<String> wordList;
  final Set<String> lettersGuessed = new Set<String>();

  late List<String> _wordToGuess;
  late int _wrongGuesses;

  StreamController<Null> _onWin = new StreamController<Null>.broadcast();
  Stream<Null> get onWin => _onWin.stream;

  StreamController<Null> _onLose = new StreamController<Null>.broadcast();
  Stream<Null> get onLose => _onLose.stream;

  StreamController<int> _onWrong = new StreamController<int>.broadcast();
  Stream<int> get onWrong => _onWrong.stream;

  StreamController<String> _onRight = new StreamController<String>.broadcast();
  Stream<String> get onRight => _onRight.stream;

  StreamController<String> _onChange = new StreamController<String>.broadcast();
  Stream<String> get onChange => _onChange.stream;

  HangmanGame(List<String> words) : wordList = new List<String>.from(words);

  void newGame() {
    //shuffles words into random order
    wordList.shuffle();

    //break first word from shuffled list to a list of letters
    _wordToGuess = wordList.first.split('');

    //resets wrong guess count
    _wrongGuesses = 0;

    //clears guessed letters
    lettersGuessed.clear();

    //gets new word
    _onChange.add(wordForDisplay);
  }

  void guessLetter(String letter) {
    //stores guessed letter
    lettersGuessed.add(letter);

    //if guessed letter is right, check for win else check for loss
    if(_wordToGuess.contains(letter)) {
      _onRight.add(letter);

      if(isComplete) {
        _onChange.add(fullWord);
        _onWin.add(null);
      } else {
        _onChange.add(wordForDisplay);
      }
    } else {
      _wrongGuesses++;

      _onWrong.add(_wrongGuesses);

      if(_wrongGuesses == hanged) {
        _onChange.add(fullWord);
        _onLose.add(null);
      }
    }
  }

  int get wrongGuesses => _wrongGuesses;
  List<String> get wordToGuess => _wordToGuess;
  String get fullWord => wordToGuess.join();

  String get wordForDisplay => wordToGuess.map((String letter) =>
  lettersGuessed.contains(letter) ? letter : '_').join();

  //check if all letters in word have been guessed
  bool get isComplete {
    for(String letter in _wordToGuess) {
      if(!lettersGuessed.contains(letter)) {
        return false;
      }
    }
    return true;
  }
}