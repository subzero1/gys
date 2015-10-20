<%@ page language="java"  pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.service.*" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%@ page import="com.netsky.dataObject.Gb05_yhk" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.netsky.dataObject.Ga02_clsb" %>
<%@page import="com.netsky.dataObject.Ga01_de"%>
<%
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	//Gb01_yhb data1=(Gb01_yhb)session.getAttribute("yhb");

	//删除	
	if(request.getParameter("act") != null && request.getParameter("act").equals("del")){
	  if(request.getParameterValues("yhk_ids") != null){
	    SaveService saveService = (SaveService) ctx.getBean(ServiceName.SaveService);
		for(int n = 0; n < request.getParameterValues("yhk_ids").length; n++){
			saveService.updateByHSql("delete Gb05_yhk where id = " + request.getParameterValues("yhk_ids")[n]);
			saveService.updateByHSql("delete Ga01_de where dek_id = " + request.getParameterValues("yhk_ids")[n]);
			saveService.updateByHSql("delete Ga02_clsb where clk_id = " + request.getParameterValues("yhk_ids")[n]);
		}
	  }
    }
    Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
	QueryBuilder queryBuilder=new HibernateQueryBuilder(Gb05_yhk.class);
	if(yh.getId().intValue()!=1)
	{
	  queryBuilder.eq("cjr_id", yh.getId());
	}
	ResultObject ro = queryService.search(queryBuilder);

%>
<html>
<head>
<meta http-equiv="Content-Type"	content="text/html; charset=GBK">
<link href="../css/list.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet">
<script language="javascript" src="../js/multiTableSave.js"></script>
<script language="javascript" src="../js/functionlib.js"></script>
<title>用户定额材料库维护</title>
<script>
function del()
{
  if(confirm("该操作会删掉此定额库下所有的定额，确定删除此定额库吗？")){
    document.form1.action='?act=del';
    document.form1.submit();
  }
}
</script>
</head>
<body>
<form action="" method="post" id="form1" name="form1">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="../images/main-images/gypms_main_blue.png" height="30" valign="top" align="right">
	<table width="100%" height="24" border="0" cellpadding="0" cellspacing="0" id="desk_menu">
		<tr>
			<td width="10"></td>
			<td>&nbsp;<font id="list_name"> </font></td>
			<td width="60"><a href="javascript:winOpen('userclwhEdit.jsp','300','260','1');" title="新建"><img src="../images/add.gif" border="0"/></a></td>
			<td width="60"><a href="javascript:del();" title="删除"><img src="../images/del.gif" border="0"/></a></td>
			<td width="10"></td>
			<td width="160" align="right" nowrap >
			<div style="position:absolute;color:white;padding-top:-3px;" onClick="blankit(this,document.form1.name);">&nbsp;在此输入要搜索的信息</div>
			<input type="text" name="searchKey" class="input-text">
			</td>
			<td width="60" valign="middle" align="left"><a href="javascript:document.form1.action='';document.form1.submit();"><img src="../images/search.gif" border="0" alt="搜索"></a></td>
			<td width="40"><a href="javascript:window.location.reload();" title="刷新工作列表"><img src="../images/refresh.gif" border="0"/></a></td>
			<td width="15">&nbsp;</td>
		</tr>
	</table>
	</td>
</tr>
<tr>
	<td>
	<table id="list" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;background:#ffffff">
		<tr>
		    <td width="30" id="list_title"></td>
			<td width="150" id="list_title">基础库名称</td>
			<td id="list_title">备注</td>
			<td width="150" id="list_title">创建时间</td>
			<td width="40" id="list_title"></td>
		</tr>
		<% 
					          		Gb05_yhk data;
					          		int i=0;
									while(ro.next()|| i < 21){
										data =(Gb05_yhk)ro.get(Gb05_yhk.class.getName());
										if(data!=null){
					          %>
					         <tr>
					            <td ><%if(data.getId().intValue()!=1&&data.getId().intValue()!=2&&data.getId().intValue()!=3&&data.getId().intValue()!=4){ %><input type="checkbox" name="yhk_ids" value="<%=data.getId()%>"><%} %></td>
					          	<td align="center"><a <%if(data.getId() == 1) {%>href="dewhList.jsp?dek_id=<%=data.getId() %>"<%}else{ %>href="clwhList.jsp?clk_id=<%=data.getId() %>&LB=<%=data.getLb()%>"<%} %>><%=data.getMc()%></a></td>
					          	<td align="center"><%if(data.getBz()!=null){out.print(data.getBz());}else{out.print("");}%></td>
					            <td align="center"><%=DateFormatUtil.FormatDate(data.getCjsj())%></td>
					            <td ><%if(data.getId().intValue()!=1&&data.getId().intValue()!=2&&data.getId().intValue()!=3&&data.getId().intValue()!=4){ %>
					            <a href="javascript:winOpen('userclwhEdit.jsp?xgbz=xg&yhk_id=<%=data.getId()%>','300','260','1');" title="修改">修改</a><%} %></td>					            
					          </tr>	
					          <%}else{ %>
					          <tr >
					            <td width="30">&nbsp;</td>
					          	<td align="center"></td>
					          	<td align="center"></td>
					            <td align="center"></td>		
					            <td ></td>				            
					          </tr>	
					          <%}i++;}%>	 
	</table>
	</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="38" bgcolor="#dce8ec"><table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td></td>
          <td align="center" style="color:#2C4866"><span>共 <b>1</b> 页&nbsp;<b>20</b>&nbsp;条记录&nbsp;</span></td>
          <td style="color:#2C4866">&nbsp;</td>
          <td align="right" style="color:#2C4866">
             <a href="javascript:pageUp(document.all.form1)" title="上一页"><img src="../images/main-images/back.png" width="41" height="12" border="0"></a>
             <a href="javascript:pageDown(document.all.form1)" title="下一页"><img src="../images/main-images/next.png" width="41" height="12" border="0"></a>
            &nbsp;第<b>1</b>页&nbsp;
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