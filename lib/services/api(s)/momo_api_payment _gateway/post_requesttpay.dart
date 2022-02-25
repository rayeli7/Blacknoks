import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../api_helpers/momo_api_helpers.dart';

class MomoApi {
  static Future<http.StreamedResponse> postRequestToPay(double amount, String ticker) async {
    var headers = {
      'X-Reference-Id': await MomoApiHelpers.getCollectionUUID(),
      //changes with every transaction
      'X-Target-Environment': 'sandbox',
      'Ocp-Apim-Subscription-Key':
          'b66795091e1842b5ad1c2a730bbd0db6', //does not change for a user
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ' + (await MomoApiHelpers.getAccessToken()).accessToken,
      //Authorization(i.e acces token)changes with every transaction
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay'));
    request.body = json.encode({
      "amount": "$amount",
      "currency": "EUR",
      "externalId": "635368786",//TODO 2: Add id generator
      "payer": {"partyIdType": "MSISDN", "partyId": "0554421283"},//TODO 1: Add field for phone number
      "payerMessage": "Stock Purchase Order Received $amount of $ticker",
      "payeeNote": "The Transaction Is Being Processed"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
}
