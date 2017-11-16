<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
Response.Buffer = True
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "No-Cache"

   	set bbsconn=server.createobject("adodb.connection")	
	Server.ScriptTimeout=1200
	
	
	
	
	
	
	
	
	
	
	
	
	'BBS_folder论坛程序安装目录，以/开头，以/结尾，根目录请填写/。如在bbs目录下面填写/bbs/
	BBS_folder="/"	
	
	'DB_folder数据库的地址，以/结尾，根目录请留空。请结合BBS_folder填写。
	DB_folder="mdb/"
	
	'DB_name数据库文件名称，建议以.asp结尾，名字中带有#号防止被下载，如：#mdb.asp
	DB_name="mdb.mdb"
	
	'备份数据库时，最大保存数量
	can_dbcounts=10
	
	'备份数据库的文件名称，请不要以.mdb为结尾，防止被他人下载
	DB_backupname="backup.asp"
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	DB_folder=BBS_folder&DB_folder
	DBPath = DB_folder&DB_name
	
	if chkFile(DBPath)="no" then
		alert_html="错误：连接数据库出错，请修改inc/conn-bbs.asp里的DB_folder为实际数据库所在目录。"
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
