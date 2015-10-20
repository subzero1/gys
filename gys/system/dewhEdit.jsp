<%@ page language="java" pageEncoding="GBK" %>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseObject.QueryBuilder" %>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>  
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.dataObject.Ga02_clsb" %>
<%@ page import="com.netsky.dataObject.Ga03_glcl" %>
<%@ page import="com.netsky.dataObject.Ga01_de" %>
<%@ page import="com.netsky.dataObject.Gb05_yhk" %>
<%@page import="com.netsky.dataObject.Gb01_yhb"%>
<%
Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
if(yh==null){
	%>
	<script language="javascript">
	window.location.href="../index.jsp";
	</script>
	<%
	return;
}
request.setCharacterEncoding("gb2312");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
Ga01_de ga01;
String HSql;
ResultObject ro;
Ga01_de list_ga01;
Ga02_clsb list_ga02;
Ga03_glcl list_ga03;
if(request.getParameter("de_id") != null){
	ga01 = (Ga01_de) queryService.searchById(Ga01_de.class,Integer.valueOf(request.getParameter("de_id")));	
}else{
	ga01 = new Ga01_de();
}
String ga01_id = "-1";
if(ga01.getId() != null){
	ga01_id = ga01.getId().toString();
}
%>
<html>

<head>
<title>系统定额维护</title>
<link href="../css/main.css" rel="stylesheet">
<script language="javascript" src="../js/functionlib.js"></script>
<script language="javascript">
function showsetting(obj){
	var tt =document.getElementById("tab1").style.display

	for(j=1;j<5;j++)
	{if(j==obj)
	{document.getElementById("tab"+j).style.display="";	
	}
	else{
	document.getElementById("tab"+j).style.display="none";}}	
	}
	
function setCard(){
	dewhTable.cells[0].style.background="url(../images/light-bg.gif)";
	dewhTable.cells[0].style.color="#1e4f75"
	dewhTable.cells[0].style.cursor="hand"
	for(i=1;i<dewhTable.cells.length-1;i++){
		dewhTable.cells[i].style.background="url(../images/white-bg.gif)";
		dewhTable.cells[i].style.color="#8c8c8c"
		dewhTable.cells[i].style.cursor="hand"
	}
}
function secCard(n)
{
	for(i=0;i<dewhTable.cells.length-1;i++) {
		if(i != n) {
			dewhTable.cells[i].style.background="url(../images/white-bg.gif)";
			dewhTable.cells[i].style.color="#8c8c8c"
		}else{
			dewhTable.cells[i].style.background="url(../images/light-bg.gif)";
			dewhTable.cells[i].style.color="#1e4f75"
		}
	}
}
function deleteRow(row){
	row.children[0].innerText = "";
	row.children[1].innerText = "";
	row.children[2].innerText = "";
	row.children[3].innerText = "";
	row.children[4].children[0].value = "";
	row.children[4].children[0].readOnly = true;
	row.children[4].children[1].value = "";
	row.children[4].children[2].value = "";
	row.children[4].children[3].value = "";
	row.children[4].children[5].value = "";
	row.children[4].children[6].value = "";
}
function setDEK(dek_str){
	obj = document.getElementsByName("dek_id");
	for(var i = 0; i < obj.length; i++){
		if(dek_str.indexOf("[" + obj[i].value + "]") != -1){
			obj[i].checked = true;
		}
	}
}
function selectDEK(){
	document.all.DEK.value = "";
	obj = document.getElementsByName("dek_id");
	for(var i = 0; i < obj.length; i++){
		if(obj[i].checked == true){
			document.all.DEK.value += "[" + obj[i].value + "]";
		}
	}
}

function form1Save(){
	var de_bh = document.getElementById("Ga01_de.BH").value;
	clbhs  = document.getElementsByName("Ga03_glcl.CL_BH");
	debhs  = document.getElementsByName("Ga03_glcl.DE_BH");
	for(var i = 0; i < clbhs.length; i++){
		if(clbhs[i].value != ""){
			debhs[i].value = de_bh;
		}
	}
	document.form1.submit();
}

