<%@ page language="java" pageEncoding="GBK" %>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseFormatUtils.*"%>
<%@ page import="com.netsky.baseObject.*"%>
<%@ page import="com.netsky.dataObject.Gd05_b3j"%>
<%@ page import="com.netsky.dataObject.Ga01_de"%>
<%
	request.setCharacterEncoding("gb2312");
	Integer dxgc_id= new Integer(request.getParameter("dxgc_id").trim());
	Integer gcxm_id= new Integer(request.getParameter("gcxm_id").trim());
 	
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd05_b3j.class);
	queryBuilder.eq("dxgc_id",dxgc_id);
	queryBuilder.eq("gcxm_id",gcxm_id);
	ResultObject ro = queryService.search(queryBuilder);
	Gd05_b3j gd05 = new Gd05_b3j();
%>
<html>
<head>
<title>定额选择</title>
<link href="../css/list.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../js/functionlib.js"></script>
<script type="text/javascript">
function selectCl(obj){
		var ro = "<%=request.getParameter("ro")%>";
		table=(window.opener.document.getElementById("list-table")).children[0];
		table.rows[ro].children[1].children[0].value = obj.children[0].children[0].value;
		table.rows[ro].children[2].children[0].value = obj.children[1].children[0].value;
		table.rows[ro].children[3].children[0].value = obj.children[2].children[0].value;
		table.rows[ro].children[4].children[0].value = obj.children[2].children[1].value;	
		table.rows[ro].children[13].children[1].value = obj.children[2].children[2].value;	
}
</script>
</head>
<body topmargin="0" leftmargin="0" id="main-body"  scroll="yes"  >
 <form name="form1" method="post" action="">
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
						                	<td>定额选择</td>
					        		</tr>
					        	</table>
					        </td>
					         <td width="10"><img src="../images/main-images/gypms_main_bar_right.gif" width="10" height="40"></td>
				        </tr>
			        </table>
		        </td>
	        </tr> 
	 </table>     
	        <tr>
		        <td bgcolor="#f8f8f8" height="28" valign="middle" style="border:solid 1px #a4bec8;">
		
		<table border="0" cellpadding="0" cellspacing="0" width="600" style="border-collapse:collapse;background:#ffffff" id="list">
		<tr>
			<td class="list_title" width="80" align="center">定额编号</td>
			<td class="list_title" align="center">定额名称</td>
			<td class="list_title" width="60" align="left">单位</td>
		</tr>	
		<%	int counter=0;
			while(ro.next()){
			gd05 = (Gd05_b3j)ro.get(Gd05_b3j.class.getName());
			if(gd05!=null){
				++counter;		
		 %>
		<tr onmouseover="style.backgroundColor='#dce8ec'" onmouseout="style.backgroundColor='#ffffff'" onDblclick="selectCl(this)" title ="双击选择定额">
			<td  width="100" align="left"><%=gd05.getDebh()%><input type="hidden" name="Ga01_de.BH"  value="<%=gd05.getDebh()%>" ></td>
			<td align="left"><%=gd05.getDemc()%><input type="hidden" name="Ga01_de.MC" value="<%=gd05.getDemc()%>" ></td>
			<td width="60" align="center" ><%=StringFormatUtil.format(gd05.getDw())%>
				<input type="hidden" name="Ga01_de.DW" value="<%=StringFormatUtil.format(gd05.getDw())%>" >
				<input type="hidden" name="DeSl" value="<%=NumberFormatUtil.roundToString(gd05.getSl(),3)%>">
				<input type="hidden" name="Gd06_b3y.B3J_ID" value="<%=gd05.getId()%>" >
			</td>
		</tr>
		<%}}%>
	</table>
	</div>
	</form>
</body>
</html>
