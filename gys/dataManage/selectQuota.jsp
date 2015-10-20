<%@ page contentType="text/html; charset=gbk"%>
<%@ page import="java.util.List"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.dataObject.Ga13_dej" %>
<%@ page import="com.netsky.dataObject.Ga01_de" %>
<%@ page import="com.netsky.dataObject.Ga12_dez" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%@ page import="com.netsky.dataObject.Gb05_yhk" %>
<%@ page import="org.hibernate.criterion.MatchMode" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%
 
 	request.setCharacterEncoding("gb2312");
 	String formTr = StringFormatUtil.format(request.getParameter("fromTr"));
 	String stable = StringFormatUtil.format(request.getParameter("stable"));
 	String keyField = StringFormatUtil.format(request.getParameter("keyField"));
 	
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession()
			.getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);

	String bh=request.getParameter("searchBh");
	String mc=request.getParameter("searchMc");
	String delb="";
	if(request.getParameter("delb")!=null && !request.getParameter("delb").equals("")){
		delb=request.getParameter("delb");
	}
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
	String dek="";
	if(request.getParameter("D1")!=null){
		dek=request.getParameter("D1");
	}
	String mrz="1.00";
	if(request.getParameter("mrz")!=null){
		mrz=request.getParameter("mrz");
	}else{
		mrz=new String("0.00");
	}
	
	Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    Integer user_id=yh.getId();
    String HSql = "select gb05 from Gb05_yhk gb05 where gb05.lb='DE' and (id=1 or cjr_id="+user_id+" or gxbz=1) order by id desc";
    ResultObject ro99 = queryService.search(HSql);
 %>
<html>
<head>
<title>选择定额</title>
<link href="../css/list.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../js/functionlib.js"></script>
<script language="javascript" src="../js/multiTableSave.js"></script>
<script language="javascript" src="../js/selectItem.js"></script>
<script type="text/javascript">
	function selectCl(obj){
		var ro = "<%=request.getParameter("ro")%>";
		table=(window.opener.document.getElementById("list-table")).children[0];
		table.rows[ro].children[1].children[0].value = obj.children[0].children[0].value;
		table.rows[ro].children[2].children[0].value = obj.children[1].children[0].value;
		table.rows[ro].children[3].children[0].value = obj.children[2].children[3].value;
		table.rows[ro].children[4].children[0].value = obj.children[2].children[0].value;
		table.rows[ro].children[5].children[0].value = obj.children[2].children[1].value;
		table.rows[ro].children[6].children[0].value = obj.children[2].children[2].value;		
	}
	function openSelectPage(obj,xh,clbh){
		selectItem(obj,'values'+xh,'|',false,clbh,3);
		var table = sourceTable.rows[fromTr-1];		
		table.cells[11].children[0].checked = true;
		table.cells[12].children[0].checked = true;
		table.cells[13].children[0].checked = true;
		table.cells[14].children[0].checked = true;
		table.cells[9].children[0].value = "1.00";
	}
