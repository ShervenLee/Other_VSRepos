<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
Response.Buffer = True
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "No-Cache"

   	set bbsconn=server.createobject("adodb.connection")	
	Server.ScriptTimeout=1200
	
	
	
	
	
	
	
	
	
	
	
	
	'BBS_folder��̳����װĿ¼����/��ͷ����/��β����Ŀ¼����д/������bbsĿ¼������д/bbs/
	BBS_folder="/"	
	
	'DB_folder���ݿ�ĵ�ַ����/��β����Ŀ¼�����ա�����BBS_folder��д��
	DB_folder="mdb/"
	
	'DB_name���ݿ��ļ����ƣ�������.asp��β�������д���#�ŷ�ֹ�����أ��磺#mdb.asp
	DB_name="mdb.mdb"
	
	'�������ݿ�ʱ����󱣴�����
	can_dbcounts=10
	
	'�������ݿ���ļ����ƣ��벻Ҫ��.mdbΪ��β����ֹ����������
	DB_backupname="backup.asp"
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	DB_folder=BBS_folder&DB_folder
	DBPath = DB_folder&DB_name
	
	if chkFile(DBPath)="no" then
		alert_html="�����������ݿ�������޸�inc/conn-bbs.asp���DB_folderΪʵ�����ݿ�����Ŀ¼��"
		%><script>
        alert('<%=alert_html%>');
        </script><%
		response.Write(alert_html)
		response.End()
	end if
	DBPath = Server.MapPath(DBPath)

	bbsconn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & DBPath &";" 
	'bbsconn.CursorLocation = adUseClient
	
	
	
thistoday = year(now)&"-"&right("0"&month(now),2)&"-"&right("0"&day(now),2)
thistime=thistoday&" "&right("0"&hour(now),2)&":"&right("0"&minute(now),2)&":"&right("0"&second(now),2)
session_user_id=chk_num(session("user_id"))
session_admin_id=chk_num(session("admin_id"))
%>
<!-- #include file="fun-bbs.asp" -->
<!-- #include file="config-bbs.asp" -->
<link rel="stylesheet" type="text/css" href="../inc/bbs.css"/>
