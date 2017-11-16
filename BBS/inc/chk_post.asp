<!-- #include file="conn-bbs.asp" -->
<!Doctype html>
<html>
<%
	topic_title=trim_fun(request("topic_title"))
	board_id=chk_num(trim_fun(request("board_id")))	
	topic_Content=request("topic_Content")
	user_id=chk_num(session_user_id)
	
	call dperror(len(topic_title)=0 or isnull(topic_title),"标题不能为空","")
	call dperror(board_id<=0,"请选择版块","")
	call dperror(len(topic_Content)=0 or isnull(topic_Content),"请输入内容","")
	call dperror(user_id<=0,"请登录后操作","")
	
	
	
	'读取会员状态
	sql="select * from BBS_User where user_id="& user_id &""
	set rs=bbsconn.execute(sql)
	user_state=0
	if not rs.eof then user_state=chk_num(rs("user_state"))
	call dperror(user_state=2,"您无权限发贴，已被禁言","")
	call dperror(user_state=3,"您无权限发贴，已被锁定","")
	
	
	
	
	'读取帖子ID
	topic_id=0
	sql="select max(topic_id) from BBS_Topic"
	set rs=bbsconn.execute(sql)
	if not rs.eof then topic_id=chk_num(rs(0))
	topic_id=topic_id+1
	
	
	sql="select * from BBS_Topic where (topic_title='"& topic_title &"' or topic_Content='"& topic_Content &"') and board_id="& board_id &""
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror(not rs.eof,"重复的主题或内容","")
	rs.addnew
		rs("topic_id")=topic_id
		rs("board_id")=board_id
		rs("user_id")=user_id
		rs("topic_title")=topic_title
		rs("topic_Content")=topic_Content
		rs("topic_addtime")=thistime
		rs("topic_state")=bbsset_topicpoststate				
	rs.update
	
	'增加版块主题数
	sql="update BBS_Board set board_count=board_count+1 where board_id="& board_id &""
	set rs=bbsconn.execute(sql)
	
	call dperror(true,"发布成功","../?p"& topic_id &".html")
	response.End()


%>
<head>
<meta charset="gb2312">
<title>注册会员</title>
</head>
<body>
</body>
</html>