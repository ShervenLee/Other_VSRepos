<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="checksession.asp" -->
<!-- #include file="fun-admin.asp" -->
<!Doctype html>
<html>
<%
		page_no=chk_num(trim_fun(request("page_no")))
		modid=chk_num(trim_fun(request("modid")))
		mydo=trim_fun(request("mydo"))
		call dperror(len(modid)=0 or isnull(modid),"读取操作信息出错，请退出登录重新操作","")

  select case mydo
	  case "gag"
	  	'禁言会员	  	
		sql="update BBS_User set user_state=2 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"禁言成功","admin_meber.asp?see_type=2")
	  case "ungag"
	  	'解除禁言	  	
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"解除禁言成功","admin_meber.asp?see_type=1")
	  case "lock"
	  	'锁定会员	  	
		sql="update BBS_User set user_state=3 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"锁定成功","admin_meber.asp?see_type=3")
	  case "unlock"
	  	'解锁会员
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"解锁成功","admin_meber.asp?see_type=1")
	  case "del_user_post"
	  	'删除会员	
		call del_user_post(modid)
		call dperror(true,"删除所有帖子成功","admin_meber.asp?see_type=1")
	  case "del_user"
	  	'删除会员	
		call del_user(modid)
		call dperror(true,"删除会员成功","admin_meber.asp?see_type=1")
  end select


%>
<head>
<meta charset="gb2312">
<title><%=this_title%>会员</title>
</head>
<body>
</body>
</html>