//%attributes = {"invisible":true,"shared":true}
C_VARIANT:C1683($1)
C_OBJECT:C1216($0;$EXPORT)

$name:=Current method name:C684

If (Storage:C1525[$name]=Null:C1517)
	Use (Storage:C1525)
		$EXPORT:=New shared object:C1526
		Storage:C1525[$name]:=$EXPORT
	End use 
Else 
	$EXPORT:=Storage:C1525[$name]
End if 

If ($EXPORT[$name]=Null:C1517)
	
	Use ($EXPORT)
		
		$EXPORT.loadSettings:=Formula:C1597(loadSettings )
		$EXPORT.getSettings:=Formula:C1597(getSettings )
		$EXPORT.generateSettings:=Formula:C1597(generateSettings )
		$EXPORT.setPrintOption:=Formula:C1597(setPrintOption )
		
		$EXPORT[$name]:=Formula:C1597(This:C1470)
		
	End use 
	
End if 

If (Count parameters:C259#0)
	
	$EXPORT.loadSettings($1)  //load from blob
	
Else 
	
	If ($EXPORT.jsonSettings=Null:C1517)
		If (Print settings to BLOB:C1433($printSettings)=1)
			$EXPORT.loadSettings($printSettings)  //default=current settings
		End if 
	End if 
	
End if 

$0:=$EXPORT