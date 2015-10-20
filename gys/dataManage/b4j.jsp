<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.service.ExpenseService" %>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.dataObject.Gd07_b4" %>
<%@ page import="com.netsky.dataObject.Ga02_clsb" %>
<%@ page import="com.netsky.dataObject.Gd02_dxgc" %>
<%@ page import="com.netsky.dataObject.Ga00_zclb" %>
<%@ page import="com.netsky.dataObject.Ga10_dwjjd" %>
<%@ page import="com.netsky.dataObject.Gd04_clfysz" %>
<%@ page import="com.netsky.dataObject.Gb03_bgxx" %>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil" %>
<%@ page import="com.netsky.baseFormatUtils.NumberFormatUtil" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%> 
<%
	Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    if(yh==null)
    {
      %> <script language="javascript"> window.location.href="../index.jsp"; </script> <%
      return;
    }

	String bgxx_id = StringFormatUtil.format(request.getParameter("bgxx_id"),"-1");
	String gcxm_id = StringFormatUtil.format(request.getParameter("gcxm_id"),"-1");
	String dxgc_id = StringFormatUtil.format(request.getParameter("dxgc_id"),"-1");
	String bgbh="";
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	ExpenseService expenseService = (ExpenseService) ctx.getBean(ServiceName.ExpenseService);
	
	int fyNum = 0;
	String lb = "",lbStr="器材";
	
	//取得表格编号
	Gb03_bgxx bgbhInfo = null;
	ResultObject bgxxRs = queryService.search("select gb03 from Gb03_bgxx gb03 where id="+bgxx_id);
	bgxxRs.next();
	bgbhInfo = (Gb03_bgxx)bgxxRs.get("gb03");
	bgbh=bgbhInfo.getBgbh();
	//主材设备价格设置
	String priceSetup = "BDJ";
	Gd02_dxgc dxgcInfo = null;
	ResultObject dxgcRs = queryService.search("select gd02 from Gd02_dxgc gd02 where gd02.id="+dxgc_id);
	dxgcRs.next();
	dxgcInfo = (Gd02_dxgc)dxgcRs.get("gd02");
	if(StringFormatUtil.format(bgbhInfo.getB4lb()).equals("ZC")){
		priceSetup = dxgcInfo.getB4_zcjg();
		lb = new String("ZC");
		lbStr="主材";
	}else if(StringFormatUtil.format(bgbhInfo.getB4lb()).equals("SB")){
		priceSetup = dxgcInfo.getB4_sbjg();
		lb = new String("SB");
		lbStr="设备";
	}
	
	//重取费率
	if(request.getParameter("chongqufy")!=null&&request.getParameter("chongqufy").equals("1")){
		expenseService.reBuildFy(dxgcInfo,new String("B4"),request);
	}
	//主材设备类型选项
	ArrayList zcsbType = new ArrayList();
	Ga00_zclb zcsbTypeInfo = null;
	ResultObject clsbTypeRs = queryService.search("select ga00 from Ga00_zclb ga00 where ga00.lb='"+lb+"' order by ga00.id");
	while(clsbTypeRs.next()){
		zcsbTypeInfo = (Ga00_zclb)clsbTypeRs.get("ga00");
		zcsbType.add(new String[]{zcsbTypeInfo.getZclb(),zcsbTypeInfo.getMc()});
	}
	//材料单位选项
	ArrayList cldwSelect = new ArrayList();
	Ga10_dwjjd dwInfo = null;
	ResultObject dwRs = queryService.search("select ga10 from Ga10_dwjjd ga10 where ga10.lb='"+lb+"' order by ga10.dwmc");
	while(dwRs.next()){
		dwInfo = (Ga10_dwjjd)dwRs.get("ga10");
		cldwSelect.add(new Object[]{dwInfo.getDwmc(),dwInfo.getJd()});
	}
	//表4主材设置信息
	ArrayList clfysz = new ArrayList();
	Gd04_clfysz szInfo = null;
	ResultObject fyszRs = queryService.search("select gd04 from Gd04_clfysz gd04 where gd04.gcxm_id="+gcxm_id+" and gd04.dxgc_id="+dxgc_id+" and gd04.bgbh='"+bgbhInfo.getBgbh()+"' order by gd04.zclb,gd04.fy_id");
	while(fyszRs.next()){
		szInfo = (Gd04_clfysz)fyszRs.get("gd04");
		clfysz.add(szInfo);
	}
	
