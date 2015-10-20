<%@ page language="java" pageEncoding="GBK" %>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.baseObject.QueryBuilder" %>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.dataObject.Ga05_fy" %>
<%@ page import="com.netsky.dataObject.Ga08_flmx" %>
<%
request.setCharacterEncoding("GBK");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
Ga05_fy ga05;
Ga08_flmx ga08;
QueryBuilder queryBuilder;
ResultObject ro;
Integer flk_id = null;
if(request.getParameter("flk_id") != null && request.getParameter("flk_id").length() > 0){
	try{
		flk_id = Integer.valueOf(request.getParameter("flk_id"));
	}catch(NumberFormatException e){
		out.print("�Ƿ����ʿ��ʶ!");
		return;
	}
}else{
	out.print("���ʿ��ʶΪ��!");
	return;
}
%>
<html>
<head>
<title>�˹���</title>
<link href="../../css/page.css" rel="stylesheet" type="text/css">
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK">
<script language="javascript" src="../../js/functionlib.js"></script>
<script language="javascript">
function onSubmit(){
	var obj = document.getElementsByName("FLZ");
	for(var i = 0; i < obj.length; i++){
		if(obj[i].value==""){
			window.alert("����ֵ����Ϊ�գ�");
			obj[i].focus();
			return ;
		}
		if(String(Number(obj[i].value)) == "NaN"){
			window.alert("���ʱ���Ϊ���֣�");
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
<input type="hidden" name="dispatchStr" value="/system/flwh/rgf.jsp">
<input type="hidden" name="perproty" value="flk_id">
<input type="hidden" name="flk_id" value="<%=flk_id%>">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga05_fy">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga08_flmx">
<div align="center">
	<div style="width:80%">
	<br/>
		<div id="tree-title">ͨ�Ž��蹤���˹���</div>
	</div>
	
	<table style="width:90%" id="tree-table">
		<tr>
			<td><hr style="border:dotted 3px #1E4F75"></td>
		</tr>	
		<tr>
			<td>ͨ�Ž��蹤�̲���רҵ�͵�����������ۺ�ȡ���˹��ѣ��˹��ѵ���Ϊ��</td>
		</tr>
		<tr>
			<td>
				<%
				queryBuilder = new HibernateQueryBuilder(Ga08_flmx.class);
				queryBuilder.eq("fy_id",new Integer(5));
				queryBuilder.eq("flk_id",flk_id);
				ro = queryService.search(queryBuilder);
				ro.next();
				ga08 = (Ga08_flmx)ro.get(Ga08_flmx.class.getName());
				%>
				<input type="hidden" name="Ga08_flmx.ID" value="<%=ga08.getId()%>">
				����Ϊ��<input type="text" name="FLZ" value="<%=ga08.getFlz()%>" size="4">Ԫ/���գ�
				<%
				queryBuilder = new HibernateQueryBuilder(Ga08_flmx.class);
				queryBuilder.eq("fy_id",new Integer(6));
				queryBuilder.eq("flk_id",flk_id);
				ro = queryService.search(queryBuilder);
				ro.next();
				ga08 = (Ga08_flmx)ro.get(Ga08_flmx.class.getName());
				%>
				<input type="hidden" name="Ga08_flmx.ID" value="<%=ga08.getId()%>">
				�չ�Ϊ��<input type="text" name="FLZ" value="<%=ga08.getFlz()%>" size="4">Ԫ/���ա�
			</td>
		</tr>
		<tr>
			<td>�ţ�Ԥ�����˹��� = ������ + �չ���</td>
		</tr>
		<%
		queryBuilder = new HibernateQueryBuilder(Ga05_fy.class);
		queryBuilder.eq("id",new Integer(5));
		ro = queryService.search(queryBuilder);
		ro.next();
		ga05 = (Ga05_fy)ro.get(Ga05_fy.class.getName());
		%>
		<tr>
			<td>
				<input type="hidden" name="Ga05_fy.ID" value="<%=ga05.getId()%>">
				<input type="hidden" name="Ga05_fy.JSGS"  id="JSGS1" value="<%=ga05.getJsgs()%>">
				<%=ga05.getMc()%> = 
				<input type="text" name="Ga05_fy.GSBDS" id="GSBDS1" style="width:300" value="<%=ga05.getGsbds()%>" readOnly>
			</td>
		</tr>
		<%
		queryBuilder = new HibernateQueryBuilder(Ga05_fy.class);
		queryBuilder.eq("id",new Integer(6));
		ro = queryService.search(queryBuilder);
		ro.next();
		ga05 = (Ga05_fy)ro.get(Ga05_fy.class.getName());
		%>
		<tr>
			<td>
				<input type="hidden" name="Ga05_fy.ID" value="<%=ga05.getId()%>">
				<input type="hidden" name="Ga05_fy.JSGS"  id="JSGS1" value="<%=ga05.getJsgs()%>">
				<%=ga05.getMc()%> = 
				<input type="text" name="Ga05_fy.GSBDS" id="GSBDS1" style="width:300" value="<%=ga05.getGsbds()%>" readOnly>
			</td>
		</tr>
		<tr>
			<td><hr style="border:dotted 3px #1E4F75"></td>
		</tr>
	</table>
	<table style="width:90%">			
		<tr>
			<td align="center"><input type="button" name="" value=" ��  �� " onclick="javascript:onSubmit();"></td>
		</tr>
	</table>
</div>
</form>
</body>

</html>
