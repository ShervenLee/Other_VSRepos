<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<%
sql="select * from BBS_User where user_id="& session("user_id") &""
set rs=bbsconn.execute(sql)
if not rs.eof then
	user_num=rs("user_num")
	user_name=rs("user_name")
	user_id=rs("user_id")
	user_state=rs("user_state")
	login_times=rs("login_times")
	user_password=rs("user_password")
	user_addtime=rs("user_addtime")
end if
user_state=CHK_num(user_state)
%>
<script language="javascript" type="text/javascript" src="inc/reg_chk.js"></script>
<div id="bbsreg_div">
    <div class="reg_title">编辑资料</div>
    <div class="reg_content">
    	<form action="inc/chk_edit_userinfo.asp" method="post" name="edit" onSubmit="return Validator.Validate(this,3)">
    <table>
  <tbody>
    <tr>
      <td style="text-align:right;" width="30%">用户名：</td>
      <td  width="30%"><%=user_num%>
      </td>
    </tr>
    <tr>
      <td style="text-align:right;">昵称：</td>
      <td><input type="text" name="user_name" class="input_style" value="<%=user_name%>" msg="昵称必须填写!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">密码：</td>
      <td><input type="password" name="user_password" class="input_style" value="<%=user_password%>" msg="密码必须填写!" min="1" dataType="Limit">
      <input class="form-control" name="user_password_old" type="hidden" value="<%=user_password%>">
      </td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">确认密码：</td>
      <td><input type="password" name="user_password2" class="input_style" value="<%=user_password%>" msg="确认密码必须填写!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td ></td>
      <td><input type="submit" class="submit_style" value="确定修改"></td>
      <td></td>
    </tr>
  </tbody>
</table>
</form>    
    </div>
</div>
