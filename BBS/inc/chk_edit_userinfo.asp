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
		
		
		call dperror(modid=0,"读取会员信息出错，请重新登录后重试","")
		call dperror(len(user_name)=0 or isnull(user_name),"请填写昵称","")
		call dperror(len(user_password)=0 or isnull(user_password),"请填写密码","")
		call dperror(len(user_password2)=0 or isnull(user_password2),"请填写确认密码","")
		call dperror(user_password<>user_password2,"两次密码输入不一致","")
		
		if user_password<>user_password_old then user_password=md5(user_password)
		

	
	'修改会员资料
	sql="update BBS_User set user_name='"& user_name &"',user_password='"& user_password &"' where user_id="& modid &""
	set rs=bbsconn.execute(sql)
	
	call dperror(true,"修改成功\n请重新登录后显示修改的信息","logout.asp")

%>
<head>
<meta charset="gb2312">
<title>修改资料</title>
</head>
<body>

</body>
</html>