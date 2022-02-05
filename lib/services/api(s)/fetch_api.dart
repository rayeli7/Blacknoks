import 'package:http/http.dart' as http;
import 'dart:async';

const baseUrl = "https://dev.kwayisi.org/apis/gse/live";
const baseInfoUrl ="https://dev.kwayisi.org/apis/gse/equities/";//change url variable names

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
