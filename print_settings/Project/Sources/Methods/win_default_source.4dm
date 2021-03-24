//%attributes = {"invisible":true}
C_VARIANT:C1683($1;$0)

C_TEXT:C284($textValue)
C_LONGINT:C283($intValue)

Case of 
	: (Value type:C1509($1)=Is text:K8:3)
		
		$textValue:=$1
		
		Case of 
			: ($textValue="onlyOne")
				$intValue:=1
			: ($textValue="lower")
				$intValue:=2
			: ($textValue="middle")
				$intValue:=3
			: ($textValue="manual")
				$intValue:=4
			: ($textValue="envelope")
				$intValue:=5
			: ($textValue="envManual")
				$intValue:=6
			: ($textValue="auto")
				$intValue:=7
			: ($textValue="tractor")
				$intValue:=8
			: ($textValue="smallFmt")
				$intValue:=9
			: ($textValue="largeFmt")
				$intValue:=10
			: ($textValue="largeCapacity")
				$intValue:=11
			: ($textValue="cassette")
				$intValue:=14
			: ($textValue="formSource")
				$intValue:=15
		End case 
		
		$0:=$intValue
		
	: (Value type:C1509($1)=Is real:K8:4)
		
		$intValue:=$1
		
		Case of 
			: ($intValue=1)
				$textValue:="onlyOne"
			: ($intValue=2)
				$textValue:="middle"
			: ($intValue=3)
				$textValue:="manual"
			: ($intValue=4)
				$textValue:="lower"
			: ($intValue=5)
				$textValue:="envelope"
			: ($intValue=6)
				$textValue:="envManual"
			: ($intValue=7)
				$textValue:="auto"
			: ($intValue=8)
				$textValue:="tractor"
			: ($intValue=9)
				$textValue:="smallFmt"
			: ($intValue=10)
				$textValue:="largeFmt"
			: ($intValue=11)
				$textValue:="largeCapacity"
			: ($intValue=14)
				$textValue:="cassette"
			: ($intValue=15)
				$textValue:="formSource"
		End case 
		
		$0:=$textValue
		
End case 