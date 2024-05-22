import 'package:cashflow/dashboard/dashboard_page.dart';
import 'package:cashflow/select_portfolio/select_portfolio.dart';
import 'package:cashflow/select_profession/profession_list.dart';
import 'package:cashflow/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/profession_model.dart';
import '../service/game_tracker_service.dart';
import '../theme.dart';

class SelectProfessionPage extends StatefulWidget {
  const SelectProfessionPage({super.key});

  @override
  State<SelectProfessionPage> createState() => _SelectProfessionPageState();
}

class _SelectProfessionPageState extends State<SelectProfessionPage> {
  ProfessionModel? _selectedProfession;
  final GameTrackerService _gameTrackerService = locator<GameTrackerService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: _mainContent(),
      )),
    );
  }

  _continueButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: const Color(0xff1C91F2)),
        onPressed:
            (_selectedProfession != null) ? _goToPortfolioSelection : null,
        child: Text('Continue',
            style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
      ),
    );
  }

  _mainContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pick a profession',
              style: titleLarge.copyWith(fontWeight: FontWeight.bold)),
          Text('This will be your initial game state', style: bodyMedium),
          _professionList(),
          _continueButton()
        ],
      ),
    );
  }

  _professionList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ProfessionListView(onSelect: _onSelectProfession),
      ),
    );
  }

  _onSelectProfession(ProfessionModel professionModel) {
    setState(() => _selectedProfession = professionModel);
  }

  _goToPortfolioSelection() {
    if (_selectedProfession != null) {
      _gameTrackerService.startGame(_selectedProfession!);
      Get.to(() => const SelectPortfolioPage());
    }
  }
}
