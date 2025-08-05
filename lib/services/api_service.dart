import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto_model.dart';

class ApiService {
  static const String _baseUrl = 'https://api.binance.com/api/v3/ticker/price';

  Future<List<CryptoModel>> fetchCryptos({int start = 0, int limit = 15}) async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data
          .skip(start)
          .take(limit)
          .map((item) => CryptoModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load crypto data');
    }
  }
}
