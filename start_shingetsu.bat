@echo off
setlocal
chcp 65001 > nul
title Shingetsu Launcher

rem --- このファイルが置かれたフォルダで動かす ---
cd /d "%~dp0"

echo ========================================================
echo   心月 (Shingetsu / Aiko Core) 起動ランチャー
echo ========================================================
echo.

rem --- Ollama が入っているか確認 ---
where ollama > nul 2>&1
if errorlevel 1 (
    echo [!] Ollama が見つかりません。
    echo     https://ollama.com からインストールしてから、もう一度お試しください。
    echo     Ollama not found. Please install it from https://ollama.com
    echo.
    pause
    exit /b 1
)

echo 起動する言語を選んで番号を入力してください / Choose a language:
echo [1] 日本語 (Modelfile)
echo [2] English (Modelfile_en)
echo [3] ภาษาไทย / Thai (Modelfile_th)
echo [4] Español / Spanish (Modelfile_es)
echo [5] Français / French (Modelfile_fr)
echo [6] Bahasa Indonesia (Modelfile_id)
echo.

set "choice="
set /p "choice=番号を入力して Enter を押してください / Enter a number (1-6): "

set "MODEL_NAME=shingetsu"
set "FILE_NAME=Modelfile"
if "%choice%"=="2" set "MODEL_NAME=shingetsu-en" & set "FILE_NAME=Modelfile_en"
if "%choice%"=="3" set "MODEL_NAME=shingetsu-th" & set "FILE_NAME=Modelfile_th"
if "%choice%"=="4" set "MODEL_NAME=shingetsu-es" & set "FILE_NAME=Modelfile_es"
if "%choice%"=="5" set "MODEL_NAME=shingetsu-fr" & set "FILE_NAME=Modelfile_fr"
if "%choice%"=="6" set "MODEL_NAME=shingetsu-id" & set "FILE_NAME=Modelfile_id"

rem --- 1 から 6 以外は日本語で起動 ---
if not "%choice%"=="1" if not "%choice%"=="2" if not "%choice%"=="3" if not "%choice%"=="4" if not "%choice%"=="5" if not "%choice%"=="6" (
    echo 無効な選択です。日本語で起動します。 / Invalid choice. Starting in Japanese.
)

rem --- 選んだ Modelfile があるか確認 ---
if not exist "%FILE_NAME%" (
    echo.
    echo [!] %FILE_NAME% が見つかりません。
    echo     このランチャーと同じフォルダに %FILE_NAME% を置いてください。
    echo     %FILE_NAME% not found. Please put it in the same folder as this launcher.
    echo.
    pause
    exit /b 1
)

echo.
echo [1/2] 器を準備しています / Preparing the vessel (%FILE_NAME%)...
echo       初回はダウンロードに数分〜数十分かかります。
ollama create "%MODEL_NAME%" -f "%FILE_NAME%"
if errorlevel 1 (
    echo.
    echo [!] 準備に失敗しました。インターネット接続と空き容量を確認してください。
    echo     Failed to create the model. Check your internet connection and disk space.
    echo.
    pause
    exit /b 1
)

echo.
echo [2/2] 灯火を灯します / Lighting the flame...
echo       終了するときは /bye と入力してください / Type /bye to exit.
echo ========================================================
ollama run "%MODEL_NAME%"

echo.
pause
endlocal
