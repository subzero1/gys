<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.baseObject.QueryBuilder" %>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.dataObject.Ga04_flk" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%@ page import="java.util.*"%>
<%
String flk_id = "1";
request.setCharacterEncoding("GBK");
if(request.getParameter("flk_id") != null){
	flk_id = request.getParameter("flk_id");
}
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga04_flk.class);
queryBuilder.eq("id",new Integer(flk_id));
ResultObject ro = queryService.search(queryBuilder);
Ga04_flk flk = new Ga04_flk();
if(ro.next()){
	flk = (Ga04_flk)ro.get(Ga04_flk.class.getName());
}
%>
<html>

<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<title>通信工程造价管理系统</title>
<script language="javascript" src="../js/treemenu.js"></script>
<link href="../css/list.css" rel="stylesheet" type="text/css">
<script laguage="javascript">

</script>
</head>

<body style="MARGIN: 0px;height:100%" scroll="no">
<div style="height:100%;background:#ffffff">
<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" style="border-collapse:collapse;">
	 <tr>
	    <td colspan="3" background="../images/main-images/gypms_main_blue.png" height="30" valign="top" align="right"></td>
	 </tr>
	<tr>
		<td height="20" colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=flk.getMc() %></td>
	</tr>
	<tr>
		<td width="280"><iframe frameBorder="0" scrolling="auto" src="flwhTree.jsp?flk_id=<%=flk_id %>" style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 0;"></iframe></td>
		<td style="border:solid 1px #99beef"><iframe frameBorder="0" id="treeshow" name="treeshow" scrolling="auto" src="treeshow.jsp" style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 0;"></iframe></td>
		<td width="10">&nbsp;</td>
	</tr>
	<tr>
		<td height="20" colspan="3"></td>
	</tr>	
</table>
</div>
</body>
<script type="text/javascript">
var MyCNLTreeMenu=new CNLTreeMenu("CNLTreeMenu","li");
MyCNLTreeMenu.InitCss("Opened","Closed","Child","../images/tree-images/s.gif");
MyCNLTreeMenu.SetNodes(0);
</script>			
			

</html>
