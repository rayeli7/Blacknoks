import 'package:blacknoks/models/company_info_model.dart';
import 'package:flutter/material.dart';

class CompanyInfoPage extends StatelessWidget {
  final CompanyInfo stockInfo;
  const CompanyInfoPage({Key? key, required this.stockInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    '${stockInfo.company.name}',
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Expanded(child: Text('Ticker: ${stockInfo.name}')),
              stockInfo.capital != null
                  ? Expanded(child: Text('Capital: GH￠ ${stockInfo.capital}.'))
                  : Container(),
              stockInfo.shares != null
                  ? Expanded(child: Text('Shares: ${stockInfo.shares}'))
                  : Container(),
              Expanded(child: Text('Price: GH￠ ${stockInfo.price}.')),
              stockInfo.dps != null
                  ? Expanded(
                      child: Text('Dividend Per Share(DPS): ${stockInfo.dps}'))
                  : Container(),
              stockInfo.eps != null
                  ? Expanded(
                      child: Text('Earning Per Share(EPS): ${stockInfo.eps}'))
                  : Container(),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Company Info.',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              stockInfo.company.address != null
                  ? Expanded(
                      child: Text('Address: ${stockInfo.company.address}'))
                  : Container(),
              stockInfo.company.email != null
                  ? Expanded(
                      child: Text('Email Address: ${stockInfo.company.email}'))
                  : Container(),
              stockInfo.company.facsimile != null
                  ? Expanded(
                      child: Text('Facsimile: ${stockInfo.company.facsimile}'))
                  : Container(),
              stockInfo.company.telephone != null
                  ? Expanded(
                      child: Text('Telephone: ${stockInfo.company.telephone}'))
                  : Container(),
              stockInfo.company.sector != null
                  ? Expanded(child: Text('Sector: ${stockInfo.company.sector}'))
                  : Container(),
              stockInfo.company.industry != null
                  ? Expanded(
                      child: Text('Industry: ${stockInfo.company.industry}'))
                  : Container(),
              for (Director director in stockInfo.company.directors)
                Expanded(
                    child: Text(
                        'Directors: ${director.position} ${director.name}')),
            ],
          ),
        ),
      ),
    );
  }
}
