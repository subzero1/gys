<%@ page language="java" pageEncoding="GBK" %>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.dataObject.Ga09_kcxs" %>
<%@ page import="com.netsky.baseFormatUtils.*"%>

<%
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	Integer D1Value =null;
	if(request.getParameter("D1")==null){
		D1Value=new Integer(1);
	}else{
		D1Value=new Integer(request.getParameter("D1"));
	}
	Integer radioValue=null;
	if(request.getParameter("adjust")==null){
		radioValue = new Integer(1);
	}else{
		radioValue = new Integer(request.getParameter("adjust"));
	}
	QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga09_kcxs.class);
	queryBuilder.eq("lb",D1Value);	
	queryBuilder.eq("sort",radioValue);
	ResultObject ro = queryService.search(queryBuilder);
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>拆扩更系数维护</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/list.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../js/multiTableSave.js"></script>
<script   language="JavaScript">   
		  function   check1()   
		  {     
  		  	document.form1.action="xskwh.jsp";
		  	document.form1.submit(); 		  
		  }  
		  function check2()
		  {   
		     var obj = document.getElementById("formlist");
		      for(var i=1;i<obj.rows.length;i++){
		  	  	if(obj.rows[i].cells[0].children[0].value == "" ){
		  	  	   obj.rows[i].cells[3].children[2].value = "" ;
		  	  	}
		  	 }
		  	 if(listValidateChk("form1","Ga09_kcxs.XS")&&listValidateChk("form1","Ga09_kcxs.SM")&&listValidateChk("form1","Ga09_kcxs.QSBH")&&listValidateChk("form1","Ga09_kcxs.JZBH")){
		  	 	document.form1.action="../afuer/dataWriter";
		    	document.form1.submit();
		     }
		  }	
		  function check3()
		  { 
			table=(document.getElementById("formlist")).children[0];
			var newRow = (table.rows[1]).cloneNode(true);
			newRow = table.rows[1].parentNode.insertAdjacentElement("beforeEnd",newRow);
			newRow.children[0].children[0].value = "";
			newRow.children[1].children[0].value = "";
			newRow.children[2].children[0].value = "";
			newRow.children[3].children[0].value = "";
			newRow.children[3].children[1].value = "";
			newRow.children[3].children[2].value = "<%=D1Value%>";
			newRow.children[3].children[3].value = "<%=radioValue%>";
		  }
		</script> 
</head>

