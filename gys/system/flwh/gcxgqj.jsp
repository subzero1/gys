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
<%@ page import="com.netsky.dataObject.Ga06_zy" %>
<%@ page import="com.netsky.dataObject.Ga07_qfqj" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%
request.setCharacterEncoding("GBK");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
Ga05_fy ga05;
Ga08_flmx ga08;
Ga06_zy ga06;
QueryBuilder queryBuilder;
ResultObject ro;
Integer fy_id = null;
Integer flk_id = null;
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
	out.print("费率库标识为空 !");
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
<title>运杂费</title>
<link href="../../css/page.css" rel="stylesheet" type="text/css">
<link href="../../css/main.css" rel="stylesheet">
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK">
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
<input type="hidden" name="dispatchStr" value="/system/flwh/gcxgqj.jsp">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga05_fy">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga08_flmx">
<input type="hidden" name="perproty" value="flk_id/fy_id">
<input type="hidden" name="flk_id" value="<%=flk_id%>">
<input type="hidden" name="fy_id" value="<%=fy_id%>">
<div align="left">
	<div style="width:1030">
		<br/>
		<div id="tree-title" align="center"><%=ga05.getMc() %></div>
	</div>
	<table id="tree-table" width="1030">
		<tr>
			<td>相关费率：</td>
		</tr>
		<tr>
			<td>
				<input type="hidden" name="Ga05_fy.ID" value="<%=ga05.getId()%>">
				<input type="hidden" name="Ga05_fy.JSGS"  id="JSGS1" value="<%=ga05.getJsgs()%>">
				<%=ga05.getMc()%> = 
				<input type="text" name="Ga05_fy.GSBDS" id="GSBDS1" style="width:300" value="<%=ga05.getGsbds()%>" readOnly>
			</td>
		</tr>
	</table>
		<%
		queryBuilder = new HibernateQueryBuilder(Ga06_zy.class);
		ro = queryService.search(queryBuilder);
		/**
		 * 列数
		 */
		int columns = ro.getLength();
		%>
		<table border="0" cellpadding="0" cellspacing="0" width="1030" style="border-collapse:collapse;background:#ffffff" id="form-list">
			<tr>
				<td align="center">费率</td>
				<%
				while(ro.next()){
					ga06 = (Ga06_zy)ro.get(Ga06_zy.class.getName());
					%>
					<td align="center" width="80"><%=ga06.getMc()%></td>
					<%
				}
				%>
			</tr>
			<%
			queryBuilder = new HibernateQueryBuilder(Ga07_qfqj.class);
			queryBuilder.eq("qjlb","GCF_JL");
			queryBuilder.addOrderBy(Order.asc("xx"));
			ResultObject ro2 = queryService.search(queryBuilder);
			int rowIndex = 0;
			while(ro2.next()){
				%>
				<tr>
					<td align="center">
					<%
					Ga07_qfqj ga07 = (Ga07_qfqj)ro2.get(Ga07_qfqj.class.getName());
					if(rowIndex == 0){
						out.print("L≤" + ga07.getSx());
					}else if(ga07.getSx() != null && ga07.getSx().intValue() != 0){
						out.print(ga07.getXx() + "&lt;L≤" + ga07.getSx());
					}else{
						out.print("&gt;" + ga07.getXx());
					}
					%>
					</td>
					<%
					ro.setBottom(true);
					for(int i = 0; i < columns; i++) {
						ro.setPlaceIndex(i);
						queryBuilder = new HibernateQueryBuilder(Ga08_flmx.class);
						queryBuilder.eq("qj_id",ga07.getId());
						queryBuilder.eq("fy_id",fy_id);
						queryBuilder.eq("zy_id",((Ga06_zy)ro.get(Ga06_zy.class.getName())).getId());
						queryBuilder.eq("flk_id",flk_id);
						ResultObject ro3 = queryService.search(queryBuilder);
						if(ro3.next()){
							ga08 = (Ga08_flmx)ro3.get(Ga08_flmx.class.getName());
							%>
							<td>
								<input type="hidden" name="Ga08_flmx.ID" value="<%=ga08.getId()%>" class="td-input-noborder">
								<input type="text" name="Ga08_flmx.FLZ" style="text-align:right" value="<%=NumberFormatUtil.roundToString(ga08.getFlz())%>" class="td-input-noborder">
								<input type="hidden" name="Ga08_flmx.FLK_ID" value="<%=StringFormatUtil.format(ga08.getFlk_id())%>">
								<input type="hidden" name="Ga08_flmx.FY_ID" value="<%=StringFormatUtil.format(ga08.getFy_id())%>">
								<input type="hidden" name="Ga08_flmx.ZY_ID" value="<%=StringFormatUtil.format(ga08.getZy_id())%>">
								<input type="hidden" name="Ga08_flmx.QJ_ID" value="<%=StringFormatUtil.format(ga08.getQj_id())%>">
								<input type="hidden" name="Ga08_flmx.ZCLB" value="<%=StringFormatUtil.format(ga08.getZclb())%>">
								<input type="hidden" name="Ga08_flmx.BGBH" value="<%=StringFormatUtil.format(ga08.getBgbh())%>">
							</td>
							<%
						}else{
							%>
							<td>
								<input type="hidden" name="Ga08_flmx.ID" value="">
								<input type="text" name="Ga08_flmx.FLZ" style="text-align:right" value="0" class="td-input-noborder">
								<input type="hidden" name="Ga08_flmx.FLK_ID" value="<%=flk_id%>">
								<input type="hidden" name="Ga08_flmx.FY_ID" value="<%=fy_id %>">
								<input type="hidden" name="Ga08_flmx.ZY_ID" value="<%=((Ga06_zy)ro.get(Ga06_zy.class.getName())).getId()%>">
								<input type="hidden" name="Ga08_flmx.QJ_ID" value="<%=StringFormatUtil.format(ga07.getId())%>">
								<input type="hidden" name="Ga08_flmx.ZCLB" value="">
								<input type="hidden" name="Ga08_flmx.BGBH" value="B4ZC">
							</td>
							<%
						}
					}
					%>
				</tr>
				<%
				rowIndex++;
			}
			%>
		</table>
	<table style="width:1030">			
		<tr>
			<td align="center"><input type="button" name="" value=" 保  存 " onclick="javascript:onSubmit();"></td>
		</tr>
	</table>
</div>
</form>
</body>
</html>
