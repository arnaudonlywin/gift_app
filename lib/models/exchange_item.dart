import 'package:gift_app/models/item.dart';

class ExchangeItem extends Item {
  String? contreparties;

  ExchangeItem({
    required super.title,
    super.subtitle,
    super.imageUrl,
    super.fileImage,
    this.contreparties,
  });
}
