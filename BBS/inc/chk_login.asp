<!-- #include file="conn-bbs.asp" -->
<!-- #include file="md5.asp" -->
<!Doctype html>
<html>
<%
	user_num=trim_fun(trim(request("user_num")))
	user_password=trim_fun(trim(request("user_password")))
	re_myurl=trim_fun(trim(request("re_myurl")))
	
	call dperror(len(user_num)=0 or isnull(user_num),"�������û���","")
	call dperror(len(user_password)=0 or isnull(user_password),"����������","")

	'call dperror(user_rzm<>user_rzm_2,"��֤�����벻��ȷ","")
	
	
	sql="select * from BBS_Switch"
	set rs=bbsconn.execute(sql)
	if not rs.eof then
		BBS_Switch=rs("BBS_Switch")
		close_tips=rs("close_tips")
	end if
	BBS_Switch=chk_num(BBS_Switch)
	call dperror(BBS_Switch>1,"��¼ʧ�ܣ�\n"&close_tips,"")
	
	
	
	user_password=md5(user_password)
	
	sql="select * from BBS_User where user_num='"& user_num &"' and user_password='"& user_password &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror(rs.eof,"�û������������","")
	
	user_state=chk_num(rs("user_state"))
	call dperror(user_state=3,"����Ȩ�޵�¼���ѱ�����","")
	
	
	session("user_id")=rs("user_id")
	session("user_name")=rs("user_name")
	session("user_num")=rs("user_num")
	rs("lastlogin_time")=thistime
	rs("login_times")=chk_num(rs("login_times"))+1
	
	rs.update
	
	'����Ա�Ƿ��ǹ���Ա
	sql="select id from BBS_Admin where user_id="& session("user_id") &""
	set rs=bbsconn.execute(sql)
	admin_id=0
	if not rs.eof then admin_id=session("user_id")
	session("admin_id")=admin_id
	
	call dperror(true,session("user_name")&"����¼�ɹ�","../?"&re_myurl)
	
	response.End()
	

%>
<head>
<meta charset="gb2312">
<title>��¼���</title>
</head>
<body>

</body>
</html>