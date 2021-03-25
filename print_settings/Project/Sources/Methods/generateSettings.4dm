//%attributes = {"invisible":true}
C_BLOB:C604($printSettings)

$o:=0

$signature:=0x50533444
LONGINT TO BLOB:C550($signature;$printSettings;PC byte ordering:K22:3;$o)

$version:=0x00020000
LONGINT TO BLOB:C550($version;$printSettings;PC byte ordering:K22:3;$o)

$json_size_o:=$o
LONGINT TO BLOB:C550(0;$printSettings;PC byte ordering:K22:3;$o)  //json_size

$native_size_o:=$o
LONGINT TO BLOB:C550(0;$printSettings;PC byte ordering:K22:3;$o)  //native_size

If (Value type:C1509(This:C1470.jsonSettings)=Is object:K8:27)
	
	$jsonSettings:=JSON Stringify:C1217(This:C1470.jsonSettings)
	TEXT TO BLOB:C554($jsonSettings;$_jsonSettings;UTF8 text without length:K22:17)
	
	$jsonSize:=BLOB size:C605($_jsonSettings)
	COPY BLOB:C558($_jsonSettings;$printSettings;0;BLOB size:C605($printSettings);$jsonSize)
	$o:=$o+$jsonSize
	LONGINT TO BLOB:C550($jsonSize;$printSettings;PC byte ordering:K22:3;$json_size_o)
	
End if 

