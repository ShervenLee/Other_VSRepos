<!-- #include file="../inc/conn-bbs.asp" -->
<%sql="select * from BBS_Board where board_belong=0"
set rs=bbsconn.execute(sql)
%><div class="bbs_main"><%
do while not rs.eof
board_id=rs("board_id")
board_name=rs("board_name")
%>

	<div class="bbs_content_title">
        <%=board_name%>
    </div>
	<%sql2="select * from BBS_Board where board_belong="& board_id &""
    set rs2=bbsconn.execute(sql2)
	
    do while not rs2.eof
	
    board_id2=rs2("board_id")
    board_name2=rs2("board_name")
	board_demo2=rs2("board_demo")	
	board_count2=chk_num(rs2("board_count"))	
	sql3="select count(id) from BBS_Topic where board_id="& board_id2 &" and left(topic_addtime,10)='"& left(thistime,10) &"'"
    set rs3=bbsconn.execute(sql3)	
	today_board_count=0
    if not rs3.eof then today_board_count=chk_num(rs3(0))
	forum_gif=""
	if today_board_count>0 then forum_gif="_new"
    %>
    <div class="bbs_content_board">
    	<div class="bbs_board_left forum_ico">                       
            <a href="?b<%=board_id2%>.html"><img src="img/forum<%=forum_gif%>.gif"></a>            
        </div>
    	<div class="bbs_board_left" style="width:55%;">
            <div class="bbs_board_title"><ul><li>
            <a href="?b<%=board_id2%>.html"><%=board_name2%></a></li></ul></div>
            <div class="bbs_board_demo">
                <%=board_demo2%>
            </div>
            <div class="bbs_board_demo">
            热点：
            <%
			sql3="select top 1 * from BBS_Topic where board_id="& board_id2 &" order by topic_seetimes desc"
    		set rs3=bbsconn.execute(sql3)
			if rs3.eof then		
			%><span class="bbs_board_topic_no">暂无热点</span><%
			else
				topic_id=rs3("topic_id")
				topic_title=rs3("topic_title")
				user_id=rs3("user_id")
				topic_addtime=rs3("topic_addtime")
				
				user_name=chk_db("BBS_User","user_id",user_id,"user_name")
				
				
			%>
				<a href="?p<%=topic_id%>.html" id="hot_link" title="<%=topic_title%>"><%=left(topic_title,15)%></a>
			<%end if%>
                
            </div>
        </div>
        <div class="bbs_board_left" style="width:10%;">
        	<div class="bbs_board_date">
        		<span><%=today_board_count%></span> / <%=board_count2%>
            </div>
        </div>
        <div class="bbs_board_right">
        <%
		sql3="select top 1 * from BBS_Topic where board_id="& board_id2 &" order by id desc"
    	set rs3=bbsconn.execute(sql3)
		
		if rs3.eof then		
			%><div class="bbs_board_topic_no">暂无贴子</div><%
		else
			topic_id=rs3("topic_id")
			topic_title=rs3("topic_title")
			user_id=rs3("user_id")
			topic_addtime=rs3("topic_addtime")
			
			user_name=chk_db("BBS_User","user_id",user_id,"user_name")
			
			
		%>
        	<div class="bbs_board_topic_title">
        		<a href="?p<%=topic_id%>.html" title="<%=topic_title%>"><%=left(topic_title,15)%></a>             
            </div>
            <div class="bbs_board_topic_date">
        		<%=howlong(topic_addtime)%>
                <a href="?u<%=user_id%>.html" id="hot_link"><%=user_name%></a>                
            </div>
        <%end if%>
        </div>       
        <div style="clear:both;"></div>
    </div>
    <%
	
	rs2.movenext
	loop
	%>
    <%
	rs.movenext
	loop
	%>
    <div style="clear:both;"></div>
</div></div>