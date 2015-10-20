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
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat" %>
<html>
	<head>
    	<title>项目汇总查询</title>
		<link href="../css/main.css" rel="stylesheet">
		<script type="text/javascript">
			function seach(){
			/*
				var sk = document.form1.searchKeyWord.value;
				if(sk==null || sk ==""){
					alert("请输入查询关键字！");
					document.form1.searchKeyWord.focus();
					return;
				}*/
				document.form1.submit();
				
			}
		</script>
	</head>
<%
 	request.setCharacterEncoding("gb2312");
 	
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	
	String searchKeyWord=StringFormatUtil.format(request.getParameter("searchKeyWord"));
	
	String sf = StringFormatUtil.format(request.getParameter("sf"));
	String cjr = StringFormatUtil.format(request.getParameter("cjr"));
	ResultObject ro_province=null;
	ResultObject ro_cjr=null;
	ResultObject ro_list=null;

	Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    Integer user_id=yh.getId();
    
    String HSql_province = "select gb01.province from Gb01_yhb gb01 group by province";
    ro_province = queryService.search(HSql_province);
    String HSql_cjr = "select gd01.cjr from Gd01_gcxm gd01 group by cjr";
    ro_cjr = queryService.search(HSql_cjr);
	
	String sql = "select gd01.xmbh,gd01.xmmc,gd01.cjr,gd01.bzrq,gb01.company_name,gb01.province from Gd01_gcxm gd01,Gb01_yhb gb01 where gd01.cjr=gb01.name";
	if(!"".equals(searchKeyWord)){
		sql = sql + " and (gd01.xmbh like '%"+searchKeyWord+"%' or gd01.xmmc like '%"+searchKeyWord+"%')";
	}
	if(!"".equals(sf)){
		sql = sql + " and gb01.province='"+sf+"'"; 
	}
	if(!"".equals(cjr)){
		sql = sql + " and gd01.cjr='"+cjr+"'"; 
	}
	sql = sql + " order by gd01.bzrq desc";
	ro_list = queryService.search(sql);
 %>
<body topmargin="0" leftmargin="0">    
<div align="center">
	<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" height="100%">
		<tr>
			<td colspan="2" height="50" id="search-head">
				<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%">
					<tr>
						<td valign="bottom"><img src="../images/xmtj.gif" border="0"/></td>
					</tr>	
					<tr>
						<td height="15" background="../images/main-images/gypms_main_bar_bg.gif"></td>
					</tr>	
				</table>
			</td>
		</tr>
		<tr>
			<td height="50" valign="middle">
			<form name="form1" action="" method="post">
			  	<table height="30" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
				
				  	<tr>
			  			<td width="15"></td>
						<td width="80" align="right">省份：</td>
			  			<td width="100">
							<select name="sf">
							<option value="">全部</option>
					    		<%
					    			//Gb01_yhb gb01=new Gb01_yhb();
					    			while(ro_province.next()){
					    				//gb01=(Gb01_yhb)ro_province.get("gb01");
					    				//String p=gb01.getProvince();
					    				String p=(String)ro_province.get("gb01.province");
					    				//out.println("<option value="+p+">"+p+"</option>");
					    				%>
					    				<option <%if(p!=null&&p.equals(sf)){%>selected<%}%> value="<%=p%>"><%=p %></option>
					    				<%
					    			}
					    		%>
					    	</select>
						</td>
					  	<td width="60" align="right">创建人：</td>
						<td width="60">
						<select name="cjr">
							<option value="">全部</option>
					    		<%
					    			//Gd01_gcxm gd01=new Gd01_gcxm();
					    			while(ro_cjr.next()){
					    				//gd01=(Gd01_gcxm)ro_cjr.get("gd01");
					    				//String c=gd01.getCjr();
					    				String c=(String)ro_cjr.get("gd01.cjr");
					    				//out.println("<option value="+c+">"+c+"</option>");
					    				%>
					    				<option <%if(c!=null&&c.equals(cjr)){%>selected<%}%> value="<%=c%>"><%=c %></option>
					    				<%
					    			}
					    		%>
					    	</select>
						</td>
						<td width=150 align='right' id="zct">
					    </td>
					    <td width=150 align='right' id="sbt">
						</td>
					   	<td width="100" align="right">项目编码或名称：</td>
					    <td width="200"><input type="text" name="searchKeyWord" value="<%=searchKeyWord%>" onkeypress="javascript:if(event.keyCode==13) seach();" class="search" style="width:240px;height:20px;text-transform:uppercase;"></td>
						<td width="50" align="right"><input type="button" value=" 查 询 " onclick="javascript:seach();" class="but" style="height:20px;"></td>
				  	</tr>
				
				</table>
			</form>
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
					    	<td align="center">项目名称</td>
					    	<td width="120">创建人</td>
							<td width="80">编制日期</td>
							<td width="80">省份</td>
							<td width="80">公司名称</td>
				 	</tr>
		<%
		int counter=0;
		if(ro_list!=null){
			while(ro_list.next()){
				++counter;
		%>
				<tr onMouseOver="this.style.backgroundColor='#dce8ec'" onMouseOut="this.style.backgroundColor=''">
					<td align="center"><%=counter%></td>
					<td><%=StringFormatUtil.format((String)ro_list.get("gd01.xmmc"))%></td>
					<td align="center"><%=StringFormatUtil.format((String)ro_list.get("gd01.cjr"))%></td><%%>
					<td align="center"><%=getSwitchDate(ro_list.get("gd01.bzrq"))%></td>
					<td align="center"><%=StringFormatUtil.format((String)ro_list.get("gb01.province"))%></td>
					<td align="left"><%=StringFormatUtil.format((String)ro_list.get("gb01.company_name"))%></td>
				</tr>
		<%		
			}
		}
		%>
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
	public String getSwitchDate(Object startDate){   
	    String bzri="";
	    try{
	    	if(startDate!=null&&!"".equals(startDate)){
	    		bzri=new SimpleDateFormat("yyyy-MM-dd").format(startDate);
	    	}
	    }catch(Exception e){   
	        e.printStackTrace();
	    }   
	    return bzri;   
    } 
%>