</script>
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
<body topmargin="0" leftmargin="0" id="main-body" onLoad="setDefaultGv('<%=formTr%>','<%=stable%>');" scroll="yes">
<div align="center">
	<table width="700" border="0" cellspacing="0" cellpadding="0">
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
						                	<td>定额选择</td>
					        		</tr>
					        	</table>
					        </td>
					         <td width="10"><img src="../images/main-images/gypms_main_bar_right.gif" width="10" height="40"></td>
				        </tr>
			        </table>
		        </td>
	        </tr>      
	        <tr>
		        <td align="center" bgcolor="#f8f8f8" height="28" valign="middle" style="border:solid 1px #a4bec8;">
	<form name="form1" method="post" action="selectQuota.jsp?value=<%=request.getParameter("value")%>
				      		&value1=<%=request.getParameter("value1")%>&value2=<%=request.getParameter("value2")%>&ro=<%=request.getParameter("ro")%>&search=yes">
		        <table border="0" cellpadding="0" style="border-collapse:collapse;height:14px;" width="95%">
				     
				      	<input type="hidden" name="fromTr" value="<%=formTr%>">
						<input type="hidden" name="stable" value="<%=stable%>">
						<input type="hidden" name="keyField" value="<%=keyField%>">
				      <input type="hidden" name="perproty" value="de_id,Ga01_de,ID/D1/ce/bh/mc/zhang/jie/mrz/delb">
						<tr>
							<td colspan="4">&nbsp;</td>
						</tr>
		        		<tr>
		        			<td width="12%" align="right">定额册：</td>
		        			<td width="40%">
		        				<select siz1="1" name="ce" id="ce" style="width:100%;height:20px;" onChange="updateSelect()">
		        				<option value=""></option>
		        				<option value="1" <%if(ce.intValue()==1){%> selected <%}%>>通信电源设备安装工程</option>
		        				<option value="2" <%if(ce.intValue()==2){%> selected <%}%>>有线通信设备安装工程</option>
		        				<option value="3" <%if(ce.intValue()==3){%> selected <%}%>>无线通信设备安装工程</option>
		        				<option value="4" <%if(ce.intValue()==4){%> selected <%}%>>通信线路工程</option>
		        				<option value="5" <%if(ce.intValue()==5){%> selected <%}%>>通信管道工程</option>
		        				</select>
		        			</td>
		        			<td width="15%" align="right">&nbsp;<!-- 定 额 库： --></td>
		        			<td width="33%">&nbsp;
			        			<!--  
			        			<select size="1" name="D1" id="D1" style="width:100%;height:20px;" onChange="clearZjc()">
			        			<%
			        				 while(ro99.next()){
			        					 Gb05_yhk yhk=(Gb05_yhk)ro99.get("gb05");
			        					 if(yhk.getId()!=null){
			        			 %>
			        			<option value="<%=yhk.getId()%>"  <%if(dek.equals(yhk.getId().toString())){%> selected <%} %>><%=yhk.getMc()%></option>
			        			<%}} %>
			        			</select>
			        			-->
		        			</td>
		        		</tr>
		        		<tr>
		        			<td align="right">章：</td>
		        			<td width="40%">
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
		        				</select>
		        			</td>
		        			<td width="15%" align="right">定额编号：</td>
		        			<td width="33%"><input type="text" name="searchBh" id="searchBh" <%if(bh!=null&&!bh.equals("")){ %> value="<%=bh %>" <%}%>class="search" style="width:100%;height:20px;"></td>
		        		</tr>
						<tr>
		        			<td align="right">节：</td>
		        			<td width="40%">
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
							  		
		        				</select>
		        			</td>
		        			<td align="right">定额名称：</td>
		        			<td><input type="text" name="searchMc" id="searchMc"<%if(mc!=null&&!mc.equals("")){%> value="<%=mc%>"<%} %> class="search" style="width:100%;height:20px;"></td>
		        		</tr>
		        		<tr>
		        			<td align="right">数量：</td>
		        			<td><input type="text" onblur="javascript:this.value = Math.round(this.value*1000)/1000;" name="mrz" value="<%if(mrz!=null){out.print(NumberFormatUtil.roundToString(mrz,3));}else{out.print(0.000);}%>" style="width:100%;height:20px;"> </td>
		        			<td align="right">类&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
		        			<td align="center"><select name="delb">
			        				<option value="">--类别--</option>
			        				<option value="GD" <%if(delb.equals("GD")){ %>selected<%}%>>管道</option>
			        				<option value="XL" <%if(delb.equals("XL")){ %>selected<%}%>>线路</option>
			        				<option value="SB" <%if(delb.equals("SB")){ %>selected<%}%>>设备</option>
		        				</select>&nbsp;&nbsp;&nbsp;
		        				<input type="button" value=" 查 询 " onclick="javascript:document.form1.submit();" class="but" style="height:20px;">&nbsp;&nbsp;</td>	        			
		        		</tr>
			        </table>
			        </form> 
		        </td>
	        </tr>
        </table>
	<table border="0" cellpadding="0" cellspacing="0" width="700" style="border-collapse:collapse;background:#ffffff" id="list">
		<tr>
			<td class="list_title" width="100" align="center">定额编号</td>
			<td class="list_title" align="center">定额名称</td>
			<td class="list_title" width="80" align="center">单位</td>
			<td class="list_title" width="100" align="center">技工工日</td>
			<td class="list_title" width="100" align="center">普工工日</td>
		</tr>
		<%  
		    boolean haveCondition = false;
		    int counter=0;
		    /**
		    * 得到册、章、节对应的起始定额编号和终止定额编号
		    */
			String p_ce = null;
			String p_zhang = null;
			String p_jie = null;
			p_ce = StringFormatUtil.format(request.getParameter("ce"));
			p_zhang = StringFormatUtil.format(request.getParameter("zhang"));
			p_jie = StringFormatUtil.format(request.getParameter("jie"));
			
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga13_dej.class);
			if(!p_ce.equals("")){
				queryBuilder.eq("c_id",new Integer(p_ce));
				haveCondition = true;
			}
			
			if(!p_zhang.equals("")){
				queryBuilder.eq("z_id",new Integer(p_zhang));
				haveCondition = true;
			}
			
			if(!p_jie.equals("")){
				queryBuilder.eq("id",new Integer(p_jie));
				haveCondition = true;
			}
			List list = queryService.searchList(queryBuilder) ;
			
			/**
			*获得定额列表
			*/
			StringBuffer sql = new StringBuffer("");
			sql.delete(0,sql.length());
			sql.append(" select bh,mc,dw,jggr,pggr,bz,lb,xj from Ga01_de where xj = '新'");
			if(bh!=null&&!bh.equals("")){
				sql.append(" and bh like '");
				sql.append(bh);
				sql.append("'");
				haveCondition = true;
			}
			if(mc!=null&&!mc.equals("")){
				sql.append(" and mc like '");
				sql.append(mc);
				sql.append("'");
				haveCondition = true;
			}
			if(delb!=null&&!delb.equals("")){
				sql.append(" and lb = '");
				sql.append(delb);
				sql.append("'");
				haveCondition = true;
			}
			
			if(list!=null && list.size() > 0){
				sql.append(" and ((1>1) ");
				for(Object obj:list){
					Ga13_dej dej = (Ga13_dej)obj;
					sql.append(" or (bh >= '");
					sql.append(dej.getQsbh());
					sql.append("'");
					sql.append(" and bh <= '");
					sql.append(dej.getJzbh());
					sql.append("')");
				}
				sql.append(") ");
			}
			if(!haveCondition){
				sql.append(" and 1 > 1 ");
			}
			sql.append(" order by bh");
			ResultObject ro = queryService.search(sql.toString());
			while(ro.next()){
				String t_bh = (String)ro.get("bh");
				String t_mc = (String)ro.get("mc");
				Double t_jggr = (Double)ro.get("jggr");
				Double t_pggr = (Double)ro.get("pggr");
				String t_dw = (String)ro.get("dw");
					++counter;
		%>
			<div  id="values<%=counter%>">
				<input type="hidden" name="Gd05_b3j.DEBH" value="<%=t_bh%>">
				<input type="hidden" name="Gd05_b3j.DEMC" value="<%=t_mc%>">
				<input type="hidden" name="Gd05_b3j.DW" value="<%=t_dw%>">
				<input type="hidden" name="Gd05_b3j.JGGR" value="<%=t_jggr%>">
				<input type="hidden" name="Gd05_b3j.PGGR" value="<%=t_pggr%>">
				<input type="hidden" name="Gd05_b3j.SL" value="<%=NumberFormatUtil.roundToString(mrz,3)%>">
			</div>
			<tr onmouseover="style.backgroundColor='#dce8ec'" onmouseout="style.backgroundColor='#ffffff'" onDblclick="javascript:openSelectPage(this,<%=counter%>,'<%=t_bh%>');" title="双击选择定额">
				<td  width="100" align="left"><%=t_bh%></td>
				<td  align="left" ><%=t_mc%></td>
				<td  width="80" align="center" ><%=t_dw%>
					<input type="hidden" name="Ga01_de.DW" align="right" readonly value="" class="td-input-noborder">
					<input type="hidden" name="Ga01_de.jGGR" value="<%=NumberFormatUtil.roundToString(t_jggr)%>">
					<input type="hidden" name="Ga01_de.PGGR" value="<%=NumberFormatUtil.roundToString(t_pggr)%>">
					<input type="hidden" name="aaa" value="<%=mrz%>">
				</td>
				<td  align="center" ><%=t_jggr%>
				<td  align="center" ><%=t_pggr%>
			</tr>
		<%}%>
	</table>
	<br>
	<br>
</body>
</html>
