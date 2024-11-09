import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  const NavBar(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      indicatorColor: Colors.blue,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      height: 60,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
          selectedIcon: Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        NavigationDestination(
          icon: Icon(Icons.explore),
          label: 'Transaction',
          selectedIcon: Icon(
            Icons.explore,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
