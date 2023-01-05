import 'package:flutter/material.dart';
import 'package:gift_app/helpers/color_helper.dart';

///Récupère l'app bar de notre appli
PreferredSizeWidget getAppBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
    backgroundColor: myGrey,
    centerTitle: true,
  );
}
