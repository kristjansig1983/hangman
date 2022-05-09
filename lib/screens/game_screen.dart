import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hangman/components/letterButton.dart';
import 'package:hangman/utilities/alphabet.dart';

Alphabet alphabetEng = Alphabet();

class TableSpace{
}

Widget createButton(index) {
  return Center(
    child: LetterButton(
      buttonTitle: alphabetEng.alphabet[index].toUpperCase(),
      onPress: () {},
    ),
  );
}

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Hang Man'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/western-town-vector-scene.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
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
