<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.service.SaveService" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.baseObject.QueryBuilder" %>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.dataObject.Ga01_de" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%@ page import="org.hibernate.criterion.MatchMode" %>
<%@ page import="org.hibernate.criterion.Restrictions" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ page import="com.netsky.dataObject.Ga13_dej" %>
<%
request.setCharacterEncoding("gb2312");

ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
int pageNum = 1;
int pageRowSize = 0;
if(request.getParameter("pageRowSize") != null&& request.getParameter("pageRowSize").length() > 0){
	pageRowSize = Integer.parseInt(request.getParameter("pageRowSize"));
}else{
	pageRowSize = 19;
}
if(request.getParameter("CurrentPage") != null && request.getParameter("CurrentPage").length() > 0){
	pageNum = Integer.parseInt(request.getParameter("CurrentPage"));
}
Ga01_de ga01;
String HSql="";
ResultObject rs;
Ga01_de list_ga01;
String ku_name=formatStr(request.getParameter("select"),"");
String keyword=formatStr(request.getParameter("searchKey"),"");
String bt=formatStr(request.getParameter("bt_id"),"");
String ft=formatStr(request.getParameter("ft_id"),"");

 %>
<html>
  <head>
    <title>表单查询</title>
    <link href="../css/main.css" rel="stylesheet">
		<script language="javascript" src="../js/functionlib.js"></script>
  </head>
   <%   

	Integer zhang;
	if(request.getParameter("zhang")==null ||request.getParameter("zhang").equals("")){
		zhang=new Integer(0);
	}else{
		zhang=new Integer(request.getParameter("zhang"));
	}

   QueryBuilder queryBuilder101 = new HibernateQueryBuilder(Ga13_dej.class);
   if(request.getParameter("ce")!=null){
		queryBuilder101.eq("c_id",new Integer(request.getParameter("ce")));
	}else{
		queryBuilder101.eq("c_id",new Integer(1));
	}
	if(request.getParameter("zhang")!=null && !request.getParameter("zhang").equals("")){
		queryBuilder101.eq("z_id",zhang);
	}
	
	if(request.getParameter("jie")!=null && !request.getParameter("jie").equals("")){
		queryBuilder101.eq("id",new Integer(request.getParameter("jie")));
	}
	ResultObject ro101 = queryService.search(queryBuilder101) ;
	Ga13_dej ga13 = new Ga13_dej();
	if(ro101.next()){
	  ga13 = (Ga13_dej)ro101.get(Ga13_dej.class.getName());
	}
   
   HSql = "select ga01 from Ga01_de ga01 where  (mc like'%"+keyword+"%' or bh like'%"+keyword+"%')";
   if(ku_name!=null&&!"".equals(ku_name))
	  HSql+=" and dek_id="+ku_name;
   if("1".equals(ku_name))
   {
      if(!ga13.getQsbh().equals("")) HSql+=" and  bh > '"+ga13.getQsbh()+"'";
      if(!ga13.getJzbh().equals("")) HSql+=" and  bh < '"+ga13.getJzbh()+"'";
   }else{
      if(!bt.equals("")||!ft.equals("")){  
         if(!bt.equals(""))	HSql+=" and  bh > '"+bt+"'";
         if(!ft.equals(""))    HSql+=" and  bh < '"+ft+"'";
      }
   }
   rs = queryService.searchByPage(HSql,pageNum,pageRowSize);
   int totalRows = rs.getTotalRows();
   int totalPages = rs.getTotalPages();
  //out.print(HSql);
  %>
 <body topmargin="0" leftmargin="0">  
  <input type="hidden" name="CurrentPage" value="<%=pageNum%>">
  <input type="hidden" name="TotalOfPages" value="<%=totalPages%>">
  <input type="hidden" name="pageRowSize" value="<%=pageRowSize%>">

    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse" id="search-list">
				  	<tr id="search-title">
						<td align="center"width="35">序号</td>
      					<td width="70">定额编号</td>
        				<td align="center">定额名称</td>
        				<td width="35">单 位</td>        
        				<td width="55">技工工日</td>
        				<td width="55">普工工日</td>
   					</tr>
     <%    
           int i = 0;
          	while(rs.next() || i < pageRowSize){
          		i++;
          	list_ga01 = (Ga01_de) rs.get("ga01");          	
          	if(list_ga01 != null){
	          %>
   <tr>
			<td align="center"><%=i%></td>
			<td align="center"><%=StringFormatUtil.format(list_ga01.getBh())%></td>
			<td align="left"><%=StringFormatUtil.format(list_ga01.getMc())%></td>
			<td align="left"><%=StringFormatUtil.format(list_ga01.getDw())%></td>
			<td align="right"><%=StringFormatUtil.format(list_ga01.getJggr())%></td>
			<td align="right"><%=StringFormatUtil.format(list_ga01.getPggr())%></td>
		  </tr>
		  <%}else{ %>
		  <tr>
			<td align="center"><%=i%></td>
			<td align="center"></td>
			<td align="left"></td>
			<td align="center"></td>
			<td align="right"></td>
			<td align="right"></td>
		  </tr>
		  <%} }%>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="38" bgcolor="#dce8ec">
       <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
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
      </table>
    </td>
  </tr>
</table>
  </body>
</html>
<%!
public String formatStr(String str,String defaultStr){
	if(str==null)
		return defaultStr;
	return str;
}
%>
