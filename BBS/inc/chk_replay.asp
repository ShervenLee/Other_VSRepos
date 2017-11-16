<!-- #include file="conn-bbs.asp" -->
<!Doctype html>
<html>
<%
	topic_id=chk_num(trim_fun(request("topic_id")))	
	topic_Content=request("topic_Content")
	user_id=chk_num(session_user_id)
	
	call dperror(topic_id<=0,"请选择回复的主题","")
	call dperror(len(topic_Content)=0 or isnull(topic_Content),"请输入内容","")
	call dperror(user_id<=0,"请登录后操作","")
	
	
	
	sql="select * from BBS_Reply where reply_content='"& topic_Content &"' and topic_id="& topic_id &""
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror(not rs.eof,"重复的内容","")
	rs.addnew
		rs("topic_id")=topic_id
		rs("reply_content")=topic_Content
		rs("user_id")=user_id
		rs("reply_time")=thistime
		rs("topic_state")=bbsset_topicpoststate				
	rs.update
	
	'给对应主题增加回复数
	sql="update BBS_Topic set replay_count=replay_count+1 where topic_id="& topic_id &""
	set rs=bbsconn.execute(sql)
	
	call dperror(true,"回复成功","../?p"& topic_id &".html")
	response.End()


%>
<head>
<meta charset="gb2312">
<title>注册会员</title>
</head>
<body>
</body>
</html>