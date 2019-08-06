B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public MeshBasicMaterial As BANanoObject
End Sub

Public Sub Initialize As TDMeshBasicMaterial
	MeshBasicMaterial.Initialize2("THREE.MeshBasicMaterial", Null)
	Return Me
End Sub

Sub SetTransparent(b As Boolean) As TDMeshBasicMaterial
	MeshBasicMaterial.SetField("transparent", b)
	Return Me
End Sub

Sub SetMap(bo As Object) As TDMeshBasicMaterial
	MeshBasicMaterial.SetField("map", bo)
	Return Me
End Sub