<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="../inc/myurl.asp" -->
<%

%>
<script language="javascript" type="text/javascript" src="inc/reg_chk.js"></script>
<div id="bbsreg_div">
    <div class="reg_title">����ע��</div>
    <div class="reg_content">
    	<form action="inc/chk_reg.asp" method="post" name="login" onSubmit="return Validator.Validate(this,3)">
    <table>
  <tbody>
    <tr>
      <td style="text-align:right;" width="30%">�û�����</td>
      <td  width="30%"><input type="text" name="user_num" placeholder="�»�Ա�û���" class="input_style" msg="������4-12λ��ĸ������!" dataType="Limit" min="4" onBlur="document.getElementById('chk_use').src='inc/chk_user.asp?chk_type=hynumber&chk_value='+this.value;"></td>
      <td  width="40%"><span id="chk_hynumber" class="color_red">*</span>
      <iframe id="chk_use" name="chk_use" src="" style="display:none"></iframe>
      </td>
    </tr>
    <tr>
      <td style="text-align:right;">�ǳƣ�</td>
      <td><input type="text" name="user_name" class="input_style" placeholder="�»�Ա�ǳ�" msg="�ǳƱ�����д!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">���룺</td>
      <td><input type="password" name="user_password" class="input_style" placeholder="�»�Ա����" msg="���������д!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td style="text-align:right;">ȷ�����룺</td>
      <td><input type="password" name="user_password2" class="input_style" placeholder="ȷ������" msg="ȷ�����������д!" min="1" dataType="Limit"></td>
      <td><span class="color_red">*</span></td>
    </tr>
    <tr>
      <td ></td>
      <td><input type="submit" class="submit_style" value="����ע��"></td>
      <td></td>
    </tr>
  </tbody>
</table>
</form>    
    </div>
</div>
