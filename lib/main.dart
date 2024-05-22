import 'package:cashflow/layout/game_tab_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'select_profession/select_profession.dart';
import 'service_locator.dart';

void main() {
  setupLocator();
  runApp(const CashFlow());
}

class CashFlow extends StatelessWidget {
  const CashFlow({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cashflow calculator',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const SelectProfessionPage(),
      //home: const GameTabLayout(),
    );
  }
}
