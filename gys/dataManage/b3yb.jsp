<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.service.ExpenseService" %>
<%@ page import="com.netsky.dataObject.Gd06_b3y"%>
<%@ page import="com.netsky.dataObject.Gd05_b3j"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Gd10_b3fl"%>
<%@ page import="com.netsky.dataObject.Ga09_kcxs" %>
<%@ page import="com.netsky.baseObject.*"%>
<%@ page import="com.netsky.baseFormatUtils.*"%>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%> 

<%
	Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    if(yh==null)
    {
      %> <script language="javascript"> window.location.href="../index.jsp"; </script> <%
      return;
    }

	String lb = request.getParameter("bgxx_id");
	String lbmc = "";
	if(lb == null || lb.equals("5")) lbmc = "机械";
	else lbmc = "仪表";
	
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	ExpenseService expenseService = (ExpenseService) ctx.getBean(ServiceName.ExpenseService);
	Integer dxgc_id= new Integer(request.getParameter("dxgc_id"));
	Integer gcxm_id= new Integer(request.getParameter("gcxm_id"));
	
	QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd06_b3y.class);
	queryBuilder.eq("dxgc_id",dxgc_id);
	queryBuilder.eq("gcxm_id",gcxm_id);
	queryBuilder.eq("lb",new String("JX"));
	queryBuilder.addOrderBy(Order.asc("xh"));
	ResultObject ro = queryService.search(queryBuilder);
	
	QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd06_b3y.class);
	queryBuilder9.eq("dxgc_id",dxgc_id);
	queryBuilder9.eq("gcxm_id",gcxm_id);
	queryBuilder9.eq("lb",new String("YB"));
	queryBuilder9.addOrderBy(Order.asc("xh"));
	ResultObject ro9 = queryService.search(queryBuilder9);
	
	QueryBuilder queryBuilder11 = new HibernateQueryBuilder(Gd02_dxgc.class);
	queryBuilder11.eq("gcxm_id",gcxm_id);
	queryBuilder11.eq("id",dxgc_id);
	ResultObject dxgcro = queryService.search(queryBuilder11);
	Gd02_dxgc dxgc= new Gd02_dxgc();
	if(dxgcro.next()){	
		dxgc = (Gd02_dxgc)dxgcro.get(Gd02_dxgc.class.getName());
	}
	Integer biaozhi=dxgc.getB3_sgtj_bz();
	String jsjd = "";
	if(dxgc.getJsjd().intValue() == 1){
		jsjd = "概算";
	}else if(dxgc.getJsjd().intValue() == 2){
		jsjd = "预算";
	}else if(dxgc.getJsjd().intValue() == 3){
		jsjd = "结算";
	}else if(dxgc.getJsjd().intValue() == 4){
		jsjd = "决算";
	}
	
	//重取费率
	if(request.getParameter("chongqufy")!=null&&request.getParameter("chongqufy").equals("1")){
		expenseService.reBuildFy(dxgc,new String("B3Y"),request);
	}
	
	QueryBuilder queryBuilder12 = new HibernateQueryBuilder(Gd10_b3fl.class);
	queryBuilder12.eq("gcxm_id",gcxm_id);
	queryBuilder12.eq("dxgc_id",dxgc_id);
	queryBuilder12.eq("fylb",new Integer(1));
	queryBuilder12.eq("bz",new Integer(1));//取高原的
	ResultObject ro12= queryService.search(queryBuilder12);
	Gd10_b3fl data12= new Gd10_b3fl();

	QueryBuilder queryBuilder13 = new HibernateQueryBuilder(Gd10_b3fl.class);
	queryBuilder13.eq("gcxm_id",gcxm_id);
	queryBuilder13.eq("dxgc_id",dxgc_id);
	queryBuilder13.eq("fylb",new Integer(1));
	queryBuilder13.eq("bz" ,new Integer(2));//取沙漠森林的
	ResultObject ro13 = queryService.search(queryBuilder13);
	Gd10_b3fl data13 = new Gd10_b3fl();
	
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>表三甲</title>
<script language="javascript" src="../js/functionlib.js"></script>
<script language="javascript" src="../js/multiTableSave.js"></script>
<script language="javascript" src="../js/selectItem.js"></script>
<script language="javascript" src="../js/calculateTotal.js"></script>
<link href="../css/data.css" rel="stylesheet" type="text/css">
<script language="javascript">
function renew(){
	if(confirm('确定按定额重新生成？'))   
    {   
	  document.form1.action="../afuer/SaveB3yb?gcxm_id="+<%=gcxm_id%>+"&dxgc_id="+<%=dxgc_id%>+"&bgxx_id="+<%=lb%>+"&renew="+<%=new Integer(1)%>;
	  document.form1.submit();
    }  
}
function save(){
	var obj = document.getElementById("list-table");
  	for(var i=3;i<obj.rows.length;i++){
  	  	if(obj.rows[i].cells[2].children[0].value=="" ){
  	  		clearRow(obj.rows[i]);
  	   	}
  	}
  	var listtable= document.getElementById("list-table");
	var rowlength=listtable.rows.length-3; 
  	rowsSortSave("list-table",rowlength,3);
  	for(var i=3;i<obj.rows.length;i++){
  		if(obj.rows[i].cells[1].children[0].value==""){
  			if(obj.rows[i].cells[2].children[0].value==""){	
  			}else{
  				alert("定额编号不能为空！");
  				return;
  			} 			
  		}else{
			if(obj.rows[i].cells[13].children[0].value==""||obj.rows[i].cells[13].children[0].value==0){
				alert("调整系数不能为空或为0！");
  				return;
  			}
		}
  	}
  	if(listValidateChk("form1","Demc")){
	 	document.form1.action="../afuer/SaveB3yb?gcxm_id="+<%=gcxm_id%>+"&dxgc_id="+<%=dxgc_id%>+"&bgxx_id="+<%=lb%>+"&biaozhi="+<%=biaozhi%>;
	    document.form1.submit(); 
    }
}
function delRow(obj){
 	var listtable= document.getElementById("list-table");
 	deleteRow(listtable.rows[obj]);
 	var rowlength=listtable.rows.length-3; 
	rowsSort("list-table",rowlength,3);//调用排序，id="list-table"；有效数据长度objlen；表头三行；
}

