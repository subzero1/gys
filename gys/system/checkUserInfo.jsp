<%@ page language="java" pageEncoding="GBK" %>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.service.SaveService" %>
<%@ page import="com.netsky.service.ForumService" %>
<%@ page import="com.netsky.baseObject.*"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
	request.setCharacterEncoding("GBK");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	ForumService forumService = (ForumService)ctx.getBean(ServiceName.ForumService);
	SaveService saveService = (SaveService)ctx.getBean(ServiceName.SaveService);
	String state = "0";
	if(request.getParameter("state")!=null){
		state = request.getParameter("state");
	}
	String province = "";
	if(request.getParameter("province")!=null){
		province = request.getParameter("province");
		province =new String(province.getBytes("iso-8859-1"),"GBK");
	}
	if(request.getParameter("check")!=null &&request.getParameter("check").equals("1")){
		if(request.getParameterValues("ids")!=null){
			for(int i=0;i<request.getParameterValues("ids").length;i++){
				forumService.passcheck(new Integer(request.getParameterValues("ids")[i]),new Integer(1));
			}
		}
	}
	if(request.getParameter("check")!=null &&request.getParameter("check").equals("2")){
		if(request.getParameterValues("ids")!=null){
			for(int i=0;i<request.getParameterValues("ids").length;i++){
				forumService.passcheck(new Integer(request.getParameterValues("ids")[i]),new Integer(2));
			}
		}
	}
	Date mintime=null;
	if(request.getParameter("mintime")!=null && !request.getParameter("mintime").equals("")){
		mintime =new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("mintime"));
	}
	Date maxtime= null;
	if(request.getParameter("maxtime")!=null && !request.getParameter("maxtime").equals("")){
		maxtime = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("maxtime"));
	}
		
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	String delflag = request.getParameter("delflag");
	if(delflag != null && delflag.equals("true")){
		if(request.getParameterValues("ids")!=null){
			for(int i=0;i<request.getParameterValues("ids").length;i++){
				if(queryService.searchById(Gb01_yhb.class,new Integer(request.getParameterValues("ids")[i])) != null)
					saveService.removeObject(Gb01_yhb.class,new Integer(request.getParameterValues("ids")[i]));
			}
		}
	}
	QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb01_yhb.class);
	queryBuilder.eq("state",state);
	queryBuilder.eq("province",province);
	if(mintime!=null){
		queryBuilder.ge("login_date",mintime);
	}
	if(maxtime!=null){
		queryBuilder.le("login_date",maxtime);
	}
	
	int pageNum = 1;
	int pageRowSize = 0;
	if(request.getParameter("pageRowSize") != null&& request.getParameter("pageRowSize").length() > 0){
		pageRowSize = Integer.parseInt(request.getParameter("pageRowSize"));
	}else{
		pageRowSize = 18;
	}
	if(request.getParameter("CurrentPage") != null && request.getParameter("CurrentPage").length() > 0){
		pageNum = Integer.parseInt(request.getParameter("CurrentPage"));
	}
	
	ResultObject ro = queryService.searchByPage(queryBuilder,pageNum,pageRowSize);
	int totalRows = ro.getTotalRows();
	int totalPages = ro.getTotalPages();
	
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>用户信息审核</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../js/multiTableSave.js"></script>
<script   language="JavaScript">   
	function seach(){
		document.form1.action="checkUserInfo.jsp?state="+document.getElementById("D1").value+"&province="+document.getElementById("D2").value;
		document.form1.submit();	
	}
	function pcheck(){
		var flag =0;
		for(var i=0;i<document.getElementsByName("ids").length;i++){
			if(document.getElementsByName("ids")[i].checked){
				flag= 1;
			}
		}
		if(flag==0){
			alert("请选择要审核的信息！");
			return;
		}
		
		document.form1.action="checkUserInfo.jsp?state="+document.getElementById("D1").value+"&province="+document.getElementById("D2").value+"&check=1";
		document.form1.submit();	
	}
	function ncheck(){
		var flag =0;
		for(var i=0;i<document.getElementsByName("ids").length;i++){
			if(document.getElementsByName("ids")[i].checked){
				flag= 1;
			}
		}
		if(flag==0){
			alert("请选择要审核的信息！");
			return;
		}
		
		document.form1.action="checkUserInfo.jsp?state="+document.getElementById("D1").value+"&province="+document.getElementById("D2").value+"&check=2";
		document.form1.submit();	
	}
	function del(){
		var flag =0;
		for(var i=0;i<document.getElementsByName("ids").length;i++){
			if(document.getElementsByName("ids")[i].checked){
				flag= 1;
			}
		}
		if(flag==0){
			alert("请选择要删除的信息！");
			return;
		}
		
		document.form1.action="checkUserInfo.jsp?delflag=true";
		document.form1.submit();	
	}
