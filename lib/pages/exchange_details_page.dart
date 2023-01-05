import 'package:flutter/material.dart';
import 'package:gift_app/helpers/color_helper.dart';
import 'package:gift_app/models/exchange_item.dart';
import 'package:gift_app/widgets/app_bar.dart';

class ExchangeDetailsPage extends StatefulWidget {
  const ExchangeDetailsPage({super.key});

  static const routeName = '/exchangeDetails';

  @override
  State<ExchangeDetailsPage> createState() => _ExchangeDetailsPageState();
}

class _ExchangeDetailsPageState extends State<ExchangeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ExchangeItem;
    return Scaffold(
      extendBody: true,
      appBar: getAppBar(item.title),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  item.imageUrl != null
                      ? Image(
                          image: NetworkImage(item.imageUrl!),
                        )
                      : const Icon(Icons.image),
                  if (item.subtitle != null)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(item.subtitle!),
                    ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            color: myGrey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(myPurple),
                  ),
                  child: const Text(
                    "Intéréssé !",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
