import 'package:cashflow/dashboard/cashflow_graph.dart';
import 'package:cashflow/model/profession_model.dart';
import 'package:cashflow/service/game_tracker_service.dart';
import 'package:cashflow/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../service_locator.dart';
import '../util.dart';

class DashBoardPage extends StatelessWidget {
  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  final GameTrackerService _gameTrackerService = locator<GameTrackerService>();
  DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var gameState = _gameTrackerService.getGameCurrentState();
    print(gameState);
    return Scaffold(
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _title(),
        _mainContent(),
      ])),
    );
  }

  _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 100),
        Text('CashFlow 202',
            style:
                bodyMedium.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(
            onPressed: () {},
            child: Text('New Game',
                style: GoogleFonts.spaceGrotesk(color: primaryColor))),
      ],
    );
  }

  _mainContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            _cashFlowAndGraph(),
            _incomeAndExpense(),
            _gameOverview(),
            _gameActions(),
          ],
        ),
      ),
    );
  }

  _cashFlowAndGraph() {
    List<double> cashFlowHistory =
        _gameTrackerService.getGameCurrentState().currentCashFlow();
    double currentCashFlow =
        cashFlowHistory.isNotEmpty ? cashFlowHistory.last : 0;
    double previousCashFlow = cashFlowHistory.length > 1
        ? cashFlowHistory[cashFlowHistory.length - 2]
        : 0;

    double difference = cashFlowHistory.isEmpty
        ? _differnceInPercentage(currentCashFlow, 0)
        : _differnceInPercentage(currentCashFlow, previousCashFlow);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CashFlow',
          style: bodyMedium.copyWith(fontWeight: FontWeight.w900),
        ),
        Text("\$$currentCashFlow", style: displayLarge),
        Row(
          children: [
            Text('This month ', style: bodyMedium.copyWith(color: greyColor)),
            Text(
              (difference > 0)
                  ? '+${difference.toStringAsFixed(2)}%'
                  : '${difference.toStringAsFixed(2)}%',
              style: bodyMedium.copyWith(
                  color:
                      (difference > 0) ? const Color(0xff088738) : Colors.red),
            )
          ],
        ),
        CashFlowGraph(cashFlowHistory: cashFlowHistory, targetCashFlow: 4500),
      ],
    );
  }

  _differnceInPercentage(current, previous) {
    var diff = current - previous;
    return (previous > 0) ? (diff * 100 / previous) : diff;
  }

  _incomeDetail() {
    Income? income =
        _gameTrackerService.getGameCurrentState().profession.income;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Income',
              style: titleLarge.copyWith(
                  fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          _statementBreakDownWidget('Salary', income!.salary ?? 0),
          const SizedBox(height: 10),
          _statementBreakDownWidget('Dividends', income.dividends ?? 0),
          const SizedBox(height: 10),
          _statementBreakDownWidget('Interest', income.interest ?? 0),
        ],
      ),
    );
  }

  _statementBreakDownWidget(String label, int amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: bodyMedium.copyWith(color: blackColor)),
            Text(formatCurrency(amount),
                style: bodyMedium.copyWith(color: greyColor))
          ]),
    );
  }

  _expenseDetail() {
    Expenses? expenses =
        _gameTrackerService.getGameCurrentState().profession.expenses;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Income',
              style: titleLarge.copyWith(
                  fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          _statementBreakDownWidget('Tax', expenses!.taxes ?? 0),
          const SizedBox(height: 10),
          _statementBreakDownWidget(
              'Mortgage Rent Pay', expenses.mortgageRentPay ?? 0),
          const SizedBox(height: 10),
          _statementBreakDownWidget(
              'School Loan Pay', expenses.schoolLoanPay ?? 0),
          _statementBreakDownWidget('Car Payment', expenses.carPayment ?? 0),
          const SizedBox(height: 10),
          _statementBreakDownWidget(
              'Credit Card Payment', expenses.carPayment ?? 0),
          const SizedBox(height: 10),
          _statementBreakDownWidget(
              'Retail Payment', expenses.retailPayment ?? 0),
          const SizedBox(height: 10),
          _statementBreakDownWidget(
              'Child Expense', expenses.perChildExpense ?? 0),
          const SizedBox(height: 10),
          _statementBreakDownWidget(
              'Other Expenses', expenses.otherExpenses ?? 0),
          const SizedBox(height: 10),
          _statementBreakDownWidget(
              'Child Expenses', expenses.childExpenses ?? 0),
          const SizedBox(height: 10),
          _statementBreakDownWidget(
              'Total Expenses', expenses.totalExpenses ?? 0),
        ],
      ),
    );
  }

  _gameOverview() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _statementBreakDownWidget('Cash on hand',
            _gameTrackerService.getGameCurrentState().cashOnHand),
        _statementBreakDownWidget('Expense', 580),
        _statementBreakDownWidget('Total income', 580),
        _statementBreakDownWidget('Pay day', 580),
      ],
    );
  }

  _gameActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(child: _actionMiniButton(() => {}, "Buy")),
            Expanded(child: _actionMiniButton(() => {}, "Sell")),
            Expanded(child: _actionMiniButton(() => {}, "Loan")),
          ]),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {},
                child: Text('Market Action',
                    style: bodyMedium.copyWith(color: Colors.white))),
          ),
        ],
      ),
    );
  }

  _actionMiniButton(Function action, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () => action(),
          child: Text(label, style: bodyMedium.copyWith(color: blackColor))),
    );
  }

  _incomeAndExpense() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _infoCard(
          'Income',
          '\$ ${_gameTrackerService.getGameCurrentState().monthlyIncome()}',
          Icons.attach_money,
        ),
        _infoCard(
          'Expense',
          '\$ ${_gameTrackerService.getGameCurrentState().monthlyExpense()}',
          Icons.attach_money,
        ),
      ],
    );
  }

  Card _infoCard(String title, String subTitle, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Icon(icon, size: 50),
            const SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: displayLarge.copyWith(fontSize: 20)),
                Text(subTitle, style: bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
