import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // 観光スポットのデータ
  final List<TourismSpot> tourismSpots = [
    TourismSpot(
      name: "谷根千エリア（谷中・根津・千駄木）",
      latitude: 35.7277,
      longitude: 139.7687,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "神楽坂",
      latitude: 35.7015,
      longitude: 139.7403,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "清澄白河（現代アートギャラリーエリア）",
      latitude: 35.6824,
      longitude: 139.7989,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "等々力渓谷",
      latitude: 35.6069,
      longitude: 139.6497,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "深川江戸資料館",
      latitude: 35.6731,
      longitude: 139.7989,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "鞍馬寺",
      latitude: 35.1213,
      longitude: 135.7702,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "大原三千院",
      latitude: 35.1141,
      longitude: 135.8266,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "桂離宮",
      latitude: 34.9915,
      longitude: 135.6930,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "半木の道（なからぎのみち）",
      latitude: 35.0271,
      longitude: 135.7553,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "宇治川の鵜飼",
      latitude: 34.8916,
      longitude: 135.8066,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "有松絞りの町並み",
      latitude: 35.0796,
      longitude: 136.9746,
      prefecture: "愛知県",
    ),
    TourismSpot(
      name: "四間道（しけみち）",
      latitude: 35.1623,
      longitude: 136.8906,
      prefecture: "愛知県",
    ),
    TourismSpot(
      name: "徳川園",
      latitude: 35.1872,
      longitude: 136.9292,
      prefecture: "愛知県",
    ),
    TourismSpot(
      name: "トヨタ産業技術記念館",
      latitude: 35.1856,
      longitude: 136.8918,
      prefecture: "愛知県",
    ),
    TourismSpot(
      name: "白壁・主税・撞木エリア",
      latitude: 35.1810,
      longitude: 136.9126,
      prefecture: "愛知県",
    ),
    TourismSpot(
      name: "キッテ丸の内",
      latitude: 35.6798,
      longitude: 139.7670,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "根津美術館",
      latitude: 35.6607,
      longitude: 139.7209,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "旧古河庭園",
      latitude: 35.7456,
      longitude: 139.7473,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "葛西臨海水族園",
      latitude: 35.6364,
      longitude: 139.8575,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "谷中霊園",
      latitude: 35.7277,
      longitude: 139.7672,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "下町風俗資料館",
      latitude: 35.7155,
      longitude: 139.7965,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "馬喰町問屋街",
      latitude: 35.6910,
      longitude: 139.7823,
      prefecture: "東京都",
    ),
    TourismSpot(
      name: "寂光院",
      latitude: 35.1187,
      longitude: 135.8213,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "龍安寺 西源院",
      latitude: 35.0354,
      longitude: 135.7185,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "峰定寺",
      latitude: 35.0376,
      longitude: 135.7798,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "京都府立植物園",
      latitude: 35.0492,
      longitude: 135.7605,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "嵯峨鳥居本",
      latitude: 35.0167,
      longitude: 135.6686,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "酢屋",
      latitude: 35.0043,
      longitude: 135.7718,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "燈明の小路",
      latitude: 35.0041,
      longitude: 135.7758,
      prefecture: "京都府",
    ),
    TourismSpot(
      name: "岡崎市美術博物館",
      latitude: 34.9536,
      longitude: 137.1716,
      prefecture: "愛知県",
    ),
    TourismSpot(
      name: "犬山城下町",
      latitude: 35.3867,
      longitude: 136.9408,
      prefecture: "愛知県",
    ),
    TourismSpot(
      name: "大須商店街",
      latitude: 35.1598,
      longitude: 136.9036,
      prefecture: "愛知県",
    ),
    TourismSpot(
      name: "熱田神宮神池庭園",
      latitude: 35.1255,
      longitude: 136.9103,
      prefecture: "愛知県",
    ),
    TourismSpot(
      name: "ノリタケの森",
      latitude: 35.1856,
      longitude: 136.8818,
      prefecture: "愛知県",
    ),
    TourismSpot(
      name: "名古屋市科学館",
      latitude: 35.1651,
      longitude: 136.9060,
      prefecture: "愛知県",
    ),
    TourismSpot(
      name: "彦根城下町",
      latitude: 35.2750,
      longitude: 136.2598,
      prefecture: "滋賀県",
    ),
    TourismSpot(
      name: "三島スカイウォーク",
      latitude: 35.1833,
      longitude: 138.9333,
      prefecture: "静岡県",
    ),
    TourismSpot(
      name: "吉野山",
      latitude: 34.3667,
      longitude: 135.8833,
      prefecture: "奈良県",
    ),
  ];

  // 都道府県のリスト（重複を排除するため）
  late List<String> prefectures;
  
  // 選択された都道府県（初期値は東京都）
  String selectedPrefecture = "東京都";
  
  // Google Map コントローラ
  GoogleMapController? mapController;
  
  // 表示するマーカーのセット
  Set<Marker> markers = {};
  
  // マップの初期位置
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(35.6812, 139.7671), // 東京都の中心あたり
    zoom: 12.0,
  );

  @override
  void initState() {
    super.initState();
    // 都道府県リストを生成
    prefectures = tourismSpots.map((spot) => spot.prefecture).toSet().toList();
    // 初期マーカーを設定
    _updateMarkers();
  }

  // 選択された都道府県に基づいてマーカーを更新
  void _updateMarkers() {
    final filteredSpots = tourismSpots.where(
      (spot) => spot.prefecture == selectedPrefecture
    ).toList();
    
    // マーカーを生成
    markers = filteredSpots.map((spot) {
      return Marker(
        markerId: MarkerId(spot.name),
        position: LatLng(spot.latitude, spot.longitude),
        infoWindow: InfoWindow(
          title: spot.name,
          snippet: spot.prefecture,
        ),
      );
    }).toSet();
    
    // マップの中心位置を更新（フィルタされたスポットの最初の位置）
    if (filteredSpots.isNotEmpty && mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(filteredSpots[0].latitude, filteredSpots[0].longitude), 
          11.0
        ),
      );
    }
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('観光スポットマップ'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // 都道府県選択ドロップダウン
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.teal.shade50,
            child: Row(
              children: [
                const Text('都道府県: ', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedPrefecture,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedPrefecture = newValue;
                          _updateMarkers();
                        });
                      }
                    },
                    items: prefectures
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          
          // Google Map
          Expanded(
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapToolbarEnabled: true,
              zoomControlsEnabled: true,
              compassEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}

// 観光スポットモデルクラス
class TourismSpot {
  final String name;
  final double latitude;
  final double longitude;
  final String prefecture;

  TourismSpot({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.prefecture,
  });
}
