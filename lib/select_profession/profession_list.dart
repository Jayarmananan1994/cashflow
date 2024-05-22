import 'dart:convert';

import 'package:cashflow/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/profession_model.dart';
import '../theme.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProfessionListView extends StatefulWidget {
  final Function onSelect;

  const ProfessionListView({super.key, required this.onSelect});

  @override
  State<ProfessionListView> createState() => _ProfessionListViewState();
}

class _ProfessionListViewState extends State<ProfessionListView> {
  ProfessionModel? _selectedProfession;
  late Future<List<ProfessionModel>> _professionModelFuture;

  @override
  void initState() {
    _professionModelFuture = _loadProfessions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _professionModelFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          List<ProfessionModel> options = snapshot.data ?? [];
          return ListView(
            children: options.map((e) => _profesionTile(e)).toList(),
          );
        });
  }

  Widget _profesionTile(ProfessionModel professionModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: (professionModel == _selectedProfession)
            ? const Color(0XFFf0f2f5)
            : Colors.white,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedProfession = professionModel;
            });
            widget.onSelect(professionModel);
          },
          child: Row(children: [
            SvgPicture.asset('assets/suitcase_icon.svg'),
            const SizedBox(width: 15),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(professionModel.profession ?? 'NA',
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                Text(
                    'Salary: ${formatCurrency(professionModel.income?.salary ?? 0)}',
                    style: bodyMedium.copyWith(color: greyColor)),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Future<List<ProfessionModel>> _loadProfessions() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/professions.json');
      List<dynamic> jsonData = json.decode(jsonString);

      return jsonData.map((e) => ProfessionModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error reading asset JSON file: $e");
      return [];
    }
  }
}
