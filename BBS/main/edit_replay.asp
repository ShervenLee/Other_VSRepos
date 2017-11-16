<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<%
sql="select * from BBS_Reply where id="& topic_no &" and user_id="& session_user_id &""
set rs=bbsconn.execute(sql)
call dperror(rs.eof,"您没有权限修改该回复","")
if not rs.eof then
	replay_user_id=rs("user_id")
	topic_id=rs("topic_id")
	reply_content=rs("reply_content")
end if

%>


    <link rel="stylesheet" href="inc/qingeditor/qingstyle.css" />
    <script src="inc/qingeditor/qingeditor-min.js"></script>
    <script>var textarea_name='reply_content';</script>
    <script src="inc/qingeditor/qingeditor-set.js"></script>
    


<form action="inc/chk_edit_replay.asp" method="post" name="post">
<div style="clear:both; padding-top:10px; padding-bottom:10px;">

修改主题：<%=chk_db("BBS_Topic","topic_id",topic_id,"topic_title")%>
<input type="hidden" name="replay_id" class="input_style" value="<%=topic_no%>" style="width:50%;">
<input type="hidden" name="replay_user_id" class="input_style" value="<%=replay_user_id%>" style="width:50%;">
</div>

<textarea class="input_style" cols="50" role="50" name="reply_content" style="  color:#000; width:99%; margin:auto; height:600px;"><%=reply_content%></textarea>

<div style="clear:both; padding-top:10px;"><input type="submit" class="submit_style" value="发表"></div>
</form>
