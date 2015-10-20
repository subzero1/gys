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
<html>
	<head>
    	<title>通信器材查询</title>
		<link href="../css/main.css" rel="stylesheet">
		<script type="text/javascript">
			function seach(){
				var sk = document.form1.searchKeyWord.value;
				if(sk==null || sk ==""){
					alert("请输入查询关键字！");
					document.form1.searchKeyWord.focus();
					return;
				}
				document.form1.submit();
			}
			function show(obj){
				if(obj.value=='ZC'){
					document.getElementById('zct').style.display='block';
					document.getElementById('sbt').style.display='none';
				}else if(obj.value=='SB'){
					document.getElementById('zct').style.display='none';
					document.getElementById('sbt').style.display='block';
				}else{
					document.getElementById('zct').style.display='none';
					document.getElementById('sbt').style.display='none';
				}
			}
		</script>
	</head>
<%
 	request.setCharacterEncoding("gb2312");
 	
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	
	String searchKeyWord=StringFormatUtil.format(request.getParameter("searchKeyWord"));
	String lb = StringFormatUtil.format(request.getParameter("LB"),"ZC");
	String zclb = StringFormatUtil.format(request.getParameter("ZCLB"));
	String sblb = StringFormatUtil.format(request.getParameter("SBLB"));
	String clk = StringFormatUtil.format(request.getParameter("CLK"));
	
	if(lb.equals("ZC"))
		sblb="";
	else if(lb.equals("SB"))
		zclb="";
	else{
		zclb="";
		sblb="";
	}
	
	ResultObject zcfl = null,sbfl=null,ro=null,clkRs=null;
	
	QueryBuilder qb1=new HibernateQueryBuilder(Ga00_zclb.class);
	qb1.eq("lb","ZC");
	qb1.addOrderBy(Order.asc("id"));
	zcfl = queryService.search(qb1);
	
	QueryBuilder qb3=new HibernateQueryBuilder(Ga00_zclb.class);
	qb3.eq("lb","SB");
	qb3.addOrderBy(Order.asc("id"));
	sbfl = queryService.search(qb3);

	//QueryBuilder qb2=new HibernateQueryBuilder(Gb05_yhk.class);
	//qb2.notEq("lb","DE");
	//qb2.addOrderBy(Order.asc("id"));
	//clkRs = queryService.search(qb2);
	
	Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    Integer user_id=yh.getId();
    String HSql = "select gb05 from Gb05_yhk gb05 where gb05.lb!='DE' and (id=2 or id=3 or id=4 or cjr_id="+user_id+")";
    clkRs = queryService.search(HSql);
	
	String sql = "";

	if(!searchKeyWord.equals("")){
		if(clk.equals("")){
			sql = "select ga02.bh,ga02.mc,ga02.xhgg,ga02.dw,ga02.zclb,ga02.bdj,ga02.bsj,ga02.qgj,ga02.ysj "+
			"from Ga02_clsb ga02 where ga02.lb='"+lb+"' and (ga02.mc like '%"+searchKeyWord+"%' or ga02.bh like '%"+searchKeyWord+"%')";
			if(lb.equals("ZC")||lb.equals("SB")){
				if(!zclb.equals(""))
					sql += " and ga02.zclb='"+zclb+"'";
				if(!sblb.equals(""))
					sql += " and ga02.zclb='"+sblb+"'";
			}
			sql += " order by ga02.bh";
			ro = queryService.search(sql);
		}else{
			sql = "select ga02.bh,ga02.mc,ga02.xhgg,ga02.dw,ga02.zclb,ga02.bdj,ga02.bsj,ga02.qgj,ga02.ysj "+
			"from Ga02_clsb ga02 where ga02.clk_id= "+clk+" and (ga02.mc like '%"+searchKeyWord+"%' or ga02.bh like '%"+searchKeyWord+"%')";
			sql += " order by ga02.bh";
			ro = queryService.search(sql);
		}
	}
 %>
