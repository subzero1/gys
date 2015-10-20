<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.dataObject.Ga07_qfqj" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	String D1Value="";
	if(request.getParameter("D1")==null){
		D1Value=new String("ZCSBYJ");
	}else{
		D1Value=request.getParameter("D1");
	}
	QueryBuilder queryBuilder= new HibernateQueryBuilder(Ga07_qfqj.class);
	queryBuilder.eq("qjlb",D1Value);
	queryBuilder.addOrderBy(Order.asc("sx"));
	ResultObject ro = queryService.search(queryBuilder);
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>取费区间维护</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/list.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" src="../js/multiTableSave.js"></script>
<script type="text/javascript">
	function check1(){     
	  	document.form1.action="qfqjwh.jsp";
		document.form1.submit(); 		  
	} 
	function check2(){
		var obj=document.getElementById("formlist");
		for(var i=1;i<obj.rows.length;i++){
		  if(obj.rows[i].cells[0].children[0].value == ""){
		   obj.rows[i].cells[2].children[2].value = "" ;
		  }
		}
		if(listValidateChk("form1","Ga07_qfqj.SX")){
			document.form1.action="../afuer/Qfqj?D1=<%=D1Value%>";
			document.form1.submit();
		}	
	}
	function check3(){
		table=(document.getElementById("formlist")).children[0];
		var newRow = (table.rows[1]).cloneNode(true);
			newRow = table.rows[1].parentNode.insertAdjacentElement("beforeEnd",newRow);
			newRow.children[0].children[0].value = "";
			newRow.children[1].children[0].value = "";
			newRow.children[2].children[0].value = "";
			newRow.children[2].children[1].value = "";
			newRow.children[2].children[2].value = "<%=D1Value%>";
	}
	function del(obj){
		if(!window.confirm("删除区间时将删除关联的费率设置，确认删除吗？")){
  	 		return;
  	 	}else{
  	 		deleteRow(obj);
  	 	}
	}
</script>

