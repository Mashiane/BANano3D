﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Public WebGLRenderer As BANanoObject
End Sub

'initialize webgl renderer
Public Sub Initialize As TDWebGLRenderer
	WebGLRenderer.Initialize2("THREE.WebGLRenderer",Null)
	Return Me
End Sub

'initialize canvas renderer
public Sub InitializeCanvas As TDWebGLRenderer
	WebGLRenderer.Initialize2("THREE.CanvasRenderer",Null)
	Return Me
End Sub

'initialize css3d renderer
public Sub InitializeCSS3D As TDWebGLRenderer
	WebGLRenderer.Initialize2("THREE.CSS3DRenderer", Null)
	Return Me
End Sub

Sub setClearColor(color As Object, opacity As Object) As TDWebGLRenderer
	WebGLRenderer.RunMethod("setClearColor", Array(color, opacity))
	Return Me
End Sub

Sub setSize(width As Object, height As Object) As TDWebGLRenderer
	WebGLRenderer.RunMethod("setSize", Array(width, height))
	Return Me
End Sub

Sub GetDomElement() As String
	Dim str As String = WebGLRenderer.GetField("domElement").Result
	Return str
End Sub

Sub Render(scene As BANanoObject, camera As BANanoObject)
	WebGLRenderer.RunMethod("render", Array(scene, camera))
End Sub