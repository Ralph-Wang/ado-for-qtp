'QTP(UFT)�����ݿ����ӿ�
Option Explicit

'���Ժ���,ʹ��ǰ��ע�͵�
'test
Private Function test()
    Const DB = "test"
    Dim DBstr_test
    DBstr_test = "Provider=SQLNCLI10;Server=(local);Database=" & DB & ";Uid=sa;Pwd="
    Dim res
    'Set res = SQL_Output1Line(DBstr, "select * from test")
    'msgbox SQL_GetValue1line(res, "a")

    'Set res = SQL_Output1Field(DBstr, "select a from test")
    'msgbox SQL_GetValue1Field(res, 1)

    Set res = SQL_OutputFullTable(DBstr_test, "select * from test")
    msgbox SQL_GetValueFullTable(res, 0, "a")
End Function

'****************************************************************************************************************************
'������:SQL_GetValue1line
'����:��SQL_Output1Line���ʹ��,��ȡ�䷵�ؽ���еľ���ֵ
'����:Dict, SQL_Output1Line�ķ��ض���; key,SQL_Output1Line��ѯ������ֶ���(����)
'****************************************************************************************************************************
Public Function SQL_GetValue1Line(Dict, key)
    SQL_GetValue1Line = Dict.Item(key)
End Function

'****************************************************************************************************************************
'������:SQL_GetValue1Field
'����:��SQL_Output1Field���ʹ��,��ȡ�䷵�ؽ���еľ���ֵ
'����:Dict, SQL_Output1Field�ķ��ض���; rowNum,SQL_Output1Field��ѯ������к�(��0��ʼ)
'****************************************************************************************************************************
Public Function SQL_GetValue1Field(Dict, rowNum)
    Dim key, i
    key = -1
    For each i in Dict.Keys()
        If InStr(1, i, Cstr(lineNo)) Then
            key = i
            Exit For
        End If
    Next
    If Key = -1 Then
        MsgBox "SQL_GetValue1Field�������,rowNum����Dict���ֵ"
        SQL_GetValue1Field = ""
        Exit Function
    End If
    SQL_GetValue1Field = Dict.Item(key)
End Function

'****************************************************************************************************************************
'������:SQL_GetValueFullTable
'����:��SQL_OutputFullTable���ʹ��,��ȡ�䷵�ؽ���еľ���ֵ
'����:Dict, SQL_Output1Field�ķ��ض���; rowNum,SQL_Output1Field��ѯ������к�(��0��ʼ); key,SQL_OutputFullTable��ѯ����е��ֶ���
'****************************************************************************************************************************
Public Function SQL_GetValueFullTable(Dict, rowNum, key)
    SQL_GetValueFullTable = Dict.Item(Cstr(rowNum)).Item(key)
End Function


'****************************************************************************************************************************
'������:SQL_Output1Field
'����:ִ��SQL��������浽Dict�����в�����,ֻ������ѯ����е�һ���ֶε�����ֵ
'����:DBstr, ���ݿ����Ӵ�(������ODBC��); strSQL, ��Ҫִ�е�SQL���
'****************************************************************************************************************************
Public Function SQL_Output1Field(DBstr, strSQL)
    Dim objCn, objRe
    Set objCn = GetDBConnection(DBstr)
    Set objRe = execSQL(objCn, strSQL)
    Dim Dict, FirstField, iter
    Set FirstField = objRe.Fields(0)
    Set Dict = CreateObject("Scripting.Dictionary")
    Dict.CompareMode = 0
    iter = 0
    Do While not objRe.EOF
        Dict.Add Cstr(FirstField.Name) & "_" & Cstr(iter), Cstr(FirstField.Value)
        objRe.MoveNext
        iter = iter + 1
    Loop
    Set SQL_Output1Field = Dict
    Set FirstField = Nothing
    Set objCn = Nothing
    Set objRe = Nothing
End Function

'****************************************************************************************************************************
'������:SQL_Output1Line
'����:ִ��SQL��������浽Dict�����в�����,ֻ������ѯ����������ֶεĵ�һ��ֵ
'����:DBstr, ���ݿ����Ӵ�(������ODBC��); strSQL, ��Ҫִ�е�SQL���
'****************************************************************************************************************************
Public Function SQL_Output1Line(DBstr, strSQL)
    Dim objCn, objRe
    Set objCn = GetDBConnection(DBstr)
    Set objRe = execSQL(objCn, strSQL)
    Dim Dict, iter
    Set Dict = CreateObject("Scripting.Dictionary")
    Dict.CompareMode = 0
    For each iter in objRe.Fields
        Dict.Add Cstr(iter.Name), Cstr(iter.Value)
    Next
    Set SQL_Output1Line = Dict
    Set objCn = Nothing
    Set objRe = Nothing
    Set Dict = Nothing
End Function

'****************************************************************************************************************************
'������:SQL_OutputFullTable
'����:ִ��SQL��������浽Dict�����в�����,������ѯ����е�ȫ�����
'����:DBstr, ���ݿ����Ӵ�(������ODBC��); strSQL, ��Ҫִ�е�SQL���
'****************************************************************************************************************************
Public Function SQL_OutputFullTable(Dbstr, strSQL)
    Dim objCn, objRe
    Set objCn = GetDBConnection(DBstr)
    Set objRe = execSQL(objCn, strSQL)
    Dim DictFields, DictLines, iter, jter, Fields, iter_Name, iter_Value
    Set DictLines = CreateObject("Scripting.Dictionary")
    DictLines.CompareMode = 0
    jter = 0
    Set Fields = objRe.Fields
    Do While not objRe.EOF
        Set DictFields = CreateObject("Scripting.Dictionary")
        DictFields.CompareMode = 0
        For each iter in Fields
            iter_Name = iter.Name
            if isNull(iter.Value) then
                iter_Value = ""
            Else
                iter_Value = iter.Value
            End if
            DictFields.Add Cstr(iter_Name), Cstr(iter_Value)
        Next
        DictLines.Add Cstr(jter), DictFields
        jter = jter + 1
        objRe.MoveNext
        Set DictFields = Nothing
    Loop
    Set SQL_OutputFullTable = DictLines
    Set objCn = Nothing
    Set objRe = Nothing
    Set DictFields = Nothing
    Set DictLines = Nothing
End Function

'****************************************************************************************************************************
'������:execSQL
'����:ִ��strSQL������һ��RecordSet����
'����:objCn, ADODB���Ӷ���; strSQL, ��Ҫִ�е�SQL���
'****************************************************************************************************************************
Private Function execSQL(objCn, strSQL)
    Dim objRe, save_strSQL
    save_strSQL = strSQL
    Set objRe = CreateObject("ADODB.RecordSet")
    objRe.Open save_strSQL, objcn, 0
    Set execSQL = objRe
    Set objRe = Nothing
End Function

'****************************************************************************************************************************
'������:GetDBConnection
'����:����һ������DBstr��ADO���Ӷ���
'����:DBstr, ���ݿ����Ӵ�(ODBC��)
'****************************************************************************************************************************
Private Function GetDBConnection(DBstr)
    Dim objCn
    Set objCn = CreateObject("ADODB.Connection")
    objCn.Open DBstr
    Set GetDBConnection = objCn
    Set objCn = Nothing
End Function
