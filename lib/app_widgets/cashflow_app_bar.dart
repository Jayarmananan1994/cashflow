import 'package:flutter/material.dart';

class CashFlowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CashFlowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cash Flow"));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
