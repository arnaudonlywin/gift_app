import 'dart:io';

class Item {
  String title;
  String? subtitle;
  String? imageUrl;
  File? fileImage;

  Item({
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.fileImage,
  });
}
