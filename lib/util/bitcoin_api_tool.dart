import 'package:http/http.dart' as http;
import 'dart:convert';

class BitCoinAPI {
  static Future<String> fetchValue() async {
    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["bpi"]["USD"]["rate_float"];
    } else {
      throw Exception('Failed to return value');
    }
  }
}