</script>
</head>
<body topmargin="0" leftmargin="0" id="main-body" onLoad="setCard()">
<form name="form1" method="post" action="../afuer/dataWriter">
<input type="hidden" name="dispatchStr" value="/system/dewhEdit.jsp">
<input type="hidden" name="perproty" value="de_id,Ga01_de,ID">
<input type="hidden" name="tableInfomation" value="noFatherTable:Ga01_de">
<input type="hidden" name="tableInfomation" value="Ga01_de,ID,DE_ID:Ga03_glcl">
<input type="hidden" name="VALIDATE" value="定额名称:Ga01_de.MC:VARCHAR2:200:N;定额编号:Ga01_de.BH:VARCHAR2:20:N;定额单位:Ga01_de.DW:VARCHAR2:20:N;技工工日:Ga01_de.JGGR:NUMBER:12.2:N;普工工日:Ga01_de.PGGR:NUMBER:12.2:N;备注:Ga01_de.BZ:VARCHAR2:200:Y;">
<%
if(ga01.getId() != null){
%>
<input type="hidden" name="Ga01_de.ID" value="<%=ga01.getId()%>">
<%
}else{
%>
<input type="hidden" name="Ga01_de.ID" value="">
<%
}
%>
<div align="center">
	<table width="98%" border="0"  cellspacing="0" cellpadding="0">
		<tr>
	        <td height="21"></td>
        </tr>
        <tr>
	        <td height="40">
		        <table width="100%" height="40" border="0"  cellpadding="0" cellspacing="0">
			        <tr>
				        <td width="10"><img src="../images/main-images/gypms_main_bar_left.gif" width="10" height="40"></td>
			         	 <td valign="bottom" background="../images/main-images/gypms_main_bar_bg.gif">
				        	<table height="30" border="0" cellpadding="0" cellspacing="0">
					                <tr>
					                	<td width="20"><img src="../images/main-images/dot.png" width="18" height="18"></td>
					                	<td width="100"><b>系统定额维护</b></td>
					        			</tr>
				        		</table>
			        	</td>
	                	<td align="right" valign="top" background="../images/main-images/gypms_main_bar_bg.gif">
		                	<table height="30" border="0" cellpadding="0" cellspacing="0" id="form-button">
							  <tr>
								<td width="35" align="center"><img src="../images/button-images/save.gif" border="0"></td>
								<td width="60" valign="bottom"><a href="javascript:if(validateChk('form1')){form1Save();}" title="保存对当前文档的修改（新建）"><span class="autoform-button">保 存</span></a> </td>
								<td width="35" align="center"><img src="../images/button-images/close.gif" border="0"></td>
								<td width="60" valign="bottom"><a href="javascript:window.close()" title="关闭当前文档" title="关闭当前文档"><span class="autoform-button">关 闭</span></a> </td>
								<td width="5" align="center"></td>
							  </tr> 
							</table>
		                </td>
				         <td width="10"><img src="../images/main-images/gypms_main_bar_right.gif" width="10" height="40"></td>
			        </tr>
		        </table>
	        </td>
        </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" width="98%" id="mainTable">
        <tr>
	        <td align="center" id="main-data" height="70" valign="middle">
				
	        <table border="0" cellpadding="3" cellspacing="0" style="border-collapse:collapse;height:14px;" width="95%">
			        <tr>
						<td colspan="7">&nbsp;</td>
					</tr>
	        		<tr>
	        			<td align="right">定额编号：</td>
	        			<td><input type="text" name="Ga01_de.BH" id="Ga01_de.BH" value="<%=StringFormatUtil.format(ga01.getBh())%>" class="td-input"></td>
	        			<td align="right">定额名称：</td>
	        			<td colspan="3"><input type="text" name="Ga01_de.MC" value="<%=StringFormatUtil.format(ga01.getMc())%>" class="td-input"></td>
	        			<td></td>
	        		</tr>
	        		<tr>
	        			<td width="12%" align="right">定额单位：</td>
	        			<td width="20%"><input type="text" name="Ga01_de.DW" value="<%=StringFormatUtil.format(ga01.getDw())%>" class="td-input"></td>
	        			<td width="12%" align="right">技工工日：</td>
	        			<td width="20%"><input type="text" name="Ga01_de.JGGR" value="<%=NumberFormatUtil.roundToString(ga01.getJggr())%>" class="td-input"></td>
	        			<td width="12%" align="right">普工工日：</td>
	        			<td width="20%"><input type="text" name="Ga01_de.PGGR" value="<%=NumberFormatUtil.roundToString(ga01.getPggr())%>" class="td-input"></td>
	        			<td width="4%"></td>
	        		</tr>
	        		<tr>
	        			<td align="right" height="28">定额库：</td>
	        			<td colspan="5">
	        			<select name="Ga01_de.DEK_ID" <%if(ga01.getDek_id()!=null&&ga01.getDek_id().intValue() == 1){out.print("disabled");} %>>
	        			<%
	        			HSql = "select gb05 from Gb05_yhk gb05 where gb05.lb='DE' and (id = 1 or cjr_id = " + yh.getId() + " or gxbz = 1)";
	        			ro = queryService.search(HSql);
	        			while(ro.next()){
	        				Gb05_yhk gb05 = (Gb05_yhk) ro.get("gb05");
	        				%>
	        				<option value="<%=gb05.getId() %>" <%if(gb05.getId()!=null&&ga01.getDek_id()!=null&&gb05.getId().intValue() == ga01.getDek_id().intValue()){out.print("selected");} %>><%=gb05.getMc() %></option>
	        				<%
	        			}
	        			%>
	        			</select>
	        			</td>
	        			<td></td>
	        		</tr>
	        		<tr>
	        			<td align="right" height="28">备注：</td>
	        			<td colspan="5"><input type="textarea" name="Ga01_de.BZ" value="<%=StringFormatUtil.format(ga01.getBz())%>" class="td-textarea"></td>
	        			<td></td>
	        		</tr>
		        
          </table>          
    <div style="width:98%;background:#ffffff">
      <p>&nbsp;</p>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" id="dewhTable" height="25">
        <tr>
          <td width="106" align="center" onClick="showsetting(1);secCard(0)">关联主材</td>
          <td width="106" align="center" onClick="showsetting(2);secCard(1);">关联机械</td>
          <td width="106" align="center" onClick="showsetting(3);secCard(2);">关联仪表仪器</td>
          <td width="106" align="center" onClick="showsetting(4);secCard(3);">关联设备</td>
          <td>&nbsp;</td>
        </tr>		
      </table>
      <div style="width:98%;background:#d1e2dc;padding:5px;"> 
      <div id="tab1" style="display:block;">
        <table name="tab1" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;background:#ffffff" id="form-list">
          <tr>
            <td width="60" align="center">材料编码</td>
            <td align="center">主材名称<a href="javascript:winOpen('clxz.jsp?type=tab1','600','300','1');" title="添加"><img src="../images/addrow.gif" border="0"/></a></td>
            <td width="200" align="center">型号规格</td>
            <td width="50" align="center">单位</td>
            <td width="90" align="center">材料数量</td>
          </tr>
          <%
      	  HSql = "select ga01,ga02,ga03 from Ga01_de ga01,Ga02_clsb ga02,Ga03_glcl ga03 where ga01.bh = ga03.de_bh and ga02.bh = ga03.cl_bh and ga02.lb = 'ZC' and ga01.id = " + ga01_id;
      	  ro = queryService.search(HSql);
      	  %>
          <%
          int i = 0;
          while(ro.next() || i < 6){
          	i++;
          	list_ga01 = (Ga01_de) ro.get("ga01");
          	list_ga02 = (Ga02_clsb) ro.get("ga02");
          	list_ga03 = (Ga03_glcl) ro.get("ga03");
          	if(list_ga01 != null){
	          %>
	          <tr onDblClick="javascript:deleteRow(this);">
	            <td align="center"><%=StringFormatUtil.format(list_ga02.getBh())%></td>
	            <td><%=StringFormatUtil.format(list_ga02.getMc())%></td>
	            <td><%=StringFormatUtil.format(list_ga02.getXhgg())%></td>
	            <td align="center"><%=StringFormatUtil.format(list_ga02.getDw())%></td>
	            <td>
	            	<input type="text" name="Ga03_glcl.CLSL" value="<%=NumberFormatUtil.roundToString(list_ga03.getClsl(),3)%>" class="td-input-noborder">
	            	<input type="hidden" name="Ga03_glcl.XH" value="<%=StringFormatUtil.format(list_ga03.getXh())%>">
	            	<input type="hidden" name="Ga03_glcl.CL_ID" value="<%=list_ga03.getCl_id()%>">
	            	<input type="hidden" name="Ga03_glcl.DE_ID" value="<%=list_ga03.getDe_id()%>">
	            	<input type="hidden" name="Ga03_glcl.ID" value="<%=list_ga03.getId()%>">
	            	<input type="hidden" name="Ga03_glcl.DE_BH" value="<%=list_ga03.getDe_bh()%>">
	            	<input type="hidden" name="Ga03_glcl.CL_BH" value="<%=list_ga03.getCl_bh()%>">
	            	
	            </td>
	          </tr>
	          <%
	      	}else{
	      		%>
	      		<tr>
	            <td align="center"></td>
	            <td></td>
	            <td></td>
	            <td align="center"></td>
	            <td>
	            	<input type="text" name="Ga03_glcl.CLSL" value="" class="td-input-noborder" readOnly>
	            	<input type="hidden" name="Ga03_glcl.XH" value="">
	            	<input type="hidden" name="Ga03_glcl.CL_ID" value="">
	            	<input type="hidden" name="Ga03_glcl.DE_ID" value="">
	            	<input type="hidden" name="Ga03_glcl.ID" value="">
	            	<input type="hidden" name="Ga03_glcl.DE_BH" value="">
	            	<input type="hidden" name="Ga03_glcl.CL_BH" value="">
	            	
	            </td>
	          </tr>
	      	<%
	      	}
          }
          %>
        </table>
      </div>
      <div  id="tab2" style="display:none;">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;background:#ffffff" id="form-list">
          <tr>
            <td width="60" align="center">机械编码</td>
            <td align="center">机械名称<a href="javascript:winOpen('clxz.jsp?type=tab2','600','300','1');" title="添加"><img src="../images/addrow.gif" border="0"/></a></td>
            <td width="120" align="center">型号规格</td>
            <td width="50" align="center">单位</td>
            <td width="80" align="center">材料数量</td>
          </tr>
          <%
      	  HSql = "select ga01,ga02,ga03 from Ga01_de ga01,Ga02_clsb ga02,Ga03_glcl ga03 where ga01.bh = ga03.de_bh and ga02.bh = ga03.cl_bh and ga02.lb = 'JX' and ga01.id = " + ga01_id;
      	  ro = queryService.search(HSql);
      	  %>
          <%
          i = 0;
          while(ro.next() || i < 6){
          	i++;
          	list_ga01 = (Ga01_de) ro.get("ga01");
          	list_ga02 = (Ga02_clsb) ro.get("ga02");
          	list_ga03 = (Ga03_glcl) ro.get("ga03");
          	if(list_ga01 != null){
	          %>
	          <tr onDblClick="javascript:deleteRow(this);">
	            <td align="center"><%=StringFormatUtil.format(list_ga02.getBh())%></td>
	            <td><%=StringFormatUtil.format(list_ga02.getMc())%></td>
	            <td><%=StringFormatUtil.format(list_ga02.getXhgg())%></td>
	            <td align="center"><%=StringFormatUtil.format(list_ga02.getDw())%></td>
	            <td>
	            	<input type="text" name="Ga03_glcl.CLSL" value="<%=NumberFormatUtil.roundToString(list_ga03.getClsl(),3)%>" class="td-input-noborder">
	            	<input type="hidden" name="Ga03_glcl.XH" value="<%=StringFormatUtil.format(list_ga03.getXh())%>">
	            	<input type="hidden" name="Ga03_glcl.CL_ID" value="<%=list_ga03.getCl_id()%>">
	            	<input type="hidden" name="Ga03_glcl.DE_ID" value="<%=list_ga03.getDe_id()%>">
	            	<input type="hidden" name="Ga03_glcl.ID" value="<%=list_ga03.getId()%>">
	            	<input type="hidden" name="Ga03_glcl.DE_BH" value="<%=list_ga03.getDe_bh()%>">
	            	<input type="hidden" name="Ga03_glcl.CL_BH" value="<%=list_ga03.getCl_bh()%>">
	            	
	            </td>
	          </tr>
	          <%
	      	}else{
	      		%>
	      		<tr>
	            <td align="center"></td>
	            <td></td>
	            <td></td>
	            <td align="center"></td>
	            <td>
	            	<input type="text" name="Ga03_glcl.CLSL" value="" class="td-input-noborder" readOnly>
	            	<input type="hidden" name="Ga03_glcl.XH" value="">
	            	<input type="hidden" name="Ga03_glcl.CL_ID" value="">
	            	<input type="hidden" name="Ga03_glcl.DE_ID" value="">
	            	<input type="hidden" name="Ga03_glcl.ID" value="">
	            	<input type="hidden" name="Ga03_glcl.DE_BH" value="">
	            	<input type="hidden" name="Ga03_glcl.CL_BH" value="">
	            	
	            </td>
	          </tr>
	      	<%
	      	}
          }
          %>
        </table>
      </div>
      <div  id="tab3" style="display:none;">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;background:#ffffff" id="form-list">
          <tr>
            <td width="60" align="center">仪表编码</td>
            <td align="center">仪表名称<a href="javascript:winOpen('clxz.jsp?type=tab3','600','300','1');" title="添加"><img src="../images/addrow.gif" border="0"/></a></td>
            <td width="120" align="center">型号规格</td>
            <td width="50" align="center">单位</td>
            <td width="80" align="center">材料数量</td>
          </tr>
          <%
      	  HSql = "select ga01,ga02,ga03 from Ga01_de ga01,Ga02_clsb ga02,Ga03_glcl ga03 where ga01.bh = ga03.de_bh and ga02.bh = ga03.cl_bh and ga02.lb = 'YB' and ga01.id = " + ga01_id;
      	  ro = queryService.search(HSql);
      	  %>
          <%
          i = 0;
          while(ro.next() || i < 6){
          	i++;
          	list_ga01 = (Ga01_de) ro.get("ga01");
          	list_ga02 = (Ga02_clsb) ro.get("ga02");
          	list_ga03 = (Ga03_glcl) ro.get("ga03");
          	if(list_ga01 != null){
	          %>
	          <tr onDblClick="javascript:deleteRow(this);">
	            <td align="center"><%=StringFormatUtil.format(list_ga02.getBh())%></td>
	            <td><%=StringFormatUtil.format(list_ga02.getMc())%></td>
	            <td><%=StringFormatUtil.format(list_ga02.getXhgg())%></td>
	            <td align="center"><%=StringFormatUtil.format(list_ga02.getDw())%></td>
	            <td>
	            	<input type="text" name="Ga03_glcl.CLSL" value="<%=NumberFormatUtil.roundToString(list_ga03.getClsl(),3)%>" class="td-input-noborder">
	            	<input type="hidden" name="Ga03_glcl.XH" value="<%=StringFormatUtil.format(list_ga03.getXh())%>">
	            	<input type="hidden" name="Ga03_glcl.CL_ID" value="<%=list_ga03.getCl_id()%>">
	            	<input type="hidden" name="Ga03_glcl.DE_ID" value="<%=list_ga03.getDe_id()%>">
	            	<input type="hidden" name="Ga03_glcl.ID" value="<%=list_ga03.getId()%>">
	            	<input type="hidden" name="Ga03_glcl.DE_BH" value="<%=list_ga03.getDe_bh()%>">
	            	<input type="hidden" name="Ga03_glcl.CL_BH" value="<%=list_ga03.getCl_bh()%>">
	            	
	            </td>
	          </tr>
	          <%
	      	}else{
	      		%>
	      		<tr>
	            <td align="center"></td>
	            <td></td>
	            <td></td>
	            <td align="center"></td>
	            <td>
	            	<input type="text" name="Ga03_glcl.CLSL" value="" class="td-input-noborder" readOnly>
	            	<input type="hidden" name="Ga03_glcl.XH" value="">
	            	<input type="hidden" name="Ga03_glcl.CL_ID" value="">
	            	<input type="hidden" name="Ga03_glcl.DE_ID" value="">
	            	<input type="hidden" name="Ga03_glcl.ID" value="">
	            	<input type="hidden" name="Ga03_glcl.DE_BH" value="">
	            	<input type="hidden" name="Ga03_glcl.CL_BH" value="">
	                	
	            </td>
	          </tr>
	      	<%
	      	}
          }
          %>
        </table>
      </div>
      <div  id="tab4" style="display:none;">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;background:#ffffff" id="form-list">
          <tr>
            <td width="60" align="center">设备编码</td>
            <td align="center">设备名称<a href="javascript:winOpen('clxz.jsp?type=tab4','600','300','1');" title="添加"><img src="../images/addrow.gif" border="0"/></a></td>
            <td width="120" align="center">型号规格</td>
            <td width="50" align="center">单位</td>
            <td width="80" align="center">材料数量</td>
          </tr>
          <%
      	  HSql = "select ga01,ga02,ga03 from Ga01_de ga01,Ga02_clsb ga02,Ga03_glcl ga03 where ga01.bh = ga03.de_bh and ga02.bh = ga03.cl_bh and ga02.lb = 'SB' and ga01.id = " + ga01_id;
      	  ro = queryService.search(HSql);
      	  %>
          <%
          i = 0;
          while(ro.next() || i < 6){
          	i++;
          	list_ga01 = (Ga01_de) ro.get("ga01");
          	list_ga02 = (Ga02_clsb) ro.get("ga02");
          	list_ga03 = (Ga03_glcl) ro.get("ga03");
          	if(list_ga01 != null){
	          %>
	          <tr onDblClick="javascript:deleteRow(this);">
	            <td align="center"><%=StringFormatUtil.format(list_ga02.getBh())%></td>
	            <td><%=StringFormatUtil.format(list_ga02.getMc())%></td>
	            <td><%=StringFormatUtil.format(list_ga02.getXhgg())%></td>
	            <td align="center"><%=StringFormatUtil.format(list_ga02.getDw())%></td>
	            <td>
	            	<input type="text" name="Ga03_glcl.CLSL" value="<%=NumberFormatUtil.roundToString(list_ga03.getClsl(),3)%>" class="td-input-noborder">
	            	<input type="hidden" name="Ga03_glcl.XH" value="<%=StringFormatUtil.format(list_ga03.getXh())%>">
	            	<input type="hidden" name="Ga03_glcl.CL_ID" value="<%=list_ga03.getCl_id()%>">
	            	<input type="hidden" name="Ga03_glcl.DE_ID" value="<%=list_ga03.getDe_id()%>">
	            	<input type="hidden" name="Ga03_glcl.ID" value="<%=list_ga03.getId()%>">
	            	<input type="hidden" name="Ga03_glcl.DE_BH" value="<%=list_ga03.getDe_bh()%>">
	            	<input type="hidden" name="Ga03_glcl.CL_BH" value="<%=list_ga03.getCl_bh()%>">
	            	
	            </td>
	          </tr>
	          <%
	      	}else{
	      		%>
	      		<tr>
	            <td align="center"></td>
	            <td></td>
	            <td></td>
	            <td align="center"></td>
	            <td>
	            	<input type="text" name="Ga03_glcl.CLSL" value="" class="td-input-noborder" readOnly>
	            	<input type="hidden" name="Ga03_glcl.XH" value="">
	            	<input type="hidden" name="Ga03_glcl.CL_ID" value="">
	            	<input type="hidden" name="Ga03_glcl.DE_ID" value="">
	            	<input type="hidden" name="Ga03_glcl.ID" value="">
	            	<input type="hidden" name="Ga03_glcl.DE_BH" value="">
	            	<input type="hidden" name="Ga03_glcl.CL_BH" value="">
	            	
	            </td>
	          </tr>
	      	<%
	      	}
          }
          %>
        </table>
      </div>
    </div>
	<div style="height:20px;background:#ffffff"></div> 
	</div>   
	</td>
        </tr>
    </table>	
</div>
</form>
</body>

</html>
