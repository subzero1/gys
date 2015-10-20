<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.service.SaveService" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.baseObject.QueryBuilder" %>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.dataObject.Gb05_yhk" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%@ page import="org.hibernate.criterion.MatchMode" %>
<%@ page import="org.hibernate.criterion.Restrictions" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.dataObject.Ga13_dej" %>
<%@ page import="com.netsky.dataObject.Ga12_dez" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%
request.setCharacterEncoding("gb2312");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService)ctx.getBean(ServiceName.QueryService);
QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb05_yhk.class);
if(request.getParameter("searchKey") != null){
	queryBuilder.addCriterion(Restrictions.or(Restrictions.like("mc",request.getParameter("searchKey"),MatchMode.ANYWHERE),Restrictions.like("bh",request.getParameter("searchKey"),MatchMode.ANYWHERE)));
}
//Gc01_yhclk gc01;
String HSql="";
ResultObject ro;
Gb05_yhk list_Gb05;

    Integer ce;
	if(request.getParameter("ce")==null ||request.getParameter("ce").equals("")){
		ce=new Integer(0);
	}else{
		ce=new Integer(request.getParameter("ce"));
	}
	Integer zhang;
	if(request.getParameter("zhang")==null ||request.getParameter("zhang").equals("")){
		zhang=new Integer(0);
	}else{
		zhang=new Integer(request.getParameter("zhang"));
	}
	Integer jie;
	if(request.getParameter("jie")==null||request.getParameter("jie").equals("")){
		jie=new Integer(0);
	}else{
		jie=new Integer(request.getParameter("jie"));
	}
%>
<html>
  <head>
    <title>定额库查询条件</title>
    <meta http-equiv="Content-Language" content="zh-cn">
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<script language="javascript" src="../js/functionlib.js"></script>
	<link href="../css/main.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript">
	var xmlHttp1;
  	function createXMLHttpRequest1(){
    	if(window.ActiveXObject){
      		xmlHttp1=new ActiveXObject("Microsoft.XMLHTTP");
    	}else if(window.XMLHttpRequset){
      		xmlHttp1=new XMLHttpRequset();
    	}
  	}
  	function updateSelectZ(){
    	var selected1=document.all.zhang.value;
    	createXMLHttpRequest1();
    	xmlHttp1.onreadystatechange=updateZ;
    	xmlHttp1.open("GET","../afuer/ShowQuotaZXml?lb1="+selected1);
    	xmlHttp1.send(null);
  	}
  	function updateZ(){
	     if(xmlHttp1.readyState==4){
	        if(xmlHttp1.status==200){
	           var doc = new ActiveXObject("MSxml2.DOMDocument")
	           doc.loadXML(xmlHttp1.responseText);
	           result=doc.getElementsByTagName("lb1");
	           while(document.all.jie.options.length>0){
	             document.all.jie.removeChild(document.all.jie.childNodes[0]);
	           }
	           //加空的节
	           var nuoption = document.createElement("OPTION");
	           nuoption.value ="";
	           document.all.jie.options.add(nuoption);
	           for(var i=0;i<result.length;i++){
	             var option=document.createElement("OPTION");
	             option.text=result[i].childNodes[0].childNodes[0].nodeValue;
	             option.value=result[i].childNodes[1].childNodes[0].nodeValue;
	             document.all.jie.options.add(option);
	           }
	        }
	     }
  	}
</script>
<script language="javascript">
	var xmlHttp;
  	function createXMLHttpRequest(){
    	if(window.ActiveXObject){
      		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    	}else if(window.XMLHttpRequset){
      		xmlHttp=new XMLHttpRequset();
    	}
  	}
  	function updateSelect(){
    	var selected=document.all.ce.value;
    	var selected1=document.all.zhang.value;
    	createXMLHttpRequest();
    	xmlHttp.onreadystatechange=updateS;
    	xmlHttp.open("GET","../afuer/ShowQuotaXml?lb="+selected+"&zhang="+selected1);
    	xmlHttp.send(null);
  	}
  	function updateS(){
	     if(xmlHttp.readyState==4){
	        if(xmlHttp.status==200){
	        
	           var doc = new ActiveXObject("MSxml2.DOMDocument")
	           doc.loadXML(xmlHttp.responseText);
	           result=doc.getElementsByTagName("lb");
	           while(document.all.zhang.options.length>0){
	             document.all.zhang.removeChild(document.all.zhang.childNodes[0]);
	           }
	           //加空的章
	           var nuoption1 = document.createElement("OPTION");
	           nuoption1.value ="";
	           document.all.zhang.options.add(nuoption1);
	           
	           for(var i=0;i<result.length;i++){
	             var option=document.createElement("OPTION");
	             option.text=result[i].childNodes[0].childNodes[0].nodeValue;
	             option.value=result[i].childNodes[1].childNodes[0].nodeValue;
	             document.all.zhang.options.add(option);
	           }
	            result1=doc.getElementsByTagName("lb1");
	           while(document.all.jie.options.length>0){
	             document.all.jie.removeChild(document.all.jie.childNodes[0]);
	           }
	           //加空的节
	           var nuoption2 = document.createElement("OPTION");
	           nuoption2.value ="";
	           document.all.jie.options.add(nuoption2);
	           
	           for(var i=0;i<result1.length;i++){
	             var option=document.createElement("OPTION");
	             option.text=result1[i].childNodes[0].childNodes[0].nodeValue;
	             option.value=result1[i].childNodes[1].childNodes[0].nodeValue;
	             document.all.jie.options.add(option);
	           }
	        }
	     }
  	}	
  	//清除章节册
  	function clearZjc(){
	var s_dek = document.form1.D1.value;
	if(s_dek!=""){
		var c = document.form1.ce;
		c.options[c.options.length-1].selected = true;
		document.form1.zhang.options.length = 0;
		document.form1.jie.options.length = 0;
	}
	}
