import 'dart:math';
import 'package:flutter/material.dart';
import '../models/crypto_model.dart';

class CryptoTile extends StatelessWidget {
  final CryptoModel crypto;

  CryptoTile({required this.crypto});

  Color _generateRandomColor() {
    Random random = Random();
    return Color.fromARGB(255, random.nextInt(256), random.nextInt(256), random.nextInt(256)).withOpacity(0.1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: _generateRandomColor(), borderRadius: BorderRadius.circular(18)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(crypto.symbol, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, fontFamily: 'SF Pro Text',))],
            ),
          ),
          Text(
            '\$${crypto.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'SF Pro Text',),
          ),
        ],
      ),
    );
  }
}
