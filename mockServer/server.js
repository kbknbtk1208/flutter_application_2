const express = require("express");
const app = express();
const port = 3050;

// JSONリクエストボディをパースするためのミドルウェア
app.use(express.json());

// POSTリクエストハンドラー
app.post("/", (req, res) => {
  console.log("Received POST request:", req.body);
  // ダミーデータの生成
  const dummyData = {
    region: "北海道", // 例として北海道を設定
    spots: [
      { id: "spot1", assetPath: "assets/images/spot/fireworks_1.jpg" },
      { id: "spot1", assetPath: "assets/images/spot/fireworks_2.jpg" },
      { id: "spot1", assetPath: "assets/images/spot/fireworks_3.jpg" },
    ],
  };

  console.log("Received POST request. Sending dummy data:", dummyData);
  res.json(dummyData);
});

app.listen(port, () => {
  console.log(`Mock server listening at http://localhost:${port}`);
});
