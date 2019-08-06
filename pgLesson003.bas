B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private body As BANanoElement
	Private BANano As BANano
	'
	Private renderer As TDWebGLRenderer
	Private scene As TDScene
	Private camera As TDPerspectiveCamera
	Private WindowInnerWidth As Object
	Private WindowInnerHeight As Object
	Private Math As BANanoObject
End Sub

#if css
	.large {
	    font-size: xx-large;
    }
#End If

Sub Init
	Math.Initialize("Math")
	 
	'do some webpage body settings
	body = BANano.GetElement("#body")
	body.SetStyle(BANano.ToJson(CreateMap("margin": "0", "overflow": "hidden","background-color": "black")))
	body.Empty
	'
	'lets get the window inner height and width
	WindowInnerWidth = BANano.Window.InnerWidth
	WindowInnerHeight = BANano.Window.InnerHeight
	
	' this will hold all elements
	scene.Initialize
	
	' camera, what we will see
	camera.Initialize(45, WindowInnerWidth / WindowInnerHeight, 0.1, 1000)
	
	'create a css3d renderer
	renderer.InitializeCSS3D
	renderer.setSize(WindowInnerWidth, WindowInnerHeight)
	
	'position and point the camera to the center of the scene
	camera.SetPosition(500, 500, 500)
	camera.LookAt(scene.GetPosition)
			
	'add the output of the renderer to the html element
	body.Append(renderer.GetDomElement)
	'
	
	Dim cssElement As TDCSS3DObject = createCSS3DObject
	cssElement.SetPosition(100, 100, 100)
	'
	scene.add(cssElement.CSS3DObject)
	
	'render stuff
	renderer.render(scene.Scene, camera.PerspectiveCamera)
	
	
End Sub


Sub createCSS3DObject As TDCSS3DObject
	'add the html elements
	Dim html As UOEHTML
	html.Initialize("").SetTag("div")
	html.AddH1("This is an H1 Element.")
	html.AddSpan("Hello BANano3D...","large",Null)
	html.AddTextArea(""," A Mashy Creation!","",Null)
	'
	Dim doc As BANanoObject = BANano.Window.GetField("document")
	Dim wrapper As BANanoObject = doc.RunMethod("createElement", Array("div"))
	wrapper.SetField("innerHTML", html.html)
	
	'generate a random color
	Dim rnd1 As Double = Math.RunMethod("random", Null)
	Dim colorValue As Double = 16777215 * rnd1
	Dim color As TDColor
	color.Initialize(colorValue)
	Dim colorStyle As Object = color.getStyle
	'
	Dim div As BANanoObject = wrapper.GetField("firstChild")
	div.GetField("style").SetField("width", "370px")
	div.GetField("style").SetField("height", "370px")
	div.GetField("style").SetField("opacity", 0.7)
	div.GetField("style").SetField("background", colorStyle)
	'
	'create a CSS3Dobject And Return it.
	Dim cssobject As TDCSS3DObject
	cssobject.Initialize(div)
	Return cssobject
End Sub