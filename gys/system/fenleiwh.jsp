<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.service.*" %>
<%@ page import="com.netsky.dataObject.Gb04_gcfl" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%@ page import="com.netsky.dataObject.Gd01_gcxm" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%
	Gb01_yhb data1=null;
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
	String user=yh.getLogin_id();
	QueryBuilder queryBuilder1=new HibernateQueryBuilder(Gb01_yhb.class);
	queryBuilder1.eq("login_id",user);
	ResultObject ro1=queryService.search(queryBuilder1);
	
	if(ro1.next()){
		data1=(Gb01_yhb)ro1.get(Gb01_yhb.class.getName());
	}
	
	QueryBuilder queryBuilder=new HibernateQueryBuilder(Gb04_gcfl.class);
	queryBuilder.eq("czy_id",data1.getId());
	queryBuilder.addOrderBy(Order.asc("id"));
	ResultObject ro = queryService.search(queryBuilder);
	Gd01_gcxm  data9=null;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>分类维护</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/list.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" src="../js/multiTableSave.js"></script>
<script type="text/javascript">
function check2(){
		var obj=document.getElementById("formlist");
		for(var i=1;i<obj.rows.length;i++){
		  	if(obj.rows[i].cells[0].children[0].value == ""){
			  if(obj.rows[i].cells[0].children[3].value != ""){
			  		alert("目前有项目隶属于此分类，不允许删除！");
					 return;
			  }else{
			   		deleteRow(obj.rows[i]);
			  }
			}
		}
		document.form1.action="../afuer/dataWriter";
		document.form1.submit();
}
function check3(){
		table=(document.getElementById("formlist")).children[0];
		var newRow = (table.rows[1]).cloneNode(true);
			newRow = table.rows[1].parentNode.insertAdjacentElement("beforeEnd",newRow);
			newRow.children[0].children[0].value = "";
			newRow.children[0].children[1].value = "";
			newRow.children[0].children[2].value = "<%=data1.getId()%>";
			newRow.children[0].children[4].value = "";
}
function deleteRo(rowObj) {
		if (rowObj.children[0].children.length > 0) {
			  if(rowObj.children[0].children[4].value != ""){
				 alert("目前有项目隶属于此分类，不允许删除！");
				 return;
			  }else{
			 	 	deleteRow(rowObj);
			  }
		}
}
function check(obj){
	if(obj.parentNode.parentNode.children[0].children[0].value == ""){
		if(obj.parentNode.parentNode.children[0].children[4].value != ""){
			alert("目前有项目隶属于此分类，不允许删除！");
			  //obj.focus();
			obj.value=obj.parentNode.parentNode.cells[0].children[3].value;
		}
	}else{
		if(strlen(obj.value)>20){
			alert("分类名称过长！");
			obj.focus();
		}
	}
}
</script>
<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" style="height:100%; background:#FFFFFF" scroll="yes">
<form name="form1" id="form1" method="post" action="">
<input type="hidden" name="dispatchStr" value="/system/fenleiwh.jsp">
<input type="hidden" name="perproty" value="D1">
<input type="hidden" name="tableInfomation" value="noFatherTable:Gb04_gcfl">
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
    			<td><b>分类维护</b></td>
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
					            <td align="center">分类名称</td>
					          </tr>
					          <%if(ro.getLength()==0){ %>
					          <tr>
					            <td align="center">
					            	<input type="text" name="Gb04_gcfl.MC" value="" class="td-input-noborder">
					            	<input type="hidden" name="Gb04_gcfl.ID" value="">
					            	<input type="hidden" name="Gb04_gcfl.CZY_ID" value="<%=data1.getId()%>"> 
					            </td>					            
					          </tr>	
					          <%} %>
					          <%
					          	Gb04_gcfl data;
					            while(ro.next()){
					            	data=(Gb04_gcfl)ro.get(Gb04_gcfl.class.getName());
					          		if(data!=null){
					          			QueryBuilder queryBuild=new HibernateQueryBuilder(Gd01_gcxm.class);
					            			queryBuild.eq("gcfl_id",data.getId());
					            			ResultObject ro9 = queryService.search(queryBuild);
					            			
					           %>
					           <tr id="del" ondblclick="deleteRo(this)" title="双击删除这一行" >
					         	
					            <td align="center">
					            	<input type="text" name="Gb04_gcfl.MC" onblur="check(this)"  value="<%=data.getMc() %>" class="td-input-noborder">
					            	<input type="hidden" name="Gb04_gcfl.ID" value="<%=data.getId() %>">
					            	<input type="hidden" name="Gb04_gcfl.CZY_ID" value="<%=data1.getId()%>"> 
					            	<input type="hidden" name="" value="<%=data.getMc() %>"> 
					            	<%if(ro9.next()){
			            				data9=(Gd01_gcxm)ro9.get(Gd01_gcxm.class.getName()); %>
					            	<input type="hidden" name="GCFL_ID" value="<%if(data9!=null){if(data9.getGcfl_id()!=null){out.print(data9.getGcfl_id());}else{out.print("");} }else{out.print("");}%>">
					            	<%}else{ %>
					            	<input type="hidden" name="GCFL_ID" value="">
					            	<%} %>
					            </td>
					          </tr>
					          <%}else{ %>
					          <tr ondblclick="deleteRo(this)">
					            <td align="center">
					            	<input type="text" name="Gb04_gcfl.MC" value="" class="td-input-noborder">
					            	<input type="hidden" name="Gb04_gcfl.ID" value="">
					            	<input type="hidden" name="Gb04_gcfl.CZY_ID" value=""> 
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
</form>
</body>
</html>