#!/data/data/com.termux/files/usr/bin/bash
pkg update -y
pkg install -y wget curl jq

echo "📦 Tải Termux APK..."
wget -O termux.apk "https://f-droid.org/repo/com.termux_1022.apk"

echo "📦 Tải MT2 APK..."
wget -O mt2.apk "https://pan.mt2.cn/mt/MT2.18.5.apk"

echo "📦 Tải file từ GoFile..."
GOFILE_LINK="https://gofile.io/d/jNMujL"
API_RESPONSE=$(curl -s "https://api.gofile.io/getContent?contentId=$(basename $GOFILE_LINK)&format=json")
STATUS=$(echo "$API_RESPONSE" | jq -r '.status')
if [ "$STATUS" != "ok" ]; then
  echo "❌ Lỗi khi truy cập GoFile."
  exit 1
fi
GOFILE_URL=$(echo "$API_RESPONSE" | jq -r '.data.contents[] | .link' | head -n 1)
echo "➡️ Tải: $GOFILE_URL"
wget -O gofile_file "$GOFILE_URL"

echo ""
echo "✅ Xong! Các file đã nằm ở:"
ls -lh termux.apk mt2.apk gofile_file