<body topmargin="0" leftmargin="0">    
<div align="center">
	<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" height="100%">
		<tr>
			<td colspan="2" height="50" id="search-head">
				<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%">
					<tr>
						<td valign="bottom"><img src="../images/txqc.gif" border="0"/></td>
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
						<td width="80" align="right">物品来源：</td>
			  			<td width="100">
							<select name="CLK">
					    		<%
					    			Gb05_yhk clkBean=new Gb05_yhk();
					    			while(clkRs.next()){
					    				clkBean=(Gb05_yhk)clkRs.get("gb05");
					    				out.println("<option value="+clkBean.getId()+">"+clkBean.getMc()+"</option>");
					    			}
					    		%>
					    	</select>
						</td>
					  	<td width="60" align="right">类别：</td>
						<td width="60">
							<select name="LB" onchange="show(this)">
								<option value="ZC">主材</option>
								<option value="SB">设备</option>
								<option value="JX">机械</option>
								<option value="YB">仪表</option>
							</select>
						</td>
						<td width=150 align='right' id="zct">主材归类：
							<select name="ZCLB">
					    		<option value="">全部</option>
					    		<%
					    			Ga00_zclb zclbBean=new Ga00_zclb();
					    			while(zcfl.next()){
					    				zclbBean=(Ga00_zclb)zcfl.get(Ga00_zclb.class.getName());
					    				out.println("<option value='"+zclbBean.getZclb()+"'>"+zclbBean.getMc()+"</option>");
					    			}
					    		%>
					    	</select>
					    </td>
					    <td width=150 align='right' id="sbt">设备归类：
				    		<select name="SBLB">
					    		<option value="">全部</option>
					    		<%
					    			Ga00_zclb sblbBean=new Ga00_zclb();
					    			while(sbfl.next()){
					    				sblbBean=(Ga00_zclb)sbfl.get(Ga00_zclb.class.getName());
					    				out.println("<option value='"+sblbBean.getZclb()+"'>"+sblbBean.getMc()+"</option>");
					    			}
					    		%>
					    	</select>
						</td>
						<script type="text/javascript">
				    		<%
				    			if(!clk.equals(""))
					    			out.println("form1.CLK.value='"+clk+"';");
					    		out.println("form1.LB.value='"+lb+"';");
				    			if(!zclb.equals(""))
				    				out.println("form1.ZCLB.value='"+zclb+"';");
				    			if(!sblb.equals(""))
				    				out.println("form1.SBLB.value='"+sblb+"';");
				    			out.println("show(document.form1.LB);");
				    		%>
				    	</script>
					   	<td width="100" align="right">编码或名称：</td>
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
					    	<td width="100" align="center">编码</td>
					    	<td align="center">名称</td>
					    	<td width="120">规格型号</td>
							<td width="80">单位</td>
							<td width="80">本地价</td>
							<td width="80">本省价</td>
							<td width="80">全国价</td>
							<td width="80">预算价</td>
				 	</tr>
		<%
		int counter=0;
		if(ro!=null){
			while(ro.next()){
				++counter;
		%>
				<tr onMouseOver="this.style.backgroundColor='#dce8ec'" onMouseOut="this.style.backgroundColor=''">
					<td align="center"><%=counter%></td>
					<td align="center"><%=StringFormatUtil.format((String)ro.get("ga02.bh"))%></td>
					<td><%=StringFormatUtil.format((String)ro.get("ga02.mc"))%></td>
					<td><%=StringFormatUtil.format((String)ro.get("ga02.xhgg"))%></td><%%>
					<td align="center"><%=StringFormatUtil.format((String)ro.get("ga02.dw"))%></td>
					<td align="right"><%=NumberFormatUtil.roundToString((Double)ro.get("ga02.bdj"))%></td>
					<td align="right"><%=NumberFormatUtil.roundToString((Double)ro.get("ga02.bsj"))%></td>
					<td align="right"><%=NumberFormatUtil.roundToString((Double)ro.get("ga02.qgj"))%></td>
					<td align="right"><%=NumberFormatUtil.roundToString((Double)ro.get("ga02.ysj"))%></td>
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
%>