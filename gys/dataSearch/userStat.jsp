<%@ page language="java" pageEncoding="GBK" %>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="org.hibernate.criterion.*" %>
<%@ page import="com.netsky.dataObject.Ga02_clsb" %>
<%@ page import="com.netsky.dataObject.Ga00_zclb" %>
<%@ page import="com.netsky.dataObject.Gb05_yhk" %>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil" %>
<%@ page import="com.netsky.baseFormatUtils.NumberFormatUtil" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%@ page import="com.netsky.dataObject.Gd01_gcxm" %>
<html>
	<head>
    	<title>使用情况查询</title>
		<link href="../css/main.css" rel="stylesheet">
	</head>
<%
 	request.setCharacterEncoding("gb2312");
 	
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);

	ResultObject ro_list=null;

	Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    Integer user_id=yh.getId();
	
	String sql = "select gb01.province,count(gb01.id) as num from Gb01_yhb gb01 group by gb01.province";
	ro_list = queryService.search(sql);
 %>
<body topmargin="0" leftmargin="0">    
<div align="center">
	<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" height="100%">
		<tr>
			<td colspan="2" height="50" id="search-head">
				<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%">
					<tr>
						<td valign="bottom"><img src="../images/syqk.gif" border="0"/></td>
					</tr>	
					<tr>
						<td height="15" background="../images/main-images/gypms_main_bar_bg.gif"></td>
					</tr>	
				</table>
			</td>
		</tr>
		
		<tr>
      			<td colspan="3" height="2" bgcolor="#c5ced4"></td>
     		</tr>				
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" id="search-list">
				  	<tr id="search-title">
					    	<td width="40">序号</td>
					    	<td width="100" align="center">省份</td>
					    	<td width="100" align="center">人数</td>
					    	<td align="left" >项目数</td>
				 	</tr>
					<%
					int zrs=0;//总人数
					int zgcs=0;//总工程数
					int counter=0;
					if(ro_list!=null){
						while(ro_list.next()){
							++counter;
							String province=StringFormatUtil.format((String)ro_list.get("gb01.province"));
							
							ResultObject p_count=null;
							String sql_p = "select count(gd01.id) as p_num from Gd01_gcxm gd01,Gb01_yhb gb01 where gd01.cjr=gb01.name and gb01.province='"+province+"'";
							System.out.println(sql_p);
							p_count = queryService.search(sql_p);
							String pp="0";
							if(p_count.next()){
								pp=p_count.get("p_num").toString();
							}
							Integer a=(Integer)ro_list.get("num");
							if(a!=null&&!"".equals(a))
							{
								zrs=zrs+a.intValue();
							}
							Integer b=new Integer(pp);
							if(b!=null&&!"".equals(b))
							{
								zgcs=zgcs+b.intValue();
							}
					%>
							<tr onMouseOver="this.style.backgroundColor='#dce8ec'" onMouseOut="this.style.backgroundColor=''">
								<td align="center"><%=counter%></td>
								<td align="center"><%=province%></td>
								<td align="center"><%=ro_list.get("num")%></td>
								<td><%=pp%></td>
							</tr>
					<%		
						}
					}
					%>
					<tr id="search-title">
						<td colspan="4" height="2" bgcolor="#c5ced4">总人数：<%=zrs %>   工程总数：<%=zgcs %></td>
				 	</tr>
				</table>
			</td>
		</tr>
	</table>
</div>  
	
  </body>
</html>
<%!
	public String formatStr(String str,String defaultStr){
		if(str==null)
			return defaultStr;
		return str;
	}
		public String formatNum(String str,String defaultStr){
		if(Double.parseDouble(str)==0)
			return defaultStr;
		return str;
	}
	public String dtos(String d)
	{
		String dd=d;
        if("0.00".equals(dd))
	    {
			dd="0";
		}
		return dd;
	}
%>