%>
<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>表四甲</title>
<script language="javascript" src="../js/functionlib.js"></script>
<script language="javascript" src="../js/multiTableSave.js"></script>
<script language="javascript" src="../js/selectItem.js"></script>
<script language="javascript" src="../js/calculateTotal.js"></script>
<link href="../css/data.css" rel="stylesheet" type="text/css">
<script language="javascript">
//保存函数
function saveB4(){
	var t_table = document.getElementById('list-table');
	var t_rows = t_table.rows;
	for(var i = 2;i < t_rows.length;i++){
		var t_row = t_rows[i];
		if(t_row.cells[3].children[0].value != '' && t_row.cells[9].children[0].value == ''){
			alert('类别必须录入');
			return false;
		}
	}
	
	delEmptyBh();
	rowsSortSave("list-table",document.getElementById('list-table').rows.length-2,2);
	b4CalculateTotal();
	noSJHJ();
	if(AmountValidateInList('list-table',2,1,0,2,0,6,0)){
		document.form1.action="../afuer/SaveB4?gcxm_id="+<%=gcxm_id%>+"&dxgc_id="+<%=dxgc_id%>+"&bgxx_id=<%=bgxx_id%>";
    	document.form1.submit(); 
	}
}
//清空编号为空的行
function delEmptyBh(){
     var obj = document.getElementById("list-table");
  	 for(var i=2;i<obj.rows.length;i++)
  	  	if(obj.rows[i].cells[1].children[0].value == "")
  	  			clearRow(obj.rows[i]);
}
function setBz(obj){
	if(obj.checked)obj.parentNode.children[1].value = "1";
	else obj.parentNode.children[1].value = "0";
	noSJHJ();
}
function showsetting(){
	var settingstyle = document.all("setting").style.display;
	if (settingstyle=="none"){
		document.all("setting").style.display="block";
	}else{
		document.all("setting").style.display="none";
	}
}
//各种价格的显示
function showPrice(priceFlag){
	if(priceFlag=='BDJ'){
		changePrice(1);
		showtable(0);		
	}else if(priceFlag=='BSJ'){
		changePrice(2);
		showtable(0);
	}else if(priceFlag=='QGJ'){
		changePrice(3);
		showtable(0);
	}else{
		changePrice(4);
		showtable(1);
	}
}
function showtable(flag){//用于显示相关设置中的费用设置
	//var table = document.getElementById('memo_table').children[0];
	if(flag==1){
		document.all("setfy").style.display="none";
		//table.style.display="none";
	}else{
		document.all("setfy").style.display="block";
		//table.style.display="block";
	}
}
function changePrice(showIndex){
	var rowsObj = document.getElementById('list-table').rows;
	for(var i=2;i<rowsObj.length;i++){
		rowsObj[i].cells[6].children[0].value=rowsObj[i].cells[6].children[showIndex].value;
	}
}	
//输入数量后进行的验证、取精度、计算合计
function computeAndValid(numObj){
	if(numObj.value!=''){
		if(NumValid(numObj)){
			var dw = numObj.parentNode.parentNode.cells[5].children[0].value;
			if(dw!=null&&dw!=''){
				dw = dw.replace('/','');
				var jd = eval('document.form1.DW_'+dw);
				if(jd!=null){
					numObj.value = setNumFormat(numObj.value,new Number(jd.value));
				}
			}
		}
	}
	b4CalculateTotal();
}
//单位变动时对数量取精度、计算合计
function dwChangeEvent(dwObj){
	if(dwObj.value!="")
		computeAndValid(dwObj.parentNode.parentNode.cells[2].children[0]);
}
//表4带调整系数算合计
function b4CalculateTotal(){
	calculateTotal('list-table',2,1,0,2,0,7,0,8,0);
	var obj_table = document.getElementById('list-table');
	var obj_rows = obj_table.rows;
	var temp_cells;
	var tempValue;
	for(var i=2; i<obj_rows.length; i++) {
		temp_cells = obj_rows[i].cells;
		if(temp_cells[1].children[0].value != "" && temp_cells[2].children[0].value != "" && temp_cells[7].children[0].value != "" && temp_cells[11].children[0].value!=""){
			tempValue = new Number(temp_cells[7].children[0].value) * new Number(temp_cells[11].children[0].value)*new Number(temp_cells[2].children[0].value);
			if(tempValue > 0) {
				temp_cells[8].children[0].value = setNumFormat(tempValue,2);
			}
		}
	}
	<%
		if(bgbhInfo.getB4lb()!=null&&!bgbhInfo.getB4lb().trim().equals("")){
			out.println("setClsbSum();");
		}
	%>
}
//根据主材或设备的类别分组计算材料原价合计值
function setClsbSum(){
	initHj();
	var rowsObj = document.getElementById('list-table').rows;
	for(var i=2;i<rowsObj.length;i++){
		if(rowsObj[i].cells[1].children[0].value!=""&&rowsObj[i].cells[2].children[0].value!=""&&rowsObj[i].cells[7].children[0].value!=""&&rowsObj[i].cells[9].children[0].value!=""){
			var hjObj = eval('document.form1.CLHJ_'+rowsObj[i].cells[9].children[0].value);
			hjObj.value = setNumFormat(new Number(hjObj.value)+new Number(rowsObj[i].cells[8].children[0].value),2);
		}
	}
	FeeSet();
}
function initHj(){
	var field = document.getElementById('tt').children;
	for(var i=0;i<field.length;i++){
		field[i].value='0';
	}
}
function FeeSet(){
	var fynum = parseInt(document.form1.fynum.value);
	var rowsObj = document.getElementById('memo_table').rows;
	for(var i=2;i<rowsObj.length;i++){
		var clsblb = rowsObj[i].cells[1].children[0].value;
		var clsbyj = parseFloat(eval('document.form1.CLHJ_'+clsblb+'.value'));
		if(clsbyj>0){
			for(var j=3;j<fynum*2+3;j++){
				var fl = parseFloat(rowsObj[i].cells[j].children[0].value);
				j++;
				if(fl>0){
					rowsObj[i].cells[j].children[0].value = setNumFormat(clsbyj*(fl/100),2);
				}else if(fl==0){
					rowsObj[i].cells[j].children[0].value = '';
				}
			}
		}else{
			for(var j=3;j<fynum*2+3;j++){
				j++;
				rowsObj[i].cells[j].children[0].value = '';
			}
		}
	}
}
function flChange(obj){
	if(obj.value=='')
		obj.value='0.0';
	else{
		NumValid(obj);
	}
	FeeSet();
}
//根据输入不同运距取运杂费率
var xmlHttp;
var aj;
var bj;
function createXMLHttpRequest(){
	if(window.ActiveXObject){
		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	}else if(window.XMLHttpRequset){
	 	xmlHttp=new XMLHttpRequset();
	}
}
function GetData(source){
	aj = source.parentNode.parentNode.cells[3].children[0];
	var lb = source.parentNode.parentNode.cells[1].children[0].value;
	if(source.value!='')
		NumValid(source);
	createXMLHttpRequest();
   	xmlHttp.onreadystatechange=setYZFL;
   	xmlHttp.open("GET","../afuer/getYZFL?yj="+source.value+"&zclb="+lb+"&flk_id="+<%=dxgcInfo.getFlk_id()%>+"&fy_id=60");
   	xmlHttp.send(null);
}
function GetCLSBInfo(event,obj){//如果按了回车键把相关信息带出来;;在主材表中如果填入设备的信息显示不出来，在设备表中填入主材同样不能显示
	if(event.keyCode==13){
		if(obj.value==''){
			alert('编号不能为空');
			return;
		}
		bj=obj.parentNode.parentNode;
		createXMLHttpRequest();
    	xmlHttp.onreadystatechange=setCLInfo;
    	xmlHttp.open("GET","../afuer/getCLSB?bh="+obj.value+"&lb=<%=lb%>");
    	xmlHttp.send(null);
	}
}
function setYZFL(){
	if(xmlHttp.readyState==4){
		if(xmlHttp.status==200){
           var doc = new ActiveXObject("MSxml2.DOMDocument")
           doc.loadXML(xmlHttp.responseText);
           result=doc.getElementsByTagName("flz");
           aj.value=result[0].childNodes[0].nodeValue;
           aj.onchange();
        }
	}
}
function setCLInfo(){
	if(xmlHttp.readyState==4){
	   if(xmlHttp.status==200){
	      var doc = new ActiveXObject("MSxml2.DOMDocument")
	      doc.loadXML(xmlHttp.responseText);
	      result=doc.getElementsByTagName("clsb");
	      if(result[0].childNodes[0].childNodes[0].nodeValue=="null"){
	      		alert("编号不存在!");
	      		bj.cells[1].children[0].value='';
	      		return;
	      }
	      bj.cells[1].children[0].value=trim(result[0].childNodes[0].childNodes[0].nodeValue);
	      bj.cells[3].children[0].value=trim(result[0].childNodes[1].childNodes[0].nodeValue);
	      bj.cells[4].children[0].value=trim(result[0].childNodes[2].childNodes[0].nodeValue);
	      bj.cells[5].children[0].value=trim(result[0].childNodes[9].childNodes[0].nodeValue);
	      bj.cells[6].children[0].value=trim(result[0].childNodes[3].childNodes[0].nodeValue);
	      bj.cells[2].children[0].value='1.00';
	      bj.cells[2].children[0].onchange();
	      bj.cells[7].children[1].value=result[0].childNodes[4].childNodes[0].nodeValue;
	      bj.cells[7].children[2].value=result[0].childNodes[5].childNodes[0].nodeValue;
	      bj.cells[7].children[3].value=result[0].childNodes[6].childNodes[0].nodeValue;
	      bj.cells[7].children[4].value=result[0].childNodes[7].childNodes[0].nodeValue;
	      bj.cells[9].children[0].value=trim(result[0].childNodes[8].childNodes[0].nodeValue);
	      if(document.getElementById("dd").value=="B4JZC"){
	     	bj.cells[11].children[0].value='1.00';
	      }else{
	      	bj.cells[10].children[0].value='1.00';
	      }
	      bj.cells[2].children[0].focus();
	      bj.cells[2].children[0].select();
		  if(document.form1.price_select.value=='BDJ'){
			  bj.cells[7].children[0].value=setNumFormat(parseFloat(bj.cells[7].children[1].value),2);
		  }else if(document.form1.price_select.value=='BSJ'){
			  bj.cells[7].children[0].value=setNumFormat(parseFloat(bj.cells[7].children[2].value),2);
		  }else if(document.form1.price_select.value=='QGJ'){
			  bj.cells[7].children[0].value=setNumFormat(parseFloat(bj.cells[7].children[3].value),2);
		  }else{
			  bj.cells[7].children[0].value=setNumFormat(parseFloat(bj.cells[7].children[4].value),2);
		  }
		  b4CalculateTotal();
	   }
	}
}
function trim(obj){
	if(obj=='null')
		return '';
	return obj;
}
function noSJHJ(){
	var obj_table = document.getElementById('list-table');
	var obj_rows = obj_table.rows;
	var temp_cells;
	var tempValue=0;
	for(var i=2; i<obj_rows.length; i++) {
		temp_cells = obj_rows[i].cells;
		if(temp_cells[1].children[0].value != "" && temp_cells[7].children[0].value != "" && temp_cells[9].children[0].checked==true)
			tempValue += new Number(temp_cells[7].children[0].value);
	}
	document.form1.NOSJHJ.value=setNumFormat(tempValue,2);
}
function checkRepeat(obj){
	obj.value=obj.value.toUpperCase();
	var obj_table = document.getElementById('list-table');
	var obj_rows = obj_table.rows;
	var temp_cells;
	for(var i=2; i<obj_rows.length; i++) {
		if(obj.parentNode.parentNode.rowIndex!=i){
			temp_cells = obj_rows[i].cells;
			if(temp_cells[1].children[0].value!=''){
				if(temp_cells[1].children[0].value==obj.value){
					alert('已经存在该编号材料');
					obj.value='';
					obj.focus();
					return false;
				}
			}
		}
	}
	return true;
}
function renew(){
	if(confirm('确定按定额重新生成？'))   
    {   
		clsbOp(1);
    }  
}
function clsbOp(flag){
	if(flag==0){
		var temp_pop = window.open("selectMergerField.jsp?gcxm_id=<%=gcxm_id%>&dxgc_id=<%=dxgc_id%>&bgxx_id=<%=bgxx_id%>","","width=300 height=220 scrollbars=0 status=yes");
		temp_pop.moveTo((screen.width-400)/2,(screen.height-400)/2);
		temp_pop.focus();
	}else{
		document.form1.action="../afuer/ClsbOp?gcxm_id=<%=gcxm_id%>&dxgc_id=<%=dxgc_id%>&bgxx_id=<%=bgxx_id%>&flag="+flag;
		document.form1.submit(); 
	}
}
function goinput(tabid,tabhead,celli,elemi,rObj){
	if(event.keyCode==13){
		var rowindex = rObj.parentNode.rowIndex;
		var exec = false;
		var rowsObj = document.getElementById(tabid).rows;
		for(var i=rowindex+1;i<rowsObj.length;i++){
			if(rowsObj[i].style.display=='none')
				continue;
			rowsObj[i].cells[celli].children[elemi].focus();
			rowsObj[i].cells[celli].children[elemi].select();
			exec=true;
			break;
		}
		if(!exec){
			addList('list-table',2);
			var rtmp = document.getElementById(tabid).rows;
			rtmp[rtmp.length-1].cells[celli].children[elemi].focus();
			rtmp[rtmp.length-1].cells[celli].children[elemi].select();
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
  
    //同步表四信息
  function xxtb()
  {
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=xxtbcl;
    xmlHttp.open("GET","../afuer/SynchronizeController?act=b4&bgxx_id=<%=request.getParameter("bgxx_id")%>&bgbh=<%=bgbh%>&dxgc_id="+<%=dxgc_id%>);
    xmlHttp.send(null);
  }
  
  function xxtbcl()
  {
    var fl;
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           var jgf=xmlHttp.responseText;
           if(jgf=="b4")
           {
             alert("表四同步成功");
           }
        }
     }
  }
</script>
</head>

<body leftmargin="0" topmargin="0" id="main-body" onload="javascript:addNumSelect()">
<div id="menuDiv" onmouseover="javascript:this.style.display='block';" onmouseout="javascript:this.style.display='none';" style="display:none;position: absolute;left:453;top:39;width:88;background-color:#FFFFFF;border:1px solid gray">
<table border="0" width="100%">
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="allwinOpen('../print/print.jsp?type=print&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%=bgxx_id%>')">单表预览</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=pdf&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%=bgxx_id%>');">PDF输出</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=doc&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%=bgxx_id%>');">WORD输出</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../export/SingleProject_excel.jsp?dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%=bgxx_id%>');">EXCEL输出</td>
	</tr>
