<%@ page language="java" pageEncoding="GBK" %>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseFormatUtils.*"%>
<%@ page import="com.netsky.baseObject.*"%>
<%@ page import="com.netsky.dataObject.Gd03_gcfysz"%>
<%@ page import="com.netsky.dataObject.Ga05_fy" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%
	request.setCharacterEncoding("gb2312");
	Integer dxgc_id = new Integer(request.getParameter("dxgc_id")); 
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Ga05_fy.class);
	queryBuilder9.isNotNull("sortid");
	queryBuilder9.addOrderBy(Order.asc("sortid"));
	ResultObject ro9 = queryService.search(queryBuilder9);
	
	
%>
<html>
<head>
<title>各表计算结果</title>
<link href="../css/list.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../js/functionlib.js"></script>
</head>
<body topmargin="0" leftmargin="0" id="main-body"  scroll="yes"  >
<div align="center">
 <form name="form1" method="post" action="">
	<table width="550" border="0" cellspacing="0" cellpadding="0">
			<tr>
		       <td height="21"></td>
	        </tr>
	        <tr>
		        <td height="40">
			        <table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">
				        <tr>
					        <td width="10"><img src="../images/main-images/gypms_main_bar_left.gif" width="10" height="40"></td>
					        <td valign="bottom" background="../images/main-images/gypms_main_bar_bg.gif">
					        	<table height="30" border="0" cellpadding="0" cellspacing="0" id="alert-title">
						                <tr>
						                	<td width="20"><img src="../images/main-images/dot.png" width="18" height="18"></td>
						                	<td>各表计算结果</td>
					        			</tr>
					        	</table>
					        </td>
					        <td width="10"><img src="../images/main-images/gypms_main_bar_right.gif" width="10" height="40"></td>
				        </tr>
			        </table>
		        </td>
	        </tr> 
	 </table>     
	      
		
		 
		<table border="0" cellpadding="0" cellspacing="0" width="550" style="border-collapse:collapse;background:#ffffff" id="list">
		<tr>
			<td class="list_title" width="80" align="center">序号</td>
			<td class="list_title" align="center">费用名称</td>
			<td class="list_title" width="80" align="left">计算结果</td>
		</tr>	
		<% 
			Ga05_fy ga05 = new Ga05_fy();
			int i=0;
			while(ro9.next()){
				i++;
				ga05 = (Ga05_fy)ro9.get(Ga05_fy.class.getName());
				QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
				queryBuilder.eq("dxgc_id",dxgc_id);
				queryBuilder.eq("fy_id",ga05.getId());
				ResultObject ro = queryService.search(queryBuilder);
			 	if(ro.next()){
					Gd03_gcfysz data = (Gd03_gcfysz)ro.get(Gd03_gcfysz.class.getName()); 
					if(data.getId()!=null){
				
		 %>
		<tr onmouseover="style.backgroundColor='#dce8ec'" onmouseout="style.backgroundColor='#ffffff'">
			<td  width="80" align="center"><%=i%></td>
			<td align="left"><%=data.getFymc()%></td>
			<td width="80" align="right"><%if(data.getFyz()!=null){out.print(NumberFormatUtil.roundToString(data.getFyz()));}else{out.print("0.00");} %></td>
		</tr>
		<%}}}%>
	</table>
	</form>
</div>
</body>
</html>
