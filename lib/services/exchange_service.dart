import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      contreparties: exchangeItemData['contreparties'],
    );
  }

  ///Récupère les items à échanger
  static Query<Map<String, dynamic>> getItems() {
    return FirebaseFirestore.instance
        .collection("exchange_items")
        .orderBy("title");
  }

  ///Ajoute un élément à échanger
  static Future<String> add(ExchangeItem item) async {
    //Enregistrer en base
    final docRef =
        await FirebaseFirestore.instance.collection("exchange_items").add(
      {
        'title': item.title,
        'subtitle': item.subtitle,
        'contreparties': item.contreparties,
      },
    );
    final itemId = docRef.id;
    //Upload la photo
    if (item.fileImage != null) {
      await FirebaseStorage.instance
          .ref("Photos")
          .child(itemId)
          .child('photo.jpg')
          .putFile(item.fileImage!)
          .then((taskSnapshot) async {
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection("exchange_items")
            .doc(itemId)
            .set(
          {
            'imageUrl': downloadUrl,
          },
          SetOptions(merge: true),
        );
      });
    }
    return itemId;
  }
}
