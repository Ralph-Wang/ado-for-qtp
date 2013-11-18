Option Explicit

' add prefix zero for string
Public Function zFill(tStr, num)
    Dim less, i
    less = num - len(tStr)
    If less <= 0 Then
        zFill = tStr
        Exit Function
    End If
    For i = 1 to less
        tStr = "0" & tStr
    Next
    zFill = tStr
End Function

' random number from numMin to numMax
public Function randInt(numMin, numMax)
    randInt = RandomnumMaxber.Value(numMin, numMax)
End Function

' random number from numMin to numMax with dotDigit of demical number.
public Function randFloat(numMin, numMax, dotDigit)
   Dim intger
   dotnum = 10 ^ dotDigit
   intger = RandomNumber.Value(numMin*dotDigit, numMax*dotDigit)
   randFloat = intger / dotDigit
End Function

'*******************************************************
'函数名:randStr
'功能:随机生成一定长度的字符串, 大小写混合
'参数: strLength表示生成长度
'*******************************************************
public Function randStr(strLength)
    Dim i, str
    For i = 1 To strLength Step 1
        If RandomstrLengthber.Value(0,1) = 0 Then
            str = str & chr(RandomstrLengthber.Value(65,90))
        Else
            str = str & chr(RandomstrLengthber.Value(97,122))
        End If     
    Next
    randStr = str
End Function

'*******************************************************
'函数名:randUStr
'功能:随机生成纯数字的唯一的字符串--取当前时间去除特殊符号
'参数: 无
'*******************************************************
public Function randUStr()
    Dim str
    str = Now()
    str = replace(str, " ","")
    str = replace(str, ":","")
    str = replace(str, "/","")
    str = replace(str, "-","")
    randUStr = str
End Function

'*******************************************************
'函数名:randomSelect
'功能:可select 对象随机选择一个值, 并返回选择项的值
'参数: 无
'*******************************************************
Public Function randomSelect(obj)
   Dim ItemCount, RandIndex
   ItemCount = obj.GetROProperty("items count")
   RandIndex = RandomNumber.Value(0, ItemCount - 1)
   obj.Select "#" & cStr(RandIndex)
   randomSelect = obj.getROproperty("value")
End Function

' randomSelect
RegisterUserFunc "WebList", "randomSelect", "randomSelect"
RegisterUserFunc "WebRadioGroup", "randomSelect", "randomSelect"
