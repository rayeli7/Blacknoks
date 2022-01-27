import 'package:http/http.dart' as http;
import 'dart:async';

const baseUrl = "https://dev.kwayisi.org/apis/gse/live";
const baseInfoUrl ="https://dev.kwayisi.org/apis/gse/equities/";

class API {
  static Future getLiveStockData() {
    var url = baseUrl;
    return http.get(Uri.parse(url));
  }
  static Future getStockInfo(String symbol){
    var url = baseInfoUrl+symbol;
    return http.get(Uri.parse(url));
  }
}

class CompanyInfo {
  double? capital;
  List? company;
  double? dps;
  double? eps;
  String? name;
  double? price;
  int? shares;

  CompanyInfo(this.capital, this.name, this.price, this.shares, this.company, this.dps, this.eps);
 
  CompanyInfo.fromJson(Map json)
      : capital = json['capital'],
        name = json['name'],
        price = json['price'],
        shares = json['shares'],
        company = json['company'],
        dps = json['shares'],
        eps = json['price'];

  Map toJson() {
    return {'capital': capital, 'name': name, 'price': price, 'shares': shares, 'company':company, 'dps': dps, 'eps': eps};
  }
}

class LiveStockData {
  double? change;
  String? name;
  double? price;
  int? volume;

  LiveStockData(this.change, this.name, this.price, this.volume);
 
  LiveStockData.fromJson(Map json)
      : change = json['change'],
        name = json['name'],
        price = json['price'],
        volume = json['volume'];

  Map toJson() {
    return {'change': change, 'name': name, 'price': price, 'volume': price};
  }
}

// ignore: constant_identifier_names
const GSE_Companies=
['AngloGold Ashanti Depository Shares',
'Access Bank Ghana Plc',
'Agricultural Development Bank',
'AngloGold Ashanti Limited',
'Aluworks LTD',
'Benso Oil Palm Plantation Ltd',
'CalBank PLC',
'Clydestone (Ghana) Limited',
'Camelot Ghana Ltd',
'Cocoa Processing Company',
'Dannex Ayrton Starwin Plc',
'Digicut Advertising and Production Limited',
'Ecobank Ghana Ltd',
'Enterprise Ghana PLC',
'Ecobank Transnational Incorporation',
'Fan Milk Limited','Ghana Commercial Bank Limited',
'Guinness Ghana Breweries Plc',
'NewGold Issuer Limited',
'Ghana Oil Company Limited',
'Golden Star Resources Ltd.',
'HORDS LTD',
'Intravenous Infusions Limited',
'Mega African Capital Limited',
'Meridian-Marshalls Holdings',
'MTN Ghana',
'Produce Buying Company Ltd.',
'Pesewa One Plc',
'Republic Bank (Ghana) PLC',
'Samba Foods Ltd',
'Standard Chartered Bank Ghana PLC',
'SIC Insurance Company Limited',
'Societe Generale Ghana Limited',
'Sam Wood Ltd.',
'Trust Bank Limited (THE GAMBIA)',
'Tullow Oil Plc',
'TOTAL PETROLEUM GHANA PLC',
'Unilever Ghana PLC',
];
