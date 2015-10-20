<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.baseObject.QueryBuilder" %>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.dataObject.Ga02_clsb" %>
<%@ page import="com.netsky.dataObject.Ga00_zclb" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%@ page import="org.hibernate.criterion.MatchMode" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ page import="com.netsky.dataObject.Gb05_yhk" %>
<%@page import="com.netsky.dataObject.Gb01_yhb"%>
<%@ page import="org.hibernate.criterion.Restrictions" %>
<%
Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
if(yh==null){
	%>
	<script language="javascript">
	window.location.href="../inclkdex.jsp";
	</script>
	<%
	return;
}
request.setCharacterEncoding("gb2312");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService)ctx.getBean(ServiceName.QueryService);
ResultObject ro = null,ro2 = null;
QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga02_clsb.class);
String type  = request.getParameter("type");
String zclb = request.getParameter("ZCLB");
String clk = request.getParameter("CLK");
String title="";
if(type.equals("tab1")){
	type = "ZC";
	title="材料";
}
else if(type.equals("tab2")){
	type = "JX";
	title="机械";
}else if(type.equals("tab3")){
	type = "YB";
	title="仪表";
}else if(type.equals("tab4")){
	type = "SB";
	title="设备";
}
if(request.getParameter("searchKey") != null){
	queryBuilder.addCriterion(Restrictions.or(Restrictions.like("mc",request.getParameter("searchKey"),MatchMode.ANYWHERE),Restrictions.like("bh",request.getParameter("searchKey"),MatchMode.ANYWHERE)));
	queryBuilder.eq("lb",type);
	if(zclb != null && zclb.length() > 0)
		queryBuilder.eq("zclb",zclb);
//	if(clk != null && clk.length() > 0)
		//queryBuilder.eq("clk_id",new Integer(clk));
	ro = queryService.search(queryBuilder);
}
QueryBuilder qb1=new HibernateQueryBuilder(Ga00_zclb.class);
qb1.eq("lb",type);
qb1.addOrderBy(Order.asc("id"));
ResultObject zcfl = queryService.search(qb1);
%>
<html>
<head>
<title>材料选择</title>
<link href="../css/page.css" rel="stylesheet">
<script language="javascript">
function selectCl(obj){
	var type="<%=request.getParameter("type")%>";
	table=(window.opener.document.getElementById(type)).children[0];
	for(var i = 1; i < table.rows.length; i++){
		if(table.rows[i].cells[0].innerText == "" || table.rows[i].cells[0].innerText == null){
			table.rows[i].cells[0].innerText = obj.children[1].innerText;
			table.rows[i].cells[1].innerText = obj.children[2].innerText;
			table.rows[i].cells[2].innerText = obj.children[3].innerText;
			table.rows[i].cells[3].innerText = obj.children[4].innerText;
			table.rows[i].cells[4].children[2].value = obj.children[0].children[0].value;
			table.rows[i].cells[4].children[6].value = obj.children[0].children[1].value;
			table.rows[i].cells[4].children[0].readOnly=false;
			table.rows[i].cells[4].children[0].value = document.all.defaultnum.value;
			return;
		}
	}
	var newRow = (table.rows[1]).cloneNode(true);
	newRow = table.rows[1].parentNode.insertAdjacentElement("beforeEnd",newRow);
	newRow.children[0].innerText = "";
	newRow.children[1].innerText = "";
	newRow.children[2].innerText = "";
	newRow.children[3].innerText = "";
	newRow.children[4].children[0].value = "";
	newRow.children[4].children[0].readOnly=false;
	newRow.children[4].children[0].value = document.all.defaultnum.value;
	newRow.children[4].children[1].value = "";
	newRow.children[4].children[2].value = "";
	newRow.children[4].children[3].value = "";
	newRow.children[4].children[4].value = "";
	selectCl(obj);
}
</script>
</head>
<body topmargin="0" leftmargin="0" id="main-body">
	<div align="center">
		<form name="form1" method="post" action="">
			<input type="hidden" name="type" value="<%=request.getParameter("type") %>">
			<table width="600" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="21"></td>
				</tr>
				<tr>
					<td height="40">
						<table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="10">
									<img src="../images/main-images/gypms_main_bar_left.gif" width="10" height="40">
								</td>
								<td valign="bottom" background="../images/main-images/gypms_main_bar_bg.gif">
									<table height="30" border="0" cellpadding="0" cellspacing="0" id="alert-title">
										<tr>
											<td width="20">
												<img src="../images/main-images/dot.png" width="18" height="18">
											</td>
											<td>
												材料选择
											</td>
										</tr>
									</table>
								</td>
								<td width="10">
									<img src="../images/main-images/gypms_main_bar_right.gif" width="10" height="40">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td bgcolor="#f8f8f8" height="28" valign="middle"
						style="border:solid 1px #a4bec8;">
						<table border="0" cellpadding="0" style="border-collapse:collapse;height:14px;" >
						
						<tr style="height:30px;">
							<td width="15"></td>
							<td align="right">物品来源：</td>
							<td>
						    	<select name="CLK">
			        			<%
			        			String HSql = "select gb05 from Gb05_yhk gb05 where gb05.lb='" + type + "' and (id = 1 or cjr_id = " + yh.getId() + " or gxbz = 1) order by id desc";
			        			ro2 = queryService.search(HSql);
			        			while(ro2.next()){
			        				Gb05_yhk gb05 = (Gb05_yhk) ro2.get("gb05");
			        				%>
			        				<option value="<%=gb05.getId() %>"><%=gb05.getMc() %></option>
			        				<%
			        			}
			        			%>
			        			</select>
							</td>
							<td>
							<%
					        	if(!type.equals("JX")&&!type.equals("YB")){
						        	if(type.equals("ZC"))
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
						    				out.println("<option value='"+zclbBean.getZclb()+"' " + ((zclb != null && zclb.equals(zclbBean.getZclb())) ? "selected" : "") + ">"+zclbBean.getMc()+"</option>");
						    			}
						    		%>
						    	</select>
						    <%
					        	}
					        %>
							</td>
							<td>默认数量：<input type="text" name="defaultnum" value="<%=StringFormatUtil.format(request.getParameter("defaultnum"),"1.00")%>" onkeypress="aotusubmit()"></td>
						</tr>
				        <tr style="height:30px;">
				        	<td width="15"></td>
				        	<td align="right"><%=title%>名称或编码：</td>
					        <td colspan="2"><input type="text" name="searchKey" value="<%=StringFormatUtil.format(request.getParameter("searchKey")) %>" class="search" style="width:240px;height:20px;text-transform:uppercase;"></td>
					        <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value=" 查 询 " onclick="javascript:document.form1.submit();" class="but" style="height:20px;"></td>
				        </tr>
			        </table>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0" width="600"
				style="border-collapse:collapse;background:#ffffff" id="list">
				<tr>
					<td width="20"></td>
					<td width="80" align="center">编码</td>
					<td align="center">名称</td>
					<td width="110" align="center">型号规格</td>
					<td width="60" align="center">单位</td>
				</tr>
				<%
	  			Ga02_clsb data;
				while(ro != null && ro.next()){
					data = (Ga02_clsb) ro.get(Ga02_clsb.class.getName());
					%>
					<tr onDblClick="javascript:selectCl(this);">
						<td>
							<input type="hidden" name="cl_id" value="<%=data.getId()%>">
							<input type="hidden" name="cl_bh" value="<%=data.getBh()%>">
						</td>
						<td align="center"><%=StringFormatUtil.format(data.getBh())%></td>
						<td><%=StringFormatUtil.format(data.getMc())%></td>
						<td align="center"><%=StringFormatUtil.format(data.getXhgg())%></td>
						<td align="center"><%=StringFormatUtil.format(data.getDw())%></td>
					</tr>
					<%
				}
				%>
			</table>
		</form>
	</div>
</body>

</html>
