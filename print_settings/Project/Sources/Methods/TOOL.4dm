//%attributes = {"invisible":true}
  //SET TEXT TO PASTEBOARD(Generate UUID)

$t:=Get text from pasteboard:C524

ARRAY LONGINT:C221($pos;0)
ARRAY LONGINT:C221($len;0)

$i:=1

$e:=1

$template:="<trans-unit d4:value=\"$4dtext($1):L\" id=\"6017C53BF8234744BF519C4AD30ED999.$4dtext($2)\">\r<source><!--#4dtext $3--></source>\r</trans-unit>\r"

$result:=""

While (Match regex:C1019("((\\w+)\\s+(-?\\d+))";$t;$i;$pos;$len))
	
	$const:=Substring:C12($t;$pos{2};$len{2})
	$val:=Num:C11(Substring:C12($t;$pos{3};$len{3}))
	PROCESS 4D TAGS:C816($template;$code;$val;$e;$const)
	$result:=$result+$code
	$i:=$pos{1}+$len{1}
	$e:=$e+1
	
End while 

SET TEXT TO PASTEBOARD:C523($result)