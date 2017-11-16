<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="checksession.asp" -->
<!-- #include file="fun-admin.asp" -->
<!Doctype html>
<html>
<%
		page_no=chk_num(trim_fun(request("page_no")))
		modid=chk_num(trim_fun(request("modid")))
		mydo=trim_fun(request("mydo"))
		call dperror(len(modid)=0 or isnull(modid),"读取回复信息出错，请退出登录重新操作","")

  select case mydo
	  case "masking"
	  	'屏蔽帖子	  	
		sql="update BBS_Reply set topic_state=3 where id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"屏蔽成功","admin_replay.asp?see_type=3")
	  case "unmasking"
	  	'解除屏蔽	  	
		sql="update BBS_Reply set topic_state=2 where id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"解除屏蔽成功","admin_replay.asp?see_type=2")
	  case "checked"
	  	'审核帖子	  	
		sql="update BBS_Reply set topic_state=2 where id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"审核帖子成功","admin_replay.asp?see_type=2")
		
	  case "del_replay"
	  	'删除回复	
		call del_replay(modid)
		call dperror(true,"删除回复成功","admin_replay.asp?see_type=1")
  end select


%>
<head>
<meta charset="gb2312">
<title><%=this_title%>帖子</title>
</head>
<body>
</body>
</html>