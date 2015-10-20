<%@ page contentType="text/html; charset=gbk"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.service.ExpenseService" %>
<%@ page import="com.netsky.dataObject.Gd05_b3j" %>
<%@ page import="com.netsky.dataObject.Gd02_dxgc" %>
<%@ page import="com.netsky.dataObject.Gd10_b3fl" %>
<%@ page import="com.netsky.dataObject.Ga09_kcxs"%>
<%@ page import="com.netsky.dataObject.Ga10_dwjjd" %>
<%@ page import="com.netsky.dataObject.Gb03_bgxx"%>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ page import="com.netsky.baseFormatUtils.NumberFormatUtil" %>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%> 
<%
	Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    if(yh==null)
    {
      %> <script language="javascript"> window.location.href="../index.jsp"; </script> <%
      return;
    }

	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	ExpenseService expenseService = (ExpenseService) ctx.getBean(ServiceName.ExpenseService);
	Integer dxgc_id= new Integer(request.getParameter("dxgc_id"));
	Integer gcxm_id= new Integer(request.getParameter("gcxm_id"));
	
	
	
	QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd05_b3j.class);
	queryBuilder.eq("dxgc_id",dxgc_id);
	queryBuilder.addOrderBy(Order.asc("xh"));
	ResultObject ro=queryService.search(queryBuilder);
	
	QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd02_dxgc.class);//��ѯ�ۺ���Ϣ����ʩ�������Ƿ�������
	queryBuilder1.eq("gcxm_id",gcxm_id);
	queryBuilder1.eq("id",dxgc_id);
	ResultObject ro1=queryService.search(queryBuilder1);
	Gd02_dxgc data1=new Gd02_dxgc();
	if(ro1.next()){
		data1=(Gd02_dxgc)ro1.get(Gd02_dxgc.class.getName());
	}
	//��ȡ����
	if(request.getParameter("chongqufy")!=null&&request.getParameter("chongqufy").equals("1")){
		expenseService.reBuildFy(data1,new String("B3J"),request);
	}
	
	Integer biaozhi=data1.getB3_sgtj_bz();
	String jsjd = "";
	if(data1.getJsjd().intValue() == 1){
		jsjd = "����";
	}else if(data1.getJsjd().intValue() == 2){
		jsjd = "Ԥ��";
	}else if(data1.getJsjd().intValue() == 3){
		jsjd = "����";
	}else if(data1.getJsjd().intValue() == 4){
		jsjd = "����";
	}
	
	QueryBuilder queryBuilder2= new HibernateQueryBuilder(Gd10_b3fl.class);
	queryBuilder2.eq("dxgc_id",dxgc_id);
	queryBuilder2.eq("gcxm_id",gcxm_id);
	queryBuilder2.eq("fylb",new Integer(1));
	queryBuilder2.eq("bz",new Integer(1));//ȡ��ԭ��
	queryBuilder2.addOrderBy(Order.asc("id"));
	ResultObject ro2=queryService.search(queryBuilder2);
	Gd10_b3fl data2=new Gd10_b3fl();
	
	QueryBuilder queryBuilder3= new HibernateQueryBuilder(Gd10_b3fl.class);
	queryBuilder3.eq("dxgc_id",dxgc_id);
	queryBuilder3.eq("gcxm_id",gcxm_id);
	queryBuilder3.eq("fylb",new Integer(1));
	queryBuilder3.eq("bz",new Integer(2));//ȡɳĮɭ�ֵ�
	queryBuilder3.addOrderBy(Order.asc("id"));
	ResultObject ro3=queryService.search(queryBuilder3);
	Gd10_b3fl data3=new Gd10_b3fl();
	
	QueryBuilder queryBuilder4 = new HibernateQueryBuilder(Gd10_b3fl.class);
	queryBuilder4.eq("dxgc_id",dxgc_id);
	queryBuilder4.eq("gcxm_id",gcxm_id);
	queryBuilder4.eq("fylb",new Integer(3));//ȡС���յ���
	queryBuilder4.eq("bz",new Integer(100));
	ResultObject ro4 = queryService.search(queryBuilder4);
	Gd10_b3fl data4=new Gd10_b3fl();
	if(ro4.next()){
		data4 = (Gd10_b3fl)ro4.get(Gd10_b3fl.class.getName());
	}
	QueryBuilder queryBuilder5 = new HibernateQueryBuilder(Gd10_b3fl.class);
	queryBuilder5.eq("dxgc_id",dxgc_id);
	queryBuilder5.eq("gcxm_id",gcxm_id);
	queryBuilder5.eq("fylb",new Integer(3));//ȡС���յ���
	queryBuilder5.eq("bz",new Integer(250));
	ResultObject ro5 = queryService.search(queryBuilder5);
	Gd10_b3fl data5=new Gd10_b3fl();
	if(ro5.next()){
		data5 = (Gd10_b3fl)ro5.get(Gd10_b3fl.class.getName());
	}
	QueryBuilder queryBuilder10 = new HibernateQueryBuilder(Gd10_b3fl.class);
	queryBuilder10.eq("dxgc_id",dxgc_id);
	queryBuilder10.eq("gcxm_id",gcxm_id);
	queryBuilder10.eq("mc",new String("ȫ���������̹��յ�������"));
	ResultObject ro10 = queryService.search(queryBuilder10);
	Gd10_b3fl data10 = new Gd10_b3fl();
	if(ro10.next()){
		data10 = (Gd10_b3fl)ro10.get(Gd10_b3fl.class.getName());
	}
	//�����ж϶�����Ƿ�Ϊ��
	Gd05_b3j  data9 = new Gd05_b3j();
	QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd05_b3j.class);
	queryBuilder9.eq("dxgc_id",dxgc_id);
	ResultObject ro9 = queryService.search(queryBuilder9);
	if(ro9.next()){
		data9 = (Gd05_b3j)ro9.get(Gd05_b3j.class.getName());
	}
	//���ڵ�λѡ��
	ArrayList list = new ArrayList();
	Ga10_dwjjd dwjjd = new  Ga10_dwjjd();
	QueryBuilder queryBuilder100 = new HibernateQueryBuilder(Ga10_dwjjd.class);
	queryBuilder100.eq("lb",new String("DE"));
	ResultObject ro100 = queryService.search(queryBuilder100);
	while(ro100.next()){
		dwjjd = (Ga10_dwjjd)ro100.get(Ga10_dwjjd.class.getName());
		list.add(new Object[]{dwjjd.getDwmc(),dwjjd.getJd()});
	}
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������</title>
<script language="javascript" src="../js/selectItem.js"></script>
<script language="javascript" src="../js/functionlib.js"></script>
<script language="javascript" src="../js/multiTableSave.js"></script>
<script language="javascript" src="../js/calculateTotal.js"></script>
<link href="../css/data.css" rel="stylesheet" type="text/css">
<script language="javascript">
  
  function check(){	   
	    var obj = document.getElementById("list-table");
	  	for(var i=3;i<obj.rows.length;i++){
	  		if(obj.rows[i].cells[1].children[0].value==""){
	  			if(obj.rows[i].cells[2].children[0].value==""){	
	  			}else{
	  				alert("�����Ų���Ϊ�գ�");
	  				return;
	  			} 			
	  		}
	  	} 	
	    if(listValidateChk("form1","Gd05_b3j.DEBH")){ 
		    //if(form1.JXSC_BZ){
			//  	 if(!form1.JXSC_BZ.checked){
			//  	 	if(!window.confirm("ȷ�����Թ�����е�Զ�����?")){
			//  	 		return;
			//  	 	}
			//  	 }
		  	//}
			//if(form1.YBSC_BZ){
			//  	 if(!form1.YBSC_BZ.checked){
			//  	 	if(!window.confirm("ȷ�����Թ����Ǳ��Զ�����?")){
			//  	 		return;
			//  	 	}
			// 	 }
		  	//}
		  	for(var i=3;i<obj.rows.length;i++){   //�������Ϊ�յ���
		  	  	if(obj.rows[i].cells[3].children[0].value==null || obj.rows[i].cells[3].children[0].value == "" ){
		  	  		clearRow(obj.rows[i]);
		  	   	}
		  	}
			var listtable= document.getElementById("list-table");
			var rowlength=listtable.rows.length-3; 
		  	rowsSortSave("list-table",rowlength,3);//��������	  	 		
	 		document.form1.action="../afuer/SaveB3?gcxm_id="+<%=gcxm_id%>+"&dxgc_id="+<%=dxgc_id%>+"&biaozhi="+<%=biaozhi%>;
   			document.form1.submit(); 
	  }
  }	
  function delRow(obj){
	 var listtable= document.getElementById("list-table");
	 deleteRow(listtable.rows[obj]);
	 var rowlength=listtable.rows.length-3; 
	 rowsSort("list-table",rowlength,3);//��������id="list-table"����Ч���ݳ���objlen����ͷ���У�
  }
  function setBz(obj){
	if(obj.checked)obj.parentNode.children[1].value = "1";
	else obj.parentNode.children[1].value = "0";
  }

  function showsetting(){
	var settingstyle = document.all("setting").style.display
	if (settingstyle=="none"){
		document.all("setting").style.display="block"
	}else{
		document.all("setting").style.display="none"
	}
  }
  var xmlHttp;
  function createXMLHttpRequest(){
   	if(window.ActiveXObject){
     	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
   	}else if(window.XMLHttpRequset){
     	xmlHttp=new XMLHttpRequset();
   	}
  }
  var aj;
  function send(event,a){//������˻س����������Ϣ������
	if(event.keyCode==13) {//���̰���Enter�� 
	    if(a.children[0].value==""){
	    	alert("�����Ų���Ϊ�գ�");
	    	return;
	    }
		aj=a;
		createXMLHttpRequest();
    	xmlHttp.onreadystatechange=update;
    	xmlHttp.open("GET","../afuer/keyEnter?bh="+a.children[0].value);
    	xmlHttp.send(null);
	}
 }
 function update(){
     if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           var doc = new ActiveXObject("MSxml2.DOMDocument")
           doc.loadXML(xmlHttp.responseText);
           result=doc.getElementsByTagName("de");
           if(result[0].childNodes[2].childNodes[0].nodeValue=="null"){
           		alert("�ö������!");
           		return;
           }
           table=(document.getElementById("list-table")).children[0];
           var i=aj.parentNode.rowIndex;
           table.rows[i].children[1].children[0].value=result[0].childNodes[0].childNodes[0].nodeValue;
           table.rows[i].children[2].children[0].value=result[0].childNodes[5].childNodes[0].nodeValue;
           table.rows[i].children[3].children[0].value=result[0].childNodes[1].childNodes[0].nodeValue;  
           table.rows[i].children[4].children[0].value=result[0].childNodes[2].childNodes[0].nodeValue; 
           table.rows[i].children[5].children[0].value=result[0].childNodes[3].childNodes[0].nodeValue;
           table.rows[i].children[6].children[0].value=result[0].childNodes[4].childNodes[0].nodeValue;  
           table.rows[i].children[2].children[0].focus();       
           
		   table.rows[i].cells[11].children[0].checked = true;
		   table.rows[i].cells[12].children[0].checked = true;
		   table.rows[i].cells[13].children[0].checked = true;
		   table.rows[i].cells[14].children[0].checked = true;
		   table.rows[i].cells[9].children[0].value = "1.00";
        }
     }
  }	
  //������������е���֤��ȡ���ȡ�����ϼ�
