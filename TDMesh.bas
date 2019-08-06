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

Sub SetName(n As String) As TDMesh
	Mesh.SetField("name", n)
	Return Me
End Sub

Sub GetScale As BANanoObject
	Dim scale As BANanoObject = Mesh.GetField("scale")
	Return scale
End Sub

Sub GetRotation As BANanoObject
	Dim rot As BANanoObject = Mesh.GetField("rotation")
	Return rot
End Sub

Sub SetMesh(bo As BANanoObject) As TDMesh
	Mesh = bo
	Return Me
End Sub

Sub GetRotationX As Double
	Dim rot As BANanoObject = GetRotation
	Dim x As Double = rot.GetField("x")
	Return x
End Sub

Sub SetScale(var1 As Double, var2 As Double, var3 As Double)
	Dim scale As BANanoObject = GetScale
	scale.RunMethod("set", Array(var1, var2, var3))
End Sub

Sub SetRotationX(x As Double)
	Dim rot As BANanoObject = GetRotation
	rot.SetField("x", x)
End Sub

Sub IncrementRotationX(x As Double)
	'get existing x rotation
	Dim oldx As Double = GetRotationX
	'increment the rotation
	oldx = oldx + x
	'update the rotation
	SetRotationX(oldx)
End Sub