B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public Stats As BANanoObject
End Sub

Public Sub Initialize As TDStats
	Stats.Initialize2("Stats", Null)
	Return Me
End Sub

Sub SetMode(mode As Int) As TDStats
	Stats.RunMethod("setMode", Array(mode))
	Return Me
End Sub

Sub update
	Stats.RunMethod("update", Null)
End Sub

Sub DomElement As BANanoObject
	Dim bo As BANanoObject = Stats.GetField("domElement")
	Return bo
End Sub

Sub GetDomElement As String
	Dim sbo As String = Stats.GetField("domElement").result
	Return sbo
End Sub

Sub DomElementStyle As BANanoObject
	Dim de As BANanoObject = DomElement
	Dim bo As BANanoObject = de.GetField("style")
	Return bo
End Sub

Sub SetDomElementStylePosition(p As Object) As TDStats
	DomElementStyle.SetField("position", p)
	Return Me
End Sub
	
Sub SetDomElementStyleLeft(l As Object) As TDStats
	DomElementStyle.SetField("left", l)
	Return Me
End Sub

Sub SetDomElementStyleTop(t As Object) As TDStats
	DomElementStyle.SetField("top", t)
	Return Me
End Sub	
