<!-- #include file="conn-bbs.asp" -->
<!-- #include file="md5.asp" -->
<!Doctype html>
<html>
<%
	user_num=trim_fun(request("user_num"))
	user_name=trim_fun(request("user_name"))
	user_password=trim_fun(request("user_password"))
	user_password2=trim_fun(request("user_password2"))
	
	call dperror(len(user_num)=0 or isnull(user_num),"�������»�Ա��¼�ʺ�","")
	user_num=LCase(user_num)
	call dperror(user_num="admin","��Ա��¼�ʺŲ���Ϊadmin","")
	call dperror(len(user_num)<4 or len(user_num)>12,"��Ա��¼�ʺű������4λС��12λ֮��","")
	
	call dperror(len(user_name)=0 or isnull(user_name),"�������»�Ա�ǳ�","")
	call dperror(len(user_password)=0 or isnull(user_password),"�������»�Ա����","")
	call dperror(user_password<>user_password2,"�������벻һ��","")
	
	
	'��ȡ��ԱID
	user_id=0
	sql="select max(user_id) from BBS_User"
	set rs=bbsconn.execute(sql)
	if not rs.eof then user_id=chk_num(rs(0))
	user_id=user_id+1
	
	sql="select * from BBS_User where user_num='"& user_num &"'"
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror(not rs.eof,"�ظ��Ļ�Ա�ʺ�","")
	rs.addnew
		rs("user_id")=user_id
		rs("user_num")=user_num
		rs("user_password")=md5(user_password)
		rs("user_name")=user_name
		rs("user_addtime")=thistime	
		rs("user_state")=1	
			
	rs.update

	
	call dperror(true,"��ϲ��ע��ɹ�\n�����µ�¼","../")
	response.End()


%>
<head>
<meta charset="gb2312">
<title>ע���Ա</title>
</head>
<body>
</body>
</html>