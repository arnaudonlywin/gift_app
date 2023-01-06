import 'package:flutter/material.dart';
import 'package:gift_app/helpers/color_helper.dart';
import 'package:gift_app/models/exchange_item.dart';
import 'package:gift_app/pages/exchange_details_page.dart';
import 'package:gift_app/services/exchange_service.dart';
import 'package:gift_app/widgets/exchange_item_widget.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  bool gridView = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Grille"),
            Switch(
              value: gridView,
              onChanged: (newValue) {
                setState(() {
                  gridView = newValue;
                });
              },
            ),
          ],
        ),
        Expanded(
          child: FutureBuilder(
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
                    return getContent(items);
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
              }),
        ),
      ],
    );
  }

  ///Retourne la liste de nos objets
  Widget getContent(List<ExchangeItem> items) {
    return gridView
        ? GridView.count(
            crossAxisCount: 2,
            children: items.map(
              (item) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ExchangeDetailsPage.routeName,
                      arguments: item,
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 5.0,
                    ),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(item.imageUrl!))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          item.title,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          )
        : ListView.separated(
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
  }
}
