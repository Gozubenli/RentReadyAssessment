import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/account.dart';

class AccountService {
  static String url = "https://aplusapi.webapptr.com/powerapp/";
  static const String _apiKey = "Aplus:423b59bd-8834-4c5c-8c6b-0565b1b4c379";

  static get getAuthKey {
    String authKey = "$_apiKey:powerApp";
    return authKey;
  }

  static get getBasicAuth {
    return 'Basic ${base64Encode(utf8.encode(getAuthKey))}';
  }

  static get getHeader {
    return <String, String>{
      'authorization': getBasicAuth,
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
  }

  static Future<List<Account>> getAccountList(String text) async {
    List<Account> list = [];
    var uri = Uri.parse('${url}PowerApp/GetAccountList');
    var response = await http.post(
      uri,
      headers: getHeader,
      body: jsonEncode({"Text": text}),
    );
    if (response.statusCode == 200) {
      list = parseAccount(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return list;
  }

  static List<Account> parseAccount(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Account>((json) => Account.fromJson(json)).toList();
  }
}
