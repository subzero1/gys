<%@ page language="java" pageEncoding="GBK" %>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.baseObject.QueryBuilder" %>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.dataObject.Ga14_b3jcfl" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%
request.setCharacterEncoding("GBK");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
Ga14_b3jcfl ga14;
QueryBuilder queryBuilder;
ResultObject ro;
Integer flk_id = null;
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
%>
<html>
<head>
<title>小工日调增</title>
<link href="../../css/page.css" rel="stylesheet" type="text/css">
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK">
<script language="javascript" src="../../js/functionlib.js"></script>
<script language="javascript">
function onSubmit(){
	var obj = document.getElementsByName("FL");
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
<body style="MARGIN: 10px;width:100%;height:100%" scroll="auto">
<form action="../../afuer/dataWriter" method="post" id="form1" name="form1">
<input type="hidden" name="dispatchStr" value="/system/flwh/xgrtz.jsp">
<input type="hidden" name="perproty" value="flk_id">
<input type="hidden" name="flk_id" value="<%=flk_id%>">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga14_b3jcfl">
<div align="left">
	<div style="width:300">
	<br/>
		<div id="tree-title" align="center">小工日调增</div>
	</div>
	
	<table style="width:400" id="tree-table">
		<tr>
			<td colspan="2"><hr style="border:dotted 3px #1E4F75"></td>
		</tr>
		<%
		queryBuilder = new HibernateQueryBuilder(Ga14_b3jcfl.class);
		queryBuilder.eq("fylb",new Integer(3));
		queryBuilder.eq("flk_id",flk_id);
		ro = queryService.search(queryBuilder);
		while(ro.next()){
			ga14 = (Ga14_b3jcfl)ro.get(Ga14_b3jcfl.class.getName());
			%>
			<tr>
				<td>
					<input type="hidden" name="Ga14_b3jcfl.ID" value="<%=ga14.getId()%>">
					<input type="hidden" name="Ga14_b3jcfl.MC" value="<%=ga14.getMc()%>">
					<%=ga14.getMc() %>
				</td>
				<td width="80"><input type="text" name="RGFL" size="4" value="<%=NumberFormatUtil.roundToString(ga14.getRgfl())%>"></td>
			</tr>
			<%
		}
		%>
		<tr>
			<td colspan="2"><hr style="border:dotted 3px #1E4F75"></td>
		</tr>
	</table>
	<table style="width:400">			
		<tr>
			<td align="center"><input type="button" name="" value=" 保  存 " onclick="javascript:onSubmit();"></td>
		</tr>
	</table>
</div>
</form>
</body>

</html>
