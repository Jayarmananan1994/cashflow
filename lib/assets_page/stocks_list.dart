import 'package:cashflow/assets_page/asset_list_item.dart';
import 'package:cashflow/theme.dart';
import 'package:flutter/material.dart';

class StockList extends StatefulWidget {
  const StockList({super.key});

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Stocks',
              style: bodyMedium.copyWith(fontWeight: FontWeight.w700),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_outlined)),
          ],
        ),
        AssetListItem(
          primaryLabel: "MYT4U @ \$15",
          secondaryLabel: "250 Units",
          buyAction: () {},
          sellAction: () {},
        )
      ],
    );
  }
}
