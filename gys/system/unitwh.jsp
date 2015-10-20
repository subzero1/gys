<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%@ page import="com.netsky.dataObject.Ga10_dwjjd"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="com.netsky.baseFormatUtils.*"%>
<%
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	String D1Value="";
	if(request.getParameter("D1")==null){
		D1Value=new String("ZC");
	}else{
		D1Value=request.getParameter("D1");
	}
	QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga10_dwjjd.class);
	queryBuilder.eq("lb",D1Value);	
	ResultObject ro = queryService.search(queryBuilder);
%>
<html>
	<head>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>计量单位维护</title>
		<script language="javascript" src="../js/functionlib.js"></script>
		<link href="../css/list.css" rel="stylesheet" type="text/css">
		<link href="../css/main.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../js/multiTableSave.js"></script>
		<script   language="JavaScript">   
		  function   check1()   
		  {     
  		  	document.form1.action="unitwh.jsp";
		  	document.form1.submit(); 		  
		  }  
		  function check2()
		  {   
		     var obj = document.getElementById("formlist");
		  	 for(var i=1;i<obj.rows.length;i++){
		  	  	if(obj.rows[i].cells[0].children[0].value == "" ){
		  	  	   obj.rows[i].cells[2].children[2].value = "" ;
		  	  	}
		  	 }
		  	 if(listValidateChk("form1","Ga10_dwjjd.DWMC")&&listValidateChk("form1","Ga10_dwjjd.JD")){
		  	 	document.form1.action="../afuer/dataWriter";
		     	document.form1.submit(); 
		     }
		  }	
		  function check3()
		  {
		    //var myNewRow = document.all.formlist.insertRow();   
			//document.all.formlist.appendChild(document.all.formlist.lastChild.cloneNode(true)); 
			
			table=(document.getElementById("formlist")).children[0];
		//	if(table.rows[1] != null){
				var newRow = (table.rows[1]).cloneNode(true);
				newRow = table.rows[1].parentNode.insertAdjacentElement("beforeEnd",newRow);
				newRow.children[0].children[0].value = "";
				newRow.children[1].innerText = "";
				newRow.children[2].children[0].value = "";
				newRow.children[2].children[1].value = "";
				newRow.children[2].children[2].value = "<%=D1Value%>";
		/*	}else{
				var objTR = table.insertRow();
				table.rows[1].insertCell(0);
				table.rows[1].insertCell(1);
				table.rows[1].insertCell(2);	
				table.rows[1].cells[0].insertChildren[0].value="";	
				table.rows[1].cells[1].innerText = "";	
				table.rows[1].cells[2].insertChildren[0].value="";	
				table.rows[1].cells[2].insertChildren[1].value="";	
				table.rows[1].cells[2].insertChildren[2].value="";				  
			}*/
		  }
		</script> 
		
	</head>
	<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0"style="height:100%; background:#FFFFFF" scroll="yes">
		<form name="form1" id="form1" method="post" action="">
		<input type="hidden" name="dispatchStr" value="/system/unitwh.jsp">
		<input type="hidden" name="perproty" value="D1">
		<input type="hidden" name="tableInfomation" value="noFatherTable:Ga10_dwjjd">
			<div align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td background="../images/main-images/gypms_main_blue.png"
							height="30" valign="top" align="right">
						</td>
					</tr>
					<tr>
						<td height="20"></td>
					</tr>
					<tr>
						<td align="center" valign="top">
							<table width="95%" height="24" border="0" cellpadding="0"cellspacing="0">
								<tr>
									<td>
										<b>计量单位维护</b>
									</td>
								</tr>
								<tr>
									<td height="40"
										style="border:solid 1px #cccccc;background:#f2f7f9">
										<table width="100%" height="24" border="0" cellpadding="0"
											cellspacing="0">
											<tr>
												<td width="99%">
													<table border="0" cellpadding="0" cellspacing="0"
														style="border-collapse:collapse;">
														<tr>
															<td width="10"></td>
															<td>
																<span
																	style="border:1px solid #1E4F75;overflow:hidden;width:100%;">
																	<select size="1" name="D1" style="margin:-1px;" onchange="check1()">
																		<option value="ZC" <%if(D1Value.equals("ZC")) {%>selected<%}%> >主材单位</option>
																		<option value="SB" <%if(D1Value.equals("SB")) {%>selected<%}%> >设备单位</option>
																		<option value="DE" <%if(D1Value.equals("DE")) {%>selected<%}%>>定额单位</option>
																		<option value="DEJSDW" <%if(D1Value.equals("DEJSDW")) {%>selected<%}%>>定额中技术参数单位</option>
																		<option value="CCGH" <%if(D1Value.equals("CCGH")) {%>selected<%}%>>拆除更换替换单位</option>
																	</select> 
																</span>
															</td>
														</tr>
													</table>
												</td>
												<td width="1%"></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td height="10"></td>
								</tr>
								<tr>
									<td align="center">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
											<tr>
												<td width="92%" height="20"
													style="background:url(../images/green-bg.gif);border-left:solid 1px #c8e0dc;border-right:solid 1px #c8e0dc;padding-left:5px;vertical-align:bottom">
												</td>
												<td width="30%" align="center"><input type="button" name=button value=" 添 加 " onclick="check3()"> </td>
												<td width="30%" align="center"><input type="button" name=button value=" 保 存 " onclick="check2()"> </td>
											</tr>
										</table>
										<div style="width:100%;background:#d1e2dc;padding:5px;">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;background:#ffffff" id="formlist">
												<tr>
													<td  align="center">单位名称</td>
													<td align="center">是否取整</td>
													<td  align="center">小数位数</td>
												</tr>
												<%
												if(ro.getLength()==0){
												for (int i = 0; i < 1; i++) {
												%>
												<tr ondblclick="javascript:deleteRow(this)">
													<td align="center"><input type="text" name="Ga10_dwjjd.DWMC" value="" class="td-input-noborder"></td>
													<td align="center"><input type="text" name="" value="" class="td-input-noborder" readOnly></td>
													<td align="center">
														<input type="text" name="Ga10_dwjjd.JD" value="" class="td-input-noborder">
														<input type="hidden" name="Ga10_dwjjd.ID" value="">
														<input type="hidden" name="Ga10_dwjjd.LB" value="<%=D1Value%>">
													</td>
												</tr>
												<%
												}}
												%>
												<%
												
												Ga10_dwjjd data;
												String isqz;
												
													while (ro.next()) {
														data = (Ga10_dwjjd) ro.get(Ga10_dwjjd.class.getName());
														if (data != null) {
															data.setLb(D1Value);
															isqz = "111";
															if (data.getJd().intValue() == 0) {
																isqz = new String("是");
															} else {
																isqz = new String("否");
															}
												%>
												<tr ondblclick="javascript:deleteRow(this)" title="双击删除这一行">
													<td  align="center"><input type="text" name="Ga10_dwjjd.DWMC" class="td-input-noborder"" value="<%=StringFormatUtil.format(data.getDwmc())%>"></td>
													<td  align="center"><input type="text" name="" value="<%=isqz%>" readOnly class="td-input-noborder"></td>
													<td  align="center">
														<input type="text" name="Ga10_dwjjd.JD" value="<%=data.getJd()%>"class="td-input-noborder">
													 	<input type="hidden" name="Ga10_dwjjd.ID" value="<%=data.getId()%>">
													 	<input type="hidden" name="Ga10_dwjjd.LB" value="<%=D1Value%>">
													</td>
													
												</tr>
												<%
												} else {
												%>
												<tr ondblclick="javascript:deleteRow(this)">
													<td align="center"><input  type="text" name="Ga10_dwjjd.DWMC" class="td-input-noborder" value=""></td>
													<td align="center"><input  type="text" name="" value=""  class="td-input-noborder" readOnly></td>
													<td align="center">
														<input  type="text" name="Ga10_dwjjd.JD" value=""class="td-input-noborder">
														<input type="hidden" name="Ga10_dwjjd.ID" value="">
														<input type="hidden" name="Ga10_dwjjd.LB" value="">
													</td>													
												</tr>
												<%
													}
													}
												%>
											</table>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="list_validate" value="单位名称:Ga10_dwjjd.DWMC:VARCHAR:30:0;小数位数:Ga10_dwjjd.JD:NUMBER:1:0;">
		</form>
	</body>
</html>
