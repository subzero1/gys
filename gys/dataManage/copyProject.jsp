<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.service.ProjectService" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.dataObject.Gd02_dxgc" %>
<%@ page import="com.netsky.dataObject.Gd01_gcxm" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%
request.setCharacterEncoding("gb2312");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService)ctx.getBean(ServiceName.QueryService);
ResultObject ro = null;
Gd02_dxgc gd02;
Gd01_gcxm gd01;
String HSql = "";
String newProjectName = request.getParameter("newProjectName");
if(newProjectName == null)
	newProjectName = "";
String gcxm_id = request.getParameter("gcxm_id");
if(gcxm_id == null)
	gcxm_id = "";
String dxgc_id = request.getParameter("dxgc_id");
if(dxgc_id == null)
	dxgc_id = "";
String gcfl_id = request.getParameter("gcfl_id");
if("".equals(gcfl_id)){
	gcfl_id = null;
}
Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
if(yh == null){
	%>
	<script language="javascript"> window.location.href="/gys/index.jsp"; </script>
	<%
	return;
}
if(request.getParameter("flag") != null && request.getParameter("flag").equals("search")){
	HSql = "select gd01,gd02 from Gd02_dxgc gd02,Gd01_gcxm gd01 where gd01.id = gd02.gcxm_id";
	if(request.getParameter("searchKey") != null && request.getParameter("searchKey").length() > 0){
		HSql += " and (gd01.xmmc like '%" + request.getParameter("searchKey") + "%' or gd02.gcmc like '%" + request.getParameter("searchKey") + "%')";
	}
	if(request.getParameter("mb") != null && request.getParameter("mb").equals("1")){
		HSql += " and gd02.mb = 1";
	}
	HSql +=" and gd02.cjr_id = " + yh.getId();
	ro = queryService.search(HSql);
}else if(request.getParameter("flag") != null && request.getParameter("flag").equals("copyProject")){
	ProjectService projectService = (ProjectService)ctx.getBean(ServiceName.ProjectService);
	Integer oldGcxm_id = null;
	if(!gcxm_id.equals(""))
		oldGcxm_id = Integer.valueOf(gcxm_id);
	gd02 = (Gd02_dxgc)queryService.searchById(Gd02_dxgc.class,projectService.copyProject(Integer.valueOf(dxgc_id),oldGcxm_id,newProjectName,gcfl_id));
	%>
	<script language="javascript">
		<%
		if(oldGcxm_id == null){		
		%>
		var arg = "width=" + new String(screen.width - 10) + ",height=" + new String(screen.height - 80) + ",scrollbars=1,menubar=0,status=yes,resize=1";
		var allpop = window.open("projectMain.jsp?gcxm_id=<%=gd02.getGcxm_id()%>&dxgc_id=<%=gd02.getId()%>","_blank",arg);
		allpop.moveTo(0,0);
		allpop.focus();
		<%
		}else{
		%>
		opener.parent.location.reload();
		<%
		}
		%>
		window.close();
	</script>
	<%
	return;
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>新建单项工程</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/page.css" rel="stylesheet" type="text/css">
<script language="javascript">
function newProject(dxgc_id){
	if(document.all.newProjectName.value == null || document.all.newProjectName.value == ""){
		window.alert("请输入新工程名称！");
		document.all.newProjectName.focus();
		return;
	}
	document.all.dxgc_id.value = dxgc_id;
	document.all.flag.value = "copyProject";
	if(window.confirm("确认以此工程为模板创建？"))
		document.form1.submit();
}
</script>
</head>
<body topmargin="0" leftmargin="0" id="main-body">
<form name="form1" id="form1" method="post" action="">
<input type="hidden" name="flag" value="search">
<input type="hidden" name="dxgc_id" value="<%=dxgc_id %>">
<input type="hidden" name="gcxm_id" value="<%=gcxm_id %>">
<input type="hidden" name="gcfl_id" value="<%=StringFormatUtil.format(gcfl_id) %>">
<div align="center">
	<table width="710" border="0" cellspacing="0" cellpadding="0">
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
						                	<td>新建单项工程</td>
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
					<table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
						<tr>	
							<td width="110" align="right">&nbsp;<font id="list_name">新单项工程名称：</font></td>
							<td width="120"><input type="text" name="newProjectName" value="<%=newProjectName %>" class="input-text"></td>
							<td width="10"></td>
							<td width="80">
								<select name="mb">
									<option value="1" <%if(request.getParameter("mb") != null && request.getParameter("mb").equals("1")){out.print("selected");} %>>从模板新建</option>
									<option value="0" <%if(request.getParameter("mb") != null && request.getParameter("mb").equals("0")){out.print("selected");} %>>从工程新建</option>
								</select>
							</td>
							<td width="10"></td>							
							<td width="140" align="right" nowrap>
							<div style="position:absolute;color:#1E4F75;padding-top:4px;" onClick="blankit(this,document.form1.searchKey);">&nbsp;输入项目名称或工程名称</div>
							<input type="text" name="searchKey" class="input-text">
							</td>
							<td width="10"></td>							
							<td width="60" align="left" valign="middle"><input type="button" value=" 查 询 " onclick="javascript:document.form1.action='';document.form1.submit();" class="but" style="height:20px;"></td>
							<td>&nbsp;</td>
						</tr>
					</table>			        
				</td>
	        </tr>
        </table>
	<table border="0" cellpadding="0" cellspacing="0" width="710" style="border-collapse:collapse;background:#ffffff" id="list">
	      <tr height="24">
			<td class="list_title" width="30" align="center">序号</td>
	        <td class="list_title" width="100" align="center">项目编码</td>
	        <td class="list_title" width="180" align="center">工程名称</td>
	        <td class="list_title" width="50" align="center">编制人</td>
		  </tr>
		  <%
		  int counter = 0;
		  while(ro != null && ro.next()){
		  	gd02 = (Gd02_dxgc)ro.get("gd02");
		  	gd01 = (Gd01_gcxm)ro.get("gd01");
		  	%>
		  	<tr onMouseOver="this.style.backgroundColor='#edf3f5'" onMouseOut="this.style.backgroundColor=''">
		  		<td align="center"><%=++counter %></td>
		  		<td align="left"><%=StringFormatUtil.format(gd01.getXmbh())%></td>
		  		<td><a href="#" onclick="javascript:newProject(<%=gd02.getId() %>);"><%=gd02.getGcmc()%></a></td>
		  		<td align="center"><%=StringFormatUtil.format(gd02.getBzr())%></td>
		  	</tr>
		  	<%
		  }
		  %>
		</table>
</div>
</form>
</body>
</html>