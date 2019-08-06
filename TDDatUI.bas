B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public DatGUI As BANanoObject
End Sub

Public Sub Initialize As TDDatUI
	DatGUI.Initialize2("dat.GUI", Null)
	Return Me
End Sub

Sub Add(controlObject As BANanoObject, controlVariable As String, MinValue As Double, maxValue As Double)
	DatGUI.RunMethod("add", Array(controlObject, controlVariable, MinValue, maxValue))
End Sub
