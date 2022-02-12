import 'dart:convert';

import 'package:blacknoks/models/company_info_model.dart';
import 'package:blacknoks/services/api(s)/fetch_api.dart';
import 'package:flutter/material.dart';

class CompanyInfoPage extends StatelessWidget {
  final CompanyInfo stockInfo;
  const CompanyInfoPage({Key? key, required this.stockInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${stockInfo.company?.name}',
                style: const TextStyle(fontSize: 30),
              ),
              Text('Ticker: ${stockInfo.name}'),
              Text('Capital: GH￠ ${stockInfo.capital}.'),
              Text('Shares: ${stockInfo.shares}'),
              Text('Price: GH￠ ${stockInfo.price}.'),
              Text('Dividend Per Share(DPS): ${stockInfo.dps}'),
              Text('Earning Per Share(EPS): ${stockInfo.eps}'),
              const Text(
                'Company Info.',
                style: TextStyle(fontSize: 25),
              ),
              Text('Address: ${stockInfo.company?.address}'),
              Text('${stockInfo.company?.email}'),
              Text('${stockInfo.company?.facsimile}'),
              Text('${stockInfo.company?.telephone}'),
              Text('${stockInfo.company?.sector}'),
              Text('${stockInfo.company?.industry}'),
              Text('Directors: ${stockInfo.company?.directors}'),
            ],
          ),
        ),
      ),
    );
  }
}
