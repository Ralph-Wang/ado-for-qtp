Option Explicit

' search the strToSearch with thePattern, return the first matched value
Function regSearch(thePattern, strToSearch)
	Dim regEx,  matches
	Set regEx = New RegExp
	regEx.Pattern = thePattern
	regEx.IgnoreCase = False
	regEx.Global = false
	Set matches = regEx.Execute(strToSearch)
    regSearch = matches(0).Value
End Function

' assert that the expValue equals to actValue in strict(mehtod=0) or in mess(method=1)
public Function assertEqual(expValue, actValue, method)
	Dim res
	If method <> 0 and method <> 1 Then
		msgbox "assertEqual函数的method参数不正确; 0-精确匹配, 1-模糊匹配"
	Else
		Select Case method
			Case 0
				res = (expValue = actValue)
				assertEqual = res
			Case 1
				res = (Instr(1,expValue,actValue) + Instr(1,actValue,expValue) > 0)
				assertEqual = res
			Case Else
		End Select
	End If
End Function

' report the Test Case named tcaseWithValues as the test result is res(true for pass, false for fail)
public Function reportWithCaseName(tcaseWithValues, res)
	If typename(res) = "Boolean" Then
		If res Then
			reporter.ReportEvent micPass, tcaseWithValues, "测试通过"
		Else
			reporter.ReportEvent micFail, tcaseWithValues, "测试未通过"
		End If
	Else
		msgbox "错误的res参数("& res &"),请输入bool类型参数"
	End If
End Function

'*******************************************************
'函数名:verifyDBres
'功能:根据测试结果输出标准测试报告; 无返回值
'参数:tcase,用例名称 ; res,布尔值,测试结果
'*******************************************************
public Function verifyDBvalue(expValue, DBvalue, tcase)
    Dim res, tcaseWithValues
    res = assertEqual(DBvalue, expValue, 0)
    tcaseWithValues = tcase  & vbcrlf & "期望值:" & expValue& vbcrlf & "数据库值:" & DBvalue
    reportWithCaseName tcaseWithValues, res
End Function


' the basic implementation for verify*
private Function pri_verifyProperty(obj, prop, expValue, tcase, method)
   Dim actValue, res, tcaseWithValues
   actValue = obj.GetROProperty(prop)
   res = assertEqual(expValue, actValue, method)
   tcaseWithValues = tcase & vbcrlf & "期望值:" & expValue & vbcrlf & "实际值:" & actValue
   reportWithCaseName tcaseWithValues, res
End Function


' public api for pri_verifyProperty
public Function verifyProperty(obj, prop, expValue, tcase, method)
   pri_verifyProperty obj, prop, expValue, tcase, method 
End Function

' verify the innertext property in strict
public Function verifyInnerTxt(obj, expValue, tcase)
	pri_verifyProperty obj, "innertext", expValue, tcase, 0
End Function

' verify the value property in strict
public Function verifyValue(obj, expValue, tcase)
	pri_verifyProperty obj, "value", expValue, tcase, 0
End Function

' verify the url property in mess
public Function verifyUrl(obj, expValue, tcase)
	pri_verifyProperty obj, "url", expValue, tcase, 1
End Function

' check the display property in css. called by verifyExist
private Function pri_verifyStyleDisplay(obj, expValue, tcase)
   Dim actValue, res
   actValue = obj.Object.currentStyle.display
   res = assertEqual(expValue, actValue, 1)
   reportWithCaseName tcase, res
End Function

' verify if the obj exists. call exist(5) firstly, then verify display property in css
public Function verifyExist(obj,tcase)
	If obj.exist(5) Then
		pri_verifyStyleDisplay obj, "block", tcase
		Exit Function
	End If
	reportWithCaseName tcase, false
End Function

' verify if the obj not exists. call exist(5) firstly, then verify display property in css
public Function verifyNotExist(obj,tcase)
   Dim res
   res = not obj.exist(5)
   If res Then
	   reportWithCaseName tcase, res
	   Exit Function
   Else
       pri_verifyStyleDisplay obj, "none", tcase
   End If
End Function

'*******************************************************
' registers
'*******************************************************

