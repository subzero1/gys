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
<%@ page import="org.hibernate.criterion.MatchMode" %>
<jsp:directive.page import="com.netsky.dataObject.Gb05_yhk"/>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%
 	request.setCharacterEncoding("gb2312");
 	String formTr = StringFormatUtil.format(request.getParameter("fromTr"));
 	String stable = StringFormatUtil.format(request.getParameter("stable"));
 	String keyField = StringFormatUtil.format(request.getParameter("keyField"));
 	
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	
	String searchKeyWord=StringFormatUtil.format(request.getParameter("searchKeyWord"));
	searchKeyWord =searchKeyWord.toUpperCase();
	String lb = StringFormatUtil.format(request.getParameter("LB"));
	String bgbh = StringFormatUtil.format(request.getParameter("BGBH"));
	String zclb = StringFormatUtil.format(request.getParameter("ZCLB"));
	String clk = StringFormatUtil.format(request.getParameter("CLK"));
	String priceType="";
		
	String title="";
	if(lb.equals("ZC"))title="材料";
	else if(lb.equals("SB"))title="设备";
	else if(lb.equals("JX"))title="机械";
	else if(lb.equals("YB"))title="仪表";
	ResultObject zcfl = null;
	ResultObject ro = null;
	ResultObject clkRs = null;

	QueryBuilder qb1=new HibernateQueryBuilder(Ga00_zclb.class);
	qb1.eq("lb",lb);
	qb1.addOrderBy(Order.asc("id"));
	zcfl = queryService.search(qb1);
	
    Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    Integer user_id=yh.getId();
    String HSql = "select gb05 from Gb05_yhk gb05 where gb05.lb!='DE' and (id=2 or id=3 or id=4 or cjr_id="+user_id+")";
    clkRs = queryService.search(HSql);
	
	String sql = "";
	if(bgbh.equals("B3Y")||bgbh.equals("B3B")){
		priceType = request.getParameter("priceflag");
		sql = "select distinct ga02.gg,ga02.bh,ga02.mc,ga02.dw,ga02.xhgg,ga02.bdj,ga02.bsj,ga02.qgj,ga02.ysj "+
		"from Ga02_clsb ga02 where ga02.lb='"+lb+"'";
		if(!searchKeyWord.equals(""))
			sql += " and (ga02.mc like '%"+searchKeyWord+"%' or ga02.bh like '%"+searchKeyWord+"%')";
		sql += " order by ga02.bh";
		ro = queryService.search(sql);
	}else{
		if(!searchKeyWord.equals("")){
			sql = "select ga02.gg,ga02.bh,ga02.mc,ga02.xhgg,ga02.dw,ga02.zclb,ga02.bdj,ga02.bsj,ga02.qgj,ga02.ysj "+
			"from Ga02_clsb ga02 where ga02.lb='"+lb+"' and (ga02.mc like '%"+searchKeyWord+"%' or ga02.bh like '%"+searchKeyWord+"%')";
			//if(!zclb.equals(""))
			//	sql += " and ga02.zclb='"+zclb+"'";
			//if(!clk.equals(""))
			//	sql += " and ga02.clk_id = "+clk;
			sql += " order by ga02.bh";
			ro = queryService.search(sql);
		}else{
			sql = "select ga02.gg,ga02.bh,ga02.mc,ga02.xhgg,ga02.dw,ga02.zclb,ga02.bdj,ga02.bsj,ga02.qgj,ga02.ysj "+
			"from Ga02_clsb ga02 where ga02.lb='"+lb+"' ";
			//if(!zclb.equals(""))
			//	sql += " and ga02.zclb='"+zclb+"'";
			//if(!clk.equals(""))
			//	sql += " and ga02.clk_id = "+clk;
			sql += " order by ga02.bh";
			ro = queryService.search(sql);
		}
	}
 %>


<html>

