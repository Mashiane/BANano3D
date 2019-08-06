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


Sub GetRotationY As Double
	Dim rot As BANanoObject = GetRotation
	Dim y As Double = rot.GetField("y")
	Return y
End Sub

Sub GetRotationZ As Double
	Dim rot As BANanoObject = GetRotation
	Dim z As Double = rot.GetField("z")
	Return z
End Sub

Sub SetScale(var1 As Double, var2 As Double, var3 As Double)
	Dim scale As BANanoObject = GetScale
	scale.RunMethod("set", Array(var1, var2, var3))
End Sub

Sub SetRotationX(x As Double)
	Dim rot As BANanoObject = GetRotation
	rot.SetField("x", x)
End Sub

Sub SetRotationY(y As Double)
	Dim rot As BANanoObject = GetRotation
	rot.SetField("y", y)
End Sub

Sub SetRotationZ(z As Double)
	Dim rot As BANanoObject = GetRotation
	rot.SetField("z", z)
End Sub

Sub IncrementRotationX(x As Double)
	'get existing x rotation
	Dim oldx As Double = GetRotationX
	'increment the rotation
	oldx = oldx + x
	'update the rotation
	SetRotationX(oldx)
End Sub

Sub DecrementRotationX(x As Double)
	'get existing x rotation
	Dim oldx As Double = GetRotationX
	'increment the rotation
	oldx = oldx - x
	'update the rotation
	SetRotationX(oldx)
End Sub

Sub IncrementRotationY(y As Double)
	'get existing y rotation
	Dim oldy As Double = GetRotationY
	'increment the rotation
	oldy = oldy + y
	'update the rotation
	SetRotationY(oldy)
End Sub

Sub DecrementRotationY(y As Double)
	'get existing y rotation
	Dim oldy As Double = GetRotationY
	'increment the rotation
	oldy = oldy - y
	'update the rotation
	SetRotationY(oldy)
End Sub

Sub IncrementRotationZ(z As Double)
	'get existing z rotation
	Dim oldz As Double = GetRotationZ
	'increment the rotation
	oldz = oldz + z
	'update the rotation
	SetRotationZ(oldz)
End Sub

Sub DecrementRotationZ(z As Double)
	'get existing z rotation
	Dim oldz As Double = GetRotationZ
	'increment the rotation
	oldz = oldz - z
	'update the rotation
	SetRotationZ(oldz)
End Sub