<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<!-- #include file="../inc/md5.asp" -->
<!Doctype html>
<html>
<%

		modid=CHK_num(session("user_id"))
		mydo=trim(request("mydo"))
		user_name=trim(request("user_name"))
		user_password=trim(request("user_password"))
		user_password2=trim(request("user_password2"))
		user_password_old=trim(request("user_password_old"))
		
		
		call dperror(modid=0,"��ȡ��Ա��Ϣ���������µ�¼������","")
		call dperror(len(user_name)=0 or isnull(user_name),"����д�ǳ�","")
		call dperror(len(user_password)=0 or isnull(user_password),"����д����","")
		call dperror(len(user_password2)=0 or isnull(user_password2),"����дȷ������","")
		call dperror(user_password<>user_password2,"�����������벻һ��","")
		
		if user_password<>user_password_old then user_password=md5(user_password)
		

	
	'�޸Ļ�Ա����
	sql="update BBS_User set user_name='"& user_name &"',user_password='"& user_password &"' where user_id="& modid &""
	set rs=bbsconn.execute(sql)
	
	call dperror(true,"�޸ĳɹ�\n�����µ�¼����ʾ�޸ĵ���Ϣ","logout.asp")

%>
<head>
<meta charset="gb2312">
<title>�޸�����</title>
</head>
<body>

</body>
</html>