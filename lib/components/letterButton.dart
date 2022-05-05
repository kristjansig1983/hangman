import 'package:flutter/material.dart';
import 'package:hangman/utilities/constants.dart';

class LetterButton extends StatelessWidget {
  LetterButton({required this.buttonTitle, required this.onPress});

  final Function() onPress;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
        child: Text(
          buttonTitle,
        textAlign: TextAlign.center,
        ),
    );
  }
}