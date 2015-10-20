<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.baseObject.QueryBuilder" %>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.dataObject.Ga05_fy" %>
<%@ page import="com.netsky.dataObject.Ga08_flmx" %>
<%@ page import="com.netsky.dataObject.Ga00_zclb" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%
/**
 * 通用普通类型费率维护,费率关联材料类型
 * 目前通用类型：运输保险费，采购代理服务费
 * @author Chiang 2009-04-20
 * @param fy_id 费用id
 * @param flk_id 费率库id
 */
request.setCharacterEncoding("GBK");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
Ga05_fy ga05;
Ga08_flmx ga08;
Ga00_zclb ga00;
QueryBuilder queryBuilder;
ResultObject ro;
String HSql;
Integer fy_id = null;
Integer flk_id = null;
String type = "";
if(request.getParameter("type") != null){
	type = request.getParameter("type");
}
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
if(request.getParameter("flk_id") != null && request.getParameter("flk_id").length() > 0){
	try{
		flk_id = Integer.valueOf(request.getParameter("flk_id"));
	}catch(NumberFormatException e){
		out.print("非法费率库标识!");
		return;
	}
}else{
	out.print("费率库标识为空!");
	return;
}
queryBuilder = new HibernateQueryBuilder(Ga05_fy.class);
queryBuilder.eq("id",fy_id);
ro = queryService.search(queryBuilder);
ro.next();
ga05 = (Ga05_fy)ro.get(Ga05_fy.class.getName());
%>
<html>
<head>
<title><%=ga05.getMc() + "维护"%></title>
<link href="../../css/page.css" rel="stylesheet" type="text/css">
<link href="../../css/main.css" rel="stylesheet">
<script language="javascript" src="../../js/functionlib.js"></script>
<script language="javascript">
function onSubmit(){
	var obj = document.getElementsByName("Ga08_flmx.FLZ");
	for(var i = 0; i < obj.length; i++){
		if(obj[i].value==""){
			window.alert("费率值不能为空！");
			obj[i].focus();
			return ;
		}
		if(String(Number(obj[i].value)) == "NaN"){
			window.alert("费率必须为数字！");
			obj[i].focus();
			return;
		}
	}
	document.form1.submit();
}
</script>
</head>
<body>
<form action="../../afuer/dataWriter" method="post" id="form1" name="form1">
<input type="hidden" name="dispatchStr" value="/system/flwh/clxgfl.jsp">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga05_fy">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga08_flmx">
<input type="hidden" name="perproty" value="fy_id/flk_id/type">
<input type="hidden" name="fy_id" value="<%=fy_id%>">
<input type="hidden" name="flk_id" value="<%=flk_id%>">
<input type="hidden" name="type" value="<%=type%>">
<div align="left">
	<div style="width:500">
		<br/>
		<div id="tree-title" align="center"><%=ga05.getMc()%></div>
	</div>
	<table style="width:500" id="tree-table">
		<tr>
			<td>
				<input type="hidden" name="Ga05_fy.ID" value="<%=ga05.getId()%>">
				<input type="hidden" name="Ga05_fy.JSGS"  id="JSGS1" value="<%=ga05.getJsgs()%>">
				<%=ga05.getMc()%> = 
				<input type="text" name="Ga05_fy.GSBDS" id="GSBDS1" style="width:300" value="<%=ga05.getGsbds()%>" readOnly>
			</td>
		</tr>
	</table>
	<table border="0" cellpadding="0" cellspacing="0" width="500" style="border-collapse:collapse;background:#ffffff" id="form-list">
		<tr>
			<td align="center" width="100">主材类别</td>
			<td align="center" width="100">费率</td>
			<td align="center">费率说明</td>
		</tr>
		<%
		HSql = "select ga08,ga00 from Ga08_flmx ga08,Ga00_zclb ga00 where ga08.zclb = ga00.zclb and ga08.fy_id = " + fy_id + " and ga08.flk_id = " + flk_id;
		if(!type.equals("")){
			HSql += " and ga00.lb = '" + type + "'";
		}
		ro = queryService.search(HSql);
		while(ro.next()){
			ga08 = (Ga08_flmx)ro.get("ga08");
			ga00 = (Ga00_zclb)ro.get("ga00");
			%>
			<tr>
				<td><%=ga00.getMc()%></td>
				<td>
					<input type="hidden" name="Ga08_flmx.ID" value="<%=ga08.getId()%>">
					<input type="text" name="Ga08_flmx.FLZ" value="<%=NumberFormatUtil.roundToString(ga08.getFlz())%>" class="td-input-noborder">
				</td>
				<td><%=ga08.getFlsm()%></td>
			</tr>
			<%
		}
		%>
	</table>
	<table style="width:500">			
		<tr>
			<td align="center"><input type="button" name="" value=" 保  存 " onclick="javascript:onSubmit();"></td>
		</tr>
	</table>
</div>
</form>
</body>
</html>