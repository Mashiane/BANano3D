B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public TextTure As BANanoObject
End Sub

public Sub LoadTexture(p As String) As TDImageUtils
	TextTure.Initialize2("THREE.ImageUtils", Null).RunMethod("loadTexture", Array(p))
	Return Me
End Sub
