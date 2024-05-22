class ProfessionModel {
  String? profession;
  Income? income;
  int? passiveIncome;
  int? totalIncome;
  Expenses? expenses;
  int? monthlyCashFlow;
  Assets? assets;
  Liabilities? liabilities;

  ProfessionModel(
      {profession,
      income,
      passiveIncome,
      totalIncome,
      expenses,
      monthlyCashFlow,
      assets,
      liabilities});

  ProfessionModel.fromJson(Map<String, dynamic> json) {
    profession = json['profession'];
    income = json['income'] != null ? Income.fromJson(json['income']) : null;
    passiveIncome = json['passive_income'];
    totalIncome = json['total_income'];
    expenses =
        json['expenses'] != null ? Expenses.fromJson(json['expenses']) : null;
    monthlyCashFlow = json['monthly_cash_flow'];
    assets = json['assets'] != null ? Assets.fromJson(json['assets']) : null;
    liabilities = json['liabilities'] != null
        ? Liabilities.fromJson(json['liabilities'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profession'] = profession;
    if (income != null) {
      data['income'] = income!.toJson();
    }
    data['passive_income'] = passiveIncome;
    data['total_income'] = totalIncome;
    if (expenses != null) {
      data['expenses'] = expenses!.toJson();
    }
    data['monthly_cash_flow'] = monthlyCashFlow;
    if (assets != null) {
      data['assets'] = assets!.toJson();
    }
    if (liabilities != null) {
      data['liabilities'] = liabilities!.toJson();
    }
    return data;
  }
}

class Income {
  int salary = 0;
  int interest = 0;
  int dividends = 0;

  Income({salary, interest, dividends});

  Income.fromJson(Map<String, dynamic> json) {
    salary = json['salary'];
    interest = json['interest'];
    dividends = json['dividends'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['salary'] = salary;
    data['interest'] = interest;
    data['dividends'] = dividends;
    return data;
  }
}

class Expenses {
  int taxes;
  int mortgageRentPay;
  int schoolLoanPay;
  int carPayment;
  int creditCardPayment;
  int retailPayment;
  int perChildExpense;
  int otherExpenses;
  int childExpenses;
  int totalExpenses;

  Expenses({
    this.taxes = 0,
    this.mortgageRentPay = 0,
    this.schoolLoanPay = 0,
    this.carPayment = 0,
    this.creditCardPayment = 0,
    this.retailPayment = 0,
    this.perChildExpense = 0,
    this.otherExpenses = 0,
    this.childExpenses = 0,
    this.totalExpenses = 0,
  });

  Expenses.fromJson(Map<String, dynamic> json)
      : taxes = json['taxes'] ?? 0,
        mortgageRentPay = json['mortgage_rent_pay'] ?? 0,
        schoolLoanPay = json['school_loan_pay'] ?? 0,
        carPayment = json['car_payment'] ?? 0,
        creditCardPayment = json['credit_card_payment'] ?? 0,
        retailPayment = json['retail_payment'] ?? 0,
        perChildExpense = json['per_child_expense'] ?? 0,
        otherExpenses = json['other_expenses'] ?? 0,
        childExpenses = json['child_expenses'] ?? 0,
        totalExpenses = json['total_expenses'] ?? 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taxes'] = taxes;
    data['mortgage_rent_pay'] = mortgageRentPay;
    data['school_loan_pay'] = schoolLoanPay;
    data['car_payment'] = carPayment;
    data['credit_card_payment'] = creditCardPayment;
    data['retail_payment'] = retailPayment;
    data['per_child_expense'] = perChildExpense;
    data['other_expenses'] = otherExpenses;
    data['child_expenses'] = childExpenses;
    data['total_expenses'] = totalExpenses;
    return data;
  }

  int fetchTotatlExpense() {
    return taxes +
        mortgageRentPay +
        schoolLoanPay +
        carPayment +
        creditCardPayment +
        retailPayment +
        perChildExpense +
        otherExpenses +
        childExpenses;
  }
}

class Assets {
  int? savings;

  Assets({savings});

  Assets.fromJson(Map<String, dynamic> json) {
    savings = json['savings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['savings'] = savings;
    return data;
  }
}

class Liabilities {
  int mortgage = 0;
  int schoolLoans = 0;
  int carLoans = 0;
  int creditCards = 0;
  int retailDebt = 0;

  Liabilities({mortgage, schoolLoans, carLoans, creditCards, retailDebt});

  Liabilities.fromJson(Map<String, dynamic> json) {
    mortgage = json['mortgage'];
    schoolLoans = json['school_loans'];
    carLoans = json['car_loans'];
    creditCards = json['credit_cards'];
    retailDebt = json['retail_debt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mortgage'] = mortgage;
    data['school_loans'] = schoolLoans;
    data['car_loans'] = carLoans;
    data['credit_cards'] = creditCards;
    data['retail_debt'] = retailDebt;
    return data;
  }
}
