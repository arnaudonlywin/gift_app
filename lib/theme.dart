import 'package:flutter/material.dart';
import 'package:gift_app/helpers/color_helper.dart';

class MyTheme {
  static getMyTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: myGrey,
        // Couleur de l'icône "retour"
        iconTheme: const IconThemeData(color: Colors.black),
        // Couleur des icônes d'actions situés à droite
        actionsIconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: Colors.black),
        floatingLabelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
