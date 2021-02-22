B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private mScriptFilename As String
	Private mCSSFilename As String
	Private startTime As Long
	Private endTime   As Long
	Private oldLength As Long
	Private newLength As Long
	Private fx As JFX
	Private JSFiles As List
	Private CSSFiles As List
	Public PublishPath As String
	Public ShortName As String
	Public AssetsPath As String
	Public ScriptsPath As String
	Public StylesPath As String
	Public ScriptFile As String
	Public UsesAlaSQL As Boolean
	Public MergeCSS As Boolean
	Public MergeJS As Boolean
	Public CompressCSS As Boolean
	Public CompressJS As Boolean
	Public MangleJS As Boolean
End Sub

Public Sub Initialize
	JSFiles.Initialize 
	CSSFiles.Initialize 
	UsesAlaSQL = False
	MangleJS = True
	MergeCSS = True
	MergeJS = False
	CompressJS = True
	CompressCSS = True
End Sub

'get the host ip address
Sub FileReadString(dir As String, source As String) As String
	Dim res As String = File.ReadString(dir, source)
	Return res
End Sub

Sub RedirectOutput (Dir As String, FileName As String)
   #if RELEASE
	Dim out As OutputStream = File.OpenOutput(Dir, FileName, False) 'Set to True to append the logs
	Dim ps As JavaObject
	ps.InitializeNewInstance("java.io.PrintStream", Array(out, True, "utf8"))
	Dim jo As JavaObject
	jo.InitializeStatic("java.lang.System")
	jo.RunMethod("setOut", Array(ps))
	jo.RunMethod("setErr", Array(ps))
   #end if
End Sub

'open the app on browser
Sub OpenLog(Dir As String, FileName As String)
	Dim URL As String = File.GetUri(Dir,FileName)
	fx.ShowExternalDocument(URL)
End Sub


Public Sub Compress(bMangleJS As Boolean)
	Dim sCompress As String = ""
	If bMangleJS Then sCompress = "--mangle"
	startTime = DateTime.Now
	oldLength = File.Size(File.GetFileParent(mScriptFilename), File.GetName(mScriptFilename))
	Dim shlCompress As Shell
	shlCompress.Initialize("shlCompress", "cmd.exe", Array("/c", "terser", File.GetName(mScriptFilename), "--compress", sCompress))
	shlCompress.WorkingDirectory = File.GetFileParent(mScriptFilename)
	shlCompress.Run(10000)
	StartMessageLoop
End Sub

Public Sub CleanCSS()
	startTime = DateTime.Now
	oldLength = File.Size(File.GetFileParent(mCSSFilename), File.GetName(mCSSFilename))
	Dim shlCompress As Shell
	shlCompress.Initialize("shlCleancss", "cmd.exe", Array("/c", "cleancss", File.GetName(mCSSFilename)))
	shlCompress.WorkingDirectory = File.GetFileParent(mCSSFilename)
	shlCompress.Run(10000)
	StartMessageLoop
End Sub