Case of 
		  //appl
	: (This:C1470.DEVMODE#Null:C1517)
		
		$platform:="WIN"
		
	Else 
		$platform:="???"
End case 

$version:=1

Case of 
	: ($platform="WIN")
		
		LONGINT TO BLOB:C550(0x57494E5F;$printSettings;PC byte ordering:K22:3;$o)
		
		$native_length_o:=$o
		LONGINT TO BLOB:C550(0;$printSettings;PC byte ordering:K22:3;$o)  //native_length
		
		C_BLOB:C604($_DEVMODE;$_DEVNAMES)
		
		C_OBJECT:C1216($DEVMODE;$DUMMYUNIONNAME;$DUMMYSTRUCTNAME;$DEVNAMES)
		
		$DEVMODE:=This:C1470.DEVMODE
		$DUMMYUNIONNAME:=$DEVMODE.DUMMYUNIONNAME
		$DUMMYSTRUCTNAME:=$DUMMYUNIONNAME.DUMMYSTRUCTNAME
		$DEVNAMES:=This:C1470.DEVNAMES
		
		If (Value type:C1509(This:C1470.DEVMODE.dmDeviceName)=Is text:K8:3)
			$dmDeviceName:=$DEVMODE.dmDeviceName
			CONVERT FROM TEXT:C1011($dmDeviceName;"utf-8";$_dmDeviceName)
			$CCHDEVICENAME:=64  //32 * sizeof wchar_t
			SET BLOB SIZE:C606($_dmDeviceName;$CCHDEVICENAME;0x0000)
			COPY BLOB:C558($_dmDeviceName;$_DEVMODE;0;BLOB size:C605($_DEVMODE);BLOB size:C605($_dmDeviceName))
		End if 
		
		$dmSpecVersion:=$DEVMODE.dmSpecVersion
		$dmDriverVersion:=$DEVMODE.dmDriverVersion
		$dmSize:=$DEVMODE.dmSize
		$dmDriverExtra:=$DEVMODE.dmDriverExtra
		
		INTEGER TO BLOB:C548($dmSpecVersion;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmDriverVersion;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmSize;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmDriverExtra;$_DEVMODE;PC byte ordering:K22:3;*)
		
		$dmFields:=0
		
		C_LONGINT:C283($dmBitsPerPel;$dmPelsWidth;$dmPelsHeight;$dmNup)
		
		C_LONGINT:C283($dmDisplayFrequency;$dmICMMethod;$dmICMIntent;$dmMediaType)
		C_LONGINT:C283($dmDitherType;$dmReserved1;$dmReserved2;$dmPanningWidth;$dmPanningHeight)
		
		C_LONGINT:C283($dmLogPixels)
		C_LONGINT:C283($dmOrientation;$dmPaperSize;$dmPaperLength;$dmPaperWidth)
		C_LONGINT:C283($dmScale;$dmCopies;$dmDefaultSource;$dmPrintQuality)
		C_LONGINT:C283($dmColor;$dmDuplex;$dmYResolution;$dmTTOption;$dmCollate)
		
		If (Value type:C1509($DUMMYSTRUCTNAME.dmOrientation)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 0
			$dmOrientation:=$DUMMYSTRUCTNAME.dmOrientation
		End if 
		
		If (Value type:C1509($DUMMYSTRUCTNAME.dmPaperSize)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 1
			$dmPaperSize:=$DUMMYSTRUCTNAME.dmPaperSize
		End if 
		
		If (Value type:C1509($DUMMYSTRUCTNAME.dmPaperLength)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 2
			$dmPaperLength:=$DUMMYSTRUCTNAME.dmPaperLength
		End if 
		
		If (Value type:C1509($DUMMYSTRUCTNAME.dmPaperWidth)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 3
			$dmPaperWidth:=$DUMMYSTRUCTNAME.dmPaperWidth
		End if 
		
		If (Value type:C1509($DUMMYSTRUCTNAME.dmScale)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 4
			$dmScale:=$DUMMYSTRUCTNAME.dmScale
		End if 
		
		If (Value type:C1509($DUMMYSTRUCTNAME.dmCopies)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 8
			$dmCopies:=$DUMMYSTRUCTNAME.dmCopies
		End if 
		
		If (Value type:C1509($DUMMYSTRUCTNAME.dmDefaultSource)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 9
			$dmDefaultSource:=$DUMMYSTRUCTNAME.dmDefaultSource
		End if 
		
		If (Value type:C1509($DUMMYSTRUCTNAME.dmPrinterQuality)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 10
			$dmPrintQuality:=$DUMMYSTRUCTNAME.dmPrinterQuality
		End if 
		
		If (Value type:C1509($DEVMODE.dmColor)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 11
			$dmColor:=$DEVMODE.dmColor
		End if 
		
		
		
		
		
		
		
		
		If (Value type:C1509($DUMMYSTRUCTNAME.dmNup)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 6
			$dmNup:=$DUMMYSTRUCTNAME.dmNup
		End if 
		
		  //7: DM_DISPLAYORIENTATION not used for printers
		
		If (Value type:C1509($DEVMODE.dmDuplex)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 12
			$dmDuplex:=$DEVMODE.dmDuplex
		End if 
		
		If (Value type:C1509($DEVMODE.dmYResolution)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 13
			$dmYResolution:=$DEVMODE.dmYResolution
		End if 
		
		If (Value type:C1509($DEVMODE.dmTTOption)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 14
			$dmTTOption:=$DEVMODE.dmTTOption
		End if 
		
		If (Value type:C1509($DEVMODE.dmCollate)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 15
			$dmCollate:=$DEVMODE.dmCollate
		End if 
		
		If (Value type:C1509($DEVMODE.dmFormName)=Is text:K8:3)
			$dmFields:=$dmFields ?+ 16
		End if 
		
		  //17: DM_LOGPIXELS not used for printers
		  //18: DM_BITSPERPEL not used for printers
		  //19: DM_PELSWIDTH not used for printers
		  //20: DM_PELSHEIGHT not used for printers
		  //21: DM_DISPLAYFLAGS not used for printers
		  //22: DM_DISPLAYFREQUENCY not used for printers
		
		If (Value type:C1509($DEVMODE.dmICMMetHod)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 23
			$dmICMMethod:=$DEVMODE.dmICMMetHod
		End if 
		
		If (Value type:C1509($DEVMODE.dmICMintent)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 24
			$dmICMIntent:=$DEVMODE.dmICMintent
		End if 
		
		If (Value type:C1509($DEVMODE.dmMediaType)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 25
			$dmMediaType:=$DEVMODE.dmMediaType
		End if 
		
		If (Value type:C1509($DEVMODE.dmDitherType)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 26
			$dmDitherType:=$DEVMODE.dmDitherType
		End if 
		
		If (Value type:C1509($DEVMODE.dmPanningWidth)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 27
			$dmPanningWidth:=$DEVMODE.dmPanningWidth
		End if 
		
		If (Value type:C1509($DEVMODE.dmPanningHeight)=Is real:K8:4)
			$dmFields:=$dmFields ?+ 28
			$dmPanningHeight:=$DEVMODE.dmPanningHeight
		End if 
		
		  //29: DM_DISPLAYFIXEDOUTPUT not used for printers
		
		LONGINT TO BLOB:C550($dmFields;$_DEVMODE;PC byte ordering:K22:3;*)
		
		INTEGER TO BLOB:C548($dmOrientation;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmPaperSize;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmPaperLength;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmPaperWidth;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmScale;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmCopies;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmDefaultSource;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmPrintQuality;$_DEVMODE;PC byte ordering:K22:3;*)
		
		INTEGER TO BLOB:C548($dmColor;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmDuplex;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmYResolution;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmTTOption;$_DEVMODE;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($dmCollate;$_DEVMODE;PC byte ordering:K22:3;*)
		
		$dmFormName:=$DEVMODE.dmFormName
		CONVERT FROM TEXT:C1011($dmFormName;"utf-8";$_dmFormName)
		$CCHFORMNAME:=64  //32 * sizeof wchar_t
		SET BLOB SIZE:C606($_dmFormName;$CCHFORMNAME;0x0000)
		COPY BLOB:C558($_dmFormName;$_DEVMODE;0;BLOB size:C605($_DEVMODE);BLOB size:C605($_dmFormName))
		
		INTEGER TO BLOB:C548($dmLogPixels;$_DEVMODE;PC byte ordering:K22:3;*)
		
		LONGINT TO BLOB:C550($dmBitsPerPel;$_DEVMODE;PC byte ordering:K22:3;*)
		LONGINT TO BLOB:C550($dmPelsWidth;$_DEVMODE;PC byte ordering:K22:3;*)
		LONGINT TO BLOB:C550($dmPelsHeight;$_DEVMODE;PC byte ordering:K22:3;*)
		LONGINT TO BLOB:C550($dmNup;$_DEVMODE;PC byte ordering:K22:3;*)
		
		LONGINT TO BLOB:C550($dmDisplayFrequency;$_DEVMODE;PC byte ordering:K22:3;*)
		LONGINT TO BLOB:C550($dmICMMethod;$_DEVMODE;PC byte ordering:K22:3;*)
		LONGINT TO BLOB:C550($dmICMIntent;$_DEVMODE;PC byte ordering:K22:3;*)
		LONGINT TO BLOB:C550($dmMediaType;$_DEVMODE;PC byte ordering:K22:3;*)
		LONGINT TO BLOB:C550($dmDitherType;$_DEVMODE;PC byte ordering:K22:3;*)
		LONGINT TO BLOB:C550($dmReserved1;$_DEVMODE;PC byte ordering:K22:3;*)
		LONGINT TO BLOB:C550($dmReserved2;$_DEVMODE;PC byte ordering:K22:3;*)
		LONGINT TO BLOB:C550($dmPanningWidth;$_DEVMODE;PC byte ordering:K22:3;*)
		LONGINT TO BLOB:C550($dmPanningHeight;$_DEVMODE;PC byte ordering:K22:3;*)
		
		If (Value type:C1509(This:C1470.DEVMODE_PRIVATE)=Is text:K8:3)
			$driverData:=This:C1470.DEVMODE_PRIVATE
			C_BLOB:C604($_driverData)
			BASE64 DECODE:C896($driverData;$_driverData)
			
			ASSERT:C1129($dmSize=BLOB size:C605($_DEVMODE))
			ASSERT:C1129($dmDriverExtra=BLOB size:C605($_driverData))
			
			COPY BLOB:C558($_driverData;$_DEVMODE;0;$dmSize;$dmDriverExtra)
		End if 
		
		C_BLOB:C604($_DEVNAMES)
		
		C_TEXT:C284($wDriver;$wDevice;$wOutput)
		C_LONGINT:C283($wDefault)
		
		If (Value type:C1509($DEVNAMES.wDriver)=Is text:K8:3)
			$wDriver:=$DEVNAMES.wDriver
		End if 
		
		If (Value type:C1509($DEVNAMES.wDevice)=Is text:K8:3)
			$wDevice:=$DEVNAMES.wDevice
		End if 
		
		If (Value type:C1509($DEVNAMES.wOutput)=Is text:K8:3)
			$wOutput:=$DEVNAMES.wOutput
		End if 
		
		If (Value type:C1509($DEVNAMES.wDefault)=Is real:K8:4)
			$wDefault:=$DEVNAMES.wDefault
		End if 
		
		CONVERT FROM TEXT:C1011($wDriver;"utf-16le";$_wDriver)
		$wDriverOffset:=4
		
		CONVERT FROM TEXT:C1011($wDevice;"utf-16le";$_wDevice)
		$wDeviceOffset:=$wDriverOffset+Length:C16($wDriver)
		
		CONVERT FROM TEXT:C1011($wOutput;"utf-16le";$_wOutput)
		$wOutputOffset:=$wDeviceOffset+Length:C16($wDevice)
		
		INTEGER TO BLOB:C548($wDriverOffset;$_DEVNAMES;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($wDeviceOffset;$_DEVNAMES;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($wOutputOffset;$_DEVNAMES;PC byte ordering:K22:3;*)
		INTEGER TO BLOB:C548($wDefault;$_DEVNAMES;PC byte ordering:K22:3;*)
		
		COPY BLOB:C558($_wDriver;$_DEVNAMES;0;$wDriverOffset*2;BLOB size:C605($_wDriver))
		COPY BLOB:C558($_wDevice;$_DEVNAMES;0;$wDeviceOffset*2;BLOB size:C605($_wDevice))
		COPY BLOB:C558($_wOutput;$_DEVNAMES;0;$wOutputOffset*2;BLOB size:C605($_wOutput))
		
		$DEVMODE_size:=BLOB size:C605($_DEVMODE)
		$DEVNAMES_size:=BLOB size:C605($_DEVNAMES)
		
		LONGINT TO BLOB:C550($version;$printSettings;PC byte ordering:K22:3;$o)
		LONGINT TO BLOB:C550($DEVMODE_size;$printSettings;PC byte ordering:K22:3;$o)
		LONGINT TO BLOB:C550($DEVNAMES_size;$printSettings;PC byte ordering:K22:3;$o)
		
		COPY BLOB:C558($_DEVMODE;$printSettings;0;BLOB size:C605($printSettings);$DEVMODE_size)
		COPY BLOB:C558($_DEVNAMES;$printSettings;0;BLOB size:C605($printSettings);$DEVNAMES_size)
		
		$nativeSize:=$DEVMODE_size+$DEVNAMES_size+20  //native_length+version+devmode_size+devnames_size
		LONGINT TO BLOB:C550($nativeSize;$printSettings;PC byte ordering:K22:3;$native_size_o)
		LONGINT TO BLOB:C550($nativeSize;$printSettings;PC byte ordering:K22:3;$native_length_o)
		
	: ($platform="MAC")
		
End case 

$0:=$printSettings