<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->

<script language="javascript" type="text/javascript" src="inc/main.js"></script>
<%
	sql="select * from BBS_Switch"
	set rs=bbsconn.execute(sql)
	if not rs.eof then
		BBS_Switch=rs("BBS_Switch")
		close_tips=rs("close_tips")
	end if
	if chk_num(BBS_Switch)=3 then
		%><div class="post_notdisplay">< <%=close_tips%> ></div><%
		response.End()
	end if
	
	
	
sql="select * from BBS_Topic where topic_id="& topic_no &""
set rs=server.CreateObject("adodb.recordset")
rs.open sql,bbsconn,1,3
if not rs.eof then
	user_id=rs("user_id")
	topic_id=chk_num(rs("topic_id"))
	topic_title=rs("topic_title")
	topic_Content=rs("topic_Content")
	topic_addtime=rs("topic_addtime")
	lastedit_time=rs("lastedit_time")
	board_id=rs("board_id")
	topic_seetimes=chk_num(rs("topic_seetimes"))
	replay_count=chk_num(rs("replay_count"))
	topic_state=chk_num(rs("topic_state"))
	rs("topic_seetimes")=topic_seetimes+1
	rs.update
	user_name=chk_db("BBS_User","user_id",user_id,"user_name")
end if
%>



<div class="topic_post">
	<%if session_user_id>0 then
    	%><a href="?n<%=board_id%>.html" title="������"><img src="img/pn_post.png"></a><%
    else
    	%><a href="javascript:void(0);" onClick="display_login_div();" title="������"><img src="img/pn_post.png"></a><%
    end if%>
</div>



<%
if page_no=1 then call display_post(1,topic_id,1,"",user_id,user_name,topic_title,topic_addtime,topic_state,topic_Content,topic_seetimes,replay_count,lastedit_time)




   set rs=server.CreateObject("adodb.recordset") 
   sql="select * from BBS_Reply where topic_id="& topic_no &" order by id asc"  
   rs.open sql,bbsconn,1,1
	page_size=bbsset_topicpagesize	
	if not rs.eof then
		rs.PageSize=page_size		
		pagecount=rs.PageCount '��ȡ��ҳ�� 
		if page_no>pagecount then page_no=pagecount		
		rs.AbsolutePage=page_no '���ñ�ҳҳ�� 
		allRecordCount=rs.RecordCount
	end if
	allRecordCount=chk_num(allRecordCount)
	i=1
	whoami=""
   do while not rs.eof
   
	user_id=rs("user_id")
	reply_content=rs("reply_content")
	topic_state=chk_num(rs("topic_state"))
	replay_id=chk_num(rs("id"))
	reply_time=rs("reply_time")
	lastedit_time=rs("lastedit_time")
	user_name=chk_db("BBS_User","user_id",user_id,"user_name")
	user_where=i+(page_no-1)*page_size
	select case user_where
		case 1
			user_where="ɳ��"
		case 2
			user_where="���"
		case else
			user_where=user_where&"¥"
	end select
	
	post_title=0
	if page_no>1 and i=1 then post_title=1

	
	call display_post(2,replay_id,post_title,user_where,user_id,user_name,"",reply_time,topic_state,reply_content,0,replay_count,lastedit_time)

	
	if i>=page_size then exit do  
	i=i+1  
	rs.movenext
	loop
%>
<div class="pagination"><%=bbs_page_no(page_no,pagecount,"")%></div>



<div class="topic_post">
	<%if session_user_id>0 then
    	%><a href="?n<%=board_id%>.html" title="������"><img src="img/pn_post.png"></a><%
    else
    	%><a href="javascript:void(0);" onClick="display_login_div();" title="������"><img src="img/pn_post.png"></a><%
    end if%>
</div>




   	<div class="page_top">
        <div class="page_left">
        	<%if session_user_id>0 then%>
                <div class="page_left_menu2">
                    <a href="?u<%=session_user_id%>.html"><%=session("user_name")%></a>
                </div>
                <div class="user_logo">
                    <img src="img/user_logo.png">
                </div>
            <%end if%>
        </div>
        <div class="page_right">
