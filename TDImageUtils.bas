B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public ImageUtils As BANanoObject
End Sub

public Sub Initialize As TDImageUtils
	ImageUtils.Initialize2("THREE.ImageUtils", Null)
	Return Me
End Sub

Public Sub LoadTexture(p As String) As BANanoObject
	Dim bo As BANanoObject = ImageUtils.RunMethod("loadTexture", Array(p))
	Return bo
End Sub