function showsetting(){
	var settingstyle = document.all("setting").style.display;
	if (settingstyle=="none"){
		document.all("setting").style.display="block";
	}else{
		document.all("setting").style.display="none";
	}
}

//以下是键盘按下选定额
var xmlHttp;
  function createXMLHttpRequest(){
   	if(window.ActiveXObject){
     	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
   	}else if(window.XMLHttpRequset){
     	xmlHttp=new XMLHttpRequset();
   	}
  }
  var aj;
  function send(event,a){//如果按了回车键把相关信息带出来
	if(event.keyCode==13) {//键盘按下Enter键 
	 	if(a.children[0].value==""){
	    	alert("定额编号不能为空！");
	    	return;
	    }
		aj=a;
		createXMLHttpRequest();
    	xmlHttp.onreadystatechange=update;
    	xmlHttp.open("GET","../afuer/keyEnterYB?fl=0&bh="+a.children[0].value+"&dxgc_id="+<%=dxgc_id%>+"&gcxm_id="+<%=gcxm_id%>);
    	xmlHttp.send(null);
	}
  }
  function update(){
     if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           var doc = new ActiveXObject("MSxml2.DOMDocument")
           doc.loadXML(xmlHttp.responseText);
           result=doc.getElementsByTagName("de");
           if(result[0].childNodes[3].childNodes[0].nodeValue=="null"){
           		alert("该定额不在表三甲中!");
           		return;
           }
           table=(document.getElementById("list-table")).children[0];
           var i=aj.parentNode.rowIndex;
           table.rows[i].children[1].children[0].value=result[0].childNodes[0].childNodes[0].nodeValue;
           table.rows[i].children[2].children[0].value=result[0].childNodes[1].childNodes[0].nodeValue;  
           table.rows[i].children[3].children[0].value=result[0].childNodes[2].childNodes[0].nodeValue; 
           table.rows[i].children[4].children[0].value=result[0].childNodes[3].childNodes[0].nodeValue;
           table.rows[i].children[13].children[1].value=result[0].childNodes[4].childNodes[0].nodeValue;             
        }
     }
  }
  
