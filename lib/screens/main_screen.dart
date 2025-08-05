import 'package:flutter/material.dart';
import '../models/crypto_model.dart';
import '../services/api_service.dart';
import '../widgets/crypto_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final ScrollController _scrollController = ScrollController();

  List<CryptoModel> _cryptos = [];
  int _currentPage = 0;
  final int _limit = 15;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        _loadMore();
      }
    });
  }

  Future<void> _loadMore() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final newCryptos = await apiService.fetchCryptos(start: _currentPage * _limit, limit: _limit);
    setState(() {
      _cryptos.addAll(newCryptos);
      _currentPage++;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _cryptos.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _cryptos.length) {
            return CryptoTile(crypto: _cryptos[index]);
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
