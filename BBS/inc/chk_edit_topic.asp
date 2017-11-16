<!-- #include file="conn-bbs.asp" -->
<!Doctype html>
<html>

    
<%
	topic_title=trim_fun(request("topic_title"))
	topic_id=chk_num(trim_fun(request("topic_id")))	
	topic_user_id=chk_num(trim_fun(request("topic_user_id")))	
	topic_Content=request("topic_Content")
	user_id=chk_num(session_user_id)
	
	call dperror(len(topic_title)=0 or isnull(topic_title),"标题不能为空","")
	call dperror(len(topic_Content)=0 or isnull(topic_Content),"请输入内容","")
	call dperror(user_id<>topic_user_id,"您没有修改权限","")
	
	
	
	'读取会员状态
	sql="select * from BBS_User where user_id="& user_id &""
	set rs=bbsconn.execute(sql)
	user_state=0
	if not rs.eof then user_state=chk_num(rs("user_state"))
	call dperror(user_state=2,"您无权限发贴，已被禁言","")
	call dperror(user_state=3,"您无权限发贴，已被锁定","")
	
	
	sql="select * from BBS_Topic where topic_id="& topic_id &" and user_id="& user_id &""
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror(rs.eof,"您没有修改权限","")
		rs("topic_title")=topic_title
		rs("topic_Content")=topic_Content
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