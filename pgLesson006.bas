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
	Private stats As TDStats
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
	
	'create the stats
	stats = createStats
	body.Append(stats.GetDomElement)
	
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
	'
	stats.update
End Sub

Sub createStats As TDStats
    Dim stats1 As TDStats
	stats1.Initialize
	stats1.setMode(0)
	'
	Dim DEStyle As BANanoObject = stats1.DomElementStyle
    DEStyle.SetField("position", "absolute")
    DEStyle.SetField("left", "0px")
    DEStyle.SetField("top", "0px")
    Return stats1
End Sub
