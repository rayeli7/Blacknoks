import 'package:http/http.dart' as http;

import '../../models/accesstoken_model.dart';

class MomoApiHelpers {
  static Future<String> getCollectionUUID() async {
    var headers = {
      'Authorization':
          'Bearer ' + (await MomoApiHelpers.getAccessToken()).accessToken,
    };
    var request = http.Request(
        'GET', Uri.parse('https://www.uuidgenerator.net/api/version4'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      return (data);
    } else {
      throw (Error);

      ///please check this code again !!!!
    }
  }

  static Future<AccessToken> getAccessToken() async {
    var headers = {
      'Ocp-Apim-Subscription-Key': 'b66795091e1842b5ad1c2a730bbd0db6',
      'Authorization':
          'Basic NTQ2MzRmODYtNjU3NC00Nzc3LTg0NjUtNzFjMGI2MmY4NDkzOjJjMDdkYWI3NTVjZjQ5MjViMTE1ZTg0ZmU4ZDE0N2Jl'
    };
    var request = http.Request('POST',
        Uri.parse('https://sandbox.momodeveloper.mtn.com/collection/token/'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      return (accessTokenFromJson(data));
    } else {
      throw (Error);

      ///please check this code again !!!!
    }
  }
}


