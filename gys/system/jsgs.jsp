<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.baseObject.QueryBuilder" %>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.dataObject.Ga05_fy" %>
<%
/**
 * 计算公式设置
 */
request.setCharacterEncoding("GBK");
Integer fy_id;
if(request.getParameter("fy_id") != null && request.getParameter("fy_id").length() > 0){
	try{
		fy_id = Integer.valueOf(request.getParameter("fy_id"));
	}catch(NumberFormatException e){
		out.print("非法费用标识!");
		return;
	}
}else{
	out.print("费用标识为空!");
	return;
}
QueryBuilder queryBuilder;
ResultObject ro;
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
Ga05_fy ga05;
queryBuilder = new HibernateQueryBuilder(Ga05_fy.class);
queryBuilder.eq("id",fy_id);
ro = queryService.search(queryBuilder);
ro.next();
ga05 = (Ga05_fy)ro.get(Ga05_fy.class.getName());
String xgfy[] = null;
if(ga05.getXgfy() != null){
	xgfy = ga05.getXgfy().split(",");
}
int counter = 0;
%>
<html>

<head>
<title>计算公式设置</title>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK">
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script language="javascript">
function input(obj){
	document.all.JSGS.value += "[" + obj.value + "]";
	if(obj.value == "费率")
		document.all.GSBDS.value += "[" + obj.value + "]";
	else
		document.all.GSBDS.value += obj.value;
}
function inputFh(obj){
	document.all.GSBDS.value += obj.value;
	if(obj.value == "×")
		document.all.JSGS.value += "*";
	else
		document.all.JSGS.value += obj.value;
}
function clearInput(){
	document.all.GSBDS.value = "";
	document.all.JSGS.value = "";
}
function setValue(){
	var obj = opener.document.getElementById("<%=request.getParameter("jsgs_id")%>");
	obj.value = document.all.JSGS.value;
	obj = opener.document.getElementById("<%=request.getParameter("gsbds_id")%>");
	obj.value = document.all.GSBDS.value;
	window.close();
}
</script>
</head>

<body>

<div align="center">
	<table border="0" cellpadding="0" style="border-collapse: collapse" width="550">
		<tr>
			<td colspan="2" style="font-weight:bold;font-size:14px;height:40px;">费用名称：<%=ga05.getMc()%></td>
		</tr>
		<tr>
			<td width="100" align="right">计算公式：</td>
			<td width="450">
				<input type="text" name="GSBDS" style="width:100%" readOnly value="<%=ga05.getGsbds() %>">
				<input type="hidden" name="JSGS" value="<%=ga05.getJsgs() %>">
			</td>
		</tr>
	</table>
	<br>
	<table border="0" cellpadding="0" style="border-collapse: collapse;background-color:#f0f0f0;height:120px;">
		<tr>
			<td width="10">　</td>
			<td width="360">
			<div align="center">
				<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%">
					<tr>
						<td colspan="3" align="center">工程基础费用</td>
					</tr>
					<tr>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
					</tr>
					<tr>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
					</tr>
					<tr>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
								counter++;
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
					</tr>
					<tr>
						<td>
							<%
							if(xgfy != null && counter < xgfy.length){
								%>
								<input type="button" value="<%=xgfy[counter] %>" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
								<%
							}else{
								%>
								<input type="button" value="****" name="FYMC" style="width:90px;">
								<%
							}
							%>
						</td>
						<td>
							<input type="button" value="%" name="%" style="width:90px;" onClick="javascript:inputFh(this);">
						</td>
						<td>
							<input type="button" value="费率" name="FYMC" style="width:90px;" onClick="javascript:input(this);">
						</td>
						<td><input type="button" value="(" name="left_kh" style="width:45px;" onClick="javascript:inputFh(this);"><input type="button" value=")" name="right_kh" style="width:45px;" onClick="javascript:inputFh(this);"></td>
					</tr>
					<tr>
					</tr>
				</table>
			</div>
			</td>
			<td width="20">　</td>
			<td>
			<div align="center">
				<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%">
					<tr>
						<td>　</td>
					</tr>
					<tr>
						<td><input type="button" value="+" name="add" style="width:30px;" onClick="javascript:inputFh(this);"></td>
					</tr>
					<tr>
						<td><input type="button" value="-" name="sub" style="width:30px;" onClick="javascript:inputFh(this);"></td>
					</tr>
					<tr>
						<td><input type="button" value="×" name="mult" style="width:30px;" onClick="javascript:inputFh(this);"></td>
					</tr>
					<tr>
						<td><input type="button" value="/" name="divi" style="width:30px;" onClick="javascript:inputFh(this);"></td>
					</tr>
				</table>
			</div>
			</td>
			<td width="20">　</td>
			<td width="100">
			<div align="center">
				<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%">
					<tr>
						<td colspan="3" align="center">&nbsp;</td>
					</tr>
					<tr>
						<td><input type="button" value="7" name="7" style="width:30px;" onClick="javascript:inputFh(this);"></td>
						<td><input type="button" value="8" name="8" style="width:30px;" onClick="javascript:inputFh(this);"></td>
						<td><input type="button" value="9" name="9" style="width:30px;" onClick="javascript:inputFh(this);"></td>
					</tr>
					<tr>
						<td><input type="button" value="4" name="4" style="width:30px;" onClick="javascript:inputFh(this);"></td>
						<td><input type="button" value="5 " name="5" style="width:30px;" onClick="javascript:inputFh(this);"></td>
						<td><input type="button" value="6" name="6" style="width:30px;" onClick="javascript:inputFh(this);"></td>
					</tr>
					<tr>
						<td><input type="button" value="1" name="1" style="width:30px;" onClick="javascript:inputFh(this);"></td>
						<td><input type="button" value="2" name="2" style="width:30px;" onClick="javascript:inputFh(this);"></td>
						<td><input type="button" value="3" name="3" style="width:30px;" onClick="javascript:inputFh(this);"></td>
					</tr>
					<tr>
						<td><input type="button" value="0" name="0" style="width:30px;" onClick="javascript:inputFh(this);"></td>
						<td><input type="button" value="." name="." style="width:30px;" onClick="javascript:inputFh(this);"></td>
						<td><input type="button" value="C" name="GCF10" style="width:30px;" onClick="javascript:clearInput();"></td>
					</tr>
				</table>
			</div>
			</td>
			<td width="10">　</td>
		</tr>
	</table>
	<br>
	<input type="button" value=" 设置好了，提交 " style="width:200px;" onClick="javascript:setValue();">
</div>

</body>

</html>