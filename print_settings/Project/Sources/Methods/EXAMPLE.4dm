//%attributes = {}
/*

windowsでプリンターをモノクロにするには

*/

$success:=print_settings ("windows").setPrintOption("dmColor";DMCOLOR_MONOCHROME)

$printSettings:=print_settings .generateSettings()

$success:=(0<BLOB to print settings:C1434($printSettings))