     
     <%user_num=session("user_num")
	 if len(user_num)=0 or isnull(user_num) then
	 %>
     <div class="user_state"> 
     <form action="inc/chk_login.asp" method="post" name="login">
     <table>
  <tbody>
    <tr>
      <td width="30%" style="text-align:right;"></td>
      <td width="50%" ><input name="user_num" placeholder="�û���" class="input_style"></td>
      <td width="20%" style="padding-left:10px;"><a href="?r.html">��ע��</a></td>
    </tr>
    <tr>
      <td style="text-align:right;"></td>
      <td>
      <input type="hidden" name="re_myurl" value="<%=myurl%>">      
      <input type="password" name="user_password" placeholder="����" class="input_style"></td>
      <td style="padding-left:10px;"><input type="submit" class="submit_style" value="��¼"></td>
    </tr>
  </tbody>
</table>     
	 </form>
     </div>
		<%
	 else
	 
	 %>
     
     <div class="bbs_user_login">
         <div class="user_login_float">
             <div class="top_user_ico"><img src="img/user_logo.png"></div>
         </div>
         <div class="user_login_float">
         	<div class="user_login_info">
         	<span class="user_login_info_title"><%=session("user_name")%></span>
            <br>
            <a href="?u<%=session_user_id%>.html">�ҵ�����</a><span class="user_login_info_line">&nbsp;&nbsp;|&nbsp;&nbsp;</span>        
             <a href="?e.html">����</a><span class="user_login_info_line">&nbsp;&nbsp;|&nbsp;&nbsp;</span>             
             <a href="inc/logout.asp">�˳�</a>
            </div> 
         </div>

     </div>
	 
	 <%
	 end if
	 %>  
        
      