//以下是键盘按下选材料
var xmlHttp1;
   function createXMLHttpRequest1(){
   	if(window.ActiveXObject){
     	xmlHttp1=new ActiveXObject("Microsoft.XMLHTTP");
   	}else if(window.XMLHttpRequset){
     	xmlHttp1=new XMLHttpRequset();
   	}
  }
  var cl;
  function sendcl(event,a){//如果按了回车键把相关信息带出来
	if(event.keyCode==13) {//键盘按下Enter键 
	 	if(a.children[0].value==""){
	    	alert("该材料不存在!");
	    	return;
	    }
		cl=a;
		createXMLHttpRequest1();
    	xmlHttp1.onreadystatechange=update1;
    	xmlHttp1.open("GET","../afuer/keyEnterYB?fl=1&lb="+a.children[1].value+"&clbh="+a.children[0].value+"&dxgc_id="+<%=dxgc_id%>+"&gcxm_id="+<%=gcxm_id%>);
    	xmlHttp1.send(null);
	}
  }
  function update1(){
     if(xmlHttp1.readyState==4){
        if(xmlHttp1.status==200){
           var doc = new ActiveXObject("MSxml2.DOMDocument")
           doc.loadXML(xmlHttp1.responseText);
           result=doc.getElementsByTagName("clsb");
           if(result[0].childNodes[1].childNodes[0].nodeValue=="null"){
           		alert("该材料不存在!");
           		return;
           }
           table=(document.getElementById("list-table")).children[0];
           var i=cl.parentNode.rowIndex;
           table.rows[i].children[5].children[0].value=result[0].childNodes[0].childNodes[0].nodeValue;
           table.rows[i].children[6].children[0].value=result[0].childNodes[1].childNodes[0].nodeValue;  
           table.rows[i].children[7].children[0].value=result[0].childNodes[2].childNodes[0].nodeValue;
           if(result[0].childNodes[3].childNodes[0].nodeValue != "null"){ 
           		table.rows[i].children[8].children[0].value=result[0].childNodes[3].childNodes[0].nodeValue;
           }
           table.rows[i].children[10].children[0].value=result[0].childNodes[4].childNodes[0].nodeValue;             
        }
     }
  }
  
    //同步表三乙丙信息
  function xxtb()
  {
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=xxtbcl;
    xmlHttp.open("GET","../afuer/SynchronizeController?act=b3yb&dxgc_id="+<%=dxgc_id%>);
    xmlHttp.send(null);
  }
  
  function xxtbcl()
  {
    var fl;
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           jgf=xmlHttp.responseText;
           if(jgf=="b3yb")
           {
             alert("表三乙丙同步成功");
           }
        }
     }
  }
  
//在序号输入域中修改序号回车后，变幻当前定额到指定行
function cha(obj){	
	changerow(obj,"list-table",3);
}
//追加行
function zj(){
	addList("list-table",3);
	var listtable= document.getElementById("list-table");
	var rowlength=listtable.rows.length-3; 
	rowsSort("list-table",rowlength,3);//调用排序，id="list-table"；有效数据长度objlen；表头三行；
}
function checkxs(obj){
	var xs=obj.value;
    if(xs==""){
      alert("调整系数不能为空，默认为1");
      obj.value=1;
      obj.focus();
    }else{
      if(xs<=0){
        alert("调整系数不能小于等于0！");
        obj.value=1;
        obj.focus();
      }
    } 
}
function reBuildFy(){//用于重取表三费率
	document.form1.chongqufy.value=1;
	document.form1.submit();
}
function dbyl(obj){
  	var oRect = obj.getBoundingClientRect();  
  	var div = document.getElementById('menuDiv');
  	div.style.display='block';
  	div.style.top = oRect.top + 20;
  	div.style.left = oRect.left + 1;
  }
</script>
</head>

<body leftmargin="0" topmargin="0" id="main-body" style="height:100%" onload="javascript:addNumSelect()">
<div id="menuDiv" onmouseover="javascript:this.style.display='block';" onmouseout="javascript:this.style.display='none';" style="display:none;position: absolute;left:351;top:39;width:88;background-color:#FFFFFF;border:1px solid gray">
<table border="0" width="100%">
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="allwinOpen('../print/print.jsp?type=print&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%if(lb.equals("5")){out.print(5);}else if(lb.equals("6")){out.print("6");}%>')">单表预览</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=pdf&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%if(lb.equals("5")){out.print(5);}else if(lb.equals("6")){out.print("6");}%>');">PDF输出</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=doc&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%if(lb.equals("5")){out.print(5);}else if(lb.equals("6")){out.print("6");}%>');">WORD输出</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../export/SingleProject_excel.jsp?dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%if(lb.equals("5")){out.print(5);}else if(lb.equals("6")){out.print("6");}%>');">EXCEL输出</td>
	</tr>
