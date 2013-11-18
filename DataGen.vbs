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
    randInt = RandomNumber.Value(numMin, numMax)
End Function

' random number from numMin to numMax with dotDigit of demical number.
public Function randFloat(numMin, numMax, dotDigit)
   Dim intger
   dotDigit = 10 ^ dotDigit
   numMin = cInt(numMin*dotDigit)
   numMax = cInt(numMax*dotDigit)
   intger = RandomNumber.Value(numMin, numMax)
   randFloat = intger / dotDigit
End Function

' generate a random string in alphabet
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

' generate unique string by date&time
public Function randUStr()
    Dim str
    str = Now()
    str = replace(str, " ","")
    str = replace(str, ":","")
    str = replace(str, "/","")
    str = replace(str, "-","")
    randUStr = str
End Function

' randomSelect from a WebList/RadioGroup.return the selected value
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
