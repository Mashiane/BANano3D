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


Sub Init
	Math.Initialize("Math")
	 
	'do some webpage body settings
	body = BANano.GetElement("#body")
	body.SetStyle(BANano.ToJson(CreateMap("margin": "0", "overflow": "hidden")))
	body.Empty
	
	'lets get the window inner height and width
	WindowInnerWidth = BANano.Window.InnerWidth
	WindowInnerHeight = BANano.Window.InnerHeight
	
	' this will hold all elements
	scene.Initialize
	
	' camera, what we will see
	camera.Initialize(45, WindowInnerWidth / WindowInnerHeight, 0.1, 1000)
	
	'create a CANVAS renderer, set background and size
	renderer.Initialize
	renderer.setClearColor("0x000000", 1.0)
	renderer.setSize(WindowInnerWidth, WindowInnerHeight)
	
	Dim cubeGeometry As TDBoxGeometry
	Dim rnd1 As Double = Math.RunMethod("random", Null)
	Dim rnd2 As Double = Math.RunMethod("random", Null)
	Dim rnd3 As Double = Math.RunMethod("random", Null)
	rnd1 = 10 * rnd1
	rnd2 = 10 * rnd2
	rnd3 = 10 * rnd3
	cubeGeometry.Initialize(rnd1, rnd2, rnd3)
	'
	Dim cubeMaterial As TDMeshNormalMaterial
	cubeMaterial.Initialize
	
	Dim cube As TDMesh
	cube.Initialize(cubeGeometry.BoxGeometry, cubeMaterial.MeshNormalMaterial)
	cube.SetName("cube")
	scene.add(cube.Mesh)
	
	'
	'position and point the camera to the center of the scene
	camera.SetPosition(15, 16, 13)
	camera.LookAt(scene.GetPosition)
		
	'add the output of the renderer to the html element
	body.Append(renderer.GetDomElement)
	'render stuff
	render
	
End Sub

Sub render
	renderer.render(scene.Scene, camera.PerspectiveCamera)
	'get the cube
	Dim cube As TDMesh = scene.GetMeshByName("cube")
	cube.IncrementRotationX(0.05)
	'
	BANano3D.requestAnimationFrame(BANano.CallBack(Me,"render", Null))
End Sub