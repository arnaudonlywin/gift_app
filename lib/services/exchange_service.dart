import 'package:gift_app/models/exchange_item.dart';

class ExchangeService {
  ///Récupère les items à échanger
  static Future<List<ExchangeItem>> getItems() async {
    final items = [
      ExchangeItem(
        title: "Lit bébé",
        subtitle:
            "Le lit bébé Jimi. Un sommier réglable en hauteur et un confort adapté au sommeil des bébés, le lit Jimi de style scandinave répond aux attentes des plus exigeants. Fabrication européenne.",
        imageUrl:
            "https://www.chambrekids.com/18378-home_default/lit-pour-bebe-evolutif-evidence-70x140.jpg",
      ),
      ExchangeItem(
        title: "VTT Rockrider",
        imageUrl:
            r"https://contents.mediadecathlon.com/p1916561/k$5de05bdafcae713efbb594debb777644/1180x0/1765pt1765/3463xcr3530/vtt-rockrider-st-520-v2-black.jpg?format=auto&quality=80",
      ),
    ];
    await Future.delayed(const Duration(seconds: 1));
    return items;
  }
}
