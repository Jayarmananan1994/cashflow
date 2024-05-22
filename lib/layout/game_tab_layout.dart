import 'package:cashflow/assets_page/assets_page.dart';
import 'package:cashflow/theme.dart';
import 'package:flutter/material.dart';

import '../dashboard/dashboard_page.dart';

class GameTabLayout extends StatefulWidget {
  const GameTabLayout({super.key});

  @override
  State<GameTabLayout> createState() => _GameTabLayoutState();
}

class _GameTabLayoutState extends State<GameTabLayout> {
  int currentPageIndex = 0;
  final List<GameTabs> _gameTabs = [
    GameTabs(
        label: "Home",
        icon: const Icon(Icons.home),
        selectedIcon: const Icon(Icons.home_outlined),
        content: DashBoardPage()),
    GameTabs(
      label: "Assets",
      icon: const Icon(Icons.account_balance),
      selectedIcon: const Icon(Icons.account_balance),
      content: const AssetsPage(),
    ),
    GameTabs(
        label: "Statements",
        icon: const Icon(Icons.bar_chart),
        selectedIcon: const Icon(Icons.messenger_sharp),
        content: const Card(
          shadowColor: Colors.transparent,
          margin: EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(child: Text('Messages')),
          ),
        ))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _handleDestimnationSelected,
        indicatorColor: primaryColor,
        selectedIndex: currentPageIndex,
        destinations: _gameTabs
            .map((e) => NavigationDestination(
                  selectedIcon: e.selectedIcon ?? e.icon,
                  icon: e.icon,
                  label: e.label,
                ))
            .toList(),
      ),
      body: _gameTabs.map((e) => e.content).toList()[currentPageIndex],
    );
  }

  void _handleDestimnationSelected(int index) {
    setState(() => currentPageIndex = index);
  }
}

class GameTabs {
  String label;
  Icon icon;
  Icon? selectedIcon;
  Widget content;

  GameTabs(
      {required this.label,
      required this.icon,
      required this.selectedIcon,
      required this.content});
}
