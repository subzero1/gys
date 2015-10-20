<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.service.*" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	Integer D1Value=null;
	if(request.getParameter("D1")!=null &&!request.getParameter("D1").equals("")){
	
		D1Value=new Integer(request.getParameter("D1"));
	}
	QueryBuilder queryBuilder=new HibernateQueryBuilder(Gb01_yhb.class);
	if(D1Value!=null){
		queryBuilder.eq("role",D1Value);
	}
	ResultObject ro = queryService.search(queryBuilder);
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>用户维护</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/list.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" src="../js/multiTableSave.js"></script>
<script type="text/javascript">
	function check1(){     
	  	document.form1.action="userwh.jsp";
		document.form1.submit(); 		  
	} 
	function check2(){
		var obj=document.getElementById("formlist");
		for(var i=1;i<obj.rows.length;i++){
		  if(obj.rows[i].cells[0].children[0].value == ""){
		   	obj.rows[i].cells[4].children[2].value = "" ;
		    deleteRow(obj.rows[i]);
		  }
		}
		if(listValidateChk("form1","Gb01_yhb.NAME")&&listValidateChk("form1","Gb01_yhb.LOGIN_ID")&&listValidateChk("form1","Gb01_yhb.PASSWD")){
			document.form1.action="../afuer/dataWriter";
			document.form1.submit();
		}
	}
	function check3(){
		table=(document.getElementById("formlist")).children[0];
		var newRow = (table.rows[1]).cloneNode(true);
			newRow = table.rows[1].parentNode.insertAdjacentElement("beforeEnd",newRow);
			newRow.children[0].children[0].value = "";
			newRow.children[1].children[0].value = "";
			newRow.children[2].children[0].value = "";
			newRow.children[3].children[0].value = "";
			newRow.children[4].children[0].value = "";
			newRow.children[4].children[1].value = "";
	}
	function deleteRo(rowObj) {
		if(confirm("是否要删除该用户？")){
			if (rowObj.children[0].children.length > 0) {
				  if(rowObj.children[4].children[2].value != ""){
					 alert("当前用户下有建设项目不允许删除！可通过设置失效日期屏蔽该用户。");
					 return;
				  }else{
				 	 	deleteRow(rowObj);
				  }
			}
		}
	}
