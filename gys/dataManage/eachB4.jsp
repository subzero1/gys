<%@ page language="java" pageEncoding="GBK" %>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.dataObject.Gb03_bgxx" %>
<%@ page import="com.netsky.dataObject.Gd07_b4" %>
<%@ page import="java.util.*" %>
<%
	String gcxm_id = request.getParameter("gcxm_id");
	String dxgc_id = request.getParameter("dxgc_id");
	String lyb ="";
	if(request.getParameter("lyb")!=null){
		lyb = request.getParameter("lyb");
	}
	String mbb = "";
	if(request.getParameter("mbb1")!=null){
		mbb= request.getParameter("mbb1");
	}
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	
	QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb03_bgxx.class);
    ResultObject ro = queryService.search(queryBuilder);
    Gb03_bgxx bgxx = new Gb03_bgxx();
    List list = new ArrayList();
    while(ro.next()){
    	bgxx = (Gb03_bgxx)ro.get(Gb03_bgxx.class.getName());
    	if(bgxx.getBgbh().startsWith("B4J")){
    		list.add(bgxx);
    	}
    }  
%>
<html>
<head>
<title></title>
<link href="../css/page.css" rel="stylesheet">
<script language="javascript" src="../js/selectItem.js"></script>
<script language="javascript">
function changely(){
	var ly = document.form1.lyb.value;
	if(ly=="B4JXASB"||ly=="B4JBXASB"||ly=="B4JBPBJ"||ly=="B4JWHQJ"){
		document.getElementById("flag").value="0";
	}else{
		document.getElementById("flag").value="1";
	}
	document.form1.action="eachB4.jsp?lyb="+ly+"&gcxm_id="+<%=gcxm_id%>+"&dxgc_id="+<%=dxgc_id%>;
	document.form1.submit();
}
function confirmb(){

	document.form1.action="../afuer/EachB4?gcxm_id="+<%=gcxm_id%>+"&dxgc_id="+<%=dxgc_id%>;
	document.form1.submit();
	//alert("操作成功！");
}
</script>
</head>
<body topmargin="0" leftmargin="0" id="main-body"  scroll="yes">
<form name="form1" method="post" action="">
<input type="hidden" name="flag" id="flag" value="0">
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
						                	<td>表四数据互导</td>
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
		       
		        	<table border="0" cellpadding="0" style="border-collapse:collapse;height:14px;" >
				    
						<tr style="height:30px;">
							<td width="30"></td>
							<td align="right">来源表选择：</td>
							<td>
								<select name="lyb"  style="width:150px;" onchange="changely()">
						    	<%
						    		
						    		Gb03_bgxx []results = (Gb03_bgxx[])list.toArray(new Gb03_bgxx[list.size()]);
						    		for(int i=0;i<results.length;i++){
								    	out.print("<option value='"+results[i].getBgbh()+"'>"+results[i].getFbt()+"</option>");
							    	}
							 	%>
						    	</select>
						    	<script type="text/javascript">
						    		<%
						    			if(!lyb.equals("")){
						    				out.println("form1.lyb.value='"+lyb+"';");
						    			}
						    		%>
						    	</script>
							</td>
							<td width="60"></td>
							<td  align="right">目标表选择：</td>
							<td>
								<select name="mbb" style="width:150px;">
								<%
									if(request.getParameter("flag")==null||request.getParameter("flag").equals("0")){
										for(int i=0;i<results.length;i++){
											if(results[i].getB4lb().equals("SB")){
												out.print("<option value='"+results[i].getBgbh()+"'>"+results[i].getFbt()+"</option>");
											}
										}
									}else if(request.getParameter("flag").equals("1")){
										for(int i=0;i<results.length;i++){
											if(results[i].getB4lb().equals("ZC")){
												out.print("<option value='"+results[i].getBgbh()+"'>"+results[i].getFbt()+"</option>");
											}
										}
									}
								 %>
								</select>	
								<script type="text/javascript">
						    		<%
						    			if(!mbb.equals("")){
						    				out.println("form1.mbb.value='"+mbb+"';");
						    			}
						    		%>
						    	</script>							
							</td>
						</tr>
						<tr>						
						</tr>
			        </table>		   
		        </td>
	        </tr>
        </table>
	<table border="0" cellpadding="0" cellspacing="0" width="600" style="border-collapse:collapse;background:#ffffff" id="list">
		<tr>
			<td class="list_title" width="25"></td>
			<td class="list_title" width="80" align="center">编号</td>
			<td class="list_title" align="center">名称</td>
			<td class="list_title" align="center">规格型号</td>
			<td class="list_title" width="60" align="center">单位</td>
		</tr>
		<%				
			if(lyb.equals("")){
				lyb="B4JXASB";
			}
			QueryBuilder queryBuilder3 = new HibernateQueryBuilder(Gd07_b4.class);
			queryBuilder3.eq("bgbh",lyb);
			queryBuilder3.eq("dxgc_id",new Integer(dxgc_id));
			ResultObject ro3 = queryService.search(queryBuilder3);
			int i=0;
			while(ro3.next()||i<15){
				i++;
				Gd07_b4 data3 = (Gd07_b4)ro3.get(Gd07_b4.class.getName());
					if(data3!=null){
		%>
		<tr onMouseOver="this.style.backgroundColor='#dce8ec'" onMouseOut="this.style.backgroundColor=''">
				<td><input type="checkbox" name="ids" value="<%=data3.getId()%>"></td>
				<td align="center"><%=data3.getBh()%></td>
				<td><%=data3.getMc()%></td>
				<td><%if(data3.getXhgg()!=null){out.print(data3.getXhgg());}else{out.print("");}%></td>
				<td align="center"><%if(data3.getDw()!=null){out.print(data3.getDw());}else{out.print("");}%></td>
		</tr>
		<%}else{%>
		<tr onMouseOver="this.style.backgroundColor='#dce8ec'" onMouseOut="this.style.backgroundColor=''">
				<td></td>
				<td align="center"></td>
				<td></td>
				<td></td>
				<td align="center"></td>
		</tr>
		<%}}%>
	</table>
	<table   width="600" border="0" cellspacing="0" cellpadding="0">
		<tr bgcolor="#f8f8f8" height="28" valign="middle" style="border:solid 1px #a4bec8;">
			<td align="center"><input type="button" name="" value=" 确认 " onclick="confirmb()"></td>
		</tr>
	</table>	
</div>
</form>
</body>
</html>
