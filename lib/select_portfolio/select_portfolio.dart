import 'dart:convert';

import 'package:cashflow/dashboard/dashboard_page.dart';
import 'package:cashflow/layout/game_tab_layout.dart';
import 'package:cashflow/model/portfolio_model.dart';
import 'package:cashflow/select_portfolio/portfolio_card.dart';
import 'package:cashflow/service/game_tracker_service.dart';
import 'package:cashflow/service_locator.dart';
import 'package:cashflow/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectPortfolioPage extends StatefulWidget {
  const SelectPortfolioPage({super.key});

  @override
  State<SelectPortfolioPage> createState() => _SelectPortfolioPageState();
}

class _SelectPortfolioPageState extends State<SelectPortfolioPage> {
  final GameTrackerService _gameTrackerService = locator<GameTrackerService>();
  PortfolioModel? _selectedPortfolio;
  late Future<List<PortfolioModel>> _professionModelFuture;

  @override
  void initState() {
    _professionModelFuture = _loadPortfolios();
    super.initState();
  }

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

  Future<List<PortfolioModel>> _loadPortfolios() async {
    try {
      String jsonString = await rootBundle.loadString('assets/portfolios.json');
      List<dynamic> jsonData = json.decode(jsonString);

      return jsonData.map((e) => PortfolioModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error reading asset JSON file: $e");
      return [];
    }
  }

  _mainContent() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: blackColor)),
                Text('Select your Portfolio',
                    style: titleLarge.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(width: 25)
              ],
            ),
            Expanded(child: portfolioList()),
            _continueButton()
          ],
        ));
  }

  _goToGameBoard() {
    _gameTrackerService.addPortfolio(_selectedPortfolio);
    //Get.to(() => DashBoardPage());
    Get.to(() => const GameTabLayout());
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
        onPressed: (_selectedPortfolio != null) ? _goToGameBoard : null,
        child: Text('Continue',
            style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
      ),
    );
  }

  portfolioList() {
    if (_selectedPortfolio != null) {
      print("Selected portfolio" + _selectedPortfolio!.portfolioId.toString());
    }

    return FutureBuilder(
        future: _professionModelFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('no data');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          List<PortfolioModel> portfolios = snapshot.data ?? [];
          return ListView.builder(
              itemCount: (portfolios.length / 2).ceil(),
              itemBuilder: (context, index) {
                // bool isSelected = _selectedPortfolio == portfolios[index * 2];
                return Row(
                  children: [
                    Expanded(
                      child: index * 2 < portfolios.length
                          ? InkWell(
                              onTap: () {
                                print("Select 1");
                                setState(() =>
                                    _selectedPortfolio = portfolios[index * 2]);
                              },
                              child: PortfolioCard(
                                  portfolio: portfolios[index * 2],
                                  bgColor: _selectedPortfolio ==
                                          portfolios[index * 2]
                                      ? const Color(0XFFf0f2f5)
                                      : Colors.white))
                          : const SizedBox(),
                    ),
                    Expanded(
                      child: (index * 2 + 1) < portfolios.length
                          ? InkWell(
                              onTap: () {
                                print("Select 2");
                                setState(() => _selectedPortfolio =
                                    portfolios[index * 2 + 1]);

                                _selectedPortfolio = portfolios[index * 2 + 1];
                              },
                              child: PortfolioCard(
                                  portfolio: portfolios[index * 2 + 1],
                                  bgColor: _selectedPortfolio ==
                                          portfolios[index * 2 + 1]
                                      ? const Color(0XFFf0f2f5)
                                      : Colors.white))
                          : const SizedBox(),
                    ),
                  ],
                );
              });
        });
  }
}
