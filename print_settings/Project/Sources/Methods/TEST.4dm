//%attributes = {}
print_settings ("windows")

$printSettings:=print_settings .getSettings()  //object

ASSERT:C1129(print_settings .setPrintOption("dmOrientation";$printSettings.DEVMODE.DUMMYUNIONNAME.DUMMYSTRUCTNAME.dmOrientation))
ASSERT:C1129(print_settings .setPrintOption("dmPaperSize";$printSettings.DEVMODE.DUMMYUNIONNAME.DUMMYSTRUCTNAME.dmPaperSize))
ASSERT:C1129(print_settings .setPrintOption("dmPaperLength";$printSettings.DEVMODE.DUMMYUNIONNAME.DUMMYSTRUCTNAME.dmPaperLength))
ASSERT:C1129(print_settings .setPrintOption("dmPaperWidth";$printSettings.DEVMODE.DUMMYUNIONNAME.DUMMYSTRUCTNAME.dmPaperWidth))
ASSERT:C1129(print_settings .setPrintOption("dmScale";$printSettings.DEVMODE.DUMMYUNIONNAME.DUMMYSTRUCTNAME.dmScale))
ASSERT:C1129(print_settings .setPrintOption("dmCopies";$printSettings.DEVMODE.DUMMYUNIONNAME.DUMMYSTRUCTNAME.dmCopies))
ASSERT:C1129(print_settings .setPrintOption("dmDefaultSource";$printSettings.DEVMODE.DUMMYUNIONNAME.DUMMYSTRUCTNAME.dmDefaultSource))
ASSERT:C1129(print_settings .setPrintOption("dmPrintQuality";$printSettings.DEVMODE.DUMMYUNIONNAME.DUMMYSTRUCTNAME.dmPrintQuality))
ASSERT:C1129(print_settings .setPrintOption("dmColor";$printSettings.DEVMODE.dmColor))
ASSERT:C1129(print_settings .setPrintOption("dmDuplex";$printSettings.DEVMODE.dmDuplex))
ASSERT:C1129(print_settings .setPrintOption("dmYResolution";$printSettings.DEVMODE.dmYResolution))
ASSERT:C1129(print_settings .setPrintOption("dmTTOption";$printSettings.DEVMODE.dmTTOption))
ASSERT:C1129(print_settings .setPrintOption("dmCollate";$printSettings.DEVMODE.dmCollate))
ASSERT:C1129(print_settings .setPrintOption("dmFormName";$printSettings.DEVMODE.dmFormName))
ASSERT:C1129(print_settings .setPrintOption("dmNup";$printSettings.DEVMODE.DUMMYUNIONNAME2.dmNup))
ASSERT:C1129(print_settings .setPrintOption("dmICMMethod";$printSettings.DEVMODE.dmICMMethod))
ASSERT:C1129(print_settings .setPrintOption("dmICMIntent";$printSettings.DEVMODE.dmICMIntent))
ASSERT:C1129(print_settings .setPrintOption("dmMediaType";$printSettings.DEVMODE.dmMediaType))
ASSERT:C1129(print_settings .setPrintOption("dmDitherType";$printSettings.DEVMODE.dmDitherType))
ASSERT:C1129(print_settings .setPrintOption("dmPanningWidth";$printSettings.DEVMODE.dmPanningWidth))
ASSERT:C1129(print_settings .setPrintOption("dmPanningHeight";$printSettings.DEVMODE.dmPanningHeight))

$printSettings:=print_settings .getSettings()  //object

$printSettings:=print_settings .generateSettings()  //blob

ASSERT:C1129(0<BLOB to print settings:C1434($printSettings))