</script>
<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" style="height:100%; background:#FFFFFF" scroll="yes">
<form name="form1" id="form1" method="post" action="">
<input type="hidden" name="dispatchStr" value="/system/userwh.jsp">
<input type="hidden" name="perproty" value="D1">
<input type="hidden" name="tableInfomation" value="noFatherTable:Gb01_yhb">
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
    			<td><b>用户维护</b></td>
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
												<option value="">全部</option>
												<option value=0 <%if(D1Value!=null && D1Value.intValue()==0){ %>selected<%}%>>管理员</option>
												<option value=1 <%if(D1Value!=null && D1Value.intValue()==1){ %>selected<%}%>>操作员</option>
												</select>
											</span>
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
					            <td width="100" align="center">姓名</td>
					            <td width="100" align="center">登录名</td>
					            <td width="100" align="center">登录密码</td>
					            <td width="100" align="center">用户失效日期</td>
					            <td align="center">备注</td> 
					            <td width="100" align="center">角色</td>
					          </tr>
					         <%if(ro.getLength()==0) {
					        	 for(int i=0; i<1; i++){ %>
					          <tr ondblclick="javascript:deleteRow(this)">
					            <td align="center"><input type="text" name="Gb01_yhb.NAME" value="" class="td-input-noborder"></td>
					            <td align="center"><input type="text" name="Gb01_yhb.LOGIN_ID" value="" class="td-input-noborder"></td>
					            <td align="center"><input type="password" name="Gb01_yhb.PASSWD" value="" class="td-input-noborder"></td>
					            <td align="center"><input type="text" name="Gb01_yhb.LIMIT_DATE" value="" class="td-input-noborder"></td>
					            <td align="center">
					            	<input type="text" name="Gb01_yhb.REMARK" value="" style="text-align:lift;border:solid 0px;">
					            	<input type="hidden" name="Gb01_yhb.ID" value="">
					            </td>
					            <td align="center">
					            	<select name="Gb01_yhb.ROLE" style="width:100%">
					            	<option value=0 >管理员</option>
					            	<option value=1 >操作员</option>
					            	<option value=""></option>
					            	</select>
					            </td>
					          </tr>
					           <%}}%>
					           <%
					           	Gb01_yhb data;
					            while(ro.next()){
					            	data=(Gb01_yhb)ro.get(Gb01_yhb.class.getName());
					          		if(data!=null){
					           %>
					           <tr ondblclick="deleteRo(this)" title="双击删除这一行">
					            <td align="center"><input type="text" name="Gb01_yhb.NAME" value="<%=data.getName()%>" class="td-input-noborder"></td>
					            <td align="center"><input type="text" name="Gb01_yhb.LOGIN_ID" value="<%=data.getLogin_id() %>" class="td-input-noborder"></td>
					            <td align="center"><input type="password" name="Gb01_yhb.PASSWD" value="<%=data.getPasswd()%>" class="td-input-noborder"></td>
					            <td align="center"><input type="text" name="Gb01_yhb.LIMIT_DATE" value="<%if(data.getLimit_date()!=null){out.print(DateFormatUtil.FormatDate(data.getLimit_date()));}else{out.print("");} %>" class="td-input-noborder"></td>
					            <td align="center">
					            	<input type="text" name="Gb01_yhb.REMARK" value="<%if(data.getRemark()!=null){out.print(data.getRemark());}else{out.print("");} %>" class="td-input-noborder">
					            	<input type="hidden" name="Gb01_yhb.ID" value="<%=data.getId()%>">
								
									<%Gd02_dxgc dxgc = new Gd02_dxgc();
										QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd02_dxgc.class);
										queryBuilder9.eq("cjr_id",data.getId());
										ResultObject ro9 = queryService.search(queryBuilder9);
										if(ro9.next()){
											dxgc = (Gd02_dxgc)ro9.get(Gd02_dxgc.class.getName());
										} 
										if(dxgc.getId()!=null){
									%>
									<input type="hidden" name="" value="1">
									<%}else{ %>
									<input type="hidden" name="" value="">
									<%} %>
					            </td>
					            <td align="center">
					            	<select name="Gb01_yhb.ROLE" style="width:100%">
					            	<option value=0 <%if(data.getRole().intValue()==0){ %>selected<%} %> >管理员</option>
					            	<option value=1 <%if(data.getRole().intValue()==1){ %>selected<%} %>>操作员</option>
					            	<option value=""></option>
					            	</select>
					            </td>
					          </tr> 
					          <%}else{ %>
					          <tr ondblclick="javascript:deleteRow(this)">
					            <td align="center"><input type="text" name="Gb01_yhb.NAME" value="" class="td-input-noborder"></td>
					            <td align="center"><input type="text" name="Gb01_yhb.LOGIN_ID" value="" class="td-input-noborder"></td>
					            <td align="center"><input type="password" name="Gb01_yhb.PASSWD" value="" class="td-input-noborder"></td>
					            <td align="center"><input type="text" name="Gb01_yhb.LIMIT_DATE" value="" class="td-input-noborder"></td>
					            <td align="center">
					            	<input type="text" name="Gb01_yhb.REMARK" value="" class="td-input-noborder">
					            	<input type="hidden" name="Gb01_yhb.ID" value="">
					            </td>
					            <td align="center">
					            	<select name="Gb01_yhb.ROLE" style="width:100%">
					            	<option value=0 >管理员</option>
					            	<option value=1 >操作员</option>
					            	<option value=""></option>
					            	</select>
					            </td>
					          </tr>
					          <%}} %>
					           </table>
						</div>	   
				</td>
    		</tr>
    	</table>
    </td>
  </tr>
</table>
</div>
<input type="hidden" name="list_validate" value="姓名:Gb01_yhb.NAME:VARCHAR:30:0;登陆名:Gb01_yhb.LOGIN_ID:VARCHAE:30:0;登陆密码:Gb01_yhb.PASSWD:VARCHAE:30:0;">
</form>
</body>
</html>