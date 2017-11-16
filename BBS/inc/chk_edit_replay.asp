<!-- #include file="conn-bbs.asp" -->
<!Doctype html>
<html>
<%
	replay_id=chk_num(trim_fun(request("replay_id")))	
	replay_user_id=chk_num(trim_fun(request("replay_user_id")))	
	reply_content=request("reply_content")
	user_id=chk_num(session_user_id)
	
	
	call dperror(len(reply_content)=0 or isnull(reply_content),"请输入内容","")
	call dperror(user_id<>replay_user_id,"您没有修改权限","")
	
	
	
	'读取会员状态
	sql="select * from BBS_User where user_id="& user_id &""
	set rs=bbsconn.execute(sql)
	user_state=0
	if not rs.eof then user_state=chk_num(rs("user_state"))
	call dperror(user_state=2,"您无权限发贴，已被禁言","")
	call dperror(user_state=3,"您无权限发贴，已被锁定","")
	
	
	sql="select * from BBS_Reply where id="& replay_id &" and user_id="& user_id &""
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror(rs.eof,"您没有修改权限","")
		topic_id=rs("topic_id")
		rs("reply_content")=reply_content
		rs("lastedit_time")=thistime
				
	rs.update
	
	
	call dperror(true,"修改成功","../?p"& topic_id &".html")
	response.End()


%>
<head>
<meta charset="gb2312">
<title>注册会员</title>
</head>
<body>
</body>
</html>