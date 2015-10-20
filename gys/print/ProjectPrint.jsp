<%@ page contentType="text/html; charset=gbk"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.dataObject.Gd02_dxgc" %>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	
	Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
	Gd02_dxgc  dxgc = new Gd02_dxgc();
	QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class); 
	queryBuilder.eq("gcxm_id",gcxm_id);
	queryBuilder.addOrderBy(Order.asc("id"));
	ResultObject ro = queryService.search(queryBuilder);
 %>
<html>
<head>
<title>工程项目表格输出</title>
<link href="../css/list.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script language='javascript'>
function abc()
{   var selectgcflag=0;
	var selectbgflag=0;
	for(i=0;i<document.all("gcxm_print").length;i++){       
		if(document.all("gcxm_print")(i).checked){       
			selectgcflag =1;
		}       
	}       
	if(selectgcflag==0){
		alert("请选择单项工程！");
		return ;
	}
	for(j=0;j<document.all("Cb_bgxd").length;j++){
		if(document.all("Cb_bgxd")(j).checked){       
			selectbgflag =1;
		}  
	}
	if(selectbgflag==0){
		alert("请选择表格！");
		return ;
	}

  document.form1.action="../print/PrintTotal.jsp?type=print&gcxm_id=<%=gcxm_id%>";
  document.form1.submit();
  window.close(); 
  return true;
}
function PDF(){
	var selectgcflag=0;
	var selectbgflag=0;
	for(i=0;i<document.all("gcxm_print").length;i++){       
		if(document.all("gcxm_print")(i).checked){       
			selectgcflag =1;
		}       
	}       
	if(selectgcflag==0){
		alert("请选择单项工程！");
		return ;
	}
	for(j=0;j<document.all("Cb_bgxd").length;j++){
		if(document.all("Cb_bgxd")(j).checked){       
			selectbgflag =1;
		}  
	}
	if(selectbgflag==0){
		alert("请选择表格！");
		return ;
	}
	document.form1.action="../print/projectTransformer.jsp?type=pdf&gcxm_id=<%=gcxm_id%>";
	document.form1.submit();
	window.close();
}
function Word(){
	var selectgcflag=0;
	var selectbgflag=0;
	for(i=0;i<document.all("gcxm_print").length;i++){       
		if(document.all("gcxm_print")(i).checked){       
			selectgcflag =1;
		}       
	}       
	if(selectgcflag==0){
		alert("请选择单项工程！");
		return ;
	}
	for(j=0;j<document.all("Cb_bgxd").length;j++){
		if(document.all("Cb_bgxd")(j).checked){       
			selectbgflag =1;
		}  
	}
	if(selectbgflag==0){
		alert("请选择表格！");
		return ;
	}
	document.form1.action="../print/projectTransformer.jsp?type=doc&gcxm_id=<%=gcxm_id%>";
	document.form1.submit();
	window.close();
}
function Excel(){
	var selectgcflag=0;
	var selectbgflag=0;
	for(i=0;i<document.all("gcxm_print").length;i++){       
		if(document.all("gcxm_print")(i).checked){       
			selectgcflag =1;
		}       
	}       
	if(selectgcflag==0){
		alert("请选择单项工程！");
		return ;
	}
	for(j=0;j<document.all("Cb_bgxd").length;j++){
		if(document.all("Cb_bgxd")(j).checked){       
			selectbgflag =1;
		}  
	}
	if(selectbgflag==0){
		alert("请选择表格！");
		return ;
	}
	document.form1.action="../export/Item_excel.jsp?gcxm_id=<%=gcxm_id%>";
	document.form1.submit();
	window.close();
}
function changdxgc(){
	if(document.form1.checkdxgc.checked == true){
		for(var i=0;i<document.getElementsByName("gcxm_print").length;i++){
			document.getElementsByName("gcxm_print")[i].checked=true;
		}
	}else{
		for(var i=0;i<document.getElementsByName("gcxm_print").length;i++){
			document.getElementsByName("gcxm_print")[i].checked=false;
		}
	}
}
function changbg(){
	if(document.form1.checkbg.checked == true){
		for(var i=0;i<document.getElementsByName("Cb_bgxd").length;i++){
			document.getElementsByName("Cb_bgxd")[i].checked=true;
		}
	}else{
		for(var i=0;i<document.getElementsByName("Cb_bgxd").length;i++){
			document.getElementsByName("Cb_bgxd")[i].checked=false;
		}
	}
}
</script>
</head>
<body scroll="yes">
<form name="form1"  method=post   action="" target="blank" >   
	<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%">
	<tr>
		<td><input type="checkbox" name="checkdxgc"  value="" onclick="changdxgc()"></td>
		<td><font color="#FF0000">选择所有单项工程</font></td>
	</tr>
	<%	while(ro.next()){
			dxgc = (Gd02_dxgc)ro.get(Gd02_dxgc.class.getName());
			if(dxgc.getId()!=null){
	 %>
	 <tr>
		<td><input type="checkbox" name="gcxm_print"  value="<%=dxgc.getId()%>" ></td>
		<td><%=dxgc.getGcmc()%></td>
	</tr>
	<%}}%>
		<tr>
		</tr>
		<tr>
			<td><input type="checkbox" name="checkbg"  value="" onclick="changbg()"></td>
			<td><font color="#FF0000">选择所有表格</font></td>
		</tr>
		<tr>
			<td width="35"><input type="checkbox" name="Cb_bgxd"  value="1" ></td>
			<td width="290">建设项目总表（汇总表）</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="2" ></td>
			<td>概预算总表（表一）</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="9"  ></td>
			<td>国内备品备件表（表四）甲</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="3" ></td>
			<td>建筑安装工程费用（表二）</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="10" ></td>
			<td>国内维护器具表（表四）甲</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="4"  ></td>
			<td>建筑安装工程量（表三）甲</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="11" ></td>
			<td>国内主要材料表（表四）甲</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="5" ></td>
			<td>建筑安装工程机械使用费（表三）乙</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="12" ></td>
			<td>国内主要材料附表（表四）甲</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="6" ></td>
			<td>建筑安装工程仪器仪表使用费（表三）丙</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="13"  ></td>
			<td>工程建设其他费用（表五）甲</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="7"  ></td>
			<td>国内需要安装设备表（表四）甲</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="14"  ></td>
			<td>建筑工程表</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="8"  ></td>
			<td>国内不需要安装设备表（表四）甲</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="15"  ></td>
			<td>回收设备表</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="17"  ></td>
			<td>国内光电缆设备表</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="16"  ></td>
			<td>回收材料表</td>

		</tr>
	</table>
	<table border="0" cellpadding="2" style="height:35px;border-collapse:collapse;" width="100%">
		<tr>
			<td style="height:5px"></td>
		</tr>
		<tr>
		<td style="vertical-aling:bottom;">
			&nbsp;<input type="button" name="b2" value=" 确认打印 "  onclick="abc()">
			&nbsp;<input type="button" name="b2" value=" PDF输出 "  onclick="PDF()">
			&nbsp;<input type="button" name="b2" value=" Word输出 "  onclick="Word()">
			&nbsp;<input type="button" name="b2" value=" Excel输出 "  onclick="Excel()">
		</td>
		</tr>
	</table>
</form>	
</body>

</html>
