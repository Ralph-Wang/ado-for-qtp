Option Explicit
'' 一般的函数
'****************************************************************************************************************************
'函数名:randInt
'功能:随机生成一个整数 (0 ~ num)
'参数: num随机数的最大值
'****************************************************************************************************************************
public Function randInt(num)
    randInt = RandomNumber.Value(0, num)
End Function

'****************************************************************************************************************************
'函数名:randFloat
'功能:随机生成一个浮点数(0 ~ num)
'参数: num随机数的最大值,小数位数dotNum
'****************************************************************************************************************************
public Function randFloat(num, dotNum)
   Dim intger
   dotNum = 10 ^ dotNum
   intger = RandomNumber.Value(0, num * dotNum)
   randFloat = intger / dotNum
End Function

'****************************************************************************************************************************
'函数名:randStr
'功能:随机生成一定长度的字符串, 大小写混合
'参数: num表示生成长度
'****************************************************************************************************************************
public Function randStr(num)
    Dim i, str
    For i = 1 To num Step 1
        If RandomNumber.Value(0,1) = 0 Then
            str = str & chr(RandomNumber.Value(65,90))
        Else
            str = str & chr(RandomNumber.Value(97,122))
        End If     
    Next
    randStr = str
End Function
'****************************************************************************************************************************
'函数名:randUStr
'功能:随机生成纯数字的唯一的字符串--取当前时间去除特殊符号
'参数: 无
'****************************************************************************************************************************
public Function randUStr()
    Dim str
    str = Now()
    str = replace(str, " ","")
    str = replace(str, ":","")
    str = replace(str, "/","")
    str = replace(str, "-","")
    randUStr = str
End Function


'****************************************************************************************************************************
'函数名:randomSelect
'功能:可select 对象随机选择一个值
'参数: 无
'****************************************************************************************************************************
Public Function randomSelect(obj)
   Dim ItemCount, RandIndex
   ItemCount = obj.GetROProperty("items count")
   RandIndex = RandomNumber.Value(0, ItemCount - 1)
   obj.Select "#" & cStr(RandIndex)
End Function


' randomSelect
RegisterUserFunc "WebList", "randomSelect", "randomSelect"
RegisterUserFunc "WebRadioGroup", "randomSelect", "randomSelect"