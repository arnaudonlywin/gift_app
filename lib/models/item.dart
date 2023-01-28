import 'dart:io';

class Item {
  String? id;
  String title;
  String? subtitle;
  String? imageUrl;
  File? fileImage;

  Item({
    this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.fileImage,
  });
}
