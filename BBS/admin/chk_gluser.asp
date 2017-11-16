<!-- #include file="../inc/conn-bbs.asp" -->
<!Doctype html>
<html>
<%
	user_num=trim_fun(trim(request("user_num")))
	user_pw=trim_fun(trim(request("user_pw")))
	user_rzm=trim_fun(trim(request("user_rzm")))
	user_rzm_2=trim(session("validateCode"))
	call dperror(len(user_num)=0 or isnull(user_num),"请输入用户名","")
	call dperror(len(user_pw)=0 or isnull(user_pw),"请输入密码","")

	call dperror(user_rzm<>user_rzm_2,"验证码输入不正确","")
	sql="select * from bbs_admin where admin_num='"& user_num &"' and admin_pw='"& user_pw &"'"
	set rs=bbsconn.execute(sql)
	call dperror(rs.eof,"用户名或密码错误","")
	
	session("admin_num")=rs("admin_num")
	'清空会员登录信息
	session("user_num")=""
	session("user_name")=""
	session("user_id")=""
	session("admin_id")=""

	
	response.Redirect("main.asp")
	response.End()
	

%>
<head>
<meta charset="gb2312">
<title>登录检查</title>
</head>
<body>

</body>
</html>