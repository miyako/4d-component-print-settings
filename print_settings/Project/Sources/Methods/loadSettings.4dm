//%attributes = {"invisible":true}
C_VARIANT:C1683($1)

Case of 
	: (Value type:C1509($1)=Is BLOB:K8:12)
		
		$size:=BLOB size:C605($1)
		
		If ($size>3)
			
			  //PS4D or D4SP
			If (BLOB to longint:C551($1;Macintosh byte ordering:K22:2)=0x44345350) | (BLOB to longint:C551($1;PC byte ordering:K22:3)=0x50533444)
				
				$o:=4
				
				$version:=BLOB to longint:C551($1;PC byte ordering:K22:3;$o)
				
				If ($version=0x00020000)  //4D Pack is 0x00010000
					
					$jsonSize:=BLOB to longint:C551($1;PC byte ordering:K22:3;$o)
					$nativeSize:=BLOB to longint:C551($1;PC byte ordering:K22:3;$o)
					
					If ($size=($o+$jsonSize+$nativeSize))
						
						$jsonSettings:=New shared object:C1526
						
						Use (This:C1470)
							This:C1470.jsonSettings:=$jsonSettings
						End use 
						
						$json:=BLOB to text:C555($1;UTF8 text without length:K22:17;$o;$jsonSize)
						$_jsonSettings:=JSON Parse:C1218($json;Is object:K8:27)
						
						Use ($jsonSettings)
							For each ($prop;$_jsonSettings)
								$jsonSettings[$prop]:=$_jsonSettings[$prop]
							End for each 
						End use 
						
						C_BLOB:C604($platformData)
						COPY BLOB:C558($1;$platformData;$o;0;4)
						
						Case of 
								  //appl
							: (0x6170706C=BLOB to longint:C551($platformData;Macintosh byte ordering:K22:2)) | (0x6C707061=BLOB to longint:C551($platformData;PC byte ordering:K22:3))
								$platform:="MAC"
								  //WIN_
							: (0x5F4E4957=BLOB to longint:C551($platformData;Macintosh byte ordering:K22:2)) | (0x57494E5F=BLOB to longint:C551($platformData;PC byte ordering:K22:3))
								$platform:="WIN"
							Else 
								$platform:="???"
						End case 
						
						$nativeSign:=BLOB to longint:C551($platformData;PC byte ordering:K22:3)
						
						$o:=$o+4
						
						$nativeLength:=BLOB to longint:C551($1;PC byte ordering:K22:3;$o)
						
						C_BLOB:C604($nativeData)
						COPY BLOB:C558($1;$nativeData;$o;0;BLOB size:C605($1)-$o)
						$nativeSize:=BLOB size:C605($nativeData)
						
						$o:=0
						
						Case of 
							: ($platform="WIN")
								
								$version:=BLOB to longint:C551($nativeData;PC byte ordering:K22:3;$o)
								$DEVMODE_size:=BLOB to longint:C551($nativeData;PC byte ordering:K22:3;$o)
								$DEVNAMES_size:=BLOB to longint:C551($nativeData;PC byte ordering:K22:3;$o)
								
								C_BLOB:C604($_DEVMODE;$_DEVNAMES)
								COPY BLOB:C558($nativeData;$_DEVMODE;$o;0;$DEVMODE_size)
								$o:=$o+$DEVMODE_size
								COPY BLOB:C558($nativeData;$_DEVNAMES;$o;0;$DEVNAMES_size)
								
								$o:=0
								
								  //DEVNAMES
								$wDriverOffset:=BLOB to integer:C549($_DEVNAMES;PC byte ordering:K22:3;$o)
								$wDeviceOffset:=BLOB to integer:C549($_DEVNAMES;PC byte ordering:K22:3;$o)
								$wOutputOffset:=BLOB to integer:C549($_DEVNAMES;PC byte ordering:K22:3;$o)
								$wDefault:=BLOB to integer:C549($_DEVNAMES;PC byte ordering:K22:3;$o)
								
								COPY BLOB:C558($_DEVNAMES;$_wDriver;$wDriverOffset*2;0;($wDeviceOffset-$wDriverOffset)*2)
								$wDriver:=Convert to text:C1012($_wDriver;"utf-16le")
								
								COPY BLOB:C558($_DEVNAMES;$_wDevice;$wDeviceOffset*2;0;($wOutputOffset-$wDeviceOffset)*2)
								$wDevice:=Convert to text:C1012($_wDevice;"utf-16le")
								
								COPY BLOB:C558($_DEVNAMES;$_wOutput;$wOutputOffset*2;0;BLOB size:C605($_DEVNAMES)-($wOutputOffset*2))
								$wOutput:=Convert to text:C1012($_wOutput;"utf-16le")
								
								$DEVNAMES:=New shared object:C1526
								
								Use (This:C1470)
									This:C1470.DEVNAMES:=$DEVNAMES
								End use 
								
								Use ($DEVNAMES)
									$DEVNAMES.wDriver:=$wDriver
									$DEVNAMES.wDevice:=$wDevice
									$DEVNAMES.wOutput:=$wOutput
									$DEVNAMES.wDefault:=$wDefault
								End use 
								
								$o:=0
								
								  //DEVMODE
								$CCHDEVICENAME:=64  //32 * sizeof wchar_t
								COPY BLOB:C558($_DEVMODE;$_dmDeviceName;$o;0;$CCHDEVICENAME)
								$dmDeviceName:=Convert to text:C1012($_dmDeviceName;"utf-16le")
								$o:=$o+$CCHDEVICENAME
								
								$dmSpecVersion:=BLOB to integer:C549($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmDriverVersion:=BLOB to integer:C549($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmSize:=BLOB to integer:C549($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmDriverExtra:=BLOB to integer:C549($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmFields:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								
								COPY BLOB:C558($_DEVMODE;$_driverData;$dmSize;0;$dmDriverExtra)
								C_TEXT:C284($driverData)
								BASE64 ENCODE:C895($_driverData;$driverData)
								Use (This:C1470)
									This:C1470.DEVMODE_PRIVATE:=$driverData
								End use 
								
								COPY BLOB:C558($_DEVMODE;$_DUMMYSTRUCTNAME;$o;0;16)
								$o:=$o+16
								$dmColor:=BLOB to integer:C549($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmDuplex:=BLOB to integer:C549($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmYResolution:=BLOB to integer:C549($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmTTOption:=BLOB to integer:C549($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmCollate:=BLOB to integer:C549($_DEVMODE;PC byte ordering:K22:3;$o)
								
								$CCHFORMNAME:=64  //32 * sizeof wchar_t
								COPY BLOB:C558($_DEVMODE;$_dmFormName;$o;0;$CCHFORMNAME)
								$dmFormName:=Convert to text:C1012($_dmFormName;"utf-16le")
								$o:=$o+$CCHFORMNAME
								
								$dmLogPixels:=BLOB to integer:C549($_DEVMODE;PC byte ordering:K22:3;$o)
								
								$dmBitsPerPel:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmPelsWidth:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmPelsHeight:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								
								$pos:=$o
								$dmDisplayFlags:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$pos)
								$pos:=$o
								$dmNup:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								
								$dmDisplayFrequency:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmICMMethod:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmICMIntent:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmMediaType:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmDitherType:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmReserved1:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmReserved2:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmPanningWidth:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								$dmPanningHeight:=BLOB to longint:C551($_DEVMODE;PC byte ordering:K22:3;$o)
								
								$o:=0
								$dmOrientation:=BLOB to integer:C549($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								$dmPaperSize:=BLOB to integer:C549($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								$dmPaperLength:=BLOB to integer:C549($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								$dmPaperWidth:=BLOB to integer:C549($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								$dmScale:=BLOB to integer:C549($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								$dmCopies:=BLOB to integer:C549($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								$dmDefaultSource:=BLOB to integer:C549($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								$dmPrintQuality:=BLOB to integer:C549($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								
								$dmDefaultSource:=$dmDefaultSource & 0x00FF
								
								$o:=0
								$dmPosition_x:=BLOB to longint:C551($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								$dmPosition_y:=BLOB to longint:C551($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								$dmDisplayOrientation:=BLOB to longint:C551($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								$dmDisplayFixedOutput:=BLOB to longint:C551($_DUMMYSTRUCTNAME;PC byte ordering:K22:3;$o)
								
								$DEVMODE:=New shared object:C1526
								
								Use (This:C1470)
									This:C1470.DEVMODE:=$DEVMODE
								End use 
								
								$DUMMYUNIONNAME:=New shared object:C1526
								$DUMMYUNIONNAME2:=New shared object:C1526
								
								Use ($DEVMODE)
									$DEVMODE.DUMMYUNIONNAME:=$DUMMYUNIONNAME
									$DEVMODE.DUMMYUNIONNAME2:=$DUMMYUNIONNAME2
									$DEVMODE.dmDeviceName:=$dmDeviceName
									$DEVMODE.dmSpecVersion:=$dmSpecVersion
									$DEVMODE.dmDriverVersion:=$dmDriverVersion
									$DEVMODE.dmSize:=$dmSize
									$DEVMODE.dmDriverExtra:=$dmDriverExtra
									$DEVMODE.dmFields:=$dmFields
								End use 
								
								$DUMMYSTRUCTNAME:=New shared object:C1526
								$DUMMYSTRUCTNAME2:=New shared object:C1526
								
								Use ($DUMMYUNIONNAME)
									$DUMMYUNIONNAME.DUMMYSTRUCTNAME:=$DUMMYSTRUCTNAME
									  //not used for printers
									  //$DUMMYUNIONNAME.DUMMYSTRUCTNAME2:=$DUMMYSTRUCTNAME2
								End use 
								
								Use ($DUMMYSTRUCTNAME)
									
									If ($dmFields ?? 0)  //DM_ORIENTATION
										$DUMMYSTRUCTNAME.dmOrientation:=$dmOrientation
									End if 
									
									If ($dmFields ?? 1)  //DM_PAPERSIZE
										$DUMMYSTRUCTNAME.dmPaperSize:=$dmPaperSize
									End if 
									
									If ($dmFields ?? 2)  //DM_PAPERLENGTH
										$DUMMYSTRUCTNAME.dmPaperLength:=$dmPaperLength
									End if 
									
									If ($dmFields ?? 3)  //DM_PAPERWIDTH
										$DUMMYSTRUCTNAME.dmPaperWidth:=$dmPaperWidth
									End if 
									
									If ($dmFields ?? 4)  //DM_SCALE
										$DUMMYSTRUCTNAME.dmScale:=$dmScale
									End if 
									
									If ($dmFields ?? 8)  //DM_COPIES
										$DUMMYSTRUCTNAME.dmCopies:=$dmCopies
									End if 
									
									If ($dmFields ?? 9)  //DM_DEFAULTSOURCE
										$DUMMYSTRUCTNAME.dmDefaultSource:=$dmDefaultSource
									End if 
									
									If ($dmFields ?? 10)  //DM_PRINTERQUALITY
										$DUMMYSTRUCTNAME.dmPrinterQuality:=$dmPrintQuality
									End if 
									
									If ($dmFields ?? 11)  //DM_COLOR
										$DUMMYSTRUCTNAME.dmColor:=$dmColor
									End if 
									
									If ($dmFields ?? 12)  //DM_DUPLEX
										$DUMMYSTRUCTNAME.dmDuplex:=$dmDuplex
									End if 
									
									If ($dmFields ?? 13)  //DM_YRESOLUTION
										$DUMMYSTRUCTNAME.dmYResolution:=$dmYResolution
									End if 
									
									If ($dmFields ?? 14)  //DM_TTOPTION
										$DUMMYSTRUCTNAME.dmTTOption:=$dmTTOption
									End if 
									
									If ($dmFields ?? 15)  //DM_COLLATE
										$DUMMYSTRUCTNAME.dmCollate:=$dmCollate
									End if 
									
									If ($dmFields ?? 22)  //DM_DISPLAYFREQUENCY
										  //not used for printers
										  //$DUMMYSTRUCTNAME.dmDisplayFrequency:=$dmDisplayFrequency
									End if 
									
									If ($dmFields ?? 23)  //DM_ICMMETHOD
										$DUMMYSTRUCTNAME.dmICMMetHod:=$dmICMMethod
									End if 
									
									If ($dmFields ?? 24)  //DM_ICMINTENT
										$DUMMYSTRUCTNAME.dmICMintent:=$dmICMIntent
									End if 
									
									If ($dmFields ?? 25)  //DM_MEDIATYPE
										$DUMMYSTRUCTNAME.dmMediaType:=$dmMediaType
									End if 
									
									If ($dmFields ?? 26)  //DM_DITHERTYPE
										$DUMMYSTRUCTNAME.dmDitherType:=$dmDitherType
									End if 
									
									If ($dmFields ?? 28)  //DM_PANNINGWIDTH
										$DUMMYSTRUCTNAME.dmPanningWidth:=$dmPanningWidth
									End if 
									
									If ($dmFields ?? 27)  //DM_PANNINGHEIGHT
										$DUMMYSTRUCTNAME.dmPanningHeight:=$dmPanningHeight
									End if 
									
									If ($dmFields ?? 16)  //DM_FORMNAME
										$DUMMYSTRUCTNAME.dmFormName:=$dmFormName
									End if 
									
									If ($dmFields ?? 17)  //DM_LOGPIXELS
										  //not used for printers
										  //$DUMMYSTRUCTNAME.dmLogPixels:=$dmLogPixels
									End if 
									
									If ($dmFields ?? 18)  //DM_BITSPERPEL
										  //not used for printers
										  //$DUMMYSTRUCTNAME.dmBitsPerPel:=$dmBitsPerPel
									End if 
									
									If ($dmFields ?? 19)  //DM_PELSWIDTH
										  //not used for printers
										  //$DUMMYSTRUCTNAME.dmPelsWidth:=$dmPelsWidth
									End if 
									
									If ($dmFields ?? 20)  //DM_PELSHEIGHT
										  //not used for printers
										  //$DUMMYSTRUCTNAME.dmPelsHeight:=$dmPelsHeight
									End if 
									
								End use 
								
								Use ($DUMMYUNIONNAME)
									
									If ($dmFields ?? 5)  //DM_POSITION
										  //not used for printers
										  //$DUMMYUNIONNAME.dmPosition:=New object
										  //$DUMMYUNIONNAME.dmPosition.x:=$dmPosition_x
										  //$DUMMYUNIONNAME.dmPosition.y:=$dmPosition_y
									End if 
									
								End use 
								
								Use ($DUMMYUNIONNAME2)
									
									If ($dmFields ?? 6)  //DM_NUP
										$DUMMYUNIONNAME2.dmNup:=$dmNup
									End if 
									
									If ($dmFields ?? 21)  //DM_DISPLAYFLAGS
										  //not used for printers
										  //$DUMMYUNIONNAME2.dmDisplayFlags:=$dmDisplayFlags
									End if 
									
								End use 
								
								Use ($DUMMYSTRUCTNAME2)
									
									  //not used for printers
									
									  //If ($dmFields ?? 5)  //DM_POSITION
									  //$DUMMYSTRUCTNAME2.dmPosition:=New object
									  //$DUMMYSTRUCTNAME2.dmPosition.x:=$dmPosition_x
									  //$DUMMYSTRUCTNAME2.dmPosition.y:=$dmPosition_y
									  //End if 
									
									  //If ($dmFields ?? 7)  //DM_DISPLAYORIENTATION
									  //$DUMMYSTRUCTNAME2.dmDisplayOrientation:=$dmDisplayOrientation
									  //End if 
									
									  //If ($dmFields ?? 29)  //DM_DISPLAYFIXEDOUTPUT
									  //$DUMMYSTRUCTNAME2.dmDisplayFixedOutput:=$dmDisplayFixedOutput
									  //End if 
									
								End use 
								
							: ($platform="MAC")
								
								$version:=BLOB to longint:C551($nativeData;PC byte ordering:K22:3)
								$printsettings_size:=BLOB to longint:C551($nativeData;PC byte ordering:K22:3;$o)
								$pageformat_size:=BLOB to longint:C551($nativeData;PC byte ordering:K22:3;$o)
								
								C_BLOB:C604($PMPrintSettings;$PMPageFormat)
								COPY BLOB:C558($nativeData;$PMPrintSettings;$o;0;$printsettings_size)
								COPY BLOB:C558($nativeData;$PMPageFormat;$o+$printsettings_size;0;$pageformat_size)
								
						End case 
						
						
					End if 
				End if 
			End if 
		End if 
		
	Else 
		
End case 