</table>
</div>
<table border="0" cellpadding="2" style="height:45px;border-collapse:collapse;" width="100%">
	<tr>
		<td style="height:15px"></td>
	</tr>
	<tr>
		<td style="vertical-aling:bottom;">
			<%if(dxgc.getGdsj() == null){ %>
			&nbsp;<input type="button" name="b1" value=" 保存信息 " onclick="save()">
			<!--
			<%if(yh.getOperate()!=null&&yh.getOperate().intValue()==1){ %>
			&nbsp;<input type="button" name="" value=" 信息同步 " onClick="xxtb()"> 
			<%} %>
			-->
			&nbsp;<input type="button" name="b2" value=" 追加行 " onclick="zj()">
			&nbsp;<input type="button" style="width:110px;" name="b2" value=" 按定额重新生成 " onclick="renew()">
			<!--  
			<%if(lb.equals("5")){%>
			&nbsp;<input type="button" name="b" style="width:110px;" value=" 重取表三乙费率 " onclick="javascript:reBuildFy()">
			<%}%> 
			-->
			<%}%>
			&nbsp;<input type="button" name="b2" value=" 单表预览 " onclick="javascript:dbyl(this);">
			&nbsp;<input type="button" name=""   value=" 全部预览 "onclick="javascript:winOpen('../print/SingleProject_print.jsp?gcxm_id=<%=request.getParameter("gcxm_id")%>&dxgc_id=<%=request.getParameter("dxgc_id")%>'
					,'580','295','0')" > 
		</td>
	</tr>
</table>
<div style="width:100%;background:#ffffff;">
<form name="form1" method="post" action="">
<input type="hidden" id="chongqufy" name="chongqufy" value="0">
<div class="file_title">
	<%if(lb.equals("5")){%>建筑安装工程机械使用费<%=jsjd%>表（表三）乙<%}%>
	<%if(lb.equals("6")){%>建筑安装工程仪器仪表使用费<%=jsjd%>表（表三）丙<%}%>