<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" style="height:100%; background:#FFFFFF" scroll="yes">
<form name="form1" id="form1" method="post" action="">
<input type="hidden" name="dispatchStr" value="/system/qfqjwh.jsp">
<input type="hidden" name="perproty" value="D1">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga07_qfqj">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td background="../images/main-images/gypms_main_blue.png" height="30" valign="top" align="right">

	</td>
  </tr> 
  <tr>
  	<td height="20"></td>
  </tr>
  <tr>
    <td align="center" valign="top">
    	<table width="95%" height="24" border="0" cellpadding="0" cellspacing="0">
    		<tr>
    			<td><b>取费区间维护</b></td>
    		</tr>
    		<tr>
    			<td height="40" style="border:solid 1px #cccccc;background:#f2f7f9">
					<table width="100%" height="24" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="99%">
		 				    		<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
		 				    			<tr>
		 				    				<td width="10"></td>
			 				    			<td>			 				   
			 				    			<span style="border:1px solid #1E4F75;overflow:hidden;width:100%;">
												<select size="1" name="D1" style="margin:-1px;" onChange="check1()">
												<option value="ZCSBYJ" <%if(D1Value.equals("ZCSBYJ")){ %>selected<%} %>>主材设备运距</option>
												<option value="B2DQLC" <%if(D1Value.equals("B2DQLC")){ %>selected<%} %>>表二调遣里程</option>
												<option value="SBGCZGR" <%if(D1Value.equals("SBGCZGR")){ %>selected<%} %> >设备工程技工总工日</option>
												<option value="XLGDZGR"  <%if(D1Value.equals("XLGDZGR")){ %>selected<%} %> >线路管道技工总工日</option>
												<option value="GCF"  <%if(D1Value.equals("GCF")){ %>selected<%} %> >工程费</option>
												<option value="GCF_JL"  <%if(D1Value.equals("GCF_JL")){ %>selected<%} %> >工程费（监理)</option>
												<option value="QYGDJL" <%if(D1Value.equals("QYGDJL")){ %>selected<%} %> >施工现场与企业距离</option>
												</select>
											</span>
											</td>
			        					</tr>
			        				</table></td> 
							<td width="1%"></td>
						</tr>
					</table>							
				</td>
    		</tr>
    		<tr><td height="10"></td></tr>
    		<tr>
    			<td>
				    	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
 				    		<tr>
 				    			<td width="90%" height="20" style="background:url(../images/green-bg.gif);border-left:solid 1px #c8e0dc;border-right:solid 1px #c8e0dc;padding-left:5px;vertical-align:bottom">
 				    			</td>
 				    			<td width="30%" align="center"><input type="button" name=button value=" 添 加 " onclick="check3()"></td>
 				    			<td width="30%" align="center"><input name=button type="button" value=" 保 存 "   onclick="check2()"></td>
 				    		</tr>
 				    	</table> 
						<div style="width:100%;background:#d1e2dc;padding:5px;">
					        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;background:#ffffff" id="formlist">
					          <tr>
					            <td width="60" align="center">下限</td>
					            <td width="60" align="center">上限</td>
					            <td width="60" align="center">每增加</td>
					          </tr>
					          <%if(ro.getLength()==0){%>
						          <tr ondblclick="javascript:deleteRow(this)">
						            <td  align="center"><input type="text" name="Ga07_qfqj.XX" value="" class="td-input-noborder"></td>
						            <td  align="center"><input type="text" name="Ga07_qfqj.SX" value="" class="td-input-noborder"></td>
						            <td  align="center">
						            	<input type="text" name="Ga07_qfqj.MZJ" value="" class="td-input-noborder">
						            	<input type="hidden" name="Ga07_qfqj.ID" value="">
										<input type="hidden" name="Ga07_qfqj.QJLB" value="<%=D1Value%>">
						            </td>
						          </tr>
					           <%}%>
					           <%
					           Ga07_qfqj data;
					           while(ro.next()){
					        	   data=(Ga07_qfqj)ro.get(Ga07_qfqj.class.getName());
					        	   if(data!=null){
					          
					           %>
					           <tr ondblclick="del(this)" title="双击删除这一行">
					            <td  align="center"><input type="text" name="Ga07_qfqj.XX" value="<%if(data.getXx()!=null){out.print(data.getXx());}else{out.print("");}%>" class="td-input-noborder"></td>
					            <td  align="center"><input type="text" name="Ga07_qfqj.SX" value="<%if(data.getSx()!=null){out.print(data.getSx());}else{out.print("");}%>" class="td-input-noborder"></td>
					            <td  align="center">
					            	<input type="text" name="Ga07_qfqj.MZJ" value="<%if(data.getMzj()!=null){out.print(data.getMzj());}else{out.print("");} %>" class="td-input-noborder">
					            	<input type="hidden" name="Ga07_qfqj.ID" value="<%=data.getId() %>">
									<input type="hidden" name="Ga07_qfqj.QJLB" value="<%=D1Value%>">
					            </td>
					          </tr>
					          <%}else{ %>
					          <tr ondblclick="del(this)">
					            <td  align="center"><input type="text" name="Ga07_qfqj.XX" value="" class="td-input-noborder"></td>
					            <td  align="center"><input type="text" name="Ga07_qfqj.SX" value="" class="td-input-noborder"></td>
					            <td  align="center">
					            	<input type="text" name="Ga07_qfqj.MZJ" value="" class="td-input-noborder">
					            	<input type="hidden" name="Ga07_qfqj.ID" value="">
									<input type="hidden" name="Ga07_qfqj.QJLB" value="">
					            </td>
					          </tr>
					          <%}} %>				           
					           </table>
						</div>	   
				</td>
    		</tr>
    	</table>
    </td>
  </tr>
</table>
</div>
<input type="hidden" name="list_validate" value="下限:Ga07_qfqj.SX:NUMBER:20:1;上限:Ga07_qfqj.XX:NUMBER:20:1;每增加:Ga07_qfqj.MZJ:NUMBER:10:1;">
</form>
</body>
</html>