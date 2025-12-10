import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lab2/services/notification_service.dart';
import 'firebase_options.dart';
import 'screens/home_page.dart';
import 'screens/category_meals_page.dart';
import 'screens/meal_details_page.dart';
import 'screens/favorites_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '221032',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/category": (context) => const CategoryMealsPage(),
        "/details": (context) => const MealDetailsPage(),
        "/favorites": (context) => const FavoritesPage(),
      },
    );
  }
}
