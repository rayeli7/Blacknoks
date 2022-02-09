import 'dart:convert';
import 'package:blacknoks/services/helpers/momo_api_helpers.dart';
import 'package:http/http.dart' as http;

class MomoApi {
  static Future<http.StreamedResponse> postRequestToPay() async {
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
      "amount": "5.0",
      "currency": "EUR",
      "externalId": "635368786",
      "payer": {"partyIdType": "MSISDN", "partyId": "0248888736"},
      "payerMessage": "Pay for product a",
      "payeeNote": "payer note"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
}
