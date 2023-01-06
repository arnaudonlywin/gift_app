import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyAlertDialog {
  final BuildContext context;
  final String titleText;
  final Widget? contentWidget;
  final String? choiceOneText;
  final String choiceTwoText;
  final void Function()? choiceOneCallback;
  final void Function() choiceTwoCallback;
  bool? popOnChoiceOne = true;
  bool? popOnChoiceTwo = true;

  MyAlertDialog({
    required this.context,
    required this.titleText,
    this.contentWidget,
    this.choiceOneText,
    required this.choiceTwoText,
    this.choiceOneCallback,
    required this.choiceTwoCallback,
    this.popOnChoiceOne,
    this.popOnChoiceTwo,
  });

  Future show() {
    TextStyle sectionTitleStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    TextStyle actionSheetChoicesRed = const TextStyle(
      color: Colors.red,
      fontFamily: 'Arial',
      fontSize: 17,
    );
    TextStyle actionSheetChoices = const TextStyle(
      color: Colors.blue,
      fontFamily: 'Arial',
      fontSize: 17,
    );
    final bool isIOS =
        !kIsWeb && Theme.of(context).platform == TargetPlatform.iOS;
    Text title = Text(
      titleText,
      style: sectionTitleStyle,
      textAlign: TextAlign.center,
    );
    Widget? content = contentWidget;
    Text? choiceOne = choiceOneText != null
        ? Text(
            choiceOneText!,
            style: actionSheetChoicesRed,
          )
        : null;
    Text choiceTwo = Text(
      choiceTwoText,
      style: actionSheetChoices,
    );

    AlertDialog alertMaterial = AlertDialog(
      title: title,
      content: content,
      actions: [
        if (choiceOne != null)
          TextButton(
            child: choiceOne,
            onPressed: () {
              popOnChoiceOne ??
                  Navigator.of(context, rootNavigator: true).pop();
              if (choiceOneCallback != null) choiceOneCallback!();
            },
          ),
        TextButton(
          child: choiceTwo,
          onPressed: () {
            popOnChoiceTwo ?? Navigator.of(context, rootNavigator: true).pop();
            choiceTwoCallback();
          },
        ),
      ],
    );

    CupertinoAlertDialog alertCupertino = CupertinoAlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        if (choiceOne != null)
          TextButton(
            child: choiceOne,
            onPressed: () {
              popOnChoiceOne ??
                  Navigator.of(context, rootNavigator: true).pop();
              if (choiceOneCallback != null) choiceOneCallback!();
            },
          ),
        TextButton(
          child: choiceTwo,
          onPressed: () {
            popOnChoiceTwo ?? Navigator.of(context, rootNavigator: true).pop();
            choiceTwoCallback();
          },
        ),
      ],
    );

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: (isIOS) ? alertCupertino : alertMaterial,
        );
      },
    );
  }
}
