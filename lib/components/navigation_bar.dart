import 'package:engage_files/Pages/Home/rout_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationBarCustom extends StatefulWidget {
  const NavigationBarCustom({super.key});
  static int currentIndex = 0;
  @override
  State<NavigationBarCustom> createState() => _NavigationBarCustomState();
}

class _NavigationBarCustomState extends State<NavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              NavigationBarCustom.currentIndex = 0;
              DashboardScreen.dashboardController.animateToPage(
                0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            });
          },
          child: NavBarIcon(
            icon: Icons.home,
            text: "Home",
            index: 0,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              NavigationBarCustom.currentIndex = 1;
              DashboardScreen.dashboardController.animateToPage(
                1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            });
          },
          child: NavBarIcon(
            icon: Icons.shopping_cart,
            text: "Cart",
            index: 1,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              NavigationBarCustom.currentIndex = 2;
              FirebaseAuth.instance.signOut();

              DashboardScreen.dashboardController.animateToPage(
                2,
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            });
          },
          child: NavBarIcon(
            icon: Icons.person,
            text: "Profile",
            index: 2,
          ),
        ),
      ],
    ));
  }
}

// ignore: must_be_immutable
class NavBarIcon extends StatefulWidget {
  IconData icon;
  String text;
  int index;
  void Function()? onTap;
  NavBarIcon({
    super.key,
    required this.icon,
    required this.text,
    required this.index,
    this.onTap,
  });

  @override
  State<NavBarIcon> createState() => _NavBarIconState();
}

class _NavBarIconState extends State<NavBarIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.icon,
            color: NavigationBarCustom.currentIndex == widget.index
                ? const Color(0xffFF6E00)
                : const Color(0xffC4C4C4),
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: NavigationBarCustom.currentIndex == widget.index
                  ? const Color(0xffFF6E00)
                  : const Color(0xffC4C4C4),
            ),
          ),
        ],
      ),
    );
  }
}
