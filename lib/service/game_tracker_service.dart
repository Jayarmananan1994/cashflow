import 'package:cashflow/model/portfolio_model.dart';
import 'package:cashflow/model/profession_model.dart';

class GameTrackerService {
  late GameState _gameState;

  startGame(ProfessionModel professionModel) {
    var expenses = extractExpenseList(
        professionModel.expenses, professionModel.liabilities);

    _gameState = GameState(
      profession: professionModel,
      expenses: expenses,
    );
  }

  GameState getGameCurrentState() {
    return _gameState;
  }

  List<double> getCashFlowHistory() {
    return _gameState.currentCashFlow();
    //return [200, 450, 670, 500, 1900, 2000, 3000, 3400, 4500];
  }

  void addPortfolio(PortfolioModel? selectedPortfolio) {}

  extractExpenseList(Expenses? expenses, Liabilities? liabilities) {
    if (expenses != null && liabilities != null) {
      return [
        Expense(ExpenseType.mortgage, liabilities.mortgage,
            expenses.mortgageRentPay, true),
        Expense(ExpenseType.other, expenses.otherExpenses,
            expenses.otherExpenses, false),
        Expense(ExpenseType.tax, expenses.taxes, expenses.taxes, false),
        Expense(ExpenseType.carLoan, liabilities.carLoans, expenses.carPayment,
            true),
        Expense(ExpenseType.creditCard, liabilities.creditCards,
            expenses.creditCardPayment, true),
      ];
    }
    return [];
  }
}

class GameState {
  List<double> cashFlow = [200, 450, 670, 500, 1900, 2000, 3000, 3400, 5500];
  ProfessionModel profession;
  List<GameAction> actionHistory = [];
  int cashOnHand;
  List<Stock> stocks = [];
  List<StockOption> stockOptions = [];
  List<RealEstate> realEstate = [];
  List<Royality> royality = [];
  List<Expense> expenses = [];

  GameState({required this.profession, required this.expenses})
      : cashOnHand = profession.assets?.savings ?? 0;

  @override
  String toString() {
    return '{"profession":"${profession.toJson()}", "actionHistory": $actionHistory}';
  }

  double monthlyExpense() {
    return expenses
        .map((e) => e.interestAmount)
        .map((e) => e.toDouble())
        .reduce((value, element) => value + element);
  }

  double monthlyIncome() {
    return profession.income?.salary.toDouble() ?? 0;
  }

  List<double> currentCashFlow() {
    return cashFlow;
  }
}

class GameAction {
  String actionName;
  double actionValue;
  GameAction({required this.actionName, required this.actionValue});
}

class Stock {
  StockSymbol symbol;
  int price;
  int units;
  Stock(this.symbol, this.price, this.units);
}

class StockOption {
  StockSymbol symbol;
  OptionType optionType;
  int price;
  int strikePrice;
  int units;
  StockOption(
      this.symbol, this.optionType, this.price, this.strikePrice, this.units);
}

class RealEstate {
  String name;
  int unit;
  int cashFlow;
  int pricePerUnit;
  RealEstate(this.name, this.unit, this.cashFlow, this.pricePerUnit);
}

class Royality {
  String name;
  int price;
  int cashFlow;
  Royality(this.name, this.price, this.cashFlow);
}

class Expense {
  ExpenseType expenseType;
  int amount;
  int interestAmount;
  bool isRepayable;
  Expense(this.expenseType, this.amount, this.interestAmount, this.isRepayable);
}

enum StockSymbol { myt4u, ok4u }

enum OptionType { put, call }

enum ExpenseType { tax, carLoan, bankLoan, creditCard, mortgage, other }
