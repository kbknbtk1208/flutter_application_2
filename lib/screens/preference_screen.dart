import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'suggestion_screen.dart';
// import '../models/preference.dart'; // モデルクラスを使う場合

class PreferenceScreen extends StatefulWidget {
  final List<Map<String, String>>
  selectedCultures; // [{id: '...', assetPath: '...'}]

  const PreferenceScreen({super.key, required this.selectedCultures});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  List<dynamic> _preferenceItems = []; // モデルクラスを使う場合は List<Preference>
  List<dynamic> _filteredItems = [];
  final Set<String> _selectedIds = {};
  final List<Map<String, String>> _selectedItemsData =
      []; // {id: '...', assetPath: '...'} のリスト

  @override
  void initState() {
    super.initState();
    _loadPreferenceData();
  }

  Future<void> _loadPreferenceData() async {
    final String response = await rootBundle.loadString(
      'assets/preference_images.json',
    );
    final data = await json.decode(response) as List;
    setState(() {
      _preferenceItems =
          data; // モデルクラスを使う場合は data.map((item) => Preference.fromJson(item)).toList();
      _filterPreferenceItems();
    });
  }

  void _filterPreferenceItems() {
    final selectedCultureIds =
        widget.selectedCultures.map((c) => c['id']).toSet();
    setState(() {
      _filteredItems =
          _preferenceItems.where((item) {
            // item['cultureId'] が selectedCultureIds に含まれていれば true
            return selectedCultureIds.contains(item['cultureId']);
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
      appBar: AppBar(title: const Text('Select Preference Images')),
      body: Column(
        children: [
          Expanded(
            child:
                _filteredItems.isEmpty
                    ? const Center(child: Text('No related images found.'))
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
                        final String id = item['id'];
                        final String assetPath = item['assetPath'];
                        final bool isSelected = _selectedIds.contains(id);

                        return GestureDetector(
                          onTap: () => _toggleSelection(id, assetPath),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(assetPath, fit: BoxFit.cover),
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
                        // 次画面に選択した項目のID配列を渡す
                        final selectedIds =
                            _selectedItemsData
                                .map((item) => item['id']!)
                                .toList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SuggestionScreen(
                                  selectedPreferenceIds: selectedIds,
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
