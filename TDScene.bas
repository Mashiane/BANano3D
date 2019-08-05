B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public Scene As BANanoObject
End Sub

Public Sub Initialize As TDScene
	Scene.Initialize2("THREE.Scene", Null)
	Return Me
End Sub

Sub add(bo As BANanoObject) As TDScene
	Scene.RunMethod("add", Array(bo))
	Return Me
End Sub

Sub GetPosition() As BANanoObject
	Dim bo As BANanoObject = Scene.GetField("position")
	Return bo
End Sub