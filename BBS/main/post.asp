<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->


<script language="javascript" type="text/javascript" src="inc/main.js"></script>

    <link rel="stylesheet" href="inc/qingeditor/qingstyle.css" />
    <script src="inc/qingeditor/qingeditor-min.js"></script>
    <script>var textarea_name='topic_Content';</script>
    <script src="inc/qingeditor/qingeditor-set.js"></script>


<%if session_user_id>0 then
%>
<form action="inc/chk_post.asp" method="post" name="post">
<div style="clear:both; padding-top:10px; padding-bottom:10px;">

标题：<input type="text" name="topic_title" class="input_style" placeholder="标题" value="" style="width:50%;">
版块：
<select class="input_style" name="board_id" style="width:15%;">
	<%sql="select * from BBS_Board where board_belong>0"
	set rs=bbsconn.execute(sql)
	do while not rs.eof
	board_id=chk_num(rs("board_id"))
	board_name=rs("board_name")
	%>
	<option value="<%=board_id%>" <%if topic_no=board_id then response.Write(" selected")%> ><%=board_name%></option>
    <%
	rs.movenext
	loop
	%>
</select>
</div>

<textarea class="input_style" cols="50" role="50" name="topic_Content" style="  color:#000; width:99%; margin:auto; height:600px;"></textarea>

<div style="clear:both; padding-top:10px;"><input type="submit" class="submit_style" value="发表"></div>
</form>
<%
else
%>
<div class="cannot_post">
您是游客，请 <a href="javascript:void(0);" onClick="display_login_div();" title="登录会员">登录会员</a> 后操作
</div>
<%
end if%>

            