</script> 
</head>

<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0">
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
						<td valign="bottom"><img src="../images/checkUserInfo.gif" border="0"/></td>
					</tr>	
					<tr>
						<td height="15" background="../images/main-images/gypms_main_bar_bg.gif"></td>
					</tr>	
				</table>
			</td>
		</tr>
		<tr>
			<td height="50" valign="middle">			
			  	<table height="30" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
					<tr>	
						<td width="10"></td>
		   				<td width="45" align="right">状态：</td>
		    			<td width="60">	
							<select size="1" id="D1" name="D1">
								<option value="0" >未审核</option>
								<option value="1" >通过</option>
								<option value="2" >未通过</option>
							</select>
							<script type="text/javascript">
								<%
									out.print("form1.D1.value='"+state+"';");
								%>
							</script>
						</td>
						<td width="90" align="right">省/直辖市：</td>
						<td width="110">	
							<select size="1" id="D2" name="D2">
								<option value=""> </option>
								<option value="天津市">天津市</option>
								<option value="北京市">北京市</option>
								<option value="上海市">上海市</option>
								<option value="重庆市">重庆市</option>
								<option value="河北省">河北省</option>
								<option value="山西省">山西省</option>
								<option value="辽宁省">辽宁省</option>
								<option value="吉林省">吉林省</option>
								<option value="黑龙江省">黑龙江省</option>
								<option value="江苏省">江苏省</option>
								<option value="浙江省">浙江省</option>
								<option value="安徽省">安徽省</option>
								<option value="福建省">福建省</option>
								<option value="江西省">江西省</option>
								<option value="山东省">山东省</option>
								<option value="河南省">河南省</option>
								<option value="湖北省">湖北省</option>
								<option value="湖南省">湖南省</option>
								<option value="广东省">广东省</option>
								<option value="海南省">海南省</option>
								<option value="四川省">四川省</option>
								<option value="贵州省">贵州省</option>
								<option value="云南省">云南省</option>
								<option value="陕西省">陕西省</option>
								<option value="甘肃省">甘肃省</option>
								<option value="青海省">青海省</option>
								<option value="广西壮族自治区">广西壮族自治区</option>
								<option value="内蒙古自治区">内蒙古自治区</option>
								<option value="西藏自治区">西藏自治区</option>
								<option value="宁夏回族自治区">宁夏回族自治区</option>
								<option value="新疆维吾尔自治区">新疆维吾尔自治区</option>
								<option value="香港特别行政区">香港特别行政区</option>
								<option value="澳门特别行政区">澳门特别行政区</option>
								<option value="台湾省">台湾省</option>
							</select> 	
							<script type="text/javascript">
								<%
									if(!province.equals("")){
										out.print("form1.D2.value='"+province+"';");
									}
								%>
							</script>	
						</td>
						<td width="80" align="right">注册时间：</td>
						<td width="120"><input type="text" name="mintime" id="mintime" value="" style="width:120px;height:20px;text-transform:uppercase;" onDblClick="javascript:datePick(this,'-');"></td>
						<td width="15" align="center">-</td>
						<td width="120"><input type="text" name="maxtime" id="maxtime" value="" style="width:120px;height:20px;text-transform:uppercase;" onDblClick="javascript:datePick(this,'-');"></td>
						<script type="text/javascript">
						<%
							if(mintime!=null&&!mintime.equals("")){
								out.print("form1.mintime.value='"+new SimpleDateFormat("yyyy-MM-dd").format(mintime)+"';");
							}
							if(maxtime!=null&&!maxtime.equals("")){
								out.print("form1.maxtime.value='"+new SimpleDateFormat("yyyy-MM-dd").format(maxtime)+"';");
							}
							
						%>
						</script>	
						<td width="10"></td>
						<td width="80" align="center"><input type="button" value=" 查 询 " onclick="javascript:seach();" style="height:20px;"></td>
						<td width="80" align="center"><input type="button" value=" 通 过 " onclick="javascript:pcheck();" class="but" style="height:20px;"></td>
						<td width="80" align="center"><input type="button" value=" 不通过 " onclick="javascript:ncheck();" class="but" style="height:20px;"></td>
						<td width="80" align="center"><input type="button" value=" 删 除 " onclick="javascript:del();" class="but" style="height:20px;"></td>
						<td width="15">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
      		<td colspan="3" height="2" bgcolor="#c5ced4"></td>
     	</tr>				
		<tr>
			<td valign="top">
				<table width="1675" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" id="search-list">
					  	<tr id="search-title">							          	
					  	<td width="25"></td>
			            <td width="120">用户名</td>
			            <td width="120">用户昵称</td>
			            <td width="100">联系人</td>
			            <td width="100">审核状态</td>
			            <td width="110">省/直辖市</td>
			            <td width="250">公司名称</td>
			            <td width="80">联系电话</td>
			            <td width="150">Email</td>
			            <td width="90">注册日期</td>
			            <td width="90">失效日期</td>
			            <td width="90">QQ</td>
			            <td width="150">MSN</td>
			            <td width="100">软件序列号</td>
			          </tr>       
			          <%
			            int i=0;
			            while(ro.next() || i < pageRowSize){
			         		i++;
			         		Gb01_yhb yhb  = (Gb01_yhb)ro.get(Gb01_yhb.class.getName());
			         		if(yhb!=null){
			          %>
			          <tr onMouseOver="this.style.backgroundColor='#dce8ec'" onMouseOut="this.style.backgroundColor=''">
			          	<td><input type="checkbox" name="ids" value="<%=yhb.getId()%>"></td>
			            <td><%=yhb.getLogin_id()%></td>
			            <td><%=yhb.getName()%></td>
			            <td><%if(yhb.getLxr()!=null){out.print(yhb.getLxr());}else{out.print("");}%></td>
			            <td align="center"><%if(yhb.getState().equals("0")){out.print("未审核");}else if(yhb.getState().equals("1")){out.print("审核通过");}else{out.print("审核未通过");}  %></td>
			            <td align="center"><%if(yhb.getProvince()!=null){out.print(yhb.getProvince());}else{out.print("");} %></td>
			            <td><%if(yhb.getCompany_name()!=null){out.print(yhb.getCompany_name());}else{out.print("");} %></td>			            
			            <td><%if(yhb.getPhone()!=null){out.print(yhb.getPhone());}else{out.print("");} %></td>
			            <td><%if(yhb.getEmail()!=null){out.print(yhb.getEmail());}else{out.print("");} %></td>
			            <td align="center"><%=new SimpleDateFormat("yyyy-MM-dd").format(yhb.getLogin_date()) %></td>
			            <td align="center"><%if(yhb.getLimit_date()!=null){out.print(new SimpleDateFormat("yyyy-MM-dd").format(yhb.getLimit_date()));}else{out.print("");} %></td>
			          	<td><%if(yhb.getQq()!=null){out.print(yhb.getQq());}else{out.print("");}%></td>
			          	<td><%if(yhb.getMsn()!=null){out.print(yhb.getMsn());}else{out.print("");}%></td>
			          	<td align="center"><%if(yhb.getSofeware_num()!=null){out.print(yhb.getSofeware_num());}else{out.print("");} %></td>
			          </tr>
			         
			          <%}else{%>
			          <tr onMouseOver="this.style.backgroundColor='#dce8ec'" onMouseOut="this.style.backgroundColor=''">
			          	<td  align="center">&nbsp;</td>
			          	<td  align="center"></td>
			            <td  align="center"></td>
			            <td  align="center"></td>
			            <td  align="center"></td>
			            <td  align="center"> </td>
			            <td  align="center"> </td>
			            <td  align="center"> </td>
			            <td  align="center"> </td>
			            <td  align="center"> </td>
			            <td  align="center"> </td>
			            <td  align="center"> </td>
			            <td  align="center"> </td>
			            <td  align="center"> </td>
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
					          <td width="150" style="color:#2C4866"><span>共 <b><%=totalPages%></b> 页&nbsp;<b><%=totalRows%></b>&nbsp;条记录&nbsp;</span></td>
					          <td style="color:#2C4866">
					             <a href="javascript:pageUp(document.all.form1)" title="上一页"><img src="../images/main-images/back.png" width="41" height="12" border="0"></a>
					             <a href="javascript:pageDown(document.all.form1)" title="下一页"><img src="../images/main-images/next.png" width="41" height="12" border="0"></a>
					            &nbsp;第<b><%=pageNum%></b>页&nbsp;
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