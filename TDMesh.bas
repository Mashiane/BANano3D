B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public Mesh As BANanoObject
End Sub

Public Sub Initialize(var1 As BANanoObject, var2 As BANanoObject) As TDMesh
	Mesh.Initialize2("THREE.Mesh", Array(var1, var2))
	Return Me
End Sub
