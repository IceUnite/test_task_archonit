class CryptoModel {
  final String symbol;
  final double price;

  CryptoModel({required this.symbol, required this.price});

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      symbol: json['symbol'],
      price: double.parse(json['price']),
    );
  }
}