</table>
</div>
<table border="0" cellpadding="2" style="height:45px;border-collapse:collapse;" width="100%">
	<tr>
		<td style="height:15px"></td>
	</tr>
	<tr>
		<td style="vertical-aling:bottom;">
			<%if(dxgcInfo.getGdsj() == null){ %>
			&nbsp;<input type="button" name="b1" value=" 保存信息 " onclick="saveB4()">
			&nbsp;<input type="button" name="b2" value=" 追加行 " onclick="addList('list-table',2)">
			<!--
			<%if(yh.getOperate()!=null&&yh.getOperate().intValue()==1){ %>
			&nbsp;<input type="button" name="" value=" 信息同步 " onClick="xxtb()"> 
			<%} %>
			&nbsp;<input type="button" name="b3" value=" 合并<%=lbStr%> " onclick="clsbOp(0)">
			&nbsp;<input type="button" style="width:100px;" name="b" value=" 重取表四费率 " onclick="javascript:reBuildFy()">
			<%if(bgbhInfo.getBgbh().startsWith("B4J")){ %>
			&nbsp;<input type="button" style="width:100px;" name="" value=" 表四数据互导 " onclick="javascript:winOpen('../dataManage/eachB4.jsp?gcxm_id=<%=gcxm_id%>&dxgc_id=<%=dxgc_id%>','640','520','0')">
			<%} %>
			-->
			<input type="button" value="表四数据导入" onclick="javascript:winOpen('../import/import.jsp?config=b4_import&GCXM_ID=<%=gcxm_id%>&DXGC_ID=<%=dxgc_id%>&BGBH=<%=bgbhInfo.getBgbh()%>','580','295','0')">
		<!-- 	
		<%
			if(bgbhInfo.getBgbh().equals("B4JXASB")||bgbhInfo.getBgbh().equals("B4JZC")){
		%>
				&nbsp;<input type="button" style="width:110px;" name="b4" value=" 按定额重新生成 " onclick="renew()">
		<%}%>
		 -->
		<%}%>
		&nbsp;<input type="button" name="b2" value=" 单表预览 " onclick="javascript:dbyl(this);">
		&nbsp;<input type="button" name=""   value=" 全部预览 " onclick="javascript:winOpen('../print/SingleProject_print.jsp?gcxm_id=<%=gcxm_id%>&dxgc_id=<%=dxgc_id%>','580','295','0')" >
		</td>
	</tr>
