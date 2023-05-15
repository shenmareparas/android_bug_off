import 'package:engage_files/Pages/Home/home.dart';
import 'package:engage_files/Pages/Home/mycart.dart';
import 'package:engage_files/Pages/_profile.dart';
import 'package:engage_files/components/navigation_bar.dart';
import 'package:engage_files/login.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static PageController dashboardController = PageController();

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          value == 2
              ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Loginscreen(),
                ))
              : null;
        },
        physics: const NeverScrollableScrollPhysics(),
        controller: DashboardScreen.dashboardController,
        children: const [
          HomeScreen(),
          MyCart(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: const NavigationBarCustom(),
    );
  }
}
