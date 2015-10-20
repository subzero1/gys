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
<%@ page import="com.netsky.dataObject.Ga00_zclb" %>
<%@page import="com.netsky.dataObject.Gb05_yhk;"%>
<%
request.setCharacterEncoding("gb2312");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
Ga02_clsb ga02;
Gb05_yhk gb05;
if(request.getParameter("de_id") != null){
	ga02 = (Ga02_clsb) queryService.searchById(Ga02_clsb.class,Integer.valueOf(request.getParameter("de_id")));	
}else{
	ga02 = new Ga02_clsb();
}
String lb=request.getParameter("lb");
%>

<html>

<head>
<title>ϵͳ����ά��</title>
<link href="../css/main.css" rel="stylesheet">
<script language="javascript" src="../js/functionlib.js"></script>
<script language="javascript">
function setCLK(clk_str){
	obj = document.getElementsByName("clk_id");
	for(var i = 0; i < obj.length; i++){
		if(clk_str.indexOf("[" + obj[i].value + "]") != -1){
			obj[i].checked = true;
		}
	}
}
function selectCLK(){
	document.all.CLK.value = "";
	obj = document.getElementsByName("clk_id");
	for(var i = 0; i < obj.length; i++){
		if(obj[i].checked == true){
			document.all.CLK.value += "[" + obj[i].value + "]";
		}
	}
}
</script>
</head>
<body topmargin="0" leftmargin="0" id="main-body">
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
					                	<td width="100"><b>ϵͳ����ά��</b></td>
					        			</tr>
				        		</table>
			        	</td>
	                	<td align="right" valign="top" background="../images/main-images/gypms_main_bar_bg.gif">
		                	<table height="30" border="0" cellpadding="0" cellspacing="0" id="form-button">
							  <tr>
								<td width="35" align="center"><img src="../images/button-images/save.gif" border="0"></td>
								<td width="60" valign="bottom"><a href="javascript:if(validateChk('form1')){document.form1.submit();}" title="����Ե�ǰ�ĵ����޸ģ��½���"><span class="autoform-button">�� ��</span></a> </td>
								<td width="35" align="center"><img src="../images/button-images/close.gif" border="0"></td>
								<td width="60" valign="bottom"><a href="javascript:window.close()" title="�رյ�ǰ�ĵ�" title="�رյ�ǰ�ĵ�"><span class="autoform-button">�� ��</span></a> </td>
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
				<form name="form1" method="post" action="../afuer/dataWriter">
	        <table border="0" cellpadding="3" cellspacing="0" style="border-collapse:collapse;height:14px;" width="95%">
			      <input type="hidden" name="VALIDATE" value="����:MC:VARCHAR2:200:N;���:BH:VARCHAR2:20:N;�ͺŹ��:XHGG:VARCHAR2:200:N;��λ:DW:VARCHAR2:20:N;���ؼ�:BDJ:NUMBER:12.2:Y;��ʡ��:BSJ:NUMBER:12.2:Y;ȫ����:QGJ:NUMBER:12.2:Y;Ԥ���:YSJ:NUMBER:12.2:Y;���:LB:VARCHAR2:2:N;�������:ZCLB:VARCHAR2:2:N;��ע:BZ:VARCHAR2:200:Y;">
			      <input type="hidden" name="dispatchStr" value="/system/clwhEdit.jsp?lb=<%=lb%>">
				  <input type="hidden" name="perproty" value="de_id,Ga02_clsb,ID">
				  <input type="hidden" name="tableInfomation" value="noFatherTable:Ga02_clsb">
			      <%
			      if(ga02.getId() != null){
			      %>
			      <input type="hidden" name="Ga02_clsb.ID" value="<%=ga02.getId()%>">
			      <%
			      }else{
			      %>
			      <input type="hidden" name="Ga02_clsb.ID" value="">
			      <%
			      }
			      %>
					<tr>
						<td colspan="6">&nbsp;</td>
					</tr>
	        		<tr>
	        			<td width="13%" align="right">�������ƣ�</td>
	        			<td colspan="3"><input type="text" name="MC" value="<%=StringFormatUtil.format(ga02.getMc())%>" class="td-input"></td>
	        			<td width="13%" align="right">���ϵ�λ��</td>
	        			<td width="20%"><input type="text" name="DW" value="<%=StringFormatUtil.format(ga02.getDw())%>" class="td-input"></td>
	        		</tr>
	        		<tr>
	        			<td width="13%" align="right">�ͺŹ��</td>
	        			<td colspan="3"><input type="text" name="XHGG" value="<%=StringFormatUtil.format(ga02.getXhgg())%>" class="td-input"></td>
	        			<td width="13%" align="right">���ϱ��룺</td>
	        			<td width="20%"><input type="text" name="BH" value="<%=StringFormatUtil.format(ga02.getBh())%>" class="td-input"></td>

	        		</tr>
	        		<tr>
	        			<td width="13%" align="right">���ؼۣ�</td>
	        			<td width="21%"><input type="text" name="BDJ" value="<%=NumberFormatUtil.roundToString(ga02.getBdj())%>" class="td-input"></td>
	        			<td width="12%" align="right">ȫ���ۣ�</td>
	        			<td width="21%"><input type="text" name="QGJ" value="<%=NumberFormatUtil.roundToString(ga02.getQgj())%>" class="td-input"></td>
	        			<td width="13%" align="right">��ʡ�ۣ�</td>
	        			<td width="20%"><input type="text" name="BSJ" value="<%=NumberFormatUtil.roundToString(ga02.getBsj())%>" class="td-input"></td>

	        		</tr>	        		
	        		<tr>
	        			<td width="13%" align="right">Ԥ��ۣ�</td>
	        			<td width="21%"><input type="text" name="YSJ" value="<%=NumberFormatUtil.roundToString(ga02.getYsj())%>" class="td-input"></td>
	        			<td width="12%" align="right">���</td>
	        			<td width="21%"><span style="border:1px solid #1E4F75;overflow:hidden;width: 100%;">
		        			<select class="td-input" name="LB" style="margin:-2px">
		        				<option value="ZC" <%if("ZC".equals(ga02.getLb())){out.print("selected");}%>>����</option>
		        				<option value="SB" <%if("SB".equals(ga02.getLb())){out.print("selected");}%>>�豸</option>
		        				<option value="JX" <%if("JX".equals(ga02.getLb())){out.print("selected");}%>>��е</option>
		        				<option value="YB" <%if("YB".equals(ga02.getLb())){out.print("selected");}%>>�Ǳ�</option>
		        			</select></span>
	        			</td>
	        			<td width="13%" align="right">�������</td>
	        			<td width="20%"><span style="border:1px solid #1E4F75;overflow:hidden;width: 100%;">
		        			<select class="td-input" name="ZCLB" style="margin:-2px">
			        			<%
			        			QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga00_zclb.class);
			        			queryBuilder.eq("lb","ZC");
			        			ResultObject ro = queryService.search(queryBuilder);
			        			while(ro.next()){
			        				Ga00_zclb ga00 = (Ga00_zclb) ro.get(Ga00_zclb.class.getName());
			        				%>
			        				<option value="<%=ga00.getZclb()%>" <%if(ga00.getZclb().equals(ga02.getZclb())){out.print("selected");}%>><%=ga00.getMc()%></option>
			        				<%
			        			}
			        			%>	        				
		        			</select></span>	
	        			</td>
	        		</tr>
	        		<tr>
	        			<td align="right">���Ͽ⣺</td>
	        			<td colspan="5">
	        			<%
	        			queryBuilder = new HibernateQueryBuilder(Gb05_yhk.class);
	        			queryBuilder.eq("lb",lb);
	        			ro = queryService.search(queryBuilder);
	        			while(ro.next()){
	        				gb05 = (Gb05_yhk) ro.get(Gb05_yhk.class.getName());
	        				%>
	        				<input type="checkbox" name="CLK_ID" value="<%=gb05.getId()%>" onClick="selectCLK();" <%if(gb05.getId().equals(ga02.getClk_id())){out.print("checked");}%>>
	        				<%=gb05.getMc()%>
	        				<%
	        			}
	        			%>
	        			<input type="hidden" name="CLK" value="">
	        			<script language="javascript">
	        				setCLK("<%=StringFormatUtil.format(ga02.getClk_id())%>");
	        				selectCLK();
	        			</script>
	        			</td>
	        		</tr>
	        		<tr>
	        			<td align="right" height="70">���ϱ�ע��</td>
	        			<td colspan="5"><input type="textarea" name="BZ" value="<%=StringFormatUtil.format(ga02.getBz())%>" class="td-textarea"></td>
	        		</tr>
	        		<tr>
	        			<td height="20" colspan="6"></td>
	        		</tr>
		        
          </table>          
   </form> 
		</td>
        </tr>
    </table>	
</div>
</body>

</html>
