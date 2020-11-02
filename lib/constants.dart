
import 'package:flutter/material.dart';

abstract class ThemeText {
  static const TextStyle custom_style = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 40,
      height: 0.5,
      fontWeight: FontWeight.w600);
}
abstract class Decor {
  static const InputDecoration decorText = InputDecoration(


    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    hintStyle: TextStyle(color: Colors.grey),

    labelStyle: TextStyle(color: Colors.grey),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    // border: InputBorder.,
    // focusedBorder: UnderlineInputBorder(
    //   borderSide: BorderSide(color: Colors.white),
    // ),
  );

}
class CustomTextStyle {

  static TextStyle display5(BuildContext context) {
    return Theme.of(context).textTheme.body1
        .copyWith(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        fontFamily: 'Montserrat',
        color: Colors.grey);
  }
}