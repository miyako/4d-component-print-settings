//%attributes = {}
C_LONGINT:C283($1;$colorOption)

$colorOption:=$1

If (Is Windows:C1573)
	If (0#Print settings to BLOB:C1433($printSettings))
		$size:=BLOB size:C605($printSettings)
		If (BLOB to longint:C551($printSettings;Macintosh byte ordering:K22:2)=0x44345350) | (BLOB to longint:C551($printSettings;PC byte ordering:K22:3)=0x50533444)
			
			C_LONGINT:C283($o)
			
			$o:=4
			
			$version:=BLOB to longint:C551($printSettings;PC byte ordering:K22:3;$o)
			If ($version=0x00020000)  //4D Pack is 0x00010000
				$jsonSize:=BLOB to longint:C551($printSettings;PC byte ordering:K22:3;$o)
				$nativeSize:=BLOB to longint:C551($printSettings;PC byte ordering:K22:3;$o)
				If ($size=($o+$jsonSize+$nativeSize))
					
					$o:=$o+$jsonSize
					
					C_BLOB:C604($platformData)
					COPY BLOB:C558($printSettings;$platformData;$o;0;4)
					$o:=$o+4
					
					If (0x5F4E4957=BLOB to longint:C551($platformData;Macintosh byte ordering:K22:2)) | (0x57494E5F=BLOB to longint:C551($platformData;PC byte ordering:K22:3))
						
						$nativeLength:=BLOB to longint:C551($printSettings;PC byte ordering:K22:3;$o)
						
						$version:=BLOB to longint:C551($printSettings;PC byte ordering:K22:3;$o)
						$DEVMODE_size:=BLOB to longint:C551($printSettings;PC byte ordering:K22:3;$o)
						$DEVNAMES_size:=BLOB to longint:C551($printSettings;PC byte ordering:K22:3;$o)
						
						$DEVMODE_start:=$o
						$DEVNAMES_start:=$o+$DEVMODE_size
						
						$o:=$DEVMODE_start+76
						
						$dmOrientation:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$dmPaperSize:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$dmPaperLength:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$dmPaperWidth:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$dmScale:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$dmCopies:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$dmDefaultSource:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$dmPrintQuality:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						
						INTEGER TO BLOB:C548($colorOption;$printSettings;PC byte ordering:K22:3;$o)
						  //$dmColor:=BLOB to integer($printSettings;PC byte ordering;$o)
						
						$dmDuplex:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$dmYResolution:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$dmTTOption:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$dmCollate:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						
						$CCHFORMNAME:=64  //32 * sizeof wchar_t
						COPY BLOB:C558($printSettings;$_dmFormName;$o;0;$CCHFORMNAME)
						$dmFormName:=Convert to text:C1012($_dmFormName;"utf-16le")
						$o:=$o+$CCHFORMNAME
						
						$dmLogPixels:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$dmBitsPerPel:=BLOB to longint:C551($printSettings;PC byte ordering:K22:3;$o)
						$dmPelsWidth:=BLOB to longint:C551($printSettings;PC byte ordering:K22:3;$o)
						$dmPelsHeight:=BLOB to longint:C551($printSettings;PC byte ordering:K22:3;$o)
						$dmNup:=BLOB to longint:C551($printSettings;PC byte ordering:K22:3;$o)
						
						$o:=$DEVNAMES_start
						
						$wDriverOffset:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$wDeviceOffset:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$wOutputOffset:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						$wDefault:=BLOB to integer:C549($printSettings;PC byte ordering:K22:3;$o)
						
						COPY BLOB:C558($printSettings;$_wDriver;$o;0;($wDeviceOffset-$wDriverOffset)*2)
						$o:=$o+BLOB size:C605($_wDriver)
						$wDriver:=Convert to text:C1012($_wDriver;"utf-16le")
						
						COPY BLOB:C558($printSettings;$_wDevice;$o;0;($wOutputOffset-$wDeviceOffset)*2)
						$o:=$o+BLOB size:C605($_wDevice)
						$wDevice:=Convert to text:C1012($_wDevice;"utf-16le")
						
						COPY BLOB:C558($printSettings;$_wOutput;$o;0;$DEVNAMES_size-($wOutputOffset*2))
						$o:=$o+BLOB size:C605($_wOutput)
						$wOutput:=Convert to text:C1012($_wOutput;"utf-16le")
						
						$status:=BLOB to print settings:C1434($printSettings)
						
					End if 
				End if 
			End if 
		End if 
	End if 
End if 