<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" style="height:100%; background:#FFFFFF" scroll="yes">
<form name="form1" id="form1" method="post" action="">
<input type="hidden" name="dispatchStr" value="/system/xskwh.jsp">
<input type="hidden" name="perproty" value="D1/adjust">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga09_kcxs">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="../images/main-images/gypms_main_blue.png" height="30" valign="top" align="right">

	</td>
  </tr>
  <tr>
  	<td height="20"></td>
  </tr>
  <tr>
    <td align="center" valign="top">
    	<table width="95%" height="24" border="0" cellpadding="0" cellspacing="0">
    		<tr>
    			<td><b>拆扩更系数维护</b></td>
    		</tr>
    		<tr>
    			<td height="40" style="border:solid 1px #cccccc;background:#f2f7f9">
					<table width="100%" height="24" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="99%">
		 				    		<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
		 				    			<tr>
		 				    				<td width="10"></td>
			 				    			<td>			 				   
			 				    			<span style="border:1px solid #1E4F75;overflow:hidden;width:100%;">
												<select size="1" name="D1" style="margin:-1px;" onChange="check1()">
												<option value=1 <%if(D1Value.intValue()==1){%> selected<%} %>>新建工程</option>
												<option value=2 <%if(D1Value.intValue()==2){%> selected<%} %>>扩建工程</option>
												<option value=3 <%if(D1Value.intValue()==3){%> selected<%} %>>拆除再利用工程</option>
												<option value=4 <%if(D1Value.intValue()==4){%> selected<%} %>>拆除不再利用工程</option>
												<option value=5 <%if(D1Value.intValue()==5){%> selected<%} %>>更换工程</option>
												</select>
											</span>
											</td>
											<td width="200">
											&nbsp;
			        						<input type="radio" name="adjust" value="1" <%if(radioValue.intValue()==1){ %>checked<%} %> onclick="check1()"/>人工调整
			        						<input type="radio" name="adjust" value="2" <%if(radioValue.intValue()==2){ %>checked<%} %> onclick="check1()"/>机械调整
			        						</td>
			        					</tr>
			        				</table></td> 
							<td width="1%"></td>
						</tr>
					</table>							
				</td>
    		</tr>
    		<tr><td height="10"></td></tr>
    		<tr>
    			<td>
				    	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
 				    		<tr>
 				    			<td width="90%" height="20" style="background:url(../images/green-bg.gif);border-left:solid 1px #c8e0dc;border-right:solid 1px #c8e0dc;padding-left:5px;vertical-align:bottom">
 				    			</td>
 				    			<td width="30%" align="center"><input type="button" name=button value=" 添 加 " onclick="check3()"></td>
 				    			<td width="30%" align="center"><input name=button type="button" value=" 保 存 "   onclick="check2()"></td>
 				    		</tr>
 				    	</table> 
 				    	<div style="width:100%;background:#d1e2dc;padding:5px;">
					        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;background:#ffffff" id="formlist">
					          <tr>
					            <td width="80" align="center">系数(%)</td>
					            <td align="center">说明</td>
					            <td width="80" align="center">起始定额号</td>
					            <td width="80" align="center">终止定额号</td>
					          </tr>
					          <%
					          if(ro.getLength()==0){
					          for(int i=0; i<1; i++){%>
					          <tr ondblclick="javascript:deleteRow(this)">
					            <td  align="center"><input type="text" name="Ga09_kcxs.XS" value="" class="td-input-noborder"></td>
					            <td align="center"><input type="text" name="Ga09_kcxs.SM" value="" class="td-input-noborder"></td>
					            <td  align="center"><input type="text" name="Ga09_kcxs.QSBH" value="" class="td-input-noborder"></td>
					            <td  align="center">
					            	<input type="text" name="Ga09_kcxs.JZBH" value="" class="td-input-noborder">
					            	<input type="hidden" name="Ga09_kcxs.ID" value="">
									<input type="hidden" name="Ga09_kcxs.LB" value="<%=D1Value %>">
									<input type="hidden" name="Ga09_kcxs.SORT" value="<%=radioValue %>">
					            </td>
					          </tr>
					          <%}}%>
					          <%
					            Ga09_kcxs data;
					         	while (ro.next()) {
					         		data = (Ga09_kcxs) ro.get(Ga09_kcxs.class.getName());
					         		if(data!=null){ 
					          %>
					          <tr ondblclick="javascript:deleteRow(this)" title="双击删除这一行">
					            <td  align="center"><input type="text" name="Ga09_kcxs.XS" value="<%=NumberFormatUtil.roundToString(data.getXs())%>" class="td-input-noborder"></td>
					            <td align="center"><input type="text" name="Ga09_kcxs.SM" value="<%=data.getSm()%>" class="td-input-noborder"></td>
					            <td  align="center"><input type="text" name="Ga09_kcxs.QSBH" value="<%=data.getQsbh()%>" class="td-input-noborder"></td>
					            <td  align="center">
					            	<input type="text" name="Ga09_kcxs.JZBH" value="<%=data.getJzbh()%>" class="td-input-noborder">
					            	<input type="hidden" name="Ga09_kcxs.ID" value="<%=data.getId()%>">
									<input type="hidden" name="Ga09_kcxs.LB" value="<%=D1Value%>">
									<input type="hidden" name="Ga09_kcxs.SORT" value="<%=radioValue %>">
					            </td>
					          </tr>
					          <%}else{
					          %>
					          <tr ondblclick="javascript:deleteRow(this)">
					            <td  align="center"><input type="text" name="Ga09_kcxs.XS" value="" class="td-input-noborder"></td>
					            <td align="center"><input type="text" name="Ga09_kcxs.SM" value="" class="td-input-noborder"></td>
					            <td  align="center"><input type="text" name="Ga09_kcxs.QSBH" value="" class="td-input-noborder"></td>
					            <td  align="center">
					            	<input type="text" name="Ga09_kcxs.JZBH" value="" class="td-input-noborder">
					            	<input type="hidden" name="Ga09_kcxs.ID" value="">
									<input type="hidden" name="Ga09_kcxs.LB" value="">
									<input type="hidden" name="Ga09_kcxs.SORT" value="">
					            </td>
					          </tr>
					          <%}}%>
					        </table>
						</div>	   
				</td>
    		</tr>
    	</table>
    </td>
  </tr>
</table>
</div>
<input type="hidden" name="list_validate" value="系数:Ga09_kcxs.XS:NUMBER:12.2:0;说明:Ga09_kcxs.SM:VARCHAR:100:0;起始定额编号:Ga09_kcxs.QSBH:VARCHAR:20:0;终止定额编号:Ga09_kcxs.JZBH:VARCHAR:20:0;">
</form>
</body>
</html>