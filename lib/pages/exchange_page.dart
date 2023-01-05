import 'package:flutter/material.dart';
import 'package:gift_app/helpers/color_helper.dart';
import 'package:gift_app/pages/exchange_details_page.dart';
import 'package:gift_app/services/exchange_service.dart';
import 'package:gift_app/widgets/exchange_item_widget.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ExchangeService.getItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: myPurple,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            if (snapshot.hasData) {
              final items = snapshot.data!;
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  return ExchangeItemWidget(
                    item: item,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ExchangeDetailsPage.routeName,
                        arguments: item,
                      );
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              );
            } else {
              return const Text("Rien à échanger pour le moment...");
            }
          }
          return Row(
            children: [
              const Icon(Icons.error),
              Column(
                children: [
                  const Text("Une erreur est survenue"),
                  if (snapshot.hasError) Text(snapshot.error.toString()),
                ],
              ),
            ],
          );
        });
  }
}
