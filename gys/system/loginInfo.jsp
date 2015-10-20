<%@ page language="java" pageEncoding="GBK" %>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseObject.*"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%@ page import="com.netsky.dataObject.Gb02_dlrz" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	request.setCharacterEncoding("GBK");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
					

	
	String Hsql = "select yhb,dlrz  from Gb01_yhb yhb,Gb02_dlrz dlrz where yhb.login_id=dlrz.login_id and flag=0  ";
	String province = "";
	if(request.getParameter("province")!=null && !request.getParameter("province").equals("")){
		province = request.getParameter("province");
		province =new String(province.getBytes("iso-8859-1"),"GBK");		
		Hsql = Hsql +" and yhb.province ='"+province+"'";
	}
	if(request.getParameter("login_id")!=null && !request.getParameter("login_id").equals("")){
		Hsql = Hsql +" and dlrz.login_id like '%"+request.getParameter("login_id")+"%'";
	}
	
	if(request.getParameter("mintime")!=null && !request.getParameter("mintime").equals("")){
		Hsql=Hsql+ " and op_date >= '"+ request.getParameter("mintime")+"'";
	}
	if(request.getParameter("maxtime")!=null && !request.getParameter("maxtime").equals("")){
		Hsql =Hsql+ " and op_date <= '"+request.getParameter("maxtime")+"'";
	}
	
	int pageNum = 1;
	int pageRowSize = 0;
	if(request.getParameter("pageRowSize") != null&& request.getParameter("pageRowSize").length() > 0){
		pageRowSize = Integer.parseInt(request.getParameter("pageRowSize"));
	}else{
		pageRowSize = 16;
	}
	if(request.getParameter("CurrentPage") != null && request.getParameter("CurrentPage").length() > 0){
		pageNum = Integer.parseInt(request.getParameter("CurrentPage"));
	}
	
	ResultObject ro = queryService.searchByPage(Hsql,pageNum,pageRowSize);
	int totalRows = ro.getTotalRows();
	int totalPages = ro.getTotalPages();
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��¼��־</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../js/multiTableSave.js"></script>
<script   language="JavaScript">   
	function seach(){
		document.form1.action="loginInfo.jsp?province="+document.getElementById("D2").value;
		document.form1.submit();	
	}
</script> 
</head>

