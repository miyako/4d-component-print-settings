//%attributes = {}
$printSettings:=Folder:C1567(fk resources folder:K87:11).file("windows.printSettings").getContent()  //WindowsでPrint settings to BLOBを実行して作成

print_settings ($printSettings)
print_settings .setPrintOption("dmColor";2)  // 1 (DMCOLOR_MONOCHROME), 2 (DMCOLOR_COLOR)
print_settings .setPrintOption("dmDuplex";2)  // 1 (DMDUP_SIMPLEX), 2 (DMDUP_VERTICAL), 3 (DMDUP_HORIZONTAL)
print_settings .setPrintOption("dmNup";2)  // 1 (DMNUP_SYSTEM), 2 (DMNUP_ONEUP)
print_settings .setPrintOption("dmDefaultSource";2)  // 1 (DMBIN_UPPER), 2 (DMBIN_LOWER), 3 (DMBIN_MIDDLE)...
print_settings .setPrintOption("dmPrintQuality";-3)  //DPI or -1 (DMRES_DRAFT), -2 (DMRES_LOW), -3 (DMRES_MEDIUM), -4 (DMRES_HIGH)
print_settings .setPrintOption("dmPaperSize";3)  // 1 (DMPAPER_LETTER), 2 (DMPAPER_LETTERSMALL), 3 (DMPAPER_TABLOID)...
print_settings .setPrintOption("dmOrientation";3)  // 1 (DMORIENT_PORTRAIT), 2 (DMORIENT_LANDSCAPE)

$printSettings:=print_settings .getSettings()  //オブジェクト型で返す

$printSettings:=print_settings .generateSettings()  //BLOBに変換

$status:=BLOB to print settings:C1434($printSettings)  //印刷設定を変更