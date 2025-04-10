import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import './preference_screen.dart';
// import '../models/culture.dart'; // モデルクラスを使う場合

class CultureScreen extends StatefulWidget {
  final DateTime fromDate;
  final DateTime toDate;

  const CultureScreen({
    super.key,
    required this.fromDate,
    required this.toDate,
  });

  @override
  State<CultureScreen> createState() => _CultureScreenState();
}

class _CultureScreenState extends State<CultureScreen> {
  List<dynamic> _cultureItems = []; // モデルクラスを使う場合は List<Culture>
  List<dynamic> _filteredItems = [];
  final Set<String> _selectedIds = {};
  final List<Map<String, String>> _selectedItemsData =
      []; // {id: '...', assetPath: '...'} のリスト

  @override
  void initState() {
    super.initState();
    _loadCultureData();
  }

  Future<void> _loadCultureData() async {
    final String response = await rootBundle.loadString(
      'assets/japan_culture.json',
    );
    final data = await json.decode(response) as List;
    setState(() {
      _cultureItems =
          data; // モデルクラスを使う場合は data.map((item) => Culture.fromJson(item)).toList();
      _filterCultureItems();
    });
  }

  void _filterCultureItems() {
    final int fromMonth = widget.fromDate.month;
    final int toMonth = widget.toDate.month;
    final int fromYear = widget.fromDate.year;
    final int toYear = widget.toDate.year;

    // 月の範囲を計算 (年をまたぐ場合も考慮)
    Set<int> targetMonths = {};
    if (fromYear == toYear) {
      for (int m = fromMonth; m <= toMonth; m++) {
        targetMonths.add(m);
      }
    } else {
      // 開始年
      for (int m = fromMonth; m <= 12; m++) {
        targetMonths.add(m);
      }
      // 間の年 (あれば)
      for (int y = fromYear + 1; y < toYear; y++) {
        for (int m = 1; m <= 12; m++) {
          targetMonths.add(m);
        }
      }
      // 終了年
      for (int m = 1; m <= toMonth; m++) {
        targetMonths.add(m);
      }
    }

    setState(() {
      _filteredItems =
          _cultureItems.where((item) {
            // item['month'] が List<int> であることを想定
            final List<int> itemMonths = List<int>.from(item['month']);
            // itemMonths のいずれかが targetMonths に含まれていれば true
            return itemMonths.any((month) => targetMonths.contains(month));
          }).toList();
    });
  }

  void _toggleSelection(String id, String assetPath) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
        _selectedItemsData.removeWhere((item) => item['id'] == id);
      } else {
        _selectedIds.add(id);
        _selectedItemsData.add({'id': id, 'assetPath': assetPath});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Cultural Images')),
      body: Column(
        children: [
          Expanded(
            child:
                _filteredItems.isEmpty
                    ? const Center(
                      child: CircularProgressIndicator(),
                    ) // または「該当なし」表示
                    : GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3列表示
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        final String id = item['id']; // モデルクラス未使用の場合
                        final String assetPath =
                            item['assetPath']; // モデルクラス未使用の場合
                        final bool isSelected = _selectedIds.contains(id);
                        print(assetPath);
                        return GestureDetector(
                          onTap: () => _toggleSelection(id, assetPath),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                assetPath, // アセットパス
                                fit: BoxFit.cover,
                              ),
                              if (isSelected)
                                Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed:
                  _selectedIds.isNotEmpty
                      ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PreferenceScreen(
                                  selectedCultures: _selectedItemsData,
                                ),
                          ),
                        );
                      }
                      : null,
              child: const Text('select'),
            ),
          ),
        ],
      ),
    );
  }
}