</script>
  </head>
  <%
  Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
  Integer user_id=yh.getId();
  HSql = "select gb05 from Gb05_yhk gb05 where gb05.lb='DE' and (id=1 or cjr_id="+user_id+")";
  ro = queryService.search(HSql);
  %>
  <body topmargin="0" leftmargin="0">    
     <table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" height="100%">
		<tr>
			<td colspan="2" height="50" id="search-head">
   			   <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%">
					<tr>
						<td valign="bottom"><img src="../images/txde.gif" border="0"/></td>
					</tr>	
					<tr>
						<td height="15" background="../images/main-images/gypms_main_bar_bg.gif"></td>
					</tr>	
				</table>
			</td>
		</tr>
		<tr>
			<td>
			<form name="form1" method="post" action="display.jsp" target="mainFrame">
  				<table width="100%" height="89" border="0" cellpadding="0" cellspacing="0">
  					<tr>
      				 <td></td>
      				 <td>&nbsp;&nbsp;定&nbsp;额&nbsp;库：</td><td>
      				 <select name="select">
      				 <option value="">--全部查询--</option>
      				  <%
         
          while(ro.next()){
          	
             list_Gb05=(Gb05_yhk) ro.get("gb05");
          %>
        			<option value="<%=StringFormatUtil.format(list_Gb05.getId())%>"><%=StringFormatUtil.format(list_Gb05.getMc())%></option>
        	<%} %> 
       		 		</select></td>
       				 <td>输入定额编号或名称：</td><td>
       				 <input type="text" name="searchKey"  value="" onkeypress="javascript:if(event.keyCode==13) document.form1.submit();"></td>
     				 <td>定额起始编号：</td><td><input type="text" name="bt_id" value=""></td>
        			 <td>定额结束编号：</td><td><input type="text" name="ft_id"> </td>
   				</tr>
   				<tr>
   				     <td></td>
       				 <td>&nbsp;&nbsp;定&nbsp;额&nbsp;册：</td><td>
       				 <select siz1="1" name="ce" id="ce" style="width:100%;height:20px;" onChange="updateSelect()">
		        				<option value="1" <%if(ce.intValue()==1){%> selected <%}%>>通信电源设备安装工程</option>
		        				<option value="2" <%if(ce.intValue()==2){%> selected <%}%>>有线通信设备安装工程</option>
		        				<option value="3" <%if(ce.intValue()==3){%> selected <%}%>>无线通信设备安装工程</option>
		        				<option value="4" <%if(ce.intValue()==4){%> selected <%}%>>通信线路工程</option>
		        				<option value="5" <%if(ce.intValue()==5){%> selected <%}%>>通信管道工程</option>
		        				</select></td>
     				 <td>章：</td><td>
     				 <select siz1="1" name="zhang" id="zhang" style="width:100%;height:20px;" onChange="updateSelectZ()">
		        				<option value=""></option>
		        				<%Ga12_dez data8;
								QueryBuilder queryBuilder8= new HibernateQueryBuilder(Ga12_dez.class);
								queryBuilder8.eq("c_id",ce);
								ResultObject ro8= queryService.search(queryBuilder8);
		        				while(ro8.next()){ 
		        					data8=(Ga12_dez)ro8.get(Ga12_dez.class.getName());
		        					if(data8!=null){
		        				%>
		        				<option value="<%=data8.getId() %>" <%if(zhang.intValue()==data8.getId().intValue()){%> selected <%}%> ><%=data8.getMc()%></option>
		        				<%}}%>
		        				<%if(ce.intValue()==0){ %>
		        				<option value="1">安装与调试高、低压供电设备</option>
		        				<option value="2">安装与调试发电机设备</option>
		        				<option value="3">安装交直流电源设备、不间断电源设备及配套装置</option>
		        				<option value="4">敷设电源母线、电力电缆及终端制作</option>
		        				<option value="5">接地装置</option>
		        				<option value="6">安装附属设施及其他</option>
		        				<%} %>
		        				</select></td>
        			 <td>节：</td><td>
        			 <select siz1="1" name="jie" id="jie" style="width:100%;height:20px;" onChange="">	
		        				<option value=""></option>
		        				<%	Ga13_dej data9=null;
							        QueryBuilder queryBulider9 = new HibernateQueryBuilder(Ga13_dej.class);
							        queryBulider9.eq("z_id", zhang);
							        queryBulider9.addOrderBy(Order.asc("id"));
							        ResultObject ro9=queryService.search(queryBulider9);
							        while(ro9.next()){
							        	data9=(Ga13_dej)ro9.get(Ga13_dej.class.getName());
							        	if(data9!=null){
							    %>
							    <option value="<%=data9.getId() %>" <%if(data9.getId().intValue()==jie.intValue()){%> selected <%} %>><%=data9.getMc()%></option>
							    <%}}%>
							  		
		        				</select></td>
        			 <td></td>
        			 <td><input type="submit" value="查询"/></td>
   				</tr>
   				 
  			</table>
  			</form>
		</td>
		</tr>
</table>

  </body>
</html>
