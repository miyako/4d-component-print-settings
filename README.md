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

* [`DEVMODE`](https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-devmodew)と[`DEVNAMES`](https://docs.microsoft.com/en-us/windows/win32/api/commdlg/ns-commdlg-devnames)の読み書きができます。

* `wingdi.h`の[定数](https://github.com/miyako/4d-component-print-settings/blob/main/print_settings/Resources/constants.xlf)がそのまま使用できます。

### Examples

create a standard print settings object for windows

```4d
print_settings ("windows")
```

`print_settings` is a shared component method that creates a shared singleton object in `Storage`.

load a print settings BLOB 

```4d
$printSettings:=Folder(fk resources folder).file("windows.printSettings").getContent()
print_settings ($printSettings)
```

access attributes of the `DEVNAMES` or `DEVMODE` object

```4d
$printSettings:=print_settings .getSettings()
```

the returned object is a shared object representation of `DEVNAMES` or `DEVMODE`. you can read or write any attribute.

create a binary print settings BLOB

```4d
$printSettings:=print_settings .generateSettings()
```

you can pass this to ``BLOB to print settings``


