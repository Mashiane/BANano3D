﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public MeshNormalMaterial As BANanoObject
End Sub

Public Sub Initialize As TDMeshNormalMaterial
	MeshNormalMaterial.Initialize2("THREE.MeshNormalMaterial", Null)
	Return Me
End Sub

Sub SetTransparent(b As Boolean) As TDMeshNormalMaterial
	MeshNormalMaterial.SetField("transparent", b)
	Return Me
End Sub

Sub SetMap(bo As Object) As TDMeshNormalMaterial
	MeshNormalMaterial.SetField("map", bo)
	Return Me
End Sub