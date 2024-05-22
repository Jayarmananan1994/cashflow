import 'package:cashflow/assets_page/asset_list_item.dart';
import 'package:cashflow/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            _stocks()
            // _realEstate(),
            // _business(),
            // _royality(),
          ],
        ),
      ),
    );
  }

  Widget _stocks() {
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

  void handleBuy(BuildContext context) {}
}