function computeAndValid(numObj){
	if(NumValid(numObj)){
		var dw = numObj.parentNode.parentNode.cells[4].children[0].value;
		if(dw!=null&&dw!=''){
			dw = dw.replace('/','');
			var jd = eval('document.form1.DW_'+dw);
			if(jd!=null){
				numObj.value = setNumFormat(numObj.value,new Number(jd.value));
			}
		}
	}
}
  //��λ�䶯ʱ������ȡ���ȡ�����ϼ�
function dwChangeEvent(dwObj){
	var slObj = dwObj.parentNode.parentNode.cells[2].children[0];
	if(slObj.value!=null&&slObj.value!='')
		computeAndValid(slObj);
}
//��ʾ���صĵ�λѡ��
//function show(obj){
//	obj.children[1].children[0].style.display="block";
//}
//��������������޸���Żس��󣬱�õ�ǰ���ָ����
function cha(obj){		
	changerow(obj,"list-table",3);
}
//׷����
function zj(){
	addList("list-table",3);
	var listtable= document.getElementById("list-table");
	var rowlength=listtable.rows.length-3; 
	rowsSort("list-table",rowlength,3);//��������id="list-table"����Ч���ݳ���objlen����ͷ���У�
}
//Ĭ��ҹ���־��ѡ�е� ����û��
function changbox(obj){
	
	obj.parentNode.parentNode.cells[11].children[0].checked = true;
	obj.parentNode.parentNode.cells[12].children[0].checked = true;
	obj.parentNode.parentNode.cells[13].children[0].checked = true;
	obj.parentNode.parentNode.cells[14].children[0].checked = true;
	obj.parentNode.parentNode.cells[9].children[0].value = "1.00";
}
function nextp(event,obj){
	if(event.keyCode==13) {
		 var i=obj.parentNode.rowIndex+1;
		 table=(document.getElementById("list-table")).children[0];
		 var rowlength=table.rows.length-1;
		 if(i>rowlength){
		 	alert("��׷����!");
		 	return;
		 }else{
		 	table.rows[i].children[1].children[0].focus(); 
		 }
	}
}
function checkxs(obj){
	var xs=obj.value;
    if(xs==""){
      alert("����ϵ������Ϊ�գ�Ĭ��Ϊ1");
      obj.value=1;
      obj.focus();
    }else{
      if(xs<=0){
        alert("����ϵ������С�ڵ���0��");
        obj.value=1;
        obj.focus();
      }
    } 
}
function checktz(obj){
	var xs=obj.value;
    if(xs==""){
      alert("����ϵ������Ϊ�գ�Ĭ��Ϊ1");
      obj.value=1;
      obj.focus();
    }else{
      if(xs<1){
      	alert("����ϵ������С��1��");
      	obj.focus();
      }
    } 
}
function reBuildFy(){//������ȡ��������
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
  
    //ͬ����������Ϣ
  function xxtb()
  {
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=xxtbcl;
    xmlHttp.open("GET","../afuer/SynchronizeController?act=b3j&dxgc_id="+<%=dxgc_id%>);
    xmlHttp.send(null);
  }
  
  function xxtbcl()
  {
    var fl;
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           jgf=xmlHttp.responseText;
           if(jgf=="b3j")
           {
             alert("������ͬ���ɹ�");
           }
        }
     }
  }
