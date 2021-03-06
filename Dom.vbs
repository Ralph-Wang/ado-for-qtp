Option Explicit


' An implementation of getElementById
Function getDomByID(htmlid)
	Set getDomByID = Browser(":=").Page(":=").Object.GetElementById(htmlid)
End Function

' An implementation of getElementsByClassName in Dom
' Unstable/ Not in Test
Function getDomByClassName(className)
	Set getDomByClassName = Browser(":=").Page(":=").Object.getElementsByClassName(className)(0)
End Function

' An implementation of getElementsByName in Dom
Function getDomByName(name)
	Set getDomByName = Browser(":=").Page(":=").Object.GetElementsByName(name)(0)
End Function

' Unstable/ Not in Test
Function getDomfromIframe(iframe,htmlid)
	If not isObject(iframe) Then
		msgbox "getDomfromIframe函数的iframe参数应该是html对象"
		Exit Function
	End If
	Set getDomfromIframe = iframe.contentDocument.getElementById(htmlid)
End Function

' Unstable/ Not in Test
Function getDomfromIframeByName(iframe,className)
	If not isObject(iframe) Then
		msgbox "getDomfromIframeByClassName函数的iframe参数应该是html对象"
		Exit Function
	End If
	Set getDomfromIframeByName = iframe.contentDocument.getElementsByClassName(className)(0)
End Function

' Unstable/ Not in Test
Function getDomfromIframeByName(iframe,name)
	If not isObject(iframe) Then
		msgbox "getDomfromIframeByName函数的iframe参数应该是html对象"
		Exit Function
	End If
	Set getDomfromIframeByName = iframe.contentDocument.getElementsByClassName(name)(0)
End Function
