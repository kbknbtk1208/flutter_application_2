import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 日付フォーマット用 (必要なら pubspec に追加)
import 'culture_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  DateTime? _fromDate;
  DateTime? _toDate;

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)), // 2年後まで選択可
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
          // To日付がFrom日付より前にならないように調整 (任意)
          if (_toDate != null && _toDate!.isBefore(_fromDate!)) {
            _toDate = _fromDate;
          }
        } else {
          _toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 日付フォーマッタ
    final DateFormat formatter = DateFormat('yyyy/MM/dd');

    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'welcome',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              const Text('Select your travel dates:'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDate(context, true),
                    child: Text(
                      _fromDate == null
                          ? 'From'
                          : 'From: ${formatter.format(_fromDate!)}',
                    ),
                  ),
                  const Text('～'),
                  ElevatedButton(
                    onPressed:
                        _fromDate == null
                            ? null
                            : () => _selectDate(
                              context,
                              false,
                            ), // Fromが選択されてからToを選択可能に
                    child: Text(
                      _toDate == null
                          ? 'To'
                          : 'To: ${formatter.format(_toDate!)}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed:
                    (_fromDate != null && _toDate != null)
                        ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CultureScreen(
                                    fromDate: _fromDate!,
                                    toDate: _toDate!,
                                  ),
                            ),
                          );
                        }
                        : null, // 日付が両方選択されるまで非活性
                child: const Text('next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