<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" style="height:100%; background:#FFFFFF" scroll="yes">
<form name="form1" id="form1" method="post" action="">
<input type="hidden" name="CurrentPage" value="<%=pageNum%>">
<input type="hidden" name="TotalOfPages" value="<%=totalPages%>">
<input type="hidden" name="pageRowSize" value="<%=pageRowSize%>">
<div align="center">
	<table border="0" cellpadding="0" style="border-collapse: collapse" height="100%">
		<tr>
			<td colspan="2" height="50" id="search-head">
				<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%">
					<tr>
						<td valign="bottom"><img src="../images/loginInfo.gif" border="0"/></td>
					</tr>	
					<tr>
						<td height="15" background="../images/main-images/gypms_main_bar_bg.gif"></td>
					</tr>	
				</table>
			</td>
		</tr>
		<tr>
			<td height="80" valign="middle">			
			  	<table height="30" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
	    			<tr>
	    				<td width="10"></td>
	    				<td>�û�����</td>
	    				<td ><input type="text" name="login_id" id="login_id" value=""></td>
	    				<script type="text/javascript">
	    					<%
	    						if(request.getParameter("login_id")!=null && !request.getParameter("login_id").equals("")){
	    							out.print("form1.login_id.value='"+request.getParameter("login_id")+"'");
	    						}
	    					%>
	    				</script>
					<td width="10"></td>
					<td >ʡ/ֱϽ�У�</td>
					<td>	
						<select size="1" id="D2" name="D2" style="margin:-1px;" >
							<option value=""> </option>
							<option value="�����">�����</option>
							<option value="������">������</option>
							<option value="�Ϻ���">�Ϻ���</option>
							<option value="������">������</option>
							<option value="�ӱ�ʡ">�ӱ�ʡ</option>
							<option value="ɽ��ʡ">ɽ��ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="������ʡ">������ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="�㽭ʡ">�㽭ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="ɽ��ʡ">ɽ��ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="�㶫ʡ">�㶫ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="�Ĵ�ʡ">�Ĵ�ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="����ʡ">����ʡ</option>
							<option value="�ຣʡ">�ຣʡ</option>
							<option value="����׳��������">����׳��������</option>
							<option value="���ɹ�������">���ɹ�������</option>
							<option value="����������">����������</option>
							<option value="���Ļ���������">���Ļ���������</option>
							<option value="�½�ά���������">�½�ά���������</option>
							<option value="����ر�������">����ر�������</option>
							<option value="�����ر�������">�����ر�������</option>
							<option value="̨��ʡ">̨��ʡ</option>
						</select> 	
						<script type="text/javascript">
							<%
								if(province!=null&&!province.equals("")){
									out.print("form1.D2.value='"+province+"';");
								}
							%>
						</script>	
					</td>
					<td width="10"></td>
					<td>��¼���ڣ�</td>
					<td width="120"><input type="text" name="mintime" id="mintime" value="" style="width:120px;height:20px;text-transform:uppercase;" onDblClick="javascript:datePick(this,'-');"></td>
					<script type="text/javascript">
						<%
							if(request.getParameter("mintime")!=null && !request.getParameter("mintime").equals("")){
								out.print("form1.mintime.value='"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("mintime")))+"'");
							}
						%>
					</script>
			
					<td width="25">����</td>
						<td width="120"><input type="text" name="maxtime" id="maxtime" value="" style="width:120px;height:20px;text-transform:uppercase;" onDblClick="javascript:datePick(this,'-');"></td>
					<script type="text/javascript">
						<%
							if(request.getParameter("maxtime")!=null && !request.getParameter("maxtime").equals("")){
								out.print("form1.maxtime.value='"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("maxtime")))+"'");
							}
						%>
					</script>
					<td width="80" align="center"><input type="button" value=" �� ѯ " onclick="javascript:seach();" style="height:20px;"></td>					
     					</tr>
				</table>
				<table height="30" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
        					<tr>
        						<%
        							String hsql = "select dlrz from Gb02_dlrz dlrz where YEAR(op_date)=YEAR(NOW()) and Month(dlrz.op_date)=Month(NOW()) and dlrz.flag=0  ";
        							String hsql1 = "select dlrz from Gb02_dlrz dlrz where YEAR(op_date)=YEAR(NOW()) and Month(dlrz.op_date)=Month(NOW()) and DAY(dlrz.op_date)=DAY(NOW()) and dlrz.flag=0 ";
        							String hsql2 = "select dlrz from Gb02_dlrz dlrz where YEAR(op_date)=YEAR(NOW()) and dlrz.flag=0 ";
        							String hsql3 = "select dlrz from Gb02_dlrz dlrz where dlrz.flag=0";
        							ResultObject roh = queryService.search(hsql);
        							ResultObject roh1 = queryService.search(hsql1);
       								ResultObject roh2 = queryService.search(hsql2);
       								ResultObject roh3 = queryService.search(hsql3);
        						%>
        						<td width="10"></td>
        						<td width="80" valign="bottom">���죺[<%=roh1.getLength() %>]</td>
        						<td width="80" valign="bottom">���£�[<%=roh.getLength()%>]</td>
        						<td width="80" valign="bottom">���꣺[<%=roh2.getLength() %>]</td>
        						<td width="80" valign="bottom">ȫ����[<%=roh3.getLength() %>]</td>
        					</tr>
        				</table>				
			</td>
		</tr>
		<tr>
      		<td colspan="3" height="2" bgcolor="#c5ced4"></td>
     	</tr>				
		<tr>
			<td valign="top">
				<table width="1075" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" id="search-list">
			          <tr id="search-title">
					  	<td width="15"></td>			          
			            <td width="80">�û���</td>
			            <td width="100">�û��ǳ�</td>
			            <td width="100">�û�IP</td>
			            <td width="150">ʡ/ֱϽ��</td>
			            <td width="150">��˾����</td>
			            <td width="100">������к�</td>
			            <td width="80">��ϵ�绰</td>
			            <td width="150">Email</td>
			            <td width="150">��¼ʱ��</td>
			          </tr>       
			          <%
			            int i=0;
			            while(ro.next() || i < pageRowSize){
			         		i++;
			         		Gb01_yhb  yhb = (Gb01_yhb)ro.get("yhb");
			         		Gb02_dlrz dlrz = (Gb02_dlrz)ro.get("dlrz");
			         		if(yhb!=null && dlrz!=null){
			          %>
			          <tr onMouseOver="this.style.backgroundColor='#dce8ec'" onMouseOut="this.style.backgroundColor=''">
					  	<td width="15"></td>			          			          
			            <td><%=yhb.getLogin_id()%></td>
			            <td><%=yhb.getName()%></td>
			            <td align="center"><%=dlrz.getIp() %></td>
			            <td align="center"><%if(yhb.getProvince()!=null){out.print(yhb.getProvince());}else{out.print("");}%></td>
			            <td><%if(yhb.getCompany_name()!=null){out.print(yhb.getCompany_name());}else{out.print("");} %></td>
			            <td align="center"><%if(yhb.getSofeware_num()!=null){out.print(yhb.getSofeware_num());}else{out.print("");} %></td>
			            <td><%if(yhb.getPhone()!=null){out.print(yhb.getPhone());}else{out.print("");} %></td>
			            <td><%if(yhb.getEmail()!=null){out.print(yhb.getEmail());}else{out.print("");} %></td>
			            <td  align="center"><%if(dlrz.getOp_date()!=null){out.print(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dlrz.getOp_date()));}else{out.print("");} %></td>
			   
			          </tr>			         
			          <%}else{%>
			          <tr onMouseOver="this.style.backgroundColor='#dce8ec'" onMouseOut="this.style.backgroundColor=''">
					  	<td  align="center"></td>			          
			            <td  align="center"></td>
			            <td  align="center"></td>
			            <td  align="center"></td>
			            <td  align="center"></td>
			            <td  align="center"></td>
			            <td  align="center"></td>
			            <td  align="center"></td>
			            <td  align="center"></td>
			            <td  align="center"></td>
			          
			          </tr>
			          <%}} %>
			        </table>
			</td>
		</tr>
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td height="38" bgcolor="#dce8ec" align="left">
					    <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
					        <tr>
					          <td width="15"></td>
					          <td width="150" style="color:#2C4866"><span>�� <b><%=totalPages%></b> ҳ&nbsp;<b><%=totalRows%></b>&nbsp;����¼&nbsp;</span></td>
					          <td style="color:#2C4866">
					             <a href="javascript:pageUp(document.all.form1)" title="��һҳ"><img src="../images/main-images/back.png" width="41" height="12" border="0"></a>
					             <a href="javascript:pageDown(document.all.form1)" title="��һҳ"><img src="../images/main-images/next.png" width="41" height="12" border="0"></a>
					            &nbsp;��<b><%=pageNum%></b>ҳ&nbsp;
					            <input type="text" name="selectPage" size="3" style="font-size: 10px" class="input-text">
					            <a href="javascript:setPage();">go</a></td>
					          <td align="right" style="color:#2C4866">&nbsp;</td>
					        </tr>
					    </table></td>
				  </tr>
				</table>			
			</td>
		</tr>									
	</table>
</div>
</form>
</body>
</html>