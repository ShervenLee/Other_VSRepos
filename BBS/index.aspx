<!-- #include file="inc/conn-bbs.asp" -->
<!-- #include file="inc/myurl.asp" -->
<%

title=bbsset_sitename
board_name=""
select case left(myurl,1)
	case "p"		
		sql="select * from BBS_Topic where topic_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			topic_title=rs("topic_title")
			board_id=rs("board_id")
		end if
		topic_title=left(topic_title,25)
		sql="select board_name from BBS_Board where board_id="& board_id &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_name=rs(0)
		title=topic_title		
		if page_no>1 then title=title&"-第"& page_no &"页"
		title=title&"-"&bbsset_sitename
		where_now=" > <a href=?b"& board_id &".html>"&board_name&"</a> > <span>"& topic_title &"</span>"
		goto_file="page"
	case "b"
		sql="select board_name from BBS_Board where board_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_name=rs(0)
		title=board_name		
		if page_no>1 then title=title&"-第"& page_no &"页"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>"&board_name&"</span>"
		goto_file="board"
	case "u"		
		board_name=chk_db("BBS_User","user_id",topic_no,"user_name")		
		title=board_name&" 的贴子"		
		if page_no>1 then title=title&"-第"& page_no &"页"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>"&board_name&" 的贴子</span>"
		goto_file="board"
	case "n"	
		title="发表新帖子"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>发表新帖子</span>"
		goto_file="post"
	case "r"	
		title="注册新会员"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>注册新会员</span>"
		goto_file="reg"
	case "e"	
		title="修改会员资料"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>修改资料</span>"
		goto_file="edit_userinfo"
	case "z"	
		title="编辑主题"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>编辑主题</span>"
		goto_file="edit_topic"
	case "h"	
		title="编辑回复"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>编辑回复</span>"
		goto_file="edit_replay"
	case else
		goto_file="main"
end select

%>
<!doctype html>
<html>
<head>
<meta charset="gb2312">
<link rel="stylesheet" type="text/css" href="inc/index.css"/>
<title><%=title%></title>


<div class="css_top" style="background-color:#f2f2f2; border-bottom:1px #cdcdcd solid; ">
	<div class="css_top_div">
 		<div class="css_top_title" style="color:#333;">
            asp+access开源简单论坛
        </div> 

	</div>	
</div>



<div class="css_top_blank">
    <div class="css_top_blank2">
        <div class="css_top_logo"  style="padding-top:15px;">
            <a href="/" title="首页"><img src="img/logo.png" alt="首页"></a>

            
        </div>
        <div>
        <div style="float:right; width:30%; padding-top:20px; padding-bottom:20px;">
        <!-- #include file="main/user_state.asp" -->

        </div>
        </div>
    </div>
</div>


<div class="page_single_top">
    <ul>
        <li><a href="/">论坛首页</a></li>
        <li><a href="http://www.cnw6.com/cnw6/bbs/" target="_blank">小清论坛</a></li>
        <li><a href="http://www.cnw6.com/" target="_blank">直销软件</a></li>

    </ul>
</div>









<div class="page_single_main">
	<div class="page_single_main_div">
        
<div style="float:left"><div class="page_single_main_title"><a href="<%=BBS_folder%>"><%=bbsset_sitename%></a><%=where_now%></div></div>
        <div class="page_single_content">        	
			<div class="bbs_content">
			
			<%server.execute("main/"&goto_file&".asp")%>
            
            </div>
        </div>
    </div>
</div>

<!-- #include file="main/login.asp" -->





<div class="css_end_3">
    <ul>


 
        <li>Powered by <a href="http://www.cnw6.com/cnw6/bbs/" target="_blank">小清论坛</a> v1.0</li>  
        <li><a href="http://www.cnw6.com/" target="_blank" title="直销软件">直销软件</a></li>  
                <li style=" margin-bottom:20px; clear:both;">
        	
        </li>
         
    </ul>
</div>



</bod></html>