Private Sub shlCleancss_ProcessCompleted(Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	Try
		endTime = DateTime.Now
		If Success Then
			If StdOut.Length > 0 Then
				newLength = StdOut.Length
				Log("CleanCSS: " & File.GetName(mCSSFilename))
				File.WriteString(File.GetFileParent(mCSSFilename), File.GetName(mCSSFilename), StdOut)
			Else
				LogError(StdErr)
			End If
		Else
			LogError("Compress: Failed")
		End If
	Catch
		Log(LastException)
	End Try
	StopMessageLoop
End Sub

Private Sub shlCompress_ProcessCompleted(Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	Try
		endTime = DateTime.Now
		If Success Then
			If StdOut.Length > 0 Then
				newLength = StdOut.Length
				Log("Compressed: " & File.GetName(mScriptFilename))
				File.WriteString(File.GetFileParent(mScriptFilename), File.GetName(mScriptFilename), StdOut)
			Else
				LogError(StdErr)
			End If
		Else
			LogError("Compress: Failed")
		End If
	Catch
		Log(LastException)
	End Try
	StopMessageLoop
End Sub

Public Sub getScriptFilename() As String
	Return mScriptFilename
End Sub
Public Sub setScriptFilename(Value As String)
	mScriptFilename = Value
End Sub

Public Sub getCSSFilename() As String
	Return mCSSFilename
End Sub

Public Sub setCSSFilename(Value As String)
	mCSSFilename = Value
End Sub

Public Sub MergeFiles(FilesToMerge As List, TargetFile As String)
   
	Try
       
		If FilesToMerge.Size = 0 Then
			LogError("No files to merge!")
			Return
		End If
       
		Log("Merging files...")

		Dim FileContent As String

		For Each FileToMerge As String In FilesToMerge
			If File.Exists(File.GetFileParent(FileToMerge), File.GetName(FileToMerge)) Then
				FileContent = FileContent & File.ReadString(File.GetFileParent(FileToMerge), File.GetName(FileToMerge))
			Else
				LogError("File: " & FileToMerge & " doesn't exists")
			End If
		Next
   
		File.WriteString(File.GetFileParent(TargetFile), File.GetName(TargetFile), FileContent)

		Log("Merging files: Ready")
   
	Catch
       
		LogError(LastException)
       
	End Try

End Sub

'open the app on browser
Sub Open(bLocalHost As Boolean)
	'open the app
	'open index.html file
	Dim appPath As String
	If bLocalHost Then
		appPath = $"http://localhost/${ShortName}/index.html"$
		fx.ShowExternalDocument(appPath)
	Else
		appPath = File.Combine(PublishPath,ShortName)
		Dim URL As String = File.GetUri(appPath,"index.html")
		fx.ShowExternalDocument(URL)
	End If
End Sub

'open the app on browser
Sub OpenOnPort(bLocalHost As Boolean, port As String)
	'open the app
	'open index.html file
	Dim appPath As String
	If bLocalHost Then
		appPath = $"http://localhost/${ShortName}/index.html"$
		If port <> "" Then appPath = $"http://localhost:${port}/${ShortName}/index.html"$
		fx.ShowExternalDocument(appPath)
	Else
		appPath = File.Combine(PublishPath,ShortName)
		Dim URL As String = File.GetUri(appPath,"index.html")
		fx.ShowExternalDocument(URL)
	End If
End Sub

'copy php config file
Sub CopyConfig
	'unzip fonts folder
	Dim zf As String = File.Combine(PublishPath,$"${ShortName}/${AssetsPath}/config.php"$)
	Dim zo As String = File.Combine(PublishPath,$"${ShortName}"$)
	File.Copy("", zf, zo, "config.php")
End Sub

'unzip the fonts file
Sub UnzipFonts()
	'unzip fonts folder
	Dim zf As String = File.Combine(PublishPath,$"${ShortName}/${AssetsPath}/fonts.zip"$)
	Dim zo As String = File.Combine(PublishPath,$"${ShortName}"$)
	Dim UnZL As SD_ZipLibray
	UnZL.Initialize
	UnZL.unZip(zf,zo)
	'delete zip File
	File.Delete("",zf)
End Sub

'unzip the fonts file
Sub UnzipFile(sFileName As String)
	'unzip fonts folder
	Dim zf As String = File.Combine(PublishPath,$"${ShortName}/${AssetsPath}/${sFileName}"$)
	Dim zo As String = File.Combine(PublishPath,$"${ShortName}"$)
	Dim UnZL As SD_ZipLibray
	UnZL.Initialize
	UnZL.unZip(zf,zo)
	'delete zip File
	File.Delete("",zf)
End Sub


'consolidate and compress resources
Sub CleanProject(DoNotDelete As Map,Resources As Map)	
	Dim appPath As String = File.Combine(PublishPath,ShortName)
	Dim csspath As String = File.Combine(appPath,StylesPath)
	Dim jspath As String = File.Combine(appPath,ScriptsPath)
	Dim asspath As String = File.Combine(appPath,AssetsPath)
	Dim deletes As List
	deletes.Initialize
	If UsesAlaSQL Then
		Resources.Remove("alasql.min.js")
		DoNotDelete.Put("alasql.min.js","alasql.min.js")
	End If
	DoNotDelete.Put(ScriptFile,ScriptFile)
	DoNotDelete.Put(ScriptFile & ".gz",ScriptFile & ".gz")
	If MergeJS Then
		Dim sFile As String = ShortName.ToLowerCase & ".js"
		DoNotDelete.Put(sFile,sFile)
		DoNotDelete.Put(sFile & ".gz",sFile & ".gz")
	End If
	If MergeCSS Then
		Dim sFile As String = ShortName.ToLowerCase & ".css"
		DoNotDelete.Put(sFile,sFile)
		DoNotDelete.Put(sFile & ".gz",sFile & ".gz")
	End If
	'css files
	Dim cssList As List = File.ListFiles(csspath)
	For Each strf As String In cssList
		Dim hasit As Boolean = DoNotDelete.ContainsKey(strf)
		If hasit = False Then
			File.Delete(csspath,strf)
		End If
	Next
	'javascript
	Dim jsList As List = File.ListFiles(jspath)
	For Each strf As String In jsList
		Dim hasit As Boolean = DoNotDelete.ContainsKey(strf)
		If hasit = False Then
			File.Delete(jspath,strf)
		End If
	Next
	'assets
	Dim asList As List = File.ListFiles(asspath)
	For Each strf As String In asList
		Dim hasit As Boolean = DoNotDelete.ContainsKey(strf)
		If hasit = False Then
			File.Delete(asspath,strf)
		End If
	Next
	'consolidate files that have been left out
	Dim js2Merge As List
	Dim css2Merge As List
	js2Merge.Initialize
	css2Merge.Initialize
	Dim mFile As String
	For Each strFile As String In Resources.keys
		If strFile.EndsWith(".js") Then
			mFile = jspath & "\" & strFile
			If File.Exists("",mFile) Then 
				js2Merge.Add(mFile)
				If MergeJS Then 
					deletes.Add(mFile)
					deletes.Add(mFile & ".gz")
				End If
			End If
		else if strFile.EndsWith(".css") Then
			mFile = csspath & "\" & strFile
			If File.Exists("",mFile) Then 
				css2Merge.Add(mFile)
				If MergeCSS Then 
					deletes.Add(mFile)
					deletes.Add(mFile & ".gz")
				End If
			End If
		End If
	Next
	'compress the files
	Dim appJS As String = jspath & "\" & ShortName.ToLowerCase & ".js"
	Dim appCSS As String = csspath & "\" & ShortName.ToLowerCase & ".css"
	'lets merge some files
	If MergeJS Then MergeFiles(js2Merge, appJS)
	If MergeCSS Then MergeFiles(css2Merge,appCSS)
	'delete all files
	For Each strFile As String In deletes
		If File.Exists("",strFile) Then File.Delete("",strFile)
	Next
	CSSFiles = File.ListFiles(csspath)
	JSFiles = File.ListFiles(jspath)
	For Each jsFile As String In JSFiles
		If jsFile.EndsWith(".js") Then
			mScriptFilename = jspath & "\" & jsFile
			If CompressJS Then Compress(MangleJS)
		End If
	Next
	For Each cssFile As String In CSSFiles
		If cssFile.endswith(".css") Then
			mCSSFilename = csspath & "\" & cssFile
			If CompressCSS Then CleanCSS
		End If
	Next
End Sub

Sub CompressResources
	Dim appPath As String = File.Combine(PublishPath,ShortName)
	Dim csspath As String = File.Combine(appPath,StylesPath)
	Dim jspath As String = File.Combine(appPath,ScriptsPath)
	JSFiles = File.ListFiles(jspath)
	For Each jsFile As String In JSFiles
		If jsFile.EndsWith(".js") Then
			mScriptFilename = jspath & "\" & jsFile
			If CompressJS Then Compress(MangleJS)
		End If
	Next
	For Each cssFile As String In CSSFiles
		If cssFile.endswith(".css") Then
			mCSSFilename = csspath & "\" & cssFile
			If CompressCSS Then CleanCSS
		End If
	Next
End Sub


