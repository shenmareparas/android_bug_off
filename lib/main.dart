import 'package:engage_files/Pages/Home/rout_Page.dart';
import 'package:engage_files/login.dart';
import 'package:engage_files/models/user_model.dart';
import 'package:engage_files/responsivescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'color_schemes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ResponsiveScreen.screenHeight = 844;
  ResponsiveScreen.screenWidth = 390;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      home: CurrentUser.currentUser == false
          ? const DashboardScreen()
          : const Loginscreen(),
    );
  }
}
