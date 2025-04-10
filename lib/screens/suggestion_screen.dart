import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'plan_detail_screen.dart';
// import '../models/suggestion.dart'; // モデルクラスを使う場合

class SuggestionScreen extends StatefulWidget {
  final List<String> selectedPreferenceIds;

  const SuggestionScreen({super.key, required this.selectedPreferenceIds});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  bool _isLoading = true;
  List<dynamic> _suggestions = []; // モデルクラスを使う場合は List<Suggestion>
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchSuggestions();
  }

  Future<void> _fetchSuggestions() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final url = Uri.parse('http://localhost:3050'); // サーバーのエンドポイント
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      'ids': widget.selectedPreferenceIds,
    }); // サーバーが期待する形式に合わせる

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        setState(() {
          // モデルクラスを使う場合は data.map((item) => Suggestion.fromJson(item)).toList();
          _suggestions = data;
          _isLoading = false;
        });
      } else {
        // サーバーエラー
        setState(() {
          _error =
              'Failed to load suggestions. Status code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      // ネットワークエラーなど
      setState(() {
        _error = 'Failed to connect to the server: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suggested Plans')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      // ローディング表示 (スケルトンUIの代わり)
      return const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      // エラー表示
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _error!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (_suggestions.isEmpty) {
      // 結果なし
      return const Center(
        child: Text('No suggestions found for your preferences.'),
      );
    } else {
      // 結果リスト表示
      return ListView.builder(
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = _suggestions[index];
          final String region = suggestion['region']; // モデル未使用の場合
          final List<dynamic> spots = suggestion['spots']; // モデル未使用の場合

          return ListTile(
            title: Text(region),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PlanDetailScreen(
                        // Map<String, dynamic> として渡す
                        suggestionData: Map<String, dynamic>.from(suggestion),
                      ),
                ),
              );
            },
          );
        },
      );
    }
  }
}
