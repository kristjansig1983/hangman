import 'dart:math';

class Words {
  int counter = 0;
  List<int> _usedNums = [];
  List<String> _words = [];

  void readWords() {
    String fileText = 'documents/words.txt';
    _words = fileText.split('\n');
  }

  void resetGame() {
    counter = 0;
    _usedNums = [];
  }

  String? getWord() {
    counter += 1;
    var random = Random();
    int wordLength = _words.length;
    int randomNum = random.nextInt(wordLength);
    bool notUnique = true;
    if(counter - 1 == _words.length) {
      notUnique = false;
      return '';
    }
    while(notUnique) {
      if(!_usedNums.contains(randomNum)) {
        notUnique = false;
        _usedNums.add(randomNum);
        return _words[randomNum];
      } else {
        randomNum = random.nextInt(wordLength);
      }
    }
    return null;
  }
  String getHiddenWord(int wordLength) {
    String word = '';
    for(int i = 0; i < wordLength; i++) {
      word += '_';
    }return word;
  }
}


