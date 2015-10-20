<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.service.SaveService" %>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ page import="com.netsky.dataObject.Ga04_flk"%>
<%@ page import="com.netsky.dataObject.Ga08_flmx" %>
<%@ page import="com.netsky.dataObject.Ga14_b3jcfl" %>
<%
request.setCharacterEncoding("GBK");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
SaveService saveService = (SaveService) ctx.getBean(ServiceName.SaveService);
Ga04_flk ga04;
QueryBuilder queryBuilder;
ResultObject ro;
String pageRowSize = request.getParameter("pageRowSize");
if(pageRowSize == null || pageRowSize.equals("")){
	pageRowSize = "19";
}
int pageNum = 1;
if(request.getParameter("CurrentPage") != null && request.getParameter("CurrentPage").length() > 0){
	pageNum = Integer.parseInt(request.getParameter("CurrentPage"));
}
if(request.getParameter("act") != null && request.getParameter("act").equals("del")){
	if(request.getParameterValues("ids") != null){
		for(int i = 0; i < request.getParameterValues("ids").length; i++){
			saveService.updateByHSql("delete Ga04_flk where id = " + request.getParameterValues("ids")[i]);
		}
	}
}
queryBuilder = new HibernateQueryBuilder(Ga04_flk.class);
queryBuilder.addOrderBy(Order.asc("id"));
ro = queryService.search(queryBuilder);
while(ro.next()){
	ga04 = (Ga04_flk)ro.get(Ga04_flk.class.getName());
	queryBuilder = new HibernateQueryBuilder(Ga08_flmx.class);
	queryBuilder.eq("flk_id",ga04.getId());
	ResultObject ro2 = queryService.search(queryBuilder);
	if(!ro2.next()){
		queryBuilder = new HibernateQueryBuilder(Ga08_flmx.class);
		queryBuilder.eq("flk_id",new Integer(1));
		ro2 = queryService.search(queryBuilder);
		while(ro2.next()){
			Ga08_flmx ga08 = (Ga08_flmx)ro2.get(Ga08_flmx.class.getName());
			ga08.setFlk_id(ga04.getId());
			ga08.setId(null);
			saveService.save(ga08);
		}
	}
	queryBuilder = new HibernateQueryBuilder(Ga14_b3jcfl.class);
	queryBuilder.eq("flk_id",ga04.getId());
	ro2 = queryService.search(queryBuilder);
	if(!ro2.next()){
		queryBuilder = new HibernateQueryBuilder(Ga14_b3jcfl.class);
		queryBuilder.eq("flk_id",new Integer(1));
		ro2 = queryService.search(queryBuilder);
		while(ro2.next()){
			Ga14_b3jcfl ga14 = (Ga14_b3jcfl)ro2.get(Ga14_b3jcfl.class.getName());
			ga14.setFlk_id(ga04.getId());
			ga14.setId(null);
			saveService.save(ga14);
		}
	}
}
saveService.updateByHSql("delete Ga14_b3jcfl where flk_id not in (select id from Ga04_flk)");
saveService.updateByHSql("delete Ga08_flmx where flk_id not in (select id from Ga04_flk)");
queryBuilder = new HibernateQueryBuilder(Ga04_flk.class);
queryBuilder.addOrderBy(Order.asc("id"));
ro = queryService.searchByPage(queryBuilder,pageNum,Integer.parseInt(pageRowSize));
int totalRows = ro.getTotalRows();
int totalPages = ro.getTotalPages();
%>
<html>
<head>
<meta http-equiv="Content-Type"	content="text/html; charset=GBK">
<link href="../../css/list.css" rel="stylesheet" type="text/css">
<link href="../../css/main.css" rel="stylesheet">
<script language="javascript" src="../../js/multiTableSave.js"></script>
<script language="javascript" src="../../js/functionlib.js"></script>
<title>费率库维护</title>
</head>
<body>
<form action="" method="post" id="form1" name="form1">
<input type="hidden" name="CurrentPage" value="<%=pageNum%>">
<input type="hidden" name="TotalOfPages" value="<%=totalPages%>">
<input type="hidden" name="pageRowSize" value="<%=pageRowSize%>">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="../../images/main-images/gypms_main_blue.png" height="30" valign="top" align="right">
	<table width="100%" height="24" border="0" cellpadding="0" cellspacing="0" id="desk_menu">
		<tr>
			<td width="10"></td>
			<td>&nbsp;<font id="list_name"> </font></td>
			<td width="60"><a href="javascript:winOpen('flkEdit.jsp','300','200','1');" title="新建"><img src="../../images/add.gif" border="0"/></a></td>
			<td width="60"><a href="javascript:document.form1.action='?act=del';document.form1.submit();" title="删除"><img src="../../images/del.gif" border="0"/></a></td>
			<td width="10"></td>
			<td width="160" align="right" nowrap >
			<div style="position:absolute;color:white;padding-top:-3px;" onClick="blankit(this,document.form1.name);">&nbsp;在此输入要搜索的信息</div>
			<input type="text" name="searchKey" class="input-text">
			</td>
			<td width="60" valign="middle" align="left"><a href="javascript:document.form1.action='';document.form1.submit();"><img src="../../images/search.gif" border="0" alt="搜索"></a></td>
			<td width="40"><a href="javascript:window.location.reload();" title="刷新工作列表"><img src="../../images/refresh.gif" border="0"/></a></td>
			<td width="15">&nbsp;</td>
		</tr>
	</table>
	</td>