</script>
</head>
<body leftmargin="0" topmargin="0" id="main-body" scroll="yes"  onload="javascript:addNumSelect()">
<div id="menuDiv" onmouseover="javascript:this.style.display='block';" onmouseout="javascript:this.style.display='none';" style="display:none;position: absolute;left:195;top:39;width:88;background-color:#FFFFFF;border:1px solid gray">
<table border="0" width="100%">
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="allwinOpen('../print/print.jsp?type=print&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=4')">����Ԥ��</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=pdf&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=4');">PDF���</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=doc&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=4');">WORD���</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../export/SingleProject_excel.jsp?dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=4');">EXCEL���</td>
	</tr>
</table>
</div>
<table border="0" cellpadding="2" style="height:45px;border-collapse:collapse;" width="100%">
	<tr>
		<td style="height:15px"></td>
	</tr>
	<tr>
		<td style="vertical-aling:bottom;">
			<%if(data1.getGdsj() == null){ %>
			&nbsp;<input type="button" name="b1" value=" ������Ϣ " onclick="check()">
			<!-- 
			<%if(yh.getOperate()!=null&&yh.getOperate().intValue()==1){ %>
			&nbsp;<input type="button" name="" value=" ��Ϣͬ�� " onClick="xxtb()"> 
			<%} %>
			-->
			&nbsp;<input type="button" name="b2" value=" ׷���� "  onclick="zj()">
			<!-- 
			&nbsp;<input type="button" style="width:110px;" name="b" value=" ��ȡ�����׷��� " onclick="javascript:reBuildFy()">
			 -->
			&nbsp;<input type="button" value="�������ݵ���" onclick="javascript:winOpen('../import/import.jsp?config=b3j_import&GCXM_ID=<%=gcxm_id%>&DXGC_ID=<%=dxgc_id%>','580','295','0')">
			<%} %>
			&nbsp;<input type="button" name="b2" value=" ����Ԥ�� " onclick="javascript:dbyl(this);">
			&nbsp;<input type="button" name=""   value=" ȫ��Ԥ�� "onclick="javascript:winOpen('../print/SingleProject_print.jsp?gcxm_id=<%=request.getParameter("gcxm_id")%>&dxgc_id=<%=request.getParameter("dxgc_id")%>'
					,'580','295','0')" >
		</td>
	</tr>
