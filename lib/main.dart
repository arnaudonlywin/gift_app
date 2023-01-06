import 'package:flutter/material.dart';
import 'package:gift_app/pages/container_page.dart';
import 'package:gift_app/pages/exchange_details_page.dart';
import 'package:gift_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gift App',
      theme: MyTheme.getMyTheme(),
      home: const ContainerPage(title: 'Gift app'),
      routes: {
        ExchangeDetailsPage.routeName: (context) => const ExchangeDetailsPage(),
      },
    );
  }
}
