import 'package:flutter/material.dart';

class PlanDetailScreen extends StatelessWidget {
  // データは Map<String, dynamic> 型で受け取る想定
  final Map<String, dynamic> suggestionData;

  const PlanDetailScreen({super.key, required this.suggestionData});

  @override
  Widget build(BuildContext context) {
    final String region = suggestionData['region'] as String;
    // spots は {id: string, assetPath: string}[] のリストのはず
    final List<dynamic> spots = suggestionData['spots'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text('Plan Details: $region')),
      body: ListView.builder(
        itemCount: spots.length,
        itemBuilder: (context, index) {
          final spot = spots[index] as Map<String, dynamic>; // 各スポットはMapのはず
          final String assetPath = spot['assetPath'] as String; // アセットパスを取得

          // 各リスト項目に余白を追加
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Card(
              // 見た目を良くするためにCardウィジェットを使用 (任意)
              clipBehavior: Clip.antiAlias, // 画像をCardの境界でクリップ
              child: AspectRatio(
                // 画像のアスペクト比を固定 (任意)
                aspectRatio: 16 / 9,
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.cover, // 画像がコンテナ全体を覆うように
                  // エラーハンドリング (任意)
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.broken_image, size: 40),
                    );
                  },
                ),
              ),
              // 必要であればスポット名などを表示する Text を追加
              // child: Column(
              //   children: [
              //     Image.asset(assetPath, fit: BoxFit.cover),
              //     // Text(spot['name'] ?? 'Spot ${spot['id']}'), // 例
              //   ],
              // )
            ),
          );
        },
      ),
    );
  }
}
