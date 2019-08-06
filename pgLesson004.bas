B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private BANano As BANano
End Sub

Sub Init
	'does webgl exist
	Dim webGL As Boolean = BANano3D.WebGLAvailable
	If webGL Then
		BANano.Window.Alert("WebGL is supported!")
	Else
		BANano.Window.Alert("WebGL is NOT supported!")
	End If
End Sub