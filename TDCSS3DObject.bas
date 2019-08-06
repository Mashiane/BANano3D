B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public CSS3DObject As BANanoObject
End Sub

Public Sub Initialize(var1 As BANanoObject) As TDCSS3DObject
	CSS3DObject.Initialize2("THREE.CSS3DObject", Array(var1))
	Return Me
End Sub

Sub GetPosition() As BANanoObject
	Dim bo As BANanoObject = CSS3DObject.GetField("position")
	Return bo
End Sub

Sub SetPosition(x As Int, y As Int, z As Int) As TDCSS3DObject
	Dim position As BANanoObject = GetPosition
	position.SetField("x", x)
	position.SetField("y", y)
	position.SetField("z", z)
	Return Me
End Sub