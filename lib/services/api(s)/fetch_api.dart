import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import '../../models/company_info_model.dart';

const baseUrl = "https://dev.kwayisi.org/apis/gse/live";
const baseInfoUrl =
    "https://dev.kwayisi.org/apis/gse/equities/"; //change url variable names

class API {
  static Future getLiveStockData() {
    var url = baseUrl;
    return http.get(Uri.parse(url));
  }

  static Future getStockInfo(String symbol) {
    var url = baseInfoUrl + symbol;
    return http.get(Uri.parse(url));
  }
}

Future<CompanyInfo> getStockInfo(stockName) async {
  var response = await API.getStockInfo(stockName);
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return CompanyInfo.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load album');
  }
}

const GSE_Companies = [
  'AngloGold Ashanti Depository Shares',
  'Access Bank Ghana Plc',
  'Agricultural Development Bank',
  'AngloGold Ashanti Limited',
  'Aluworks Limited',
  'Benso Oil Palm Plantation Limited',
  'CAL Bank Limited',
  'Clydestone Ghana Limited',
  'Camelot Ghana Ltd',
  'Cocoa Processing Company Limited',
  'Dannex Ayrton Starwin Plc',
  'Digicut Advertising and Production Limited',
  'Ecobank Ghana Ltd',
  'Enterprise Group Limited',
  'Ecobank Transnational Incorporated',
  'Fan Milk PLC',
  'Ghana Commercial Bank Limited',
  'Guinness Ghana Breweries Limited',
  'NewGold Issuer (RF) Limited',
  'Ghana Oil Company Limited',
  'HORDS Limited',
  'Intravenous Infusions Limited',
  'Mega African Capital Limited',
  'Meridian-Marshalls Holdings',
  'Scancom PLC',
  'Produce Buying Company Ltd.',
  'Pesewa One Plc',
  'Republic Bank Ghana Limited',
  'Samba Foods Ltd',
  'Standard Chartered Bank (Ghana) Limited',
  'Standard Chartered Bank (Ghana) Limited',
  'SIC Insurance Company Limited',
  'Societe Generale Ghana Limited',
  'Trust Bank (GAMBIA) Limited',
  'Tullow Oil Plc',
  'Total Petroleum Ghana Limited',
  'Unilever Ghana Limited',
];