<head>
<title></title>
<link href="../css/page.css" rel="stylesheet">
<script language="javascript" src="../js/selectItem.js"></script>
<script language="javascript" src="../js/calculateTotal.js"></script>
<script language="javascript">
function aotusubmit(){
	if(event.keyCode==13){
		seach();
	}
}
function seach(){

	document.form1.submit();
}
function openSelectPage(obj,xh,clbh){
<%
	if(bgbh.equals("B3Y")||bgbh.equals("B3B")){
%>
		selectItem(obj,'values'+xh,'|',false,clbh,3);
<%
	}else{
%>
		selectItem(obj,'values'+xh,'|',false,clbh,2);
		b3zcAmountClear();
<%
	}
%>
}
function b3zcAmountClear(){
	var openerRow = sourceTable.rows[fromTr-1];
	openerRow.cells[2].children[0].value=document.form1.default_num.value;
	openerRow.cells[8].children[0].value='';
	 if(document.getElementById("dd").value=="B4JZC"){
	     openerRow.cells[11].children[0].value='1.00';
	 }else{
	     openerRow.cells[10].children[0].value='1.00';
	 }
	
	var flag = opener.document.form1.price_select.value;
	if(flag=='BDJ'){
		openerRow.cells[7].children[0].value=setNumFormat(parseFloat(openerRow.cells[7].children[1].value),2);
	}else if(flag=='BSJ'){
		openerRow.cells[7].children[0].value=setNumFormat(parseFloat(openerRow.cells[7].children[2].value),2);
	}else if(flag=='QGJ'){
		openerRow.cells[7].children[0].value=setNumFormat(parseFloat(openerRow.cells[7].children[3].value),2);
	}else{
		openerRow.cells[7].children[0].value=setNumFormat(parseFloat(openerRow.cells[7].children[4].value),2);
	}
	opener.computeAndValid(openerRow.cells[2].children[0]);
}
</script>
</head>
<body topmargin="0" leftmargin="0" id="main-body" onLoad="setDefaultGv('<%=formTr%>','<%=stable%>','<%=keyField%>');">
<div align="center">
	<table width="600" border="0" cellspacing="0" cellpadding="0">
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
						                	<td><%=title%>选择</td>
					        		</tr>
					        	</table>
					        </td>
					         <td width="10"><img src="../images/main-images/gypms_main_bar_right.gif" width="10" height="40"></td>
				        </tr>
			        </table>
		        </td>
	        </tr>      
	        <tr>
		        <td bgcolor="#f8f8f8" height="28" valign="middle" style="border:solid 1px #a4bec8;">
		        <form name="form1" method="post" action="selectMaterial.jsp">
		        <input type="hidden" name="" id="dd" value="<%=bgbh%>">
		        	<table border="0" cellpadding="0" style="border-collapse:collapse;height:14px;" >
				    
						<input type="hidden" name="fromTr" value="<%=formTr%>">
						<input type="hidden" name="stable" value="<%=stable%>">
						<input type="hidden" name="keyField" value="<%=keyField%>">
						
						<input type="hidden" name="LB" value="<%=lb%>">
						<input type="hidden" name="BGBH" value="<%=bgbh%>">
						<input type="hidden" name="priceflag" value="<%=priceType%>">
						<!-- 
						<tr style="height:30px;">
							<td width="15"></td>
							<td align="right">物品来源：</td>
							<td>
								<select name="CLK">
						    		<%
						    			Gb05_yhk clkBean=new Gb05_yhk();
						    			while(clkRs.next()){
						    				clkBean=(Gb05_yhk)clkRs.get("gb05");
						    				out.println("<option value="+clkBean.getId()+">"+clkBean.getMc()+"</option>");
						    			}
						    		%>
						    	</select>
						    	<script type="text/javascript">
						    		<%
						    			if(!clk.equals(""))
						    				out.println("form1.CLK.value='"+clk+"';");
						    		%>
						    	</script>
							</td>
							<td>
							<%
					        	if(!lb.equals("JX")&&!lb.equals("YB")){
						        	if(lb.equals("ZC"))
						        		out.println("主材归类：");
						        	else
						        		out.println("设备归类：");
						    %>
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
						    	<script type="text/javascript">
						    		<%
						    			if(!zclb.equals(""))
						    				out.println("form1.ZCLB.value='"+zclb+"';");
						    		%>
						    	</script>
						    <%
					        	}
					        %>
							</td>
							<td>默认数量：<input type="text" name="default_num" value="<%=StringFormatUtil.format(request.getParameter("default_num"),"1.00")%>" onkeypress="aotusubmit()"></td>
						</tr>
						 -->
				        <tr style="height:30px;">
				        	<td width="15"></td>
				        	<td align="right"><%=title%>名称或编码：</td>
					        <td><input type="text" name="searchKeyWord" onkeypress="aotusubmit()" value="<%=searchKeyWord%>" class="search" style="width:180px;height:20px;text-transform:uppercase;"></td>
					        <td>&nbsp;&nbsp;默认数量：<input type="text"  onblur="javascript:this.value = Math.round(this.value*1000)/1000;" size="10" name="default_num" value="<%=StringFormatUtil.format(request.getParameter("default_num"),"0.00")%>" onkeypress="aotusubmit()"></td>
					        <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value=" 查 询 " onclick="javascript:seach();" class="but" style="height:20px;"></td>
				        </tr>
			        </table>
			    </form>
		        </td>
	        </tr>
        </table>
	<table border="0" cellpadding="0" cellspacing="0" width="600" style="border-collapse:collapse;background:#ffffff" id="list">
		<tr>
			<td class="list_title" width="80" align="center"><%=title%>编码</td>
			<td class="list_title" align="center"><%=title%>名称</td>
			<td class="list_title" align="center">型号</td>
			<td class="list_title" align="center">规格</td>
			<td class="list_title" width="60" align="center">单位</td>
		</tr>
		<%
		int counter=0;
		if(ro!=null){
			while(ro.next()){
				++counter;
		%>
				<div id="values<%=counter%>">
					<%
						if(bgbh.equals("B3Y")||bgbh.equals("B3B")){
					%>
							<input type="hidden" name="BH" value="<%=StringFormatUtil.format((String)ro.get("ga02.bh"))%>">
							<input type="hidden" name="MC" value="<%=StringFormatUtil.format((String)ro.get("ga02.mc"))%>">
							<input type="hidden" name="DW" value="<%=StringFormatUtil.format((String)ro.get("ga02.dw"))%>">
							<input type="hidden" name="XHGG" value="<%=StringFormatUtil.format((String)ro.get("ga02.xhgg"))%>">
					<%
						if(priceType.equals("BDJ"))
							out.println("<input type='hidden' name='DJ' value='"+StringFormatUtil.format((Double)ro.get("ga02.bdj"))+"'>");
						else if(priceType.equals("BSJ"))
							out.println("<input type='hidden' name='DJ' value='"+StringFormatUtil.format((Double)ro.get("ga02.bsj"))+"'>");
						else if(priceType.equals("QGJ"))
							out.println("<input type='hidden' name='DJ' value='"+StringFormatUtil.format((Double)ro.get("ga02.qgj"))+"'>");
						else
							out.println("<input type='hidden' name='DJ' value='"+StringFormatUtil.format((Double)ro.get("ga02.ysj"))+"'>");
						}else{
					%>
							<input type="hidden" name="Gd07_b4.BH" value="<%=StringFormatUtil.format((String)ro.get("ga02.bh"))%>">
							<input type="hidden" name="Gd07_b4.MC" value="<%=StringFormatUtil.format((String)ro.get("ga02.mc"))%>">
							<input type="hidden" name="Gd07_b4.XHGG" value="<%=StringFormatUtil.format((String)ro.get("ga02.xhgg"))%>">
							<input type="hidden" name="Gd07_b4.DW" value="<%=StringFormatUtil.format((String)ro.get("ga02.dw"))%>">
							<input type="hidden" name="Gd07_b4.ZCLB" value="<%=StringFormatUtil.format((String)ro.get("ga02.zclb"))%>">
							<input type="hidden" name="DJ_BDJ" value="<%=StringFormatUtil.format((Double)ro.get("ga02.bdj"))%>">
							<input type="hidden" name="DJ_BSJ" value="<%=StringFormatUtil.format((Double)ro.get("ga02.bsj"))%>">
							<input type="hidden" name="DJ_QGJ" value="<%=StringFormatUtil.format((Double)ro.get("ga02.qgj"))%>">
							<input type="hidden" name="DJ_YSJ" value="<%=StringFormatUtil.format((Double)ro.get("ga02.ysj"))%>">
							<input type="hidden" name="Gd07_b4.GG" value="<%=StringFormatUtil.format((String)ro.get("ga02.gg")) %>">
					<%
						}
					%>

					
				</div>
				<tr onDblclick="javascript:openSelectPage(this,<%=counter%>,'<%=StringFormatUtil.format((String)ro.get("ga02.bh"))%>');" onMouseOver="this.style.backgroundColor='#dce8ec'" onMouseOut="this.style.backgroundColor=''">
						<td align="center"><%=StringFormatUtil.format((String)ro.get("ga02.bh"))%></td>
						<td><%=StringFormatUtil.format((String)ro.get("ga02.mc"))%></td>
						<td><%=StringFormatUtil.format((String)ro.get("ga02.xhgg"))%></td>
						<td><%=StringFormatUtil.format((String)ro.get("ga02.gg"))%></td>
						<td align="center"><%=StringFormatUtil.format((String)ro.get("ga02.dw"))%></td>
				</tr>
		<%

			}
			
		}
		for(++counter;counter<=12;counter++){
			out.println("<tr><td></td><td></td><td></td><td></td></tr>");
		}
		%>
	</table>
</div>
</body>
</html>