</table>
<div style="width:100%;background:#ffffff;">
<form name="form1" method="post" action="" >
<input type="hidden"  name="" id="dd" value="<%=bgbhInfo.getBgbh()%>">
<input type="hidden" id="chongqufy" name="chongqufy" value="0">
<div class="file_title">
<%
	if(!formatStr(bgbhInfo.getBgbh(),"").equals("JZGCB")){
		out.print("国内器材");
		if(dxgcInfo.getJsjd().intValue()==1)
			out.print("概算");
		else if(dxgcInfo.getJsjd().intValue()==2)
			out.print("预算");
		else if(dxgcInfo.getJsjd().intValue()==3)
			out.print("结算");
		else
			out.print("决算");
		out.print("表（表四）甲");
	}else{
		out.print(bgbhInfo.getMc());
	}
%>
</div>
<br>
<div class="file_title_2">
<%
		out.print("("+bgbhInfo.getFbt()+")");
%>
</div>
<%
	if(!bgbhInfo.getBgbh().equals("JZGCB")){
%>
	<div style="text-align:left;color:1E4F75;font-size:13px;font-weight:bold;padding:3px 0px;"><img src="../images/setting.gif" border="0" onClick="showsetting()" style="cursor:hand;"></div>
		
		<div align="left">		
		<div id="setting" style="display:none;">
		<table border="0" cellpadding="0" style="border-collapse: collapse;background-color:#f0f0f0;border:solid 1px #cccccc" width="98%">
		<tr style="height:6px;">
			<td colspan="6" align="center"><div style="position:relative;"><div style="position:absolute;right:2px;cursor: hand;"><img src="../images/ca.jpg" border="0" onClick="showsetting()"></div></div></td>
		</tr>	
		<%
			if(bgbhInfo.getBgbh().indexOf("B4J")==0){
		%>	
		
		<tr>
			<td width="30" align="right">※ </td>
			<td>费用设置</td>
			<td width="30" align="right">　</td>
			<td>　</td>
			<td width="30" align="right"> </td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td colspan="5" valign="top">
				<div id="setfy" <%if(priceSetup.equals("YSJ")){ %> style="display:none;"<%}%>>
				<table id="memo_table" border="1" cellpadding="0" style="border-collapse: collapse;"  >
					<tr style="font-weight:bold;text-align:center;">
						<td width="20" rowspan="2"></td>
						<td width="60" rowspan="2">类别</td>
						<td width="80" rowspan="2">运距<br>(公里)</td>
					<%
						ResultObject fymcRs = queryService.search("select distinct gd04.fy_id,gd04.fymc from Gd04_clfysz gd04 where gd04.gcxm_id="+gcxm_id+" and gd04.dxgc_id="+dxgc_id+" and gd04.bgbh='"+bgbhInfo.getBgbh()+"' and gd04.zclb is not null order by gd04.fy_id");
						while(fymcRs.next()){
							String fymc = (String)fymcRs.get("gd04.fymc");
							++fyNum;
							out.println("<td width='160' colspan='2'>"+fymc+"</td>");
						}
					%>
					</tr>
					<tr style="font-weight:bold;text-align:center;">
					<%
						for(int i=0;i<fyNum;i++){
							out.println("<td width='80'>费率</td>");
							out.println("<td width='80'>费用值</td>");
						}
					%>
					</tr>
					
					<%
						for(int i=0;i<zcsbType.size();i++){
							String[] tmp = (String[])zcsbType.get(i);
							if(tmp[0].equals("YS"))
								continue;
					%>
					<tr>
						<td align="center"><%=(i+1)%></td>
						<td align="center"><input type="hidden" name="CLT" value="<%=tmp[0]%>"/><%=tmp[1]%></td>
					<%
							int cc = 1;
							boolean yjNeed = true;
							Gd04_clfysz szTmp = null;
							for(int j=0;j<clfysz.size();j++){
								szTmp = (Gd04_clfysz)clfysz.get(j);
								if(szTmp.getZclb().equals(tmp[0])){
									int k = j;
									for(;j<k+fyNum;j++){
										Gd04_clfysz szTmp2 = (Gd04_clfysz)clfysz.get(j);
										if(yjNeed){
											String aa="";
											if(szTmp2.getFlyj()!=null){
												aa=NumberFormatUtil.roundToString(szTmp2.getFlyj());
											}
											out.println("<td><input type='text' onchange='GetData(this)' name='"+tmp[0]+"_YJ' value='"+aa+"'></td>");
											yjNeed = false;
										}
										String bc = "";
										if(szTmp2.getFlz()!=null){
											bc = NumberFormatUtil.roundToString(szTmp2.getFlz());
										}
										String bb = "";
										if(szTmp2.getFyz()!=null){
											bb = NumberFormatUtil.roundToString(szTmp2.getFyz());
										}
										out.println("<td><input type='text' name='"+tmp[0]+"_FL_"+cc+"' onchange='flChange(this)' value='"+bc+"'></td>");
										out.println("<td><input type='text' name='"+tmp[0]+"_FYZ_"+cc+"' value='"+bb+"' readOnly><input type='hidden' name='"+tmp[0]+"_SZID_"+cc+"' value='"+szTmp2.getId()+"'></td>");
										cc++;
									}
									break;
								}
							}
					%>
					</tr>
					<%
						}
					%>
				</table>
				</div>
			</td>
		</tr>
		
		<%
			}
		%>
		<tr>
			<td width="30" align="right">※ </td>
			<td>价格设置</td>
			<td width="30" align="right">　</td>
			<td>　</td>
			<td width="30" align="right"> </td>
			<td></td>
		</tr>
		<tr>
			<td width="30" align="right"> </td>
			<td colspan="5"><%=lbStr%>价格：
			  <select name="price_select" onchange="javascript:showPrice(this.value);b4CalculateTotal();">
				<option value="BDJ" <%=selectCompare("BDJ",priceSetup)%>>本地价</option>
				<option value="BSJ" <%=selectCompare("BSJ",priceSetup)%>>本省价</option>
				<option value="QGJ" <%=selectCompare("QGJ",priceSetup)%>>全国价</option>
				<option value="YSJ" <%=selectCompare("YSJ",priceSetup)%>>预算价</option>
			  </select>
			</td>
		</tr>
		<tr style="height:6px;">
			<td colspan="6"> </td>
		</tr>
		</table>
	<br>	
	<input type="hidden" name="fynum" value="<%=fyNum%>">
	</div>	
<%
	}