' verifyProperty
RegisterUserFunc "Browser", "verifyProperty", "verifyProperty"
RegisterUserFunc "Frame", "verifyProperty", "verifyProperty"
RegisterUserFunc "Image", "verifyProperty", "verifyProperty"
RegisterUserFunc "Link", "verifyProperty", "verifyProperty"
RegisterUserFunc "Page", "verifyProperty", "verifyProperty"
RegisterUserFunc "ViewLink", "verifyProperty", "verifyProperty"
RegisterUserFunc "WebArea", "verifyProperty", "verifyProperty"
RegisterUserFunc "WebButton", "verifyProperty", "verifyProperty"
RegisterUserFunc "WebCheckBox", "verifyProperty", "verifyProperty"
RegisterUserFunc "WebEdit", "verifyProperty", "verifyProperty"
RegisterUserFunc "WebElement", "verifyProperty", "verifyProperty"
RegisterUserFunc "WebFile", "verifyProperty", "verifyProperty"
RegisterUserFunc "WebList", "verifyProperty", "verifyProperty"
RegisterUserFunc "WebRadioGroup", "verifyProperty", "verifyProperty"
RegisterUserFunc "WebTable", "verifyProperty", "verifyProperty"
RegisterUserFunc "WebXML", "verifyProperty", "verifyProperty"

' verifyInnerTxt
RegisterUserFunc "Browser", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "Frame", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "Image", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "Link", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "Page", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "ViewLink", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "WebArea", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "WebButton", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "WebCheckBox", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "WebEdit", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "WebElement", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "WebFile", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "WebList", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "WebRadioGroup", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "WebTable", "verifyInnerTxt", "verifyInnerTxt"
RegisterUserFunc "WebXML", "verifyInnerTxt", "verifyInnerTxt"


' verifyValue
RegisterUserFunc "Browser", "verifyValue", "verifyValue"
RegisterUserFunc "Frame", "verifyValue", "verifyValue"
RegisterUserFunc "Image", "verifyValue", "verifyValue"
RegisterUserFunc "Link", "verifyValue", "verifyValue"
RegisterUserFunc "Page", "verifyValue", "verifyValue"
RegisterUserFunc "ViewLink", "verifyValue", "verifyValue"
RegisterUserFunc "WebArea", "verifyValue", "verifyValue"
RegisterUserFunc "WebButton", "verifyValue", "verifyValue"
RegisterUserFunc "WebCheckBox", "verifyValue", "verifyValue"
RegisterUserFunc "WebEdit", "verifyValue", "verifyValue"
RegisterUserFunc "WebElement", "verifyValue", "verifyValue"
RegisterUserFunc "WebFile", "verifyValue", "verifyValue"
RegisterUserFunc "WebList", "verifyValue", "verifyValue"
RegisterUserFunc "WebRadioGroup", "verifyValue", "verifyValue"
RegisterUserFunc "WebTable", "verifyValue", "verifyValue"
RegisterUserFunc "WebXML", "verifyValue", "verifyValue"

' verifyUrl
RegisterUserFunc "Frame", "verifyUrl", "verifyUrl"
RegisterUserFunc "Image", "verifyUrl", "verifyUrl"
RegisterUserFunc "Link", "verifyUrl", "verifyUrl"
RegisterUserFunc "Page", "verifyUrl", "verifyUrl"
RegisterUserFunc "WebArea", "verifyUrl", "verifyUrl"


'verifyExist
RegisterUserFunc "Browser", "verifyExist", "verifyExist"
RegisterUserFunc "Frame", "verifyExist", "verifyExist"
RegisterUserFunc "Image", "verifyExist", "verifyExist"
RegisterUserFunc "Link", "verifyExist", "verifyExist"
RegisterUserFunc "Page", "verifyExist", "verifyExist"
RegisterUserFunc "ViewLink", "verifyExist", "verifyExist"
RegisterUserFunc "WebArea", "verifyExist", "verifyExist"
RegisterUserFunc "WebButton", "verifyExist", "verifyExist"
RegisterUserFunc "WebCheckBox", "verifyExist", "verifyExist"
RegisterUserFunc "WebEdit", "verifyExist", "verifyExist"
RegisterUserFunc "WebElement", "verifyExist", "verifyExist"
RegisterUserFunc "WebFile", "verifyExist", "verifyExist"
RegisterUserFunc "WebList", "verifyExist", "verifyExist"
RegisterUserFunc "WebRadioGroup", "verifyExist", "verifyExist"
RegisterUserFunc "WebTable", "verifyExist", "verifyExist"
RegisterUserFunc "WebXML", "verifyExist", "verifyExist"

'verifyNotExist
RegisterUserFunc "Browser", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "Frame", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "Image", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "Link", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "Page", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "ViewLink", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "WebArea", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "WebButton", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "WebCheckBox", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "WebEdit", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "WebElement", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "WebFile", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "WebList", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "WebRadioGroup", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "WebTable", "verifyNotExist", "verifyNotExist"
RegisterUserFunc "WebXML", "verifyNotExist", "verifyNotExist"
