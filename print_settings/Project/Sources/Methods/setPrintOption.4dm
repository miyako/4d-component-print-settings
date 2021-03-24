//%attributes = {"invisible":true}
C_TEXT:C284($1;$option)
C_VARIANT:C1683($2)

$option:=$1

$printSettings:=This:C1470.getSettings()

Case of 
	: ($printSettings.DEVMODE#Null:C1517)  //windows
		
		Case of 
			: ($option="dmNup")
				
				$DUMMYUNIONNAME2:=$printSettings.DEVMODE.DUMMYUNIONNAME2
				
				Use ($DUMMYUNIONNAME2)
					$DUMMYUNIONNAME2[$option]:=$2
				End use 
				
			: ($option="dmColor")\
				 | ($option="dmDuplex")\
				 | ($option="dmYResolution")\
				 | ($option="dmTTOption")\
				 | ($option="dmCollate")\
				 | ($option="dmFormName")\
				 | ($option="dmICMMethod")\
				 | ($option="dmICMIntent")\
				 | ($option="dmMediaType")\
				 | ($option="dmDitherType")\
				 | ($option="dmReserved1")\
				 | ($option="dmReserved2")\
				 | ($option="dmPanningWidth")\
				 | ($option="dmPanningHeight")
				
				$DEVMODE:=$printSettings.DEVMODE
				
				Use ($DEVMODE)
					$DEVMODE[$option]:=$2
				End use 
				
			: ($option="dmOrientation")\
				 | ($option="dmPaperSize")\
				 | ($option="dmPaperLength")\
				 | ($option="dmPaperWidth")\
				 | ($option="dmScale")\
				 | ($option="dmCopies")\
				 | ($option="dmDefaultSource")\
				 | ($option="dmPrintQuality")
				
				$DUMMYSTRUCTNAME:=$printSettings.DEVMODE.DUMMYUNIONNAME.DUMMYSTRUCTNAME
				
				Use ($DUMMYSTRUCTNAME)
					$DUMMYSTRUCTNAME[$option]:=$2
				End use 
				
		End case 
		
End case 