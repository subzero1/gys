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
<%@ page import="com.netsky.dataObject.Ga07_qfqj" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%
/**
 * ͨ�����������ά��
 * Ŀǰͨ�����ͣ����赥λ�����
 * @author Chiang 2009-04-20
 * @param fy_id ����id
 * @param flk_id ���ʿ�id
 */
request.setCharacterEncoding("GBK");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
Ga05_fy ga05;
Ga08_flmx ga08;
Ga07_qfqj ga07;
QueryBuilder queryBuilder;
ResultObject ro,ro2;
Integer fy_id = null;
Integer flk_id = null;
if(request.getParameter("fy_id") != null && request.getParameter("fy_id").length() > 0){
	try{
		fy_id = Integer.valueOf(request.getParameter("fy_id"));
	}catch(NumberFormatException e){
		out.print("�Ƿ����ñ�ʶ!");
		return;
	}
}else{
	out.print("���ñ�ʶΪ��!");
	return;
}
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
queryBuilder = new HibernateQueryBuilder(Ga05_fy.class);
queryBuilder.eq("id",fy_id);
ro = queryService.search(queryBuilder);
ro.next();
ga05 = (Ga05_fy)ro.get(Ga05_fy.class.getName());
%>
<html>
<head>
<title><%=ga05.getMc() + "ά��"%></title>
<link href="../../css/page.css" rel="stylesheet" type="text/css">
<link href="../../css/main.css" rel="stylesheet">
<script language="javascript" src="../../js/functionlib.js"></script>
<script language="javascript">
function onSubmit(){
	var obj = document.getElementsByName("Ga08_flmx.FLZ");
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
<body>
<form action="../../afuer/dataWriter" name="form1" id="form1">
<input type="hidden" name="dispatchStr" value="/system/flwh/qjfy.jsp">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga05_fy">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga08_flmx">
<input type="hidden" name="perproty" value="fy_id/flk_id">
<input type="hidden" name="fy_id" value="<%=fy_id%>">
<input type="hidden" name="flk_id" value="<%=flk_id%>">
<div align="left">
	<div style="width:450">
		<br/>
		<div id="tree-title" align="center"><%=ga05.getMc()%></div>
	</div>
	<table style="width:450" id="tree-table">
		<tr>
			<td>
				<input type="hidden" name="Ga05_fy.ID" value="<%=ga05.getId()%>">
				<input type="hidden" name="Ga05_fy.JSGS"  id="JSGS1" value="<%=ga05.getJsgs()%>">
				<%=ga05.getMc()%> = 
				<input type="text" name="Ga05_fy.GSBDS" id="GSBDS1" style="width:300" value="<%=StringFormatUtil.format(ga05.getGsbds())%>" readOnly>
			</td>
		</tr>
	</table>
	<table border="0" cellpadding="0" cellspacing="0" width="450" style="border-collapse:collapse;background:#ffffff" id="form-list">
		<tr>
			<td align="center">
				<%
				if(fy_id.intValue() == 71){
					out.print("�����ܸ���");
				}
				%>
			</td>
			<td width="100" align="center">����</td>
		</tr>
		<%
		queryBuilder = new HibernateQueryBuilder(Ga07_qfqj.class);
		queryBuilder.eq("qjlb","GCF");
		queryBuilder.addOrderBy(Order.asc("xx"));
		ro2 = queryService.search(queryBuilder);
		while(ro2.next()){
			%>
			<tr>
				<td>
				<%
				ga07 = (Ga07_qfqj)ro2.get(Ga07_qfqj.class.getName());
				if(ga07.getXx().doubleValue() == 0){
					out.print(ga07.getSx() + "����");
				}else if(ga07.getSx() != null && ga07.getSx().intValue() != 0){
					out.print(ga07.getXx() + "-" + ga07.getSx());
				}else{
					out.print(ga07.getXx() + "����");
				}
				%>
				</td>
				<td>
				<%
				queryBuilder = new HibernateQueryBuilder(Ga08_flmx.class);
				queryBuilder.eq("qj_id",ga07.getId());
				queryBuilder.eq("fy_id",fy_id);
				queryBuilder.eq("flk_id",flk_id);
				ro = queryService.search(queryBuilder);
				if(ro.next()){
					ga08 = (Ga08_flmx)ro.get(Ga08_flmx.class.getName());
					%>
					<input type="hidden" name="Ga08_flmx.ID" value="<%=ga08.getId()%>" class="td-input-noborder">
					<input type="text" name="Ga08_flmx.FLZ" style="text-align:right" value="<%=NumberFormatUtil.roundToString(ga08.getFlz())%>" class="td-input-noborder">
					<input type="hidden" name="Ga08_flmx.FLK_ID" value="<%=StringFormatUtil.format(ga08.getFlk_id())%>">
					<input type="hidden" name="Ga08_flmx.FY_ID" value="<%=StringFormatUtil.format(ga08.getFy_id())%>">
					<input type="hidden" name="Ga08_flmx.ZY_ID" value="<%=StringFormatUtil.format(ga08.getZy_id())%>">
					<input type="hidden" name="Ga08_flmx.QJ_ID" value="<%=StringFormatUtil.format(ga08.getQj_id())%>">
					<input type="hidden" name="Ga08_flmx.ZCLB" value="<%=StringFormatUtil.format(ga08.getZclb())%>">
					<input type="hidden" name="Ga08_flmx.BGBH" value="<%=StringFormatUtil.format(ga08.getBgbh())%>">
					<%
				}else{
					%>
					<input type="hidden" name="Ga08_flmx.ID" value="">
					<input type="text" name="Ga08_flmx.FLZ" style="text-align:right" value="0" class="td-input-noborder">
					<input type="hidden" name="Ga08_flmx.FLK_ID" value="<%=flk_id%>">
					<input type="hidden" name="Ga08_flmx.FY_ID" value="<%=fy_id%>">
					<input type="hidden" name="Ga08_flmx.ZY_ID" value="">
					<input type="hidden" name="Ga08_flmx.QJ_ID" value="<%=StringFormatUtil.format(ga07.getId())%>">
					<input type="hidden" name="Ga08_flmx.BGBH" value="B5">
					<%
				}
				%>
				</td>
			</tr>
			<%
		}
		%>
	</table>
	<table style="width:450">			
		<tr>
			<td align="center"><input type="button" name="" value=" ��  �� " onclick="javascript:onSubmit();"></td>
		</tr>
	</table>
</div>
</form>
</body>
</html>