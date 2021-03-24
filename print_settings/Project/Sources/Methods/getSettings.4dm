//%attributes = {"invisible":true}
C_OBJECT:C1216($0;$jsonSettings)

$jsonSettings:=New object:C1471

If (Value type:C1509(This:C1470.jsonSettings)=Is object:K8:27)
	$jsonSettings.jsonSettings:=This:C1470.jsonSettings
End if 

If (Value type:C1509(This:C1470.DEVMODE)=Is object:K8:27)
	$jsonSettings.DEVMODE:=This:C1470.DEVMODE
End if 

If (Value type:C1509(This:C1470.DEVNAMES)=Is object:K8:27)
	$jsonSettings.DEVNAMES:=This:C1470.DEVNAMES
End if 

$0:=$jsonSettings