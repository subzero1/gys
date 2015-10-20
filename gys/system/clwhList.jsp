<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.service.SaveService" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.baseObject.QueryBuilder" %>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.dataObject.Ga02_clsb" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%@ page import="org.hibernate.criterion.MatchMode" %>
<%@ page import="org.hibernate.criterion.Restrictions" %>
<%@ page import="org.hibernate.criterion.Order" %>

<%
request.setCharacterEncoding("gb2312");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
if(request.getParameter("act") != null && request.getParameter("act").equals("del")){
	SaveService saveService = (SaveService) ctx.getBean(ServiceName.SaveService);
	if(request.getParameterValues("ids") != null){
		for(int i = 0; i < request.getParameterValues("ids").length; i++){
			saveService.removeObject(Ga02_clsb.class,Integer.valueOf(request.getParameterValues("ids")[i]));
		}
	}
}
String lb = "";
QueryService queryService = (QueryService)ctx.getBean(ServiceName.QueryService);
QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga02_clsb.class);
if(request.getParameter("searchKey") != null){
	queryBuilder.addCriterion(Restrictions.or(Restrictions.like("mc",request.getParameter("searchKey"),MatchMode.ANYWHERE),Restrictions.like("bh",request.getParameter("searchKey"),MatchMode.ANYWHERE)));
}
if(request.getParameter("LB") != null && request.getParameter("LB").length() > 0){
	queryBuilder.eq("lb",request.getParameter("LB"));
	lb = request.getParameter("LB");
	System.out.println("123="+lb);
}

if(request.getParameter("clk_id") != null && request.getParameter("clk_id").length() > 0){
	//queryBuilder.eq("clk_id",new Integer(request.getParameter("clk_id")));
	;
}else{
    //Integer a=new Integer(-1);
    //queryBuilder.eq("clk_id",a);
}
queryBuilder.addOrderBy(Order.asc("id"));
int pageNum = 1;
int pageRowSize = 0;
if(request.getParameter("pageRowSize") != null&& request.getParameter("pageRowSize").length() > 0){
	pageRowSize = Integer.parseInt(request.getParameter("pageRowSize"));
}else{
	pageRowSize = 18;
}
if(request.getParameter("CurrentPage") != null && request.getParameter("CurrentPage").length() > 0){
	pageNum = Integer.parseInt(request.getParameter("CurrentPage"));
}

ResultObject ro = queryService.searchByPage(queryBuilder,pageNum,pageRowSize);
int totalRows = ro.getTotalRows();
int totalPages = ro.getTotalPages();
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>标准材料维护</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/list.css" rel="stylesheet" type="text/css">
</head>

<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onLoad="iframeAutoFit();" style="height:100%; background:#FFFFFF">
<form name="form1" id="form1" method="post" action="">
<input type="hidden" name="CurrentPage" value="<%=pageNum%>">
<input type="hidden" name="TotalOfPages" value="<%=totalPages%>">
<input type="hidden" name="pageRowSize" value="<%=pageRowSize%>">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="../images/main-images/gypms_main_blue.png" height="30" valign="top" align="right">
		<table width="100%" height="24" border="0" cellpadding="0" cellspacing="0" id="desk_menu">
			<tr>	
				<td width="10"></td>
				<td>&nbsp;<font id="list_name"> </font></td>
				<td width="60"><a href="javascript:winOpen('clwhEdit.jsp?lb=<%=lb %>','600','300','1');" title="新建"><img src="../images/add.gif" border="0"/></a></td>
				<td width="60"><a href="javascript:document.form1.action='?act=del';document.form1.submit();" title="删除"><img src="../images/del.gif" border="0"/></a></td>
				<td width="10"></td>
				<td width="80">
					<select name="LB">
						<option value="">--材料类别--</option>
        				<option value="ZC" <%if(lb.equals("ZC")){out.print("selected");}%>>主材</option>
        				<option value="SB" <%if(lb.equals("SB")){out.print("selected");}%>>设备</option>
        				<option value="JX" <%if(lb.equals("JX")){out.print("selected");}%>>机械</option>
        				<option value="YB" <%if(lb.equals("YB")){out.print("selected");}%>>仪表</option>
        			</select>
				</td>
				<td width="160" align="right" nowrap >
				<div style="position:absolute;color:white;padding-top:-3px;" onClick="blankit(this,document.form1.searchKey);">&nbsp;<%if(request.getParameter("searchKey") == null){%>在此输入要搜索的信息<%} %></div>
				<input type="text" name="searchKey" class="input-text" onkeypress="javascript:if(event.keyCode==13){document.form1.action='';document.form1.submit();}">
				<script type="text/javascript">
					<%
						if(request.getParameter("searchKey") != null){
							out.print("document.form1.searchKey.value='"+request.getParameter("searchKey")+"';");
						}
					%>
				</script>
				</td>
				<td width="60" valign="middle" align="left"><a href="javascript:document.form1.action='';document.form1.submit();"><img src="../images/search.gif" border="0" alt="搜索"></a></td>
				<td width="40"><a href="javascript:window.location.reload();" title="刷新工作列表"><img src="../images/refresh.gif" border="0"/></a></td>
				<td width="15">&nbsp;</td>
			</tr>
		</table>	
	</td>
  </tr>
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-collapse:collapse" id="list">
      <tr height="24">
		<td id="list_title" width="25"></td>
        <td id="list_title" width="80">材料编码</td>
        <td id="list_title" >名称</td> 
        <td id="list_title" width="70">型号规格</td>
        <td id="list_title" width="50">单位</td>
        <td id="list_title" width="50">本地价</td>
		<td id="list_title" width="50">全国价</td>
		<td id="list_title" width="50">全省价</td>
		<td id="list_title" width="50">预算价</td>
		<td id="list_title" width="50">备注</td>
	  </tr>
	  <%
	  int i = 0;
	  Ga02_clsb data;
	  while(ro.next() || i < pageRowSize){
	  	i++;
	  	data = (Ga02_clsb) ro.get(Ga02_clsb.class.getName());
	  	if(data != null){
		  %>
		  <tr>
			<td><input type="checkbox" name="ids" value="<%=data.getId()%>"></td>
			<td align="center"><%=StringFormatUtil.format(data.getBh())%></td>
			<td><a href="javascript:winOpen('clwhEdit.jsp?de_id=<%=data.getId()%>&lb=<%=lb%>','600','300','1');"><%=StringFormatUtil.format(data.getMc())%></a></td>
			<td align="center"><%=StringFormatUtil.format(data.getXhgg())%></td>
			<td align="center"><%=StringFormatUtil.format(data.getDw()) %></td>
			<td align="right"><%=NumberFormatUtil.roundToString(data.getBdj()) %></td>
			<td align="right"><%=NumberFormatUtil.roundToString(data.getQgj()) %></td>
			<td align="right"><%=NumberFormatUtil.roundToString(data.getBsj()) %></td>
			<td align="right"><%=NumberFormatUtil.roundToString(data.getYsj()) %></td>
			<td><%=StringFormatUtil.format(data.getBz()) %></td>					
		  </tr>
		  <%
		}else{
		  %><tr>
			<td>&nbsp;</td>
			<td align="center"></td>
			<td></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td></td>					
		  </tr>
		  <%
		}
	  }
	  %>
    </table></td>
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
             <a href="javascript:pageUp(document.all.form1)" title="上一页"><img src="../images/main-images/back.png" width="41" height="12" border="0"></a>
             <a href="javascript:pageDown(document.all.form1)" title="下一页"><img src="../images/main-images/next.png" width="41" height="12" border="0"></a>
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