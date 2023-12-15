import 'package:flutter/material.dart';

class Constants {
  static BoxDecoration postPageContainer = const BoxDecoration(
    color: Color(0XFFdddddd),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  );
  static const TextStyle titleStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

  static TextStyle postPageBody =
      const TextStyle(fontStyle: FontStyle.italic, fontSize: 14.0);

  static SizedBox height10 = const SizedBox(height: 10);

//UserPage constants -- //TextStyle  //decoration
  static TextStyle userPageText = const TextStyle(fontSize: 16.0);
  static SizedBox height20 = const SizedBox(height: 20);
  static BoxDecoration usersPageContainer = const BoxDecoration(
    color: Color(0XFFdddddd),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );
}
