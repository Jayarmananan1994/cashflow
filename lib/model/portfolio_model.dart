class PortfolioModel {
  final int portfolioId;
  final int cash;
  final List<dynamic> stocks;
  final List<dynamic> realEstate;

  PortfolioModel({
    required this.portfolioId,
    required this.cash,
    required this.stocks,
    required this.realEstate,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      portfolioId: json['portfolioId'],
      cash: json['cash'],
      stocks: json['stocks'],
      realEstate: json['realEstate'],
    );
  }
}
