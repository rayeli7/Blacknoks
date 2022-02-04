import 'dart:convert';

import 'package:blacknoks/models/company_info_model.dart';
import 'package:blacknoks/services/api(s)/fetch_api.dart';
import 'package:flutter/material.dart';

class CompanyInfoPage extends StatefulWidget {
  final String stockName;
  const CompanyInfoPage({Key? key,required this.stockName}) : super(key: key);

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
CompanyInfo? stockInfo;



  _getStockInfo() {
    API.getStockInfo(widget.stockName).then((response) {
      setState(() {
        final jsonResponse = json.decode(response.body);
        stockInfo = CompanyInfo.fromJson(jsonResponse);
      });
    });
  }



  @override
  initState() {
    super.initState();
      _getStockInfo();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text('${stockInfo?.company?.name}'),
      ),
    );
  }
}