</tr>
<tr>
	<td>
	<table id="list" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;background:#ffffff">
		<tr>
			<td width="40" id="list_title"></td>
			<td id="list_title">费率库名称</td>
			<td width="40" id="list_title"></td>
		</tr>
		<%
		int i = 1;
		while(ro.next() || i < Integer.parseInt(pageRowSize)){
			ga04 = (Ga04_flk)ro.get(Ga04_flk.class.getName());
			i++;
			%>
			<tr>
				
				
					<%
					if(ga04 != null){
						%>
						<td>
						<%
						if(ga04.getId().intValue() != 1){
							%>
							<input type="checkbox" name="ids" value="<%=ga04.getId()%>">
							<%
						}
						%>						
						</td>
						<td>
							<input type="hidden" name="Ga04_flk.ID" value="<%=ga04.getId()%>">
							<a href="#" onclick="winOpen('../flwhList.jsp?flk_id=<%=ga04.getId()%>',new String(screen.width - 10),new String(screen.height - 80),0)"><%=ga04.getMc()%></a>
							
						</td>
						<td><a href="#" onclick="javascript:winOpen('flkEdit.jsp?flk_id=<%=ga04.getId()%>','300','200','1');">修改</a></td>
						<%
					}else{
						%>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%
					}
					%>
			</tr>
			<%
		}
		%>
	</table>
	</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="38" bgcolor="#dce8ec"><table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td></td>
          <td align="center" style="color:#2C4866"><span>共 <b><%=totalPages%></b> 页&nbsp;<b><%=totalRows%></b>&nbsp;条记录&nbsp;</span></td>
          <td style="color:#2C4866">&nbsp;</td>
          <td align="right" style="color:#2C4866">
             <a href="javascript:pageUp(document.all.form1)" title="上一页"><img src="../../images/main-images/back.png" width="41" height="12" border="0"></a>
             <a href="javascript:pageDown(document.all.form1)" title="下一页"><img src="../../images/main-images/next.png" width="41" height="12" border="0"></a>
            &nbsp;第<b><%=pageNum%></b>页&nbsp;
            <input type="text" name="selectPage" size="3" style="font-size: 10px" class="input-text">
            <a href="javascript:setPage();">go</a></td>
          <td align="right" style="color:#2C4866">&nbsp;</td>
        </tr>
    </table></td>
  </tr>
</table>
</div>
</form>
</body>
</html>