</table>
<div style="width:100%;background:#ffffff;">
<form name="form1" method="post" action="">
<div class="file_title">������װ������<%=jsjd%>����������</div>
<input type="hidden" id="chongqufy" name="chongqufy" value="0">
<input type="hidden" name="perproty" value="b3j_id,Gd05_b3j,ID">
<input type="hidden" name="tableInfomation" value="noFatherTable:Gd05_b3j">
	<div style="text-align:left;color:1E4F75;font-size:13px;font-weight:bold;padding:3px 0px;"><img src="../images/setting.gif" border="0" onClick="showsetting()" style="cursor:hand;"></div>
		<div align="left">		
		<div id="setting" style="display:none;">
		<table border="0" cellpadding="0" style="border-collapse: collapse;background-color:#f0f0f0;border:solid 1px #cccccc" width="98%">
		<tr style="height:6px;">
			<td colspan="6" align="center"><div style="position:relative;"><div style="position:absolute;right:2px;cursor: hand;"><img src="../images/ca.jpg" border="0" onClick="showsetting()"></div></div></td>
		</tr>
		<tr>
			<td width="30" align="right">�� </td>
			<td>���յ���</td>
			<td width="30" align="right">�� </td>
			<td>��������</td>
		</tr>
		<tr>
			<td></td>
			<td valign="top">
			<%if(data1.getZy_id().intValue()==1||data1.getZy_id().intValue()==2){ %>
				���߹���С���ղ�ȡ���յ����� <input type="checkbox" name="xgr_bz"  value="1" <%if(data1.getXgr_bz()!=null && data1.getXgr_bz().intValue()==1){%> checked<%}%>><br>
				100�������¹��̵���ϵ����<input  onblur="checktz(this)" type="text" name="100xgr_tz"
					value="<%if(data4.getBz()!=null&&data4.getBz().intValue()==100){out.print(NumberFormatUtil.roundToString(data4.getRgfl()));}else{out.print("1.0");} %>" style="width:78px;color:red;"><br>
				100-250���չ��̵���ϵ����<input onblur="checktz(this)" type="text" name="250xgr_tz"
					value="<%if(data5.getBz()!=null&&data5.getBz().intValue()==250){out.print(NumberFormatUtil.roundToString(data5.getRgfl()));}else{out.print("1.0");} %>" style="width:78px;color:red;"><br>
			<%} %>
			<%if(data1.getGcxz()!=null&&data1.getGcxz().intValue()==2){%>
				ȫ���������̹��յ������ʣ�<input type="text" name="qbkjgc" value="<%if(data10!=null&&data10.getRgfl()!=null){out.print(NumberFormatUtil.roundToString(data10.getRgfl()));}%>" style="width:78px;color:red;"><br>
			<%} %>
				�����ϼƹ��յ���ϵ����<input onblur="checkxs(this)" type="text" name="jghj" value="<%if(data1.getB3_jggr_tzxs()!=null){out.print(NumberFormatUtil.roundToString(data1.getB3_jggr_tzxs()));}else{out.print("1.0");}%>" style="width:66px;color:red;"><br>
				��ͨ�ϼƹ��յ���ϵ����<input onblur="checkxs(this)" type="text" name="pghj" value="<%if(data1.getB3_pggr_tzxs()!=null){out.print(NumberFormatUtil.roundToString(data1.getB3_pggr_tzxs()));}else{out.print("1.0");}%>" style="width:66px;color:red;">
			</td>
			<td>��</td>
			 
			<td valign="top">
			<% String bgxd=data1.getBgxd();
			 	String HSql4="select gb03 from Gb03_bgxx gb03 where id in ("+bgxd+")";
                   ResultObject roo = queryService.search(HSql4);
                   int[] bgxx_xh=new int[18];
                   for(int j=0;j<18;j++)
                   {
                     bgxx_xh[j]=0;
                   }
                   while(roo.next())
                   {
                        Gb03_bgxx gb03=null;
                        gb03=(Gb03_bgxx)roo.get("gb03");
                        bgxx_xh[gb03.getId().intValue()]=gb03.getId().intValue();
                   }
			%>
				<%if(bgxx_xh[11]==11){ %>
				���������Զ�����<input type="checkbox" name="ZCSC_BZ" value="1" <%if(data9.getId()==null){%> 
				checked<%}%> >
				���ļ۸�<select name="B4_ZCJG">
							<option value="BDJ" <%if(data1.getB4_zcjg()!=null&&data1.getB4_zcjg().equals("BDJ")){%>selected<%} %>>���ؼ�</option>
							<option value="BSJ" <%if(data1.getB4_zcjg()!=null&&data1.getB4_zcjg().equals("BSJ")){%>selected<%} %>>��ʡ��</option>
							<option value="QGJ" <%if(data1.getB4_zcjg()!=null&&data1.getB4_zcjg().equals("QGJ")){%>selected<%} %>>ȫ����</option>
							<option value="YSJ" <%if(data1.getB4_zcjg()!=null&&data1.getB4_zcjg().equals("YSJ")){%>selected<%}%>>Ԥ���</option>
						  </select><br>
				<%} %>
	 			<% if(bgxx_xh[7]==7){ %>
				�����豸�Զ�����<input type="checkbox" name="SBSC_BZ" value="1" <%if(data9.getId()==null){%> 
				checked<%}%> >
				�豸�۸�<select name="B4_SBJG">
							<option value="BDJ" <%if(data1.getB4_sbjg()!=null&&data1.getB4_sbjg().equals("BDJ")){%>selected<%}%>>���ؼ�</option>
							<option value="BSJ" <%if(data1.getB4_sbjg()!=null&&data1.getB4_sbjg().equals("BSJ")){%>selected<%}%>>��ʡ��</option>
							<option value="QGJ" <%if(data1.getB4_sbjg()!=null&&data1.getB4_sbjg().equals("QGJ")){%>selected<%}%>>ȫ����</option>
							<option value="YSJ" <%if(data1.getB4_sbjg()!=null&&data1.getB4_sbjg().equals("YSJ")){%>selected<%}%>>Ԥ���</option>
						  </select><br>
				<%} %>
				<% if(bgxx_xh[5]==5){ %>		  
				������е�Զ�����<input type="checkbox" name="JXSC_BZ" value="1" <%if(data9.getId()==null){%>
				checked<%}%>>
				��е���ۣ�<select name="B4_JXJG">
							<option value="BDJ" <%if(data1.getB3_jxjg()!=null&&data1.getB3_jxjg().equals("BDJ")){%>selected<%}%>>���ؼ�</option>
							<option value="BSJ" <%if(data1.getB3_jxjg()!=null&&data1.getB3_jxjg().equals("BSJ")){%>selected<%}%>>��ʡ��</option>
							<option value="QGJ" <%if(data1.getB3_jxjg()!=null&&data1.getB3_jxjg().equals("QGJ")){%>selected<%}%>>ȫ����</option>
							<option value="YSJ" <%if(data1.getB3_jxjg()!=null&&data1.getB3_jxjg().equals("YSJ")){%>selected<%}%>>Ԥ���</option>
						  </select><br>
				<%}%>
				<% if(bgxx_xh[6]==6){ %>
				�����Ǳ��Զ�����<input type="checkbox" name="YBSC_BZ" value="1" <%if(data9.getId()==null){%>
				checked<%}%>>
				�Ǳ��ۣ�<select name="B4_YBJG">
							<option value="BDJ" <%if(data1.getB3_ybjg()!=null&&data1.getB3_ybjg().equals("BDJ")){%>selected<%}%>>���ؼ�</option>
							<option value="BSJ" <%if(data1.getB3_ybjg()!=null&&data1.getB3_ybjg().equals("BSJ")){%>selected<%}%>>��ʡ��</option>
							<option value="QGJ" <%if(data1.getB3_ybjg()!=null&&data1.getB3_ybjg().equals("QGJ")){%>selected<%}%>>ȫ����</option>
							<option value="YSJ" <%if(data1.getB3_ybjg()!=null&&data1.getB3_ybjg().equals("YSJ")){%>selected<%}%>>Ԥ���</option>
						  </select>
				<%}%>
				
			</td>
		</tr>
		<%if(data1.getB3_sgtj_bz()!=null&&data1.getB3_sgtj_bz().intValue()==0) {%>
		<tr>
			<td width="30" align="right">�� </td>
			<td> ��ԭ����</td>
			<td width="30" align="right">�� </td>
			<td>ɭ�ּ�ɳĮ����</td>
		</tr>
		<tr>
			<td></td>
			<td valign="top">
				<input type="radio" name="B3_GYDQ_BZ" value="1" checked>��������<br>
				<%
					while(ro2.next()){
					data2=(Gd10_b3fl)ro2.get(Gd10_b3fl.class.getName());
					if(data2!=null){
				 %>
				 <input type="radio" name="B3_GYDQ_BZ" value="<%=data2.getId()%>" 
				 	<%if(data2.getFlag()!=null){if(data2.getFlag().intValue()==1){ %>checked<%} }%> 
				 	><%=data2.getMc()%>��<input type="text" name="gy<%=data2.getId().intValue()%>" 
				 	value="<%if(data2.getRgfl()!=null){out.print(NumberFormatUtil.roundToString(data2.getRgfl()));}%>"style="width:66px;color:red;"><br>
				 <%} }%>			
			</td>
			<td></td>
			<td valign="top">
				<input type="radio" name="B3_SLSM_BZ" value="1" checked>��������<br>
				<%
				int j=1;
				while(ro3.next()){
					data3=(Gd10_b3fl)ro3.get(Gd10_b3fl.class.getName());
					if(data3!=null){
					j++;
				 %>
				 <input type="radio" name="B3_SLSM_BZ" value="<%=data3.getId()%>" 
				 	<%if(data3.getFlag()!=null&&data3.getFlag().intValue()==1){%>checked<%}%> 
				 	><%=data3.getMc()%>��<input type="text" name="sl<%=data3.getId().intValue()%>" 
				 	value="<%if(data3.getRgfl()!=null){out.print(NumberFormatUtil.roundToString(data3.getRgfl()));}%>"style="width:66px;color:red;"><br>
				 <%}} %>
				</td>
		</tr>
		<%}%>
		<tr style="height:6px;">
			<td colspan="6"> </td>
		</tr>
	</table>
	<br>
	</div>
	<table name="listtable" id="list-table" border="0" cellpadding="0" style="border-collapse: collapse" width="1400">
		<tr class="list-title">
			<td width="30" rowspan="2">���</td>
			<td width="110" rowspan="2">������</td>
			<td width="100" rowspan="2">����</td>
			<td width="400" rowspan="2">��������</td>
			<td width="65" rowspan="2">��λ</td>
			<td width="140" colspan="2">��λ����ֵ</td>
			<td width="140" colspan="2">�ϼ�ֵ</td>
			<td width="80" rowspan="2">����ϵ��</td>
			<td width="80" rowspan="2" align="center">��������</td>
			<td width="40" rowspan="2">ҹ���־</td>
			<td width="50" rowspan="2">���꼾��־</td>
			<td width="40" rowspan="2">���̸���</td>
			<td width="40" rowspan="2">�����־</td>
			<td width="300" rowspan="2" align="center" >��ע</td>
		</tr>
		<tr class="list-title">
			<td width="70">����<br>����</td>
			<td width="70">�չ�<br>����</td>
			<td width="70">����<br>����</td>
			<td width="70">�չ�<br>����</td>
		</tr>
		<tr class="list-title">
			<td width="30">1</td>
			<td width="110">2</td>
			<td width="80">3</td>
			<td width="400">4</td>
			<td width="65">5</td>
			<td width="60">6</td>
			<td width="60">7</td>
			<td width="60">8</td>
			<td width="60">9</td>
			<td width="80">10</td>
			<td width="80">11</td>
			<td width="40">12</td>
			<td width="50">13</td>
			<td width="40">14</td>
			<td width="40">15</td>
			<td width="300">16</td>
		</tr>
		<%	Gd05_b3j data= new Gd05_b3j();
			int i = 0;
			while(ro.next() || i < 15){
				i++;
				data=(Gd05_b3j)ro.get(Gd05_b3j.class.getName());
				if(data!=null){
					String jgsum="";//�����ϼ�
					String pgsum="";//�չ��ϼ�
					if(data.getTzxs()!=null){
						jgsum = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
							data.getSl().doubleValue(),data.getJggr().doubleValue()),data.getTzxs().doubleValue()));}
					else{
						jgsum = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data.getSl().doubleValue(),data.getJggr().doubleValue()));
					}
					if(data.getTzxs()!=null){
						pgsum = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
						data.getSl().doubleValue(),data.getPggr().doubleValue()),data.getTzxs().doubleValue()));
					}else{
						pgsum = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data.getSl().doubleValue(),data.getPggr().doubleValue()));
					}
					if(data.getCk_bz()!=null){// ��ѯ����ϵ��
						QueryBuilder queryBuilder22 = new HibernateQueryBuilder(Ga09_kcxs.class);
						queryBuilder22.eq("lb", data.getCk_bz());
						queryBuilder22.eq("sort",new Integer(1));//���1���˹���2�ǻ�е
						queryBuilder22.ge("jzbh", data.getDebh());//������С�ڵ�����ֹ���
						queryBuilder22.le("qsbh", data.getDebh());//�����Ŵ��ڵ�����ʼ���
						ResultObject ro22 = queryService.search(queryBuilder22);
						Ga09_kcxs ckxs = new Ga09_kcxs();
						if(ro22.next()){
							 ckxs = (Ga09_kcxs)ro22.get(Ga09_kcxs.class.getName());
							 if(ckxs!=null){
								jgsum = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(jgsum,NumberFormatUtil.roundToString(NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100))));//����������ϼ��ٳ���ϵ��
								pgsum = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(pgsum,NumberFormatUtil.roundToString(NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100))));
							}					
						}
					}				
		%>
		<tr>
			<td title="˫��ɾ����һ��" ondblclick="javascript:if(confirm('ȷ��ɾ����'))delRow(this.parentNode.rowIndex);">
				<input type="text" onblur="cha(this.parentNode)"  style="text-align:center"  name="Gd05_b3j.XH" value="<%if(data.getXh()!=null){out.print(data.getXh());}else{out.print(i);}%>"></td>
			<td onkeypress="send(event,this)" ondblclick="javascript:openSelectWin(this,'list-table','../dataManage/selectQuota.jsp?ro='+this.parentNode.rowIndex,'750','550','0')">
				<input type="text" name="Gd05_b3j.DEBH" value="<%=data.getDebh()%>" title="˫���򿪶���ѡ�񴰿ڣ���ֱ��¼�붨���س�" >
			</td>
			<td onkeypress="nextp(event,this)"><input type="text" name="Gd05_b3j.SL"  style="text-align:right;" value="<%=NumberFormatUtil.roundToString(data.getSl(),3)%>"></td>
			<td style="text-align:left;" ondblclick="javascript:winOpen('degl.jsp?de_bh=<%=data.getDebh()%>','800','500','1');" title="˫���򿪲鿴���������е�����ϵ�"><textarea name="Gd05_b3j.DEMC" id="Gd05_b3j.DEMC" readonly><%=data.getDemc()%></textarea></td>
			<td><input type="text" name="Gd05_b3j.DW" readonly  value="<%=StringFormatUtil.format(data.getDw())%>"></td>
			<td><input type="text" name="Gd05_b3j.JGGR" readonly style="text-align:right;" value="<%=NumberFormatUtil.roundToString(data.getJggr())%>"></td>
			<td><input type="text" name="Gd05_b3j.PGGR" readonly style="text-align:right;" value="<%=NumberFormatUtil.roundToString(data.getPggr())%>"></td>
			<td align="right"><%=jgsum%></td>
			<td align="right"><%=pgsum%></td>
			<td><input type="text" name="Gd05_b3j.TZXS" value="<%if(data.getTzxs()!=null){out.print(NumberFormatUtil.roundToString(data.getTzxs()));}else{out.print(NumberFormatUtil.roundToString(1.00));}%>" style="text-align:right;"></td>
			<td>
				<select name="Gd05_b3j.CK_BZ">
					<option value="1" <%if(data.getCk_bz() != null && data.getCk_bz().intValue() == 1){out.print("selected");}%>>�½�</option>
					<option value="2" <%if(data.getCk_bz() != null && data.getCk_bz().intValue() == 2){out.print("selected");}%>>����</option>
					<option value="3" <%if(data.getCk_bz() != null && data.getCk_bz().intValue() == 3){out.print("selected");}%>>���������</option>
					<option value="4" <%if(data.getCk_bz() != null && data.getCk_bz().intValue() == 4){out.print("selected");}%>>�����������</option>
					<option value="5" <%if(data.getCk_bz() != null && data.getCk_bz().intValue() == 5){out.print("selected");}%>>����</option>
					<option value="" ></option>
				</select>
			</td>
			<td> 
				<input type="checkbox" style="width:30px;" name="YJBZ" onclick="javascript:setBz(this);" <%if(data.getYj_bz()!=null && data.getYj_bz().intValue()==1){%>checked<%}%>>
				<input type="hidden" name="Gd05_b3j.YJ_BZ" value="<%if(data.getYj_bz()!=null){out.print(data.getYj_bz());}%>">
			</td>
			<td>
				<input type="checkbox" style="width:30px;" name="DYJBZ"  onclick="javascript:setBz(this);" <%if(data.getDyj_bz()!=null && data.getDyj_bz().intValue()==1){ %>checked<%} %>>
				<input type="hidden" name="Gd05_b3j.DYJ_BZ" value="<%if(data.getDyj_bz()!=null){out.print(data.getDyj_bz());}%>">
			</td>
			<td>
				<input type="checkbox" style="width:30px;" name="GRFBZ" onclick="javascript:setBz(this);" <%if(data.getGrf_bz()!=null && data.getGrf_bz().intValue()==1){ %>checked<%} %>>
				<input type="hidden" name="Gd05_b3j.GRF_BZ" value="<%if(data.getGrf_bz()!=null){out.print(data.getGrf_bz());}%>">
			</td>
			<td>
				<input type="checkbox" style="width:30px;" name="SDQBZ" onclick="javascript:setBz(this);" <%if(data.getTsdq_bz()!=null && data.getTsdq_bz().intValue()==1){ %>checked<%}%>>
				<input type="hidden" name="Gd05_b3j.TSDQ_BZ" value="<%if(data.getTsdq_bz()!=null){out.print(data.getTsdq_bz());}%>">
			</td>
			<td><input type="text" name="Gd05_b3j.BZ" value="<%if(data.getBz()!=null){out.print(data.getBz());}else{out.print(""); }%>">
				<input type="hidden" name="Gd05_b3j.GCXM_ID" value="<%=data.getGcxm_id()%>">
				<input type="hidden" name="Gd05_b3j.DXGC_ID" value="<%=dxgc_id%>">
				<input type="hidden" name="Gd05_b3j.ID" value="<%=data.getId()%>">		
			</td>
		</tr>
		<%}else{%>
		<tr>
			<td title="˫��ɾ����һ��" ondblclick="javaxcript:if(confirm('ȷ��ɾ����'))delRow(this.parentNode.rowIndex);">
			<input onblur="cha(this.parentNode)" style="text-align:center" name="Gd05_b3j.XH" value="<%=i%>">					
			</td>
			<td onkeypress="send(event,this)"  ondblclick="javascript:openSelectWin(this,'list-table','../dataManage/selectQuota.jsp?ro='+this.parentNode.rowIndex,'750','550','0')">
				<input type="text" name="Gd05_b3j.DEBH" value="" title="˫���򿪶���ѡ�񴰿ڣ���ֱ��¼�붨���س�" >
			<td onkeypress="nextp(event,this)"><input type="text" name="Gd05_b3j.SL" onchange="computeAndValid(this)" style="text-align:right;" value=""></td>
			<td><textarea name="Gd05_b3j.DEMC" id="Gd05_b3j.DEMC" readonly></textarea></td>
			<td><input type="text" name="Gd05_b3j.DW" readonly   value=""></td>
			<td><input type="text" name="Gd05_b3j.JGGR" readonly style="text-align:right;" value=""></td>
			<td><input type="text" name="Gd05_b3j.PGGR" readonly style="text-align:right;" value=""></td>
			<td>��</td>
			<td>��</td>
			<td><input type="text" name="Gd05_b3j.TZXS" value="" style="text-align:right;"></td>
			<td><select name="Gd05_b3j.CK_BZ">
				<option value="1">�½�</option>
				<option value="2">����</option>
				<option value="3">���������</option>
				<option value="4">�����������</option>
				<option value="5">����</option>
				<option value="" ></option>
				</select>
			</td>
			<td><input type="checkbox" style="width:30px;" name="YJBZ"  onclick="javascript:setBz(this);">
					<input type="hidden" name="Gd05_b3j.YJ_BZ" value="1"></td>
			<td><input type="checkbox" style="width:30px;" name="DYJBZ" onclick="javascript:setBz(this);">
					<input type="hidden" name="Gd05_b3j.DYJ_BZ" value="1"></td>
			<td><input type="checkbox" style="width:30px;" name="GRFBZ" onclick="javascript:setBz(this);">
					<input type="hidden" name="Gd05_b3j.GRF_BZ" value="1"></td>
			<td><input type="checkbox" style="width:30px;" name="SDQBZ" onclick="javascript:setBz(this);">
					<input type="hidden" name="Gd05_b3j.TSDQ_BZ" value="1"></td>
			
			<td><input type="text" name="Gd05_b3j.BZ" value="">
				<input type="hidden" name="Gd05_b3j.GCXM_ID" value="<%=gcxm_id%>">
				<input type="hidden" name="Gd05_b3j.DXGC_ID" value="<%=dxgc_id %>">
				<input type="hidden" name="Gd05_b3j.ID" value="">
			</td>
		</tr>
		<%}}%>	
		</table>
		<%
		for(int k=0;k<list.size();k++){
			Object[] tmp = (Object[])list.get(k);
			out.println("<input type='hidden' name='DW_"+tmp[0].toString().replaceAll("/","")+"' value='"+tmp[1].toString()+"'>");
		}
		%>
		<table border="0" cellpadding="2" style="height:35px;border-collapse:collapse;" width="100%">
		<tr>
			<td style="height:5px"></td>
		</tr>
		<tr>
		<td style="vertical-aling:bottom;">
			&nbsp;<input type="button" name="b2" value=" ׷���� "  onclick="zj()">
		</td>
		</tr>
		</table>
		<br>
		<input type="hidden" name="limitInput">
		<input type="hidden" name="list_validate" value="���:Gd05_b3j.XH:NUMBER:3:1;������:Gd05_b3j.DEBH:VARCHAR2:20:0;
			��������:Gd05_b3j.DEMC:VARCHAR2:200:0;����:Gd05_b3j.SL:NUMBER:12.3:0;��λ:Gd05_b3j.DW:VARCHAR2:20:0;
			��������:Gd05_b3j.JGGR:NUMBER:12.2:0;�չ�����:Gd05_b3j.PGGR:NUMBER:12.2:0;��ע:Gd05_b3j.BZ:VAECHAR2:100:1;
			����ϵ��:Gd05_b3j.TZXS:NUMBER:5.2:1;">
</form>
</div>
</body>
</html>