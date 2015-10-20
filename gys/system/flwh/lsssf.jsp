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
/**
 * 临时设施费维护
 * @author Chiang 2009-04-20
 * @param fy_id 费用id
 * @param flk_id 费率库id
 */
request.setCharacterEncoding("GBK");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
Ga05_fy ga05;
Ga08_flmx ga08;
Ga06_zy ga06;
Ga07_qfqj ga07;
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
<title><%=ga05.getMc() + "维护"%></title>
</head>
<body>
<form action="../../afuer/dataWriter" method="post" id="form1" name="form1">
<input type="hidden" name="dispatchStr" value="/system/flwh/lsssf.jsp">
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
				<input type="text" name="Ga05_fy.GSBDS" id="GSBDS1" style="width:300" value="<%=ga05.getGsbds()%>" readOnly>
			</td>
		</tr>
	</table>
	<%
	queryBuilder = new HibernateQueryBuilder(Ga07_qfqj.class);
	queryBuilder.eq("qjlb","QYGDJL");
	queryBuilder.addOrderBy(Order.asc("xx"));
	ro = queryService.search(queryBuilder);
	/**
	 * 列数
	 */
	int columns = ro.getLength();
	%>
	<table border="0" cellpadding="0" cellspacing="0" width="450" style="border-collapse:collapse;background:#ffffff" id="form-list">
		<tr>
			<td align="center">工程专业</td>
			<%
			while(ro.next()){
				ga07 = (Ga07_qfqj)ro.get(Ga07_qfqj.class.getName());
				%>
				<td align="center" width="80">
					<%
					if(ga07.getXx().doubleValue() == 0){
						out.print("距离≤" + ga07.getSx());
					}else{
						out.print("距离&gt;" + ga07.getXx());
					}
					%>
				</td>
				<%
			}
			%>
		</tr>
		<%
		queryBuilder = new HibernateQueryBuilder(Ga06_zy.class);
		ResultObject ro2 = queryService.search(queryBuilder); 
		while(ro2.next()){
			ga06 = (Ga06_zy)ro2.get(Ga06_zy.class.getName());
			%>
			<tr>
				<td align="left"><%=ga06.getMc()%></td>
				<%
				ro.setBottom(true);
				for(int i = 0; i < columns; i++) {
					ro.setPlaceIndex(i);
					queryBuilder = new HibernateQueryBuilder(Ga08_flmx.class);
					queryBuilder.eq("qj_id",((Ga07_qfqj)ro.get(Ga07_qfqj.class.getName())).getId());
					queryBuilder.eq("fy_id",fy_id);
					queryBuilder.eq("zy_id",ga06.getId());
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
							<input type="text" name="Ga08_flmx.FLZ" value="0" style="text-align:right" class="td-input-noborder">
							<input type="hidden" name="Ga08_flmx.FLK_ID" value="<%=flk_id%>">
							<input type="hidden" name="Ga08_flmx.FY_ID" value="<%=fy_id%>">
							<input type="hidden" name="Ga08_flmx.ZY_ID" value="">
							<input type="hidden" name="Ga08_flmx.QJ_ID" value="<%=StringFormatUtil.format(((Ga07_qfqj)ro.get(Ga07_qfqj.class.getName())).getId())%>">
							<input type="hidden" name="Ga08_flmx.ZCLB" value="">
							<input type="hidden" name="Ga08_flmx.BGBH" value="B2">
						</td>
						<%
					}
				}
				%>
			</tr>
			<%
		}
		%>
	</table>
	<table style="width:450">			
		<tr>
			<td align="center"><input type="button" name="" value=" 保  存 " onclick="javascript:onSubmit();"></td>
		</tr>
	</table>
</div>
</form>
</body>
</html>