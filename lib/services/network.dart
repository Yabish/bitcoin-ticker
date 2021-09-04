import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'BF2CF75B-70E8-43D7-9157-BB43D0281815';

class NetworkHandler {
  Future<dynamic> getCurrencyDataFromWeb(String crypto, String currency) async {
    http.Response response = await http.get(
      Uri.parse('https://rest.coinapi.io/v1/exchangerate/$crypto/$currency'),
      headers: {'X-CoinAPI-Key': apiKey},
    );

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return null;
    }
  }
}
