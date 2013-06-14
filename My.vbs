Option Explicit


'****************************************************************************************************************************
'函数名:Init_App
'功能:重新启动浏览器,并访问被测系统; 无返回值
'参数:program,测试机IE浏览器的绝对路径  ; url,被测系统的网页地址
'****************************************************************************************************************************
Function Init_App(program, url)
   '用描述性编程关闭 浏览器对象 的所有 标签
   If Browser(":=").Exist(3) Then
       Browser(":=").CloseAllTabs
   End If
   SystemUtil.Run program, url
End Function

'****************************************************************************************************************************
'函数名:Rand_str
'功能:随机生成一定长度的字符串, 大小写混合
'参数: num表示生成长度
'****************************************************************************************************************************
Function Rand_str(num)
    Dim i, str
    For i = 1 To num Step 1
        If RandomNumber.Value(0,1) = 0 Then
            str = str & chr(RandomNumber.Value(65,90))
        Else
            str = str & chr(RandomNumber.Value(97,122))
        End If
        
    Next
    Rand_str = str
End Function

'****************************************************************************************************************************
'函数名:Check_Test
'功能:检查测试实际值与用例期望值是否一致; 一致则返回True,否则返回False
'参数:exp_value,用例期望值   ;  act_value, 测试实际值   ; method, 0代表精确匹配, 1代表模糊匹配
'****************************************************************************************************************************
Function Check_Test(exp_value, act_value, method)
	Dim res
	If method <> 0 and method <> 1 Then
		msgbox "Check_Test函数的method参数不正确; 0-精确匹配, 1-模糊匹配"
	Elseif method = 0 Then
		res = (exp_value = act_value)
		Check_Test = res
	End If
	Select Case method
		Case 0
			res = (exp_value = act_value)
			Check_Test = res
		Case 1
			res = (Instr(1,exp_value,act_value) + Instr(1,act_value,exp_value) > 0)
			Check_Test = res
		Case Else
	End Select
End Function

'****************************************************************************************************************************
'函数名:My_Reporter
'功能:根据测试结果输出标准测试报告; 无返回值
'参数:tcase,用例名称 ; res,布尔值,测试结果
'****************************************************************************************************************************
Function My_Reporter(tcase, res)
	If typename(res) = "Boolean" Then
		Select Case Cstr(res)
			Case "True"
				reporter.ReportEvent micPass, tcase, "测试通过"
			Case "False"
				reporter.ReportEvent micFail, tcase, "测试未通过"
			Case Else
				msgbox "错误的res参数("& res &"),请输入bool类型参数"
		End Select
	Else
		msgbox "错误的res参数("& res &"),请输入bool类型参数"
	End If
End Function





'*****************************************************************************
'以下部分为注册对象方法
'*****************************************************************************
'****************************************************************************************************************************
'方法名:VerifyProperty
'功能:检查测试对象的属性值与期望值是否一致,并输出测试报告
'参数:obj,测试对象 ; prop,需要检查的属性 ; exp_value,测试期望值 ; tcase,测试名称; method, 检查方法, 0代表精确匹配, 1代表模糊匹配
'****************************************************************************************************************************
Function VerifyProperty(obj, prop, exp_value, tcase, method)
   Dim act_value, res
   act_value = obj.GetROProperty(prop)
   res = Check_Test(exp_value, act_value, method)
   Call My_Reporter(tcase, res)
End Function
RegisterUserFunc "Browser", "VerifyProperty", "VerifyProperty"
RegisterUserFunc "Page", "VerifyProperty", "VerifyProperty"
RegisterUserFunc "WebEdit", "VerifyProperty", "VerifyProperty"
RegisterUserFunc "WebButton", "VerifyProperty", "VerifyProperty"
RegisterUserFunc "WebElement", "VerifyProperty", "VerifyProperty"
RegisterUserFunc "Link", "VerifyProperty", "VerifyProperty"
'RegisterUserFunc "Page", "VerifyProperty", "VerifyProperty"
'RegisterUserFunc "Page", "VerifyProperty", "VerifyProperty"
