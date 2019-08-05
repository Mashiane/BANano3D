B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public PerspectiveCamera As BANanoObject
End Sub

Public Sub Initialize(var1 As Object, var2 As Object, var3 As Object, var4 As Object) As TDPerspectiveCamera
	PerspectiveCamera.Initialize2("THREE.PerspectiveCamera", Array(var1,var2,var3,var4))
	Return Me
End Sub

Sub GetPosition() As BANanoObject
	Dim bo As BANanoObject = PerspectiveCamera.GetField("position")
	Return bo
End Sub

Sub SetPosition(x As Int, y As Int, z As Int) As TDPerspectiveCamera
	Dim position As BANanoObject = GetPosition
	position.SetField("x", x)
	position.SetField("y", y)
	position.SetField("z", z)
	Return Me
End Sub

Sub LookAt(position As BANanoObject) As TDPerspectiveCamera
	PerspectiveCamera.RunMethod("lookAt", Array(position))
	Return Me
End Sub