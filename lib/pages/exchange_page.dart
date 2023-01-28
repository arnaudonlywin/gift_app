import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
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
          child: FirestoreQueryBuilder<Map<String, dynamic>>(
            query: ExchangeService.getItems(),
            builder: (context, snapshot, _) {
              if (snapshot.isFetching) {
                return Center(
                  child: CircularProgressIndicator(
                    color: myPurple,
                  ),
                );
              }
              if (snapshot.hasError) {
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
              }
              if (snapshot.hasData) {
                return _getContent(snapshot);
              } else {
                return const Text("Rien à échanger pour le moment...");
              }
            },
          ),
        ),
      ],
    );
  }

  ///Retourne la liste de nos objets
  Widget _getContent(
    FirestoreQueryBuilderSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return gridView
        ? GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                snapshot.fetchMore();
              }
              final item = ExchangeService.convertDocSnapshotToObject(
                snapshot.docs[index],
              );
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
          )
        : ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                snapshot.fetchMore();
              }
              final item = ExchangeService.convertDocSnapshotToObject(
                snapshot.docs[index],
              );
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
