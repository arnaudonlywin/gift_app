import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gift_app/models/exchange_item.dart';

class ExchangeService {
  ///Transforme un document snapshot en objet ExchangeItem
  static ExchangeItem convertDocSnapshotToObject(
    DocumentSnapshot<Map<String, dynamic>> docSnapshot,
  ) {
    final exchangeItemData = docSnapshot.data()!;
    return ExchangeItem(
      id: docSnapshot.id,
      title: exchangeItemData['title'],
      subtitle: exchangeItemData['subtitle'],
      imageUrl: exchangeItemData['imageUrl'],
    );
  }

  ///Récupère les items à échanger
  static Query<Map<String, dynamic>> getItems() {
    return FirebaseFirestore.instance
        .collection("exchange_items")
        .orderBy("title");
  }
}