%>
	<table id="list-table" border="0" cellpadding="0" style="border-collapse: collapse" width="1270">
		<tr class="list-title">
			<td width="30">序号</td>
			<td width="80">编码</td>
			<td width="65">数量</td>
			<td width="300">名称</td>
			<td width="200">型号</td>
			<td width="100">规格</td>
			<td width="60">单位</td>
			<td width="65">单价</td>
			<td width="65">合计</td>
			<td width="65">类别</td>
			<%if(bgbhInfo.getBgbh().equals("B4JZC")){%>
			<td width="40">不取税金</td>
			<%} %>
			<td width="50">调整<br>系数</td>
			<td width="150">备注</td>
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
			<%if(bgbhInfo.getBgbh().equals("B4JZC")){%>
			<td>13</td>
			<%} %>
		</tr>
		<%
			String HSql1="select gd07 from Gd07_b4 gd07 where gd07.gcxm_id="+gcxm_id+" and gd07.dxgc_id="+dxgc_id+" and gd07.bgbh='"+bgbhInfo.getBgbh()+"' order by gd07.xh";
	    	ResultObject mainRs = queryService.search(HSql1);
			int counter = 1;
			Double bdj,bsj,qgj,ysj;
			while(mainRs.next()){
				Gd07_b4 currGd07 = (Gd07_b4)mainRs.get("gd07");
				ResultObject clsbRs = queryService.search("select ga02 from Ga02_clsb ga02 where ga02.bh='"+currGd07.getBh()+"'");
				if(clsbRs.next()){
					Ga02_clsb currGa02 = (Ga02_clsb)clsbRs.get("ga02");
					bdj = currGa02.getBdj();
					bsj = currGa02.getBsj();
					qgj = currGa02.getQgj();
					ysj = currGa02.getYsj();
				}else{
					bdj = currGd07.getDj();
					bsj = currGd07.getDj();
					qgj = currGd07.getDj();
					ysj = currGd07.getDj();
				}
		%>
				<tr>
					<td align="center" title="双击删除当前行数据" ondblclick="javascript:if(confirm('确认删除吗？')){clearCurItem(this.parentNode,1,0);b4CalculateTotal();}">
						<input type="text" style="text-align:center" onblur="changerow(this.parentNode,'list-table',2)" name="Gd07_b4.XH" value="<%=StringFormatUtil.format(currGd07.getXh(),String.valueOf(counter))%>">
					</td>
					<td title="双击选择<%=lbStr%>"
					<%
						if(!bgbhInfo.getBgbh().equals("JZGCB")){
					%>
					 ondblclick="javascript:openSelectWin(this,'list-table','selectMaterial.jsp?LB=<%=lb%>&BGBH=<%=bgbhInfo.getBgbh()%>',650,470,1);"
					<%
						}
					%>
					 >
						<input type="text" name="Gd07_b4.BH" value="<%=currGd07.getBh()%>" onkeypress="GetCLSBInfo(event,this)"></td>
					<td><input type="text" name="Gd07_b4.SL" style="text-align:right" value="<%=NumberFormatUtil.roundToString(currGd07.getSl())%>" onchange="computeAndValid(this)" onkeypress="goinput('list-table',2,1,0,this.parentNode)"></td>
					<td><textarea name="Gd07_b4.MC" id="Gd07_b4.MC" ><%=StringFormatUtil.format(currGd07.getMc())%></textarea></td>
					<td><textarea name="Gd07_b4.XHGG" id="Gd07_b4.XHGG" ><%=StringFormatUtil.format(currGd07.getXhgg())%></textarea></td>
					<td><textarea name="Gd07_b4.GG" id="Gd07_b4.GG" ><%=StringFormatUtil.format(currGd07.getGg())%></textarea></td>
					<td style="width:62px"><input type="text" name="Gd07_b4.DW" onchange="dwChangeEvent(this)" style="width:40px;" value="<%=StringFormatUtil.format(currGd07.getDw())%>"><span name="ss" style="width:18px;height:18px;border:0px solid;"><select name="SELECT_DW" style="margin-left:-40px;margin-top:2px;width:58px;" onChange="javascript:this.parentNode.parentNode.children[0].value=this.value;this.parentNode.parentNode.children[0].onchange();">
					<%
						for(int i=0;i<cldwSelect.size();i++){
							Object[] tmp = (Object[])cldwSelect.get(i);
							out.println("<option value='"+tmp[0].toString()+"'>"+tmp[0].toString()+"</option>");
						}
					%>
					</select></span></td>
					<td><input type="text" name="Gd07_b4.DJ" style="text-align:right" value="<%=NumberFormatUtil.roundToString(StringFormatUtil.format(currGd07.getDj()))%>" onchange="javascript:if(this.value!='')NumValid(this);b4CalculateTotal();">
						<input type="hidden" name="DJ_BDJ" value="<%=StringFormatUtil.format(bdj)%>">
						<input type="hidden" name="DJ_BSJ" value="<%=StringFormatUtil.format(bsj)%>">
						<input type="hidden" name="DJ_QGJ" value="<%=StringFormatUtil.format(qgj)%>">
						<input type="hidden" name="DJ_YSJ" value="<%=StringFormatUtil.format(ysj)%>">
					</td>
					<td><input type="text" name="SUBTOTAL" style="text-align:right" value="" readOnly></td>
					<td><select name="Gd07_b4.ZCLB" onchange="b4CalculateTotal()" style="width:100%">
							<option value=""></option>
						<%
							for(int i=0;i<zcsbType.size();i++){
								String[] tmp = (String[])zcsbType.get(i);
								out.println("<option value='"+tmp[0]+"' "+selectCompare(tmp[0],currGd07.getZclb())+">"+tmp[1]+"</option>");
							}
						%>
						</select></td>
					<%if(bgbhInfo.getBgbh().equals("B4JZC")){%>
					<td><input type="checkbox" style="width:30px;" name="SJ_BZ_C" <%=disableCompare("B4JZC",bgbhInfo.getBgbh())%> onclick="setBz(this)" <%=checkCompare("1",String.valueOf(currGd07.getSj_bz()))%>>
						<input type="hidden" name="Gd07_b4.SJ_BZ" value="<%if(currGd07.getSj_bz()!=null){out.print(String.valueOf(currGd07.getSj_bz()));}else{out.print(0);}%>"></td>
					<%}%>
					<td><input type="text" name="Gd07_b4.TZXS" onchange="javascript:if(this.value!='')NumValid(this);b4CalculateTotal();" style="text-align:right" value="<%if(currGd07.getTzxs()!=null){out.print(NumberFormatUtil.roundToString(currGd07.getTzxs()));}else{out.print("1.00");}%>"></td>
					<td><textarea name="Gd07_b4.BZ" id="Gd07_b4.BZ" ><%if(currGd07.getBz()!=null){out.print(currGd07.getBz());}else{out.print("");}%></textarea><input type="hidden" name="Gd07_b4.ID" value="<%=currGd07.getId()%>"></td>
				</tr>
		<%
				counter++;
			}
		for(int i=counter; i<16; i++){
		%>
		<tr>
			<td align="center" title="双击删除当前行数据"   ondblclick="javascript:if(confirm('确认删除吗？')){clearCurItem(this.parentNode,1,0);b4CalculateTotal();}">
				<input type="text" style="text-align:center"  onblur="changerow(this.parentNode,'list-table',2)" name="Gd07_b4.XH" value="<%=i%>">
			</td>
			<td title="双击选择<%=lbStr%>"
			<%
				if(!bgbhInfo.getBgbh().equals("JZGCB")){
			%>
			 ondblclick="javascript:openSelectWin(this,'list-table','selectMaterial.jsp?LB=<%=lb%>&BGBH=<%=bgbhInfo.getBgbh()%>',650,470,1);"
			<%
				}
			%>
			 >
			<input type="text" name="Gd07_b4.BH" onkeypress="GetCLSBInfo(event,this)"></td>
			<td><input type="text" name="Gd07_b4.SL" style="text-align:right" onchange="computeAndValid(this)" onkeypress="goinput('list-table',2,1,0,this.parentNode)"></td>
			<td><textarea name="Gd07_b4.MC" id="Gd07_b4.MC"></textarea></td>
			<td><textarea name="Gd07_b4.XHGG" id="Gd07_b4.XHGG"></textarea></td>
			<td><textarea name="Gd07_b4.GG" id="Gd07_b4.GG"></textarea></td>
			<td style="width:62px"><input type="text" name="Gd07_b4.DW" onchange="dwChangeEvent(this)" style="width:40px;"><span name="ss" style="width:18px;height:18px;border:0px solid;"><select name="SELECT_DW" style="margin-left:-40px;margin-top:2px;width:58px;" onChange="javascript:this.parentNode.parentNode.children[0].value=this.value;this.parentNode.parentNode.children[0].onchange();">
			<%
				for(int j=0;j<cldwSelect.size();j++){
					Object[] tmp = (Object[])cldwSelect.get(j);
					out.println("<option value='"+tmp[0].toString()+"'>"+tmp[0].toString()+"</option>");
				}
			%>
			</select></span></td>
			<td><input type="text" name="Gd07_b4.DJ" style="text-align:right" onchange="javascript:if(this.value!='')NumValid(this);b4CalculateTotal();" value="">
				<input type="hidden" name="DJ_BDJ" value="">
				<input type="hidden" name="DJ_BSJ" value="">
				<input type="hidden" name="DJ_QGJ" value="">
				<input type="hidden" name="DJ_YSJ" value=""></td>
			<td><input type="text" name="SUBTOTAL" style="text-align:right" value="" readOnly></td>
			<td><select name="Gd07_b4.ZCLB" onchange="b4CalculateTotal()" style="width:100%">
					<option value=""></option>
				<%
					for(int j=0;j<zcsbType.size();j++){
						String[] tmp = (String[])zcsbType.get(j);
						out.println("<option value='"+tmp[0]+"'>"+tmp[1]+"</option>");
					}
				%>
				</select></td>
			<%if(bgbhInfo.getBgbh().equals("B4JZC")){%>
			<td><input type="checkbox" style="width:30px;" name="SJ_BZ_C" <%=disableCompare("B4JZC",bgbhInfo.getBgbh())%> onclick="setBz(this)"><input type="hidden" name="Gd07_b4.SJ_BZ" value="0"></td>
			<%}%>
			
			<td><input type="text" name="Gd07_b4.TZXS" onchange="javascript:if(this.value!='')NumValid(this);b4CalculateTotal();" style="text-align:right" value=""></td>
			<td><input type="text" name="Gd07_b4.BZ"><input type="hidden" name="Gd07_b4.ID" value=""></td>
		</tr>
		<%}%>
	</table>
	<div align="left"><input type="button" name="b2" value=" 追加行 " onclick="addList('list-table',2)"></div>
	<%
		for(int i=0;i<cldwSelect.size();i++){
			Object[] tmp = (Object[])cldwSelect.get(i);
			out.println("<input type='hidden' name='DW_"+tmp[0].toString().replaceAll("/","")+"' value='"+tmp[1].toString()+"'>");
		}
		out.println("<span id='tt'>");
		for(int j=0;j<zcsbType.size();j++){
			String[] tmp = (String[])zcsbType.get(j);
			out.println("<input type='hidden' name='CLHJ_"+tmp[0]+"' value='0'>");
		}
		out.println("</span>");
	%>
	<input type="hidden" name="NOSJHJ" value="">
	<br>
	<br>
	<br>
	<br>
	<br>
<input type="hidden" name="limitInput">
<script type="text/javascript">
b4CalculateTotal();
noSJHJ();
//initializeWeb('Gd07_b4.BH');
</script>
</form>
</div>

</body>

</html>
<%!
	public String formatStr(String str1,String str2){
		if(str1==null||str1.equals(""))
			return str2;
		return str1;
	}
	public String selectCompare(String str,String str2){
		if(str2!=null && str.equals(str2))
			return " selected";
		return "";
	}
	public String checkCompare(String str,String str2){
		if(str.equals(str2))
			return " checked";
		return "";
	}
	public String disableCompare(String str,String str2){
		if(str.equals(str2))
			return "";
		return " disabled";
	}
%>