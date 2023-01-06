import 'package:flutter/material.dart';
import 'package:gift_app/pages/container_page.dart';
import 'package:gift_app/pages/exchange_details_page.dart';
import 'package:gift_app/theme.dart';

void main() => runApp(const MyApp());

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
