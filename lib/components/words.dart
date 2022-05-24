import 'dart:math';

String randomWord() {
  String words = ('documents/words.txt');
  List<String> wordList = words.split(' ');
  wordList.removeWhere((element) => element.length > 5);
  Random random = new Random(DateTime.now().millisecondsSinceEpoch);
  return wordList[random.nextInt(wordList.length - 1)];
}