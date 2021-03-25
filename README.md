![version](https://img.shields.io/badge/version-18%2B-EB8E5F)
[![license](https://img.shields.io/github/license/miyako/4d-component-print-settings)](LICENSE)

# 4d-component-print-settings
Windowsの印刷設定をダイレクトに制御


```4d
/*
	
	windowsでプリンターをモノクロにするには
	
*/

$success:=print_settings ("windows").setPrintOption("dmColor";DMCOLOR_MONOCHROME)

$printSettings:=print_settings .generateSettings()

$success:=(0<BLOB to print settings($printSettings))
```

`wingdi.h`の定数がそのまま使用できます。

---

<img width="1061" alt="スクリーンショット 2021-03-24 21 56 12" src="https://user-images.githubusercontent.com/1725068/112314045-e6a97300-8ceb-11eb-9e19-c29dce79f649.png">

[`DEVMODE`](https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-devmodew)と[`DEVNAMES`](https://docs.microsoft.com/en-us/windows/win32/api/commdlg/ns-commdlg-devnames)の読み書き

[Color option](https://doc.4d.com/4Dv17/4D/17.5/Print-Options.302-5255443.ja.html)が設定できる・・・かもしれない
