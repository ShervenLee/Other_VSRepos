<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<%
sql="select * from BBS_Topic where topic_id="& topic_no &" and user_id="& session_user_id &""
set rs=bbsconn.execute(sql)
call dperror(rs.eof,"您没有权限修改该主题","")
if not rs.eof then
	topic_user_id=rs("user_id")
	topic_title=rs("topic_title")
	topic_Content=rs("topic_Content")
end if
%>



    <link rel="stylesheet" href="inc/qingeditor/qingstyle.css" />
    <script src="inc/qingeditor/qingeditor-min.js"></script>
    <script>var textarea_name='topic_Content';</script>
    <script src="inc/qingeditor/qingeditor-set.js"></script>
    


<form action="inc/chk_edit_topic.asp" method="post" name="post">
<div style="clear:both; padding-top:10px; padding-bottom:10px;">

标题：<input type="text" name="topic_title" class="input_style" placeholder="标题" value="<%=topic_title%>" style="width:50%;">
<input type="hidden" name="topic_id" class="input_style" value="<%=topic_no%>" style="width:50%;">
<input type="hidden" name="topic_user_id" class="input_style" value="<%=topic_user_id%>" style="width:50%;">
</div>

<textarea class="input_style" cols="50" role="50" name="topic_Content" style="  color:#000; width:99%; margin:auto; height:600px;"><%=topic_Content%></textarea>

<div style="clear:both; padding-top:10px;"><input type="submit" class="submit_style" value="发表"></div>
</form>
