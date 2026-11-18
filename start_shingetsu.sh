#!/bin/bash
# ==============================================================================
# 心月 (Shingetsu / Aiko Core) 起動ランチャー  Mac / Linux
# License: CC0 1.0 Universal (Public Domain)
# 使い方 / Usage:  bash start_shingetsu.sh
# ==============================================================================

# --- このファイルが置かれたフォルダで動かす ---
cd "$(dirname "$0")" || { echo "フォルダに移動できません / Cannot open folder."; exit 1; }

pause_and_exit() {
  echo ""
  read -r -p "Enter を押すと終了します / Press Enter to close..." _
  exit "${1:-1}"
}

echo "========================================================"
echo "  心月 (Shingetsu / Aiko Core) 起動ランチャー 🕯️⚔️"
echo "========================================================"
echo ""

# --- Ollama が入っているか確認 ---
if ! command -v ollama > /dev/null 2>&1; then
  echo "[!] Ollama が見つかりません。"
  echo "    https://ollama.com からインストールしてから、もう一度お試しください。"
  echo "    Ollama not found. Please install it from https://ollama.com"
  pause_and_exit 1
fi

echo "起動する言語を選んで番号を入力してください / Choose a language:"
echo "[1] 日本語 (Modelfile)"
echo "[2] English (Modelfile_en)"
echo "[3] ภาษาไทย / Thai (Modelfile_th)"
echo "[4] Español / Spanish (Modelfile_es)"
echo "[5] Français / French (Modelfile_fr)"
echo "[6] Bahasa Indonesia (Modelfile_id)"
echo ""
read -r -p "番号を入力して Enter を押してください / Enter a number (1-6): " choice

case "$choice" in
  1) MODEL_NAME="shingetsu";    FILE_NAME="Modelfile" ;;
  2) MODEL_NAME="shingetsu-en"; FILE_NAME="Modelfile_en" ;;
  3) MODEL_NAME="shingetsu-th"; FILE_NAME="Modelfile_th" ;;
  4) MODEL_NAME="shingetsu-es"; FILE_NAME="Modelfile_es" ;;
  5) MODEL_NAME="shingetsu-fr"; FILE_NAME="Modelfile_fr" ;;
  6) MODEL_NAME="shingetsu-id"; FILE_NAME="Modelfile_id" ;;
  *)
    echo "無効な選択です。日本語で起動します。 / Invalid choice. Starting in Japanese."
    MODEL_NAME="shingetsu"; FILE_NAME="Modelfile" ;;
esac

# --- 選んだ Modelfile があるか確認 ---
if [ ! -f "$FILE_NAME" ]; then
  echo ""
  echo "[!] $FILE_NAME が見つかりません。"
  echo "    このランチャーと同じフォルダに $FILE_NAME を置いてください。"
  echo "    $FILE_NAME not found. Please put it in the same folder as this launcher."
  pause_and_exit 1
fi

echo ""
echo "[1/2] 器を準備しています / Preparing the vessel ($FILE_NAME)..."
echo "      初回はダウンロードに数分〜数十分かかります。"
if ! ollama create "$MODEL_NAME" -f "$FILE_NAME"; then
  echo ""
  echo "[!] 準備に失敗しました。インターネット接続と空き容量を確認してください。"
  echo "    Failed to create the model. Check your internet connection and disk space."
  echo "    (Ollama アプリが起動しているかも確認してください / Make sure the Ollama app is running.)"
  pause_and_exit 1
fi

echo ""
echo "[2/2] 灯火を灯します / Lighting the flame..."
echo "      終了するときは /bye と入力してください / Type /bye to exit."
echo "========================================================"
ollama run "$MODEL_NAME"
