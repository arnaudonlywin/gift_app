import 'package:flutter/material.dart';
import 'package:gift_app/helpers/color_helper.dart';
import 'package:gift_app/models/exchange_item.dart';

class ExchangeItemWidget extends StatelessWidget {
  final ExchangeItem item;
  final void Function()? onTap;

  const ExchangeItemWidget({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: myPurple,
      onTap: onTap,
      child: ListTile(
        leading: getLeading(),
        title: Text(item.title),
        // subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  ///Retourne l'image de l'item
  Widget getLeading() {
    return SizedBox(
      height: 50,
      width: 50,
      child: item.imageUrl != null
          ? Image(
              image: NetworkImage(item.imageUrl!),
            )
          : const Icon(Icons.image),
    );
  }
}
