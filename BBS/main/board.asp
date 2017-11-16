<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<script language="javascript" type="text/javascript" src="inc/main.js"></script>
<%
select case left(myurl,1)
	case "b" 
		sql="select * from BBS_Board where board_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		if rs.eof then
			response.Redirect("?")
			response.End()
		end if
		board_id=rs("board_id")
		board_name=rs("board_name")
		board_sql=" and board_id="& board_id
		now_board=topic_no
		board_count=chk_num(rs("board_count"))
		sql="select count(id) from BBS_Topic where board_id="& topic_no &" and left(topic_addtime,10)='"& left(thistime,10) &"'"
		set rs=bbsconn.execute(sql)
		today_board_count=chk_num(rs(0))		
		
	case "u"
		board_id=topic_no
		board_name=chk_db("BBS_User","user_id",topic_no,"user_name")&" 全部帖子"
		board_sql=" and user_id="& board_id	
		now_board=0
		sql="select count(id) from BBS_Topic where user_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		board_count=chk_num(rs(0))
		sql="select count(id) from BBS_Topic where user_id="& topic_no &" and left(topic_addtime,10)='"& left(thistime,10) &"'"
		set rs=bbsconn.execute(sql)
		today_board_count=chk_num(rs(0))
end select
%>
	<div class="Board_top">
        <div class="Board_title"><%=board_name%></div>
        <div class="Board_about">
        今日: <span class="Board_about_count"><%=today_board_count%></span>
        <span class="Board_about_line">&nbsp;|&nbsp;</span>
        主题: <span class="Board_about_count"><%=board_count%></span>
        </div>
    </div>
    <div style="clear:both;"></div>

<div class="topic_post">
<%if session_user_id>0 then
%><a href="?n<%=now_board%>.html" title="发新贴"><img src="img/pn_post.png"></a><%
else
%><a href="javascript:void(0);" onClick="display_login_div();" title="发新贴"><img src="img/pn_post.png"></a><%
end if%>

</div>

</div>   
    
    
   <div class="Board_table">
 <table>
     <thead>
         <tr>
          <th width="60%">主题</th>
          <th>作者</th>
          <th>回复/查看</th>
          <th>最后发表</th>
        </tr>
     </thead>
  <tbody>
  
  <%
  sql="select * from BBS_Topic where 1=1"
  if session_user_id>0 then
  	sql=sql&" and (topic_state=2 or user_id="& session_user_id &" or "& session_user_id &">0)"
  else
  	sql=sql&" and topic_state=2"
  end if
  sql=sql&board_sql
  sql=sql&" order by id desc"
  set rs=server.CreateObject("adodb.recordset")
  rs.open sql,bbsconn,1,1
	page_size=bbsset_boardpagesize
	
	if not rs.eof then
		rs.PageSize=page_size		
		pagecount=rs.PageCount '获取总页码 
		if page_no>pagecount then page_no=pagecount		
		rs.AbsolutePage=page_no '设置本页页码 
		allRecordCount=rs.RecordCount
	else
		%>
		
		    <tr>
      <td colspan="4">暂无帖子!</td>
      </tr>
		<%
	end if
	allRecordCount=chk_num(allRecordCount)
	i=1

  do while not rs.eof
    topic_id=rs("topic_id")
  	topic_title=rs("topic_title")
	topic_addtime=rs("topic_addtime")
	topic_seetimes=chk_num(rs("topic_seetimes"))
	replay_count=chk_num(rs("replay_count"))
	user_id=rs("user_id")
	user_name=chk_db("BBS_User","user_id",user_id,"user_name")
	
  %>
    <tr>
      <td class="board_topic_title"><a href="?p<%=topic_id%>.html" title="<%=topic_title%>">
      <img src="img/folder_common.gif">
	  <%=left(topic_title,35)%></a></td>
      <td><a href="?u<%=user_id%>.html"><%=user_name%></a><br><%=howlong(topic_addtime)%></td>
      <td><%=replay_count%><br><%=topic_seetimes%></td>
      <td><a href="?u<%=user_id%>.html"><%=user_name%></a><br><%=howlong(topic_addtime)%></td>
    </tr>
    <%
	if i>=page_size then exit do
    i=i+1
	rs.movenext
	loop
	%>
    <tr>
      <td colspan="4"><ul class="pagination"><%=bbs_page_no(page_no,pagecount,"")%></ul></td>
      </tr>
    
  </tbody>
</table>

   </div>
<div style="clear:both;"></div>
