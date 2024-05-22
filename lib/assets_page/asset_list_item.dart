import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AssetListItem extends StatelessWidget {
  final String primaryLabel;
  final String secondaryLabel;
  final Function buyAction;
  final Function sellAction;

  const AssetListItem(
      {super.key,
      required this.primaryLabel,
      required this.secondaryLabel,
      required this.buyAction,
      required this.sellAction});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context) => buyAction(),
          label: 'Buy',
          backgroundColor: Colors.green.shade300,
          foregroundColor: Colors.white,
        ),
        SlidableAction(
          backgroundColor: Colors.red.shade500,
          foregroundColor: Colors.white,
          onPressed: (context) => sellAction(),
          label: 'Sell',
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(primaryLabel),
            Text(secondaryLabel),
          ],
        ),
      ),
    );
  }
}
