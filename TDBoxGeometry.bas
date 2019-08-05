B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public BoxGeometry As BANanoObject
End Sub

Public Sub Initialize(var1 As Object, var2 As Object, var3 As Object) As TDBoxGeometry
	BoxGeometry.Initialize2("THREE.BoxGeometry", Array(var1, var2, var3))
	Return Me
End Sub