<div class="topic_Content" style="padding-top:30px;">
<form action="inc/chk_replay.asp" method="post" name="post">	
    <link rel="stylesheet" href="inc/qingeditor/qingstyle.css" />
    <script src="inc/qingeditor/qingeditor-min.js"></script>
    <script>var textarea_name='topic_Content';</script>
    <script src="inc/qingeditor/qingeditor-set.js"></script>
    <div style=" float:left; width:70%; position:relative;">
	<%if session_user_id<=0 then%>
        <div class="notlogin_replay">
            ����Ҫ��¼��ſ��Ի���
            <a href="javascript:void(0);" onClick="display_login_div();" title="��¼��Ա">��¼</a> |
            <a href="?r.html">����ע��</a>
        </div>
    <%end if%>
    <textarea class="input_style" cols="50" role="50" name="topic_Content" style="  color:#000; width:100%; height:280px;"></textarea>
    <input type="hidden" value="<%=topic_no%>" name="topic_id">
    </div>
    <div style=" float:left; width:28%; padding-left:2%;">
    <b>������</b>
    <div style="line-height:22px; text-indent:2em;"><%=chk_db("BBS_Board","board_id",board_id,"board_demo")%></div>
    </div>
    
<div class="topic_post_div">

    <div class="topic_post">
        <%if session_user_id>0 then
            %><input type="submit" class="submit_style" value="����ظ�"><%
        else
            %><input type="button" class="submit_style" value="����ظ�" onClick="display_login_div();"><%
        end if%>
    </div>


</div>
    
 </form>   
</div>

        	           
        </div>
<div style="clear:both;"></div>
   </div>
   
   
   
   <%
	sub display_post(post_type,post_id,post_title,user_where,user_id,user_name,topic_title,topic_addtime,topic_state,topic_Content,topic_seetimes,replay_count,lastedit_time)
%>

	<div class="page_top">
        <div class="page_left">
        	<%if post_title=1 then%>
                 <div class="page_left_menu1"> 
                    <%if post_type=1 then%>           
                        �鿴: <span><%=topic_seetimes%></span>
                        &nbsp;|&nbsp;
                        �ظ�: <span><%=replay_count%> </span>
                    <%end if%>
                </div>
            <%end if%>
            
            <div class="page_left_menu2">
        		<%if post_type=1 then%>
                	¥��
                <%else%>
                	<%=user_where%>
                <%end if%>
                ��<a href="?u<%=user_id%>.html"><%=user_name%></a>
                
            </div>
            <div class="user_logo">
        		<img src="img/user_logo.png">
            </div>
            
            
        </div>
        <div class="page_right">
        
        	<%if post_title=1 then%>
                <div class="page_right_menu1" title="<%=topic_title%>">
                    <%=left(topic_title,35)%>
                </div>
            <%end if%>
            <div class="page_right_menu2">
        		<img src="img/online_admin.gif"> ������ <%=howlong(topic_addtime)%>
            </div>
            <div class="topic_Content">
            <%select case topic_state
				case 1%>
                <div class="post_notdisplay">< ������������� ></div>
              <%case 2%>
              	<div class="lastedit_time">
					<%if len(lastedit_time)>0 then%>
                        ��������� <%=user_name%> �� <%=howlong(lastedit_time)%> �༭
                    <%end if%>
                </div>
              	<%=topic_Content%>
              <%case 3%>
              	<div class="post_notdisplay">< ���������ѱ����� ></div>
              <%end select%>              
            
                <%
				if user_id=session_user_id then%>
                  <div class="topic_edit_line"><ul><li>
						<%if post_type=1 then%>
                            <a href="?z<%=post_id%>.html" title="�༭����">�༭</a>
                        <%else%>
                            <a href="?h<%=post_id%>.html" title="�༭�ظ�">�༭</a>
                        <%end if%>  
                        </li>
                          
                        </li>
                        
                        </ul>                      
                  </div>
                <%end if%>
        	 </div>        
        </div>
<div style="clear:both;"></div>
   </div>
  <%end sub%> 