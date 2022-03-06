import 'dart:convert';

import 'package:blacknoks/models/flutterwave_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../api_helpers/payment_helpers.dart';

class FlutterWaveApi {
  static Future<FlutterWaveResponse> postRequestToPay(
      double amount, String ticker) async {
    var headers = {
      'Authorization': 'Bearer FLWSECK_TEST-c9fb0c5c6722ff9e176e33f287d7e318-X',
      'Content-Type': 'application/json'
    };
    Request request = http.Request(
        'POST',
        Uri.parse(
            'https://api.flutterwave.com/v3/charges?type=mobile_money_ghana'));
    request.body = json.encode({
      "tx_ref": "MC-158523s09v5050e8",
      "amount": "$amount",
      "currency": "GHS",
      "voucher": "143256743",
      "network": "MTN",
      "email": "developers@flutterwavego.com",
      "phone_number": "0554421283",
      "fullname": "Flutterwave Developers",
      "client_ip": "154.123.220.1",
      "device_fingerprint": "62wd23423rq324323qew1",
      "meta": {"Asset": "$ticker"}
    });
    request.headers.addAll(headers);

    final response = await request.send().timeout(Duration(seconds: 5));

    final respStr = await response.stream.bytesToString();

    final FlutterWaveResponse flutterWaveResponse =
        flutterWaveResponseFromJson(respStr);

    print(flutterWaveResponse.message);

    return flutterWaveResponse;
  }
}

class MomoApi {
  static Future<http.StreamedResponse> postRequestToPay(
      double amount, String ticker) async {
    var headers = {
      'X-Reference-Id': await PaymentApiHelpers.getCollectionUUID(),
      //changes with every transaction
      'X-Target-Environment': 'sandbox',
      'Ocp-Apim-Subscription-Key':
          'b66795091e1842b5ad1c2a730bbd0db6', //does not change for a user
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ' + (await PaymentApiHelpers.getAccessToken()).accessToken,
      //Authorization(i.e acces token)changes with every transaction
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay'));
    request.body = json.encode({
      "amount": "$amount",
      "currency": "EUR",
      "externalId": "635368786",
      "payer": {"partyIdType": "MSISDN", "partyId": "0554421283"},
      "payerMessage": "Stock Purchase Order Received $amount of $ticker",
      "payeeNote": "The Transaction Is Being Processed"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
}
