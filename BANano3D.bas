B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Private BANano As BANano
End Sub

Sub Document As BANanoObject
	Dim doc As BANanoObject = BANano.Window.GetField("document")
	Return doc
End Sub

Sub CreateElement(tag As String) As BANanoObject
	Dim doc As BANanoObject = Document
	Dim div As BANanoObject = doc.RunMethod("createElement", Array(tag))
	Return div
End Sub

Sub WebGLAvailable As Boolean
	'first create a canvas element
	Dim testCanvas As BANanoObject = CreateElement("canvas")
	'and from that canvas get the webgl context
	Dim gl As BANanoObject = Null

	'If exceptions are thrown, indicates webgl is Null
	Try
		gl = testCanvas.RunMethod("getContext", Array("webgl"))
	Catch
		gl = Null
	End Try
	'if webgl is all good return true;
	If gl <> Null Then
		Return True
	Else
		Return False
	End If
End Sub

Sub requestAnimationFrame(cb As BANanoObject)
	BANano.RunJavascriptMethod("requestAnimationFrame", Array(cb))
End Sub