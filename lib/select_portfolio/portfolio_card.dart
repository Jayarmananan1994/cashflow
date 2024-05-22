import 'package:cashflow/model/portfolio_model.dart';
import 'package:cashflow/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PortfolioCard extends StatelessWidget {
  final PortfolioModel portfolio;
  final Color bgColor;
  const PortfolioCard(
      {super.key, required this.portfolio, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      //margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(CupertinoIcons.briefcase),
            title: Text('ID: ${portfolio.portfolioId}'),
            //subtitle: Text('Cash: \$${portfolio.cash}'),
          ),
          ListTile(
            title: Text('Cash',
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Text("\$ ${portfolio.cash}"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('Stocks',
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
          ),
          if (portfolio.stocks.isNotEmpty) ...[
            for (var stock in portfolio.stocks)
              ListTile(
                title: Text('${stock['name']} @ \$${stock['pricePerShare']}'),
                subtitle: Text('No. of Share: \$${stock['quantity']}'),
              ),
          ],
          if (portfolio.stocks.isEmpty) ...[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Text('Not Available', style: bodyMedium),
            )
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('Real Estate',
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
          ),
          if (portfolio.realEstate.isNotEmpty) ...[
            for (var realEstate in portfolio.realEstate)
              ListTile(
                title: Text('${realEstate['type']}'),
                subtitle: Text('CashFlow: \$${realEstate['cashFlowPerMonth']}'),
              ),
          ],
          if (portfolio.realEstate.isEmpty) ...[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Text('Not Available', style: bodyMedium),
            )
          ],
        ],
      ),
    );
  }
}
