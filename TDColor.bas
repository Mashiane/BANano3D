B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public Color As BANanoObject
End Sub

Public Sub Initialize(ColorValue As Double) As TDColor
	Color.Initialize2("THREE.Color", Array(ColorValue))
	Return Me
End Sub

Sub getStyle As Object
	Dim style As Object = Color.RunMethod("getStyle", Null).Result
	Return style
End Sub