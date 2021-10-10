import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'ADA',
  'BNB',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'API-KEY'; // for ref: E75B854F-66A1-4271-B682-2A1E96960CF6

class CoinData {
  Future getCoinData(String? selectedeCurrency) async {
    Map<String, String>? cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedeCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } 
      else {
        print(response.statusCode);   // debug console , if #429 means 100 req limit exceeded.
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
