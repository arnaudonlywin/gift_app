import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/pages/container_page.dart';
import 'package:gift_app/pages/exchange_details_page.dart';
import 'package:gift_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("fa7183ad-6326-44dc-8aa8-da3be52af509");
  //The promptForPushNotificationsWithUserResponse function will show
  //the iOS or Android push notification prompt. We recommend removing
  //the following code and instead using an In-App Message to prompt for
  //notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    debugPrint("Accepted permission: $accepted");
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gift App',
      theme: MyTheme.getMyTheme(),
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? '/sign-in'
          : ContainerPage.routeName,
      routes: {
        ContainerPage.routeName: (context) {
          return const ContainerPage(title: 'Gift app');
        },
        '/sign-in': (context) {
          return SignInScreen(
            providers: [EmailAuthProvider()],
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(
                    context, ContainerPage.routeName);
              }),
            ],
          );
        },
        ExchangeDetailsPage.routeName: (context) => const ExchangeDetailsPage(),
      },
    );
  }
}