</div>
	<div style="text-align:left;color:1E4F75;font-size:13px;font-weight:bold;padding:3px 0px;"><img src="../images/setting.gif" border="0" onClick="showsetting()" style="cursor:hand;"></div>
		<div align="left">		
		<div id="setting" style="display:none;">
		<table border="0" cellpadding="0" style="border-collapse: collapse;background-color:#f0f0f0;border:solid 1px #cccccc" width="98%">
		<tr style="height:6px;">
			<td colspan="6" align="center"><div style="position:relative;"><div style="position:absolute;right:2px;cursor: hand;"><img src="../images/ca.jpg" border="0" onClick="showsetting()"></div></div></td>
		</tr>
		<tr>
			<td width="30" align="right">※ </td>
			<td>费用调整</td>
			<td width="30" align="right">　</td>
			<td>　</td>
			<td width="30" align="right"> </td>
			<td></td>
		</tr>
		<%if(lb==null || lb.equals("5")){%>
		<tr>
			<td></td>
			<td valign="top">
				机械使用费合计值调整系数： <input onblur="checkxs(this)" type="text" name="B3_JXF_TZXS" 
				value="<%if(dxgc.getB3_jxf_tzxs()!=null){out.print(NumberFormatUtil.roundToString(dxgc.getB3_jxf_tzxs()));}else{out.print("1.00");}%>" style="width:70px;color:red;">			
			</td>	
			<td></td>
			<td>机械单价：<select name="B4_JXJG">
							<option value="BDJ" <%if(dxgc.getB3_jxjg()!=null&&dxgc.getB3_jxjg().equals("BDJ")){%>selected<%}%>>本地价</option>
							<option value="BSJ" <%if(dxgc.getB3_jxjg()!=null&&dxgc.getB3_jxjg().equals("BSJ")){%>selected<%}%>>本省价</option>
							<option value="QGJ" <%if(dxgc.getB3_jxjg()!=null&&dxgc.getB3_jxjg().equals("QGJ")){%>selected<%}%>>全国价</option>
							<option value="YSJ" <%if(dxgc.getB3_jxjg()!=null&&dxgc.getB3_jxjg().equals("YSJ")){%>selected<%}%>>预算价</option>
						  </select>
			</td>	
		</tr>
		<%if(dxgc.getB3_sgtj_bz()!=null&&dxgc.getB3_sgtj_bz().intValue()==0) {%>
		<tr>
			<td width="30" align="right">※ </td>
			<td> 高原地区</td>
			<td width="30" align="right">※ </td>
			<td>森林及沙漠地区</td>
		</tr>
		<tr>
			<td></td>
			<td valign="top">
				<input type="radio" name="B3_GYDQ_BZ" value="1" checked>正常地区<br>
				<%
					while(ro12.next()){
					data12=(Gd10_b3fl)ro12.get(Gd10_b3fl.class.getName());
					if(data12.getId()!=null){
				 %>
				 <input type="radio" name="B3_GYDQ_BZ" value="<%=data12.getId()%>" 
				 	<%if(data12.getFlag()!=null){if(data12.getFlag().intValue()==1){ %>checked<%} }%> 
				 	><%=data12.getMc()%>：<input type="text" name="gy<%=data12.getId().intValue()%>" 
				 	value="<%if(data12.getJxfl()!=null){out.print(NumberFormatUtil.roundToString(data12.getJxfl()));}%>"style="width:66px;color:red;"><br>
				 <%} }%>			
			</td>
			<td></td>
			<td valign="top">
				<input type="radio" name="B3_SLSM_BZ" value="1" checked>正常地区<br>
				<%
				while(ro13.next()){
					data13=(Gd10_b3fl)ro13.get(Gd10_b3fl.class.getName());
					if(data13.getId()!=null){
				 %>
				 <input type="radio" name="B3_SLSM_BZ" value="<%=data13.getId()%>" 
				 	<%if(data13.getFlag()!=null&&data13.getFlag().intValue()==1){%>checked<%}%> 
				 	><%=data13.getMc()%>：<input type="text" name="sl<%=data13.getId().intValue()%>" 
				 	value="<%if(data13.getJxfl()!=null){out.print(NumberFormatUtil.roundToString(data13.getJxfl()));}%>"style="width:66px;color:red;"><br>
				 <%}} %>
				</td>
		</tr>
		<%}%>
		<%}else{%>
		<tr>
			<td></td>
			<td valign="top">
				仪器仪表使用费合计值调整系数： <input onblur="checkxs(this)" type="text" name="B3_YBF_TZXS" 
				value="<%if(dxgc.getB3_ybf_tzxs()!=null){out.print(NumberFormatUtil.roundToString(dxgc.getB3_ybf_tzxs()));}else{out.print("1.00");}%>" style="width:70px;color:red;">
			</td>
			<td></td>
			<td valign="top">
				仪表单价：<select name="B4_YBJG">
							<option value="BDJ" <%if(dxgc.getB3_ybjg()!=null&&dxgc.getB3_ybjg().equals("BDJ")){%>selected<%}%>>本地价</option>
							<option value="BSJ" <%if(dxgc.getB3_ybjg()!=null&&dxgc.getB3_ybjg().equals("BSJ")){%>selected<%}%>>本省价</option>
							<option value="QGJ" <%if(dxgc.getB3_ybjg()!=null&&dxgc.getB3_ybjg().equals("QGJ")){%>selected<%}%>>全国价</option>
							<option value="YSJ" <%if(dxgc.getB3_ybjg()!=null&&dxgc.getB3_ybjg().equals("YSJ")){%>selected<%}%>>预算价</option>
						  </select>
			</td>
		</tr>
		<%}%>
		<tr style="height:6px;">
			<td colspan="6"> </td>
		</tr>
		</table>
	<br>
	</div>
	<table id="list-table" border="0" cellpadding="0" style="border-collapse: collapse" width="1260">
		<tr class="list-title">
			<td width="30" rowspan="2">序号</td>
			<td width="70" rowspan="2">定额编号</td>
			<td width="250" rowspan="2">定额名称</td>
			<td width="45" rowspan="2">定额<br>单位</td>
			<td width="70" rowspan="2">定额数量</td>
			<td width="70" rowspan="2"><%=lbmc%>编号</td>
			<td width="250" rowspan="2"><%=lbmc%>名称</td>
			<td width="50" rowspan="2">单位</td>
			<td width="80" rowspan="2">型号规格</td>
			<td width="140" colspan="2">单位定额值</td>
			<td width="140" colspan="2">合计值</td>
			<td width="70" rowspan="2">调整<br>系数</td>
		</tr>
		<tr class="list-title">
			<td width="70">数量<br>(台班)</td>
			<td width="70">单价<br>(元)</td>
			<td width="70">数量<br>(台班)</td>
			<td width="70">合价<br>(元)</td>
		</tr>
		<tr class="list-title">
			<td>1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
			<td>5</td>
			<td>6</td>
			<td>7</td>
			<td>8</td>
			<td>9</td>
			<td>10</td>
			<td>11</td>
			<td>12</td>
			<td>13</td>
			<td>14</td>
		</tr>
		<% if(lb.equals("5")){ 
			int i=0;
		  	while(ro.next()||i<15){
		  		i++;
		  		Gd06_b3y  data =  (Gd06_b3y)ro.get(Gd06_b3y.class.getName()); 
		  		if(data!=null){
		  		 	double hjz=0.00;//合计值
		  			QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd05_b3j.class);
		  			queryBuilder1.eq("id",data.getB3j_id());
		  			ResultObject ro1 = queryService.search(queryBuilder1);
		  			Gd05_b3j data1 = new Gd05_b3j();
		  			if(ro1.next()){
		  				data1 = (Gd05_b3j)ro1.get(Gd05_b3j.class.getName());
		  				double ckxsz =1.00;//拆扩系数
		  				hjz=NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
									data1.getSl().doubleValue(),data.getDj().doubleValue()),data.getGlsl().doubleValue()),data.getTzxs().doubleValue());
			  			StringBuffer mc = new StringBuffer(data1.getDemc());
			  			if (data1.getCk_bz() != null) {// 查询拆扩系数
							QueryBuilder queryBuilder4 = new HibernateQueryBuilder(Ga09_kcxs.class);
							queryBuilder4.eq("lb", data1.getCk_bz());
							queryBuilder4.eq("sort",new Integer(2));//类别：1是人工的；2是机械的
							queryBuilder4.ge("jzbh", data1.getDebh());//定额编号小于等于终止编号
							queryBuilder4.le("qsbh", data1.getDebh());//定额编号大于等于起始编号
							ResultObject ro4 = queryService.search(queryBuilder4);
							Ga09_kcxs ckxs = new Ga09_kcxs();
							if (ro4.next()) {
								ckxs = (Ga09_kcxs) ro4.get(Ga09_kcxs.class.getName());
									ckxsz = NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100);
									hjz = NumberFormatUtil.mulToDouble(ckxsz,hjz);
									if (data1.getCk_bz().intValue() == 1) {
										mc.append("（新建 机械×");
									} else if (data1.getCk_bz().intValue() == 2) {
										mc.append("（扩建 机械×");
									} else if (data1.getCk_bz().intValue() == 3) {
										mc.append("（拆除再利用 机械×");
									} else if (data1.getCk_bz().intValue() == 4) {
										mc.append("（拆除不再利用 机械×");
									} else if (data1.getCk_bz().intValue() == 5) {
										mc.append("（更换 机械×");
									}
									mc.append(NumberFormatUtil.roundToString(ckxs.getXs().doubleValue()));
									mc.append("%）");
							}
						}
						data1.setDemc(new String(mc));
		  			}
		%>
		<tr>
			<td title="双击删除这一行" ondblclick="javascript:if(confirm('确认删除吗？'))delRow(this.parentNode.rowIndex);">
				<input type="text" name="XH" onblur="cha(this.parentNode)"  style="text-align:center;" value="<%if(data.getXh()!=null){out.print(data.getXh());}else{out.print(i);}%>"></td>
			<td onkeypress="send(event,this)" title="双击选择定额" ondblclick="javascript:winOpen('../dataManage/gljxde.jsp?ro='+this.parentNode.rowIndex+'&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>','650','480','0')">
				<input type="text" name="Debh" value="<%=data1.getDebh()%>" ></td>
			<td><textarea name="Demc" id="Demc" readonly><%=data1.getDemc() %></textarea></td>
			<td><input type="text" name="DeDw"  style="text-align:center;" value="<%=data1.getDw()%>" readOnly></td>
			<td><input type="text" name="DeSl"  style="text-align:right;" value="<%=NumberFormatUtil.roundToString(data1.getSl(),3)%>" readOnly></td>
			<td onkeypress="sendcl(event,this)"  title="双击选择材料" ondblclick="javascript:openSelectWin(this,'list-table','selectMaterial.jsp?LB=JX&BGBH=B3Y&priceflag=<%=dxgc.getB3_jxjg()%>',650,450,1);">
				<input type="text" name="BH" value="<%=data.getBh()%>">
				<input type="hidden" name="" value="<%="JX"%>"></td> 
			<td><textarea name="MC" id="MC" readonly><%=data.getMc()%></textarea></td>
			<td><input type="text" name="DW" style="text-align:center;" value="<%=data.getDw()%>"></td>
			<td><textarea name="XHGG" id="XHGG" readonly><%=StringFormatUtil.format(data.getXhgg())%></textarea></td>
			<td><input type="text" name="GLSL" style="text-align:right;" value="<%=NumberFormatUtil.roundToString(data.getGlsl())%>"></td>
			<td><input type="text" name="DJ" style="text-align:right;" value="<%=NumberFormatUtil.roundToString(data.getDj())%>"></td>
			<td align="right"><%=NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data1.getSl().doubleValue(),data.getGlsl().doubleValue()))%></td>
			<td align="right"><%=NumberFormatUtil.roundToString(hjz)%></td>
			<td>
				<input type="text" name="TZXS" style="text-align:right;" value="<%=NumberFormatUtil.roundToString(data.getTzxs())%>">
				<input type="hidden" name="Gd06_b3y.B3J_ID" value="<%=data.getB3j_id()%>">
				<input type="hidden" name="Gd06_b3y.ID" value="<%=data.getId()%>">
			</td>
		</tr>
		<%}else{%>
		<tr>
			<td title="双击删除这一行"  ondblclick="javascript:if(confirm('确认删除吗？'))delRow(this.parentNode.rowIndex);">
				<input type="text" name="XH" onblur="cha(this.parentNode)"  style="text-align:center;" value="<%=i%>"></td>
			<td onkeypress="send(event,this)" title="双击选择定额" ondblclick="javascript:winOpen('../dataManage/gljxde.jsp?ro='+this.parentNode.rowIndex+'&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>','650','480','0')">
				<input type="text" name="Debh"  value="" ></td>
			<td><textarea name="Demc" id="Demc" readonly></textarea></td>
			<td><input type="text" name="DeDw"  value="" readOnly></td>
			<td><input type="text" name="DeSl"  style="text-align:right;" value="" readOnly></td>
			<td onkeypress="sendcl(event,this)" title="双击选择材料" ondblclick="javascript:openSelectWin(this,'list-table','selectMaterial.jsp?LB=JX&BGBH=B3Y&priceflag=<%=dxgc.getB3_jxjg()%>',650,450,1);">
				<input type="text" name="BH" value="">
				<input type="hidden" name="" value="<%="JX"%>"></td>
			<td><textarea name="MC" id="MC" readonly></textarea></td>
			<td><input type="text" name="DW" style="text-align:center;" value=""></td>
			<td><textarea name="XHGG" id="XHGG" readonly></textarea></td>
			<td><input type="text" name="GLSL" style="text-align:right;" value=""></td>
			<td><input type="text" name="DJ" style="text-align:right;" value=""></td>
			<td> </td>
			<td> </td>
			<td>
				<input type="text" name="TZXS" style="text-align:right;" value="">
				<input type="hidden" name="Gd06_b3y.B3J_ID" value="" >
				<input type="hidden" name="Gd06_b3y.ID" value="">
			</td>
		</tr>
		<%}}}%>
		
		<% if(lb.equals("6")){ 
			 int j=0;	
			 while(ro9.next()||j<15){
			 	j++;
		  		Gd06_b3y  data =  (Gd06_b3y)ro9.get(Gd06_b3y.class.getName()); 
		  		if(data!=null){
		  			QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd05_b3j.class);
		  			queryBuilder1.eq("id",data.getB3j_id());
		  			ResultObject ro1 = queryService.search(queryBuilder1);
		  			Gd05_b3j data1 = new Gd05_b3j();
		  			if(ro1.next()){
		  				data1 = (Gd05_b3j)ro1.get(Gd05_b3j.class.getName());
		  			}
		%>
		<tr>
			<td title="双击删除这一行"  ondblclick="javascript:if(confirm('确认删除吗？'))delRow(this.parentNode.rowIndex);">
				<input type="text" name="XH" onblur="cha(this.parentNode)"  style="text-align:center;" value="<%if(data.getXh()!=null){out.print(data.getXh());}else{out.print(j);}%>"></td>
			<td onkeypress="send(event,this)" title="双击选择定额" ondblclick="javascript:winOpen('../dataManage/gljxde.jsp?ro='+this.parentNode.rowIndex+'&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>','650','480','0')">
				<input type="text" name="Debh" value="<%=data1.getDebh()%>" ></td>
			<td><textarea name="Demc" id="Demc" readonly><%=data1.getDemc() %></textarea></td>
			<td><input type="text" name="DeDw" style="text-align:center;" value="<%=data1.getDw()%>" readOnly></td>
			<td><input type="text" name="DeSl"　 style="text-align:right;" value="<%=NumberFormatUtil.roundToString(data1.getSl(),3)%>" readOnly></td>
			<td onkeypress="sendcl(event,this)" title="双击选择材料" ondblclick="javascript:openSelectWin(this,'list-table','selectMaterial.jsp?LB=YB&BGBH=B3B&priceflag=<%=dxgc.getB3_ybjg()%>',650,450,1);">
				<input type="text" name="BH" value="<%=data.getBh()%>">
				<input type="hidden" name="" value="<%="YB"%>"></td>
			<td><textarea name="MC" id="MC" readonly><%=data.getMc()%></textarea></td>
			<td><input type="text" name="DW" style="text-align:center;" value="<%=data.getDw()%>"></td>
			<td><textarea name="XHGG" id="XHGG" readonly><%=StringFormatUtil.format(data.getXhgg())%></textarea></td>
			<td><input type="text" name="GLSL" style="text-align:right;" value="<%=NumberFormatUtil.roundToString(data.getGlsl())%>"></td>
			<td><input type="text" name="DJ" style="text-align:right;" value="<%=NumberFormatUtil.roundToString(data.getDj())%>"></td>
			<td align="right"><%=NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data1.getSl().doubleValue(),data.getGlsl().doubleValue()))%></td>
			<td align="right"><%=NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
			    NumberFormatUtil.mulToDouble(data1.getSl().doubleValue(),data.getDj().doubleValue()),data.getGlsl().doubleValue()),data.getTzxs().doubleValue()))%></td>
			<td>
				<input type="text" name="TZXS" style="text-align:right;" value="<%=NumberFormatUtil.roundToString(data.getTzxs())%>">
				<input type="hidden" name="Gd06_b3y.B3J_ID" value="<%=data.getB3j_id()%>" >
				<input type="hidden" name="Gd06_b3y.ID" value="<%=data.getId()%>">
			</td>
		</tr>
		<%}else{%>
		<tr>
			<td title="双击删除这一行"  ondblclick="javascript:if(confirm('确认删除吗？'))delRow(this.parentNode.rowIndex);">
				<input type="text" name="XH" onblur="cha(this.parentNode)"  style="text-align:center;" value="<%=j%>"></td>
			<td onkeypress="send(event,this)" title="双击选择定额" ondblclick="javascript:winOpen('../dataManage/gljxde.jsp?ro='+this.parentNode.rowIndex+'&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>','650','480','0')">
				<input type="text" name="Debh"　 value="" ></td>
			<td><textarea name="Demc" id="Demc" readonly></textarea></td>
			<td><input type="text" name="DeDw"　 value="" readOnly></td>
			<td><input type="text" name="DeSl"　 style="text-align:right;" value="" readOnly></td>
			<td onkeypress="sendcl(event,this)"  title="双击选择材料" ondblclick="javascript:openSelectWin(this,'list-table','selectMaterial.jsp?LB=YB&BGBH=B3B&priceflag=<%=dxgc.getB3_ybjg()%>',650,450,1);">
				<input type="text" name="BH" value="">
				<input type="hidden" name="" value="<%="YB"%>"></td>
			<td><textarea name="MC" id="MC" readonly></textarea></td>
			<td><input type="text" name="DW" style="text-align:center;" value=""></td>
			<td><textarea name="XHGG" id="XHGG" readonly></textarea></td>
			<td><input type="text" name="GLSL" style="text-align:right;" value=""></td>
			<td><input type="text" name="DJ" style="text-align:right;" value=""></td>
			<td> </td>
			<td> </td>
			<td>
				<input type="text" name="TZXS" style="text-align:right;" value="">
				<input type="hidden" name="Gd06_b3y.B3J_ID" value="" >
				<input type="hidden" name="Gd06_b3y.ID" value="">
			</td>
		</tr>
		<%}}}%>	
	</table>
	<br>
	<input type="hidden" name="list_validate" value="序号:XH:NUMBER:3:1;编号:BH:VARCHAR2:20:0;
			名称:MC:VARCHAR2:200:0;单位:DW:VARCHAR2:20:0;关联数量:GLSL:NUMBER:12.3:0;单价:DJ:NUMBER:12.2:0;调整系数:TZXS:NUMBER:5.2:1;">
</form>
</div>
</body>
</html>