<%@ page language="java" pageEncoding="GBK" %>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseFormatUtils.*" %> 
<%@ page import="com.netsky.dataObject.Ga04_flk" %>
<%
request.setCharacterEncoding("gb2312");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
Ga04_flk ga04;
if(request.getParameter("flk_id") != null){
	ga04 = (Ga04_flk) queryService.searchById(Ga04_flk.class,Integer.valueOf(request.getParameter("flk_id")));	
}else{
	ga04 = new Ga04_flk();
}
if(request.getParameter("flag") != null && request.getParameter("flag").equals("save")){
	%>
	<script language="javascript">
		opener.window.location.reload();
	</script>
	<%
}
%>

<html>

<head>
<title>费率库维护</title>
<link href="../../css/main.css" rel="stylesheet">
<script language="javascript" src="../../js/functionlib.js"></script>
</head>
<body topmargin="0" leftmargin="0" id="main-body">
<div align="center">
	<form name="form1" method="post" action="../../afuer/dataWriter">
	  <input type="hidden" name="dispatchStr" value="/system/flwh/flkEdit.jsp">
	  <input type="hidden" name="perproty" value="flk_id,Ga04_flk,ID/flag">
	  <input type="hidden" name="tableInfomation" value="noFatherTable:Ga04_flk">
	  <input type="hidden" name="flag" value="save">
      <%
      if(ga04.getId() != null){
      %>
      <input type="hidden" name="Ga04_flk.ID" value="<%=ga04.getId()%>">
      <%
      }else{
      %>
      <input type="hidden" name="Ga04_flk.ID" value="">
      <%
      }
      %>
	<table width="98%" border="0"  cellspacing="0" cellpadding="0">
		<tr>
	        <td height="21"></td>
        </tr>
        <tr>
	        <td height="40">
		        <table width="100%" height="40" border="0"  cellpadding="0" cellspacing="0">
			        <tr>
				        <td width="10"><img src="../../images/main-images/gypms_main_bar_left.gif" width="10" height="40"></td>
			         	 <td valign="bottom" background="../../images/main-images/gypms_main_bar_bg.gif">
				        	<table height="30" border="0" cellpadding="0" cellspacing="0">
					                <tr>
					                	<td width="20"><img src="../../images/main-images/dot.png" width="18" height="18"></td>
					                	<td width="100"><b>费率库维护</b></td>
					        			</tr>
				        		</table>
			        	</td>
	                	<td align="right" valign="top" background="../../images/main-images/gypms_main_bar_bg.gif">
		                	
		                </td>
				         <td width="10"><img src="../../images/main-images/gypms_main_bar_right.gif" width="10" height="40"></td>
			        </tr>
		        </table>
	        </td>
        </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" width="98%" id="mainTable">
        <tr>
	        <td align="center" id="main-data" height="70" valign="middle">
				
	        <table border="0" cellpadding="3" cellspacing="0" style="border-collapse:collapse;height:14px;" width="95%">
		        <tr>
					<td colspan="2">&nbsp;</td>
				</tr>
        		<tr>
        			<td width="100" align="right">费率库名称：</td>
        			<td><input type="text" name="MC" value="<%=StringFormatUtil.format(ga04.getMc())%>" class="td-input"></td>
        		</tr>
          </table>          
		<table height="30" border="0" cellpadding="0" cellspacing="0" id="form-button">
		  <tr>
		  	<br>
			<td width="5" align="left"><input type="button" name="b2" value=" 保 存 "  onclick="javascript:document.form1.submit();" title="保存对当前文档的修改（新建）"></td>
			<td width="5" align="right"><input type="button" name="b2" value=" 关 闭 "  onclick="javascript:window.close()" title="关闭当前文档" ></td>			
		  	<td width="5" align="center"><br></td>
		  </tr> 
		  <tr>
		  <td width="5" align="center"><br><br><br></td>
		  	
		  </tr>
		</table>
		</td>
        </tr>
    </table>
    </form> 
</div>
</body>

</html>
