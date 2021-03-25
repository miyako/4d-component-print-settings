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
	
	C_BLOB:C604($printSettings)
	
	Case of 
		: (Value type:C1509($1)=Is text:K8:3)
			
			Case of 
				: ($1="win@") | ($1="pc@")
					
					$printSettings:=Folder:C1567(fk resources folder:K87:11).file("windows.printSettings").getContent()
					
				: ($1="mac@") | ($1="appl@")
					
					$printSettings:=Folder:C1567(fk resources folder:K87:11).file("apple.printSettings").getContent()
					
			End case 
			
		: (Value type:C1509($1)=Is BLOB:K8:12)
			
			$printSettings:=$1
			
	End case 
	
	If (BLOB size:C605($printSettings)#0)
		
		$EXPORT.loadSettings($printSettings)  //load from blob
		
	End if 
	
Else 
	
	If ($EXPORT.jsonSettings=Null:C1517)
		If (Print settings to BLOB:C1433($printSettings)=1)
			$EXPORT.loadSettings($printSettings)  //default=current settings
		End if 
	End if 
	
End if 

$0:=$EXPORT