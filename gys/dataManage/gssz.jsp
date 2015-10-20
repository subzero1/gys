<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Gd01_gcxm"%>
<%@ page import="com.netsky.dataObject.Gb03_bgxx" %>
<%@ page import="com.netsky.dataObject.Ga05_fy"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="java.util.*"%>
<%@ page import="com.netsky.dataObject.Gd03_gcfysz"%>
<%@ page import="org.hibernate.criterion.Order"%>
<%@ page import="com.netsky.baseFormatUtils.NumberFormatUtil"%>
<%@ page import="com.netsky.baseObject.Calculator"%>
<%@ page import="com.netsky.service.ExpenseService"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil"%>
<%@page import="com.netsky.baseFormatUtils.NumberFormatUtil"%>

<%                 
      ApplicationContext ctx1 = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
      ExpenseService expenseService = (ExpenseService) ctx1.getBean(ServiceName.ExpenseService);
      String user = (String)session.getAttribute("user");
   	  String fy_id=request.getParameter("fy_id");
      String dxgc_id=request.getParameter("dxgc_id");
      ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
          QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
      String HSql1="select ga05 from Ga05_fy ga05 where id="+fy_id;
      String HSql2="select gd03 from Gd03_gcfysz gd03 where fy_id="+fy_id+" and dxgc_id="+dxgc_id;
      
      //-------------------------表二辅材费的公式，光电缆表被选中时（在综合信息中），才要加光电缆费     
//      QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
//      queryBuilder.eq("id",new Integer(dxgc_id));
//      ResultObject ro = queryService.search(queryBuilder);
//      Gd02_dxgc dxgc = new Gd02_dxgc();
//      String bgxd=null;
//      if(ro.next()){
//      		dxgc = (Gd02_dxgc)ro.get(Gd02_dxgc.class.getName());
//      		 bgxd=dxgc.getBgxd();
//      }
//      String HSql4="select gb03 from Gb03_bgxx gb03 where id in ("+bgxd+")";
//      ResultObject ro4 = queryService.search(HSql4);
//      int[] bgxx_xh=new int[18]; 
//      while(ro4.next())
//      {
//           Gb03_bgxx gb03=null;
//           gb03=(Gb03_bgxx)ro4.get("gb03");
//           bgxx_xh[gb03.getId().intValue()]=gb03.getId().intValue();
//      }
      //------------------------------------
      
      ResultObject ro1 = queryService.search(HSql1);
      ResultObject ro2 = queryService.search(HSql2);
      Ga05_fy ga05=new Ga05_fy();
      if(ro1.next())
      {
         ga05=(Ga05_fy)ro1.get("ga05");
      }
      Gd03_gcfysz gd03=new Gd03_gcfysz();
      if(ro2.next())
      {
         gd03=(Gd03_gcfysz)ro2.get("gd03");
      }
 %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>计算公式设置</title>
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" language="JavaScript" src="../js/gssz.js" ></script>
<script type="text/javascript">
  var xmlHttp; 
  function createXMLHttpRequest()
  {
    if(window.ActiveXObject)
    {
      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if(window.XMLHttpRequset)
    {
      xmlHttp=new XMLHttpRequest();
    }
  }
  
  function js()
  {
    if(document.all.jsfs[1].checked){
      t=document.all.T2.value;
      s=document.all.S2.value;
      var obj = opener.document.getElementById("<%=request.getParameter("id")%>");
	  var objv = opener.document.getElementById("<%=request.getParameter("id")%>"+"z");
	  var objg = opener.document.getElementById("<%=request.getParameter("id")%>"+"g");
	  objv.value=round(t,2);
	  obj.value =s;
	  objg.value="";
	  window.opener.jaf("<%=request.getParameter("dyyl")%>");
	  window.close();
    }else{
      createXMLHttpRequest();
      var jsgs;
      if(document.all.jsfs[0].checked)
      {
        jsgs=document.all.T1.value;
      }
      if(document.all.jsfs[2].checked)
      {
        jsgs=document.all.T3.value;
      }
      xmlHttp.onreadystatechange=cl;
      var sjcs="";
      if(<%=request.getParameter("fy_id")%>=="34")
      {
        sjcs="&zjf=<%=request.getParameter("zjf")%>&jjf=<%=request.getParameter("jjf")%>&lr=<%=request.getParameter("lr")%>&clf=<%=request.getParameter("clf")%>";
      }
      xmlHttp.open("GET","../afuer/GsjsXml?dxgc_id=<%=request.getParameter("dxgc_id")%>&jsgs="+encodeURIComponent(jsgs)+sjcs);
      xmlHttp.send(null);
    }
  }
  
  function cl()
  {
    var jsjg;
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           jsjg=xmlHttp.responseText;
           setValue(jsjg);
        }
     }
  }
  
  //设置表2页面值
  function setValue(jsjg)
  {
    var t;
    if(document.all.jsfs[0].checked)
    {
      t=document.all.T1.value;
      s=document.all.S1.value;
    }
    if(document.all.jsfs[1].checked)
    {
      t=document.all.T2.value;
      s=document.all.S2.value;
    }
    if(document.all.jsfs[2].checked)
    {
      t=document.all.T3.value;
      s=document.all.S3.value;
    }
	var obj = opener.document.getElementById("<%=request.getParameter("id")%>");
	var objv = opener.document.getElementById("<%=request.getParameter("id")%>"+"z");
	var objg = opener.document.getElementById("<%=request.getParameter("id")%>"+"g");
	objv.value=round(jsjg,2);
	obj.value = s;
	if("<%=request.getParameter("id")%>"=="sj")
	{
	  obj.value = document.all.S1.value;
	}else{
	  obj.value = s;
	}
	objg.value = t
	//opener.location="javascript:jaf()";
	window.opener.jaf("<%=request.getParameter("dyyl")%>");
	if("<%=request.getParameter("id")%>"!="sj")
	{
	  window.opener.sjr();
	}
	window.close();
  }
  
  //公式显示
  function input(obj,str,jc)
  {
    if(document.all.jsfs[1].checked)
    {
      	document.all.T2.value+=str;
      	//document.all.S2.value+=obj.value;
      	document.all.S2.value="按实计列";
    }
    if(document.all.jsfs[2].checked)
    {
        if(jc==1){
          document.all.T3.value+="["+obj.value+"]";
        }
        else{
      	  document.all.T3.value+=str;
      	}
      	document.all.S3.value+=obj.value;
    }
  }
  //清除公式内容
  function clearInput()
  {
	if(document.all.jsfs[1].checked)
    {
      	document.all.T2.value = "";
      	document.all.S2.value = "";  	
    }
    if(document.all.jsfs[2].checked)
    {
      	document.all.T3.value = "";
      	document.all.S3.value = "";
    }
    k=0;
  }
  
  
  //公式输入限制
  var k=0;//括号标记
  var j=0;//除号标记
  var d=0;//小数点标记
  var ling=0;//0标记
  var ii=0;//相关费率
  function setBtn(csh)
  {
    if(document.all.jsfs[0].checked)
    {
      disbtn('jcfy',ii,0);
      disbtn('left_kh',1,0);
      disbtn('right_kh',1,0);
      disbtn('ysf',4,0);
      disbtn('sz',9,0);
      disbtn('sz0',1,0);
      disbtn('dian',1,0);
      disbtn('bfh',1,0);
      disbtn('GCF10',1,0);
      disbtn('tj',1,1);
      k=0;
      j=0;
      d=0;
      ling=0;
      document.all.T2.value = "";  
      document.all.T3.value = "";
      document.all.S2.value = "";  
      document.all.S3.value = "";
    }
    if(document.all.jsfs[1].checked)
    {
      if("<%=request.getParameter("id")%>"=="sj")
	  {
	    disbtn('jcfy',ii,0);
        disbtn('left_kh',1,0);
        disbtn('right_kh',1,0);
        disbtn('ysf',4,0);
        disbtn('sz',9,0);
        disbtn('sz0',1,0);
        disbtn('dian',1,0);
        disbtn('bfh',1,0);
        disbtn('GCF10',1,0);
        disbtn('tj',1,0);
	  }else{
        disbtn('jcfy',ii,0);
        disbtn('left_kh',1,0);
        disbtn('right_kh',1,0);
        disbtn('ysf',4,0);
        disbtn('sz',9,1);
        disbtn('sz0',1,1);
        disbtn('dian',1,0);
        disbtn('bfh',1,0);
        disbtn('GCF10',1,1);
        disbtn('tj',1,1);
      }
      k=0;
      j=0;
      d=0;
      ling=0;   
      document.all.T3.value = "";
      document.all.S3.value = "";
      if(csh==0)
      {
        document.all.T2.value = "";  
        document.all.S2.value = "";  
      }
    }
    if(document.all.jsfs[2].checked)
    {
      disbtn('jcfy',ii,1);
      disbtn('left_kh',1,1);
      disbtn('right_kh',1,0);
      disbtn('ysf',4,0);
      disbtn('sz',9,1);
      disbtn('sz0',1,1);
      disbtn('dian',1,0);
      disbtn('bfh',1,0);
      disbtn('GCF10',1,1);
      disbtn('tj',1,1);
      k=0;
      j=0;
      d=0;
      ling=0;
      document.all.T2.value = "";  
      document.all.S2.value = "";  
      if(csh==0)
      {
        document.all.T3.value = "";  
        document.all.S3.value = "";  
      }
    }
  }
  //基本费用
  function jcfytoysf()
  {
      disbtn('jcfy',ii,0);
      disbtn('left_kh',1,0);
      if(k>0){
        disbtn('right_kh',1,1);
      }else{
        disbtn('right_kh',1,0);
      }
      disbtn('ysf',4,1);
      disbtn('sz',9,0);
      disbtn('sz0',1,0);
      disbtn('dian',1,0);
      disbtn('GCF10',1,1);
      if(k==0){
        disbtn('tj',1,1);
      }else{disbtn('tj',1,0);}
      j=0;
      d=0;
      ling=0;
      disbtn('bfh',1,0);
  }
  //运算符号
  function ysftojcfy(bz)
  {
      disbtn('jcfy',ii,1);
      disbtn('left_kh',1,1);
      disbtn('right_kh',1,0);
      disbtn('ysf',4,0);
      disbtn('sz',9,1);
      disbtn('sz0',1,1);
      disbtn('dian',1,0);
      disbtn('GCF10',1,1);
      if(k==0){
        disbtn('tj',1,1);
      }else{disbtn('tj',1,0);}
      if(bz==4){
        j=1;
      }
      disbtn('tj',1,0);
      d=0;
      ling=0;
      disbtn('bfh',1,0);
  }
  //括号
  function kh(zy)
  { 
      disbtn('left_kh',1,0);
      disbtn('right_kh',1,0);
      if(zy==2){
        k--;
        disbtn('jcfy',ii,0);
        disbtn('ysf',4,1);
        disbtn('sz',9,0);
        disbtn('sz0',1,0);
        if(k>0){
          disbtn('right_kh',1,1);
        }
      }else{
        k++;
        disbtn('jcfy',ii,1);
        disbtn('ysf',4,0);
        disbtn('sz',9,1);
        disbtn('sz0',1,1);
      }
      
      disbtn('dian',1,0);
      disbtn('GCF10',1,1);
      if(k==0){
          disbtn('tj',1,1);
        }else{
          disbtn('tj',1,0);
        }
      j=0;
      d=0;
      ling=0;
      disbtn('bfh',1,0);
  }
  //数字,不包括0
  function sz(s)
  {
      if(document.all.jsfs[1].checked)
      {
        //disbtn('dian',1,1);
        if(d==0){
        disbtn('dian',1,1);
        }
      }else{
      disbtn('jcfy',ii,0);
      disbtn('left_kh',1,0);
      if(k>0){
        disbtn('right_kh',1,1);
      }
      disbtn('ysf',4,1);
      disbtn('sz',9,1);
      disbtn('sz0',1,1);
      if(d==0){
        disbtn('dian',1,1);
      }
      disbtn('GCF10',1,1);
      if(k==0){
          disbtn('tj',1,1);
        }else{
          disbtn('tj',1,0);
        }
      j=0;
      //ling=1;
      }
      ling=1;
      disbtn('bfh',1,1);
  }
    //数字0
  function sz0()
  {
      if(document.all.jsfs[1].checked)
      {
        if(d==0){
           disbtn('dian',1,1);
         }
         if(ling==1){
            disbtn('sz',9,1);
            disbtn('sz0',1,1);
         }else{
            disbtn('sz',9,0);
            disbtn('sz0',1,0);
           }
      }else{
         disbtn('jcfy',ii,0);
         disbtn('left_kh',1,0);
         
         //disbtn('ysf',4,1);
         if(ling==1){
            disbtn('sz',9,1);
            disbtn('sz0',1,1);
         }else{
            disbtn('sz',9,0);
            disbtn('sz0',1,0);
           }
      
         if(d==0){
           disbtn('dian',1,1);
         }
         disbtn('GCF10',1,1);
         if(j==1)
         {
           disbtn('ysf',4,0);
           disbtn('tj',1,0);
         }else{
           if(k==0){
              disbtn('tj',1,1);
            }else{
              disbtn('tj',1,0);
            }
            disbtn('ysf',4,1);
            
            if(k>0){
               disbtn('right_kh',1,1);
            }
         }
      }
  }
  //小数点
  function dian()
  {
    disbtn('sz',9,1); 
    disbtn('ysf',4,0);
    disbtn('left_kh',1,0);
    disbtn('right_kh',1,0);
    disbtn('dian',1,0);
    disbtn('sz0',1,1);
    d=1;
    ling=1;
    disbtn('bfh',1,0);
  }
  //百分号
  function bfh()
  {
    disbtn('sz',9,0); 
    if(document.all.jsfs[1].checked)
    {
      disbtn('ysf',4,0);
    }else{
      disbtn('ysf',4,1);
    }
    disbtn('left_kh',1,0);
    disbtn('right_kh',1,0);
    disbtn('dian',1,0);
    disbtn('sz0',1,0);
    disbtn('bfh',1,0);
  }
  
  //控制按钮
  function disbtn(name,gs,bz)
  {
    var i;
    for(i=0;i<gs;i++)
    {
      if(bz==1){
        document.getElementsByName(name)[i].disabled=false;
      }else{
        document.getElementsByName(name)[i].disabled=true;
      } 
    }
  }
  
  //
  function ss(str)
  {
    if(str=="null")
    {str="***";}
    var datastr;
    datastr=str.split(",");   
    var iii;
    for(iii=0;iii<datastr.length;iii++){
      document.getElementsByName("jcfy")[iii].value=datastr[iii];
    }
    if(str=="***"){
      iii=0;
    }
    ii=iii;
    for(iii;iii<15;iii++){
      document.getElementsByName("jcfy")[iii].value="****";
      document.getElementsByName("jcfy")[iii].disabled=true;
    }
  }
  
  //初始化按钮
  function csh()
  {
    document.all.jsfs[1].Enabled=false;
    if(document.all.jsfs[0].checked)
    {
      disbtn('jcfy',ii,0);
      disbtn('left_kh',1,0);
      disbtn('right_kh',1,0);
      disbtn('ysf',4,0);
      disbtn('sz',9,0);
      disbtn('sz0',1,0);
      disbtn('dian',1,0);
      disbtn('bfh',1,0);
      disbtn('GCF10',1,0);
      disbtn('tj',1,1);
      k=0;
      j=0;
      d=0;
      ling=0;
      document.all.T2.value = "";  
      document.all.T3.value = "";
      document.all.S2.value = "";  
      document.all.S3.value = "";
    }
    if(document.all.jsfs[1].checked)
    {
      disbtn('jcfy',ii,0);
      disbtn('left_kh',1,0);
      disbtn('right_kh',1,0);
      disbtn('ysf',4,0);
      disbtn('sz',9,0);
      disbtn('sz0',1,0);
      disbtn('dian',1,0);
      disbtn('bfh',1,0);
      disbtn('GCF10',1,1);
      disbtn('tj',1,1);
      k=0;
      j=0;
      d=0;
      ling=0;
      //document.all.T3.value = "";
      //document.all.S3.value = "";
      document.all.T2.value = "<%=NumberFormatUtil.roundToDouble(gd03.getFyz())%>";  
      document.all.S2.value = "<%=StringFormatUtil.format(gd03.getGsbds())%>";  
    }
    if(document.all.jsfs[2].checked)
    {
      disbtn('jcfy',ii,0);
      disbtn('left_kh',1,0);
      disbtn('right_kh',1,0);
      disbtn('ysf',4,0);
      disbtn('sz',9,0);
      disbtn('sz0',1,0);
      disbtn('dian',1,0);
      disbtn('bfh',1,0);
      disbtn('GCF10',1,1);
      disbtn('tj',1,1);
      k=0;
      j=0;
      d=0;
      ling=0;
      //document.all.T2.value = "";  
      //document.all.S2.value = "";  
      document.all.T3.value = "<%=StringFormatUtil.format(gd03.getJsgs()) %>";
      document.all.S3.value = "<%=StringFormatUtil.format(gd03.getGsbds()) %>";
    }
  }
  
  	//保留小数
	function round(v,e) 
    { 
      var t=1; 
      for(;e>0;t*=10,e--); 
      for(;e<0;t/=10,e ); 
      //return Math.round(v*t)/t; 
      //把0变成“”返回
      return tonull(Math.round(v*t)/t);
    } 
    
      //把0转化成""
  function tonull(d)
  {
    if(0==d)
    {
      d="";
    }
    return d;
  }
  //测试用--暂时没用
  function www(gs)
  {
    var bz=true;
    var a;
    try{
        a=eval("8%");
    }catch(e){bz=false;}    
    if(bz){alert("1");}else{alert("2");}
    alert(a);
  }
  
</script>
</head>
<body>

<div align="center">
	<table border="0" cellpadding="0" style="border-collapse: collapse" width="550">

		 <tr>
			<td colspan="5" style="font-weight:bold;font-size:14px;height:40px;">费用名称：<%=ga05.getMc() %></td>
		</tr>
		<tr>
			<td width="30"><input type="radio" name="jsfs" id="jsfs" value="1" checked onClick="javascript:setBtn(0);"></td>
			<td width="100">按系统取费标准：</td>
			<%
//				String  biaozhun="";
//				if(bgxx_xh[17]!=17){
//					biaozhun ="[主要材料费]×"+ new String(expenseService.getFlz(new Integer(dxgc_id),new Integer(fy_id)))+"%";
//				}else{
//					biaozhun = StringFormatUtil.format(ga05.getJsgs()).replaceAll("\\[费率\\]", new String(expenseService.getFlz(new Integer(dxgc_id),new Integer(fy_id)))) ;
//				}
			 %>
			<td width="180"><input type="text" name="T1" style="width:100%" value="<%=StringFormatUtil.format(ga05.getJsgs()).replaceAll("\\[费率\\]", new String(expenseService.getFlz(new Integer(dxgc_id),new Integer(fy_id))))%>" readOnly></td>
			<td width="70" align="right">依据说明：</td>
			<%
//				String yiju = "";
//				if(bgxx_xh[17]!=17){
//					yiju = "(主要材料费)×"+new String(expenseService.getFlz(new Integer(dxgc_id),new Integer(fy_id)))+"%";
//				}else{
//					yiju = StringFormatUtil.format(ga05.getGsbds()).replaceAll("\\[费率\\]", new String(expenseService.getFlz(new Integer(dxgc_id),new Integer(fy_id))));
//				}
			%>
			<td><input type="text" name="S1" value="<%=StringFormatUtil.format(ga05.getGsbds()).replaceAll("\\[费率\\]", new String(expenseService.getFlz(new Integer(dxgc_id),new Integer(fy_id))))%>" style="width:100%" readOnly></td>
		</tr>
		<tr>
			<td><input type="radio" name="jsfs" id="jsfs" value="2" <%if(gd03.getJsgs()==null&&gd03.getFyz()!=null){ %>checked<%} %> onClick="javascript:setBtn(0);"></td>
			<td>用户输入立即数：</td>
			<td><input type="text" name="T2" style="width:100%" value="" readOnly></td>
			<td align="right">依据说明：</td>
			<td><input type="text" name="S2" style="width:100%" value=""></td>
		</tr>
		<tr>
			<td><input type="radio" name="jsfs" id="jsfs" value="3" <%if(gd03.getJsgs()!=null&&!gd03.getJsgs().equals(StringFormatUtil.format(ga05.getJsgs()).replaceAll("\\[费率\\]", new String(expenseService.getFlz(new Integer(dxgc_id),new Integer(fy_id)))))){ %>checked<%} %> onClick="javascript:setBtn(0);"></td>
			<td>自定义计算公式：</td>
			<td><input type="text" name="T3" style="width:100%" value="" readOnly></td>
			<td align="right">依据说明：</td>
			<td><input type="text" name="S3" style="width:100%" value=""></td>
		</tr>
	</table>
<script>
  window.onload=function()   
  {   
     ss("<%=gd03.getXgfy()%>");
     csh();   
  }
</script>
	<br>
	<table border="0" cellpadding="0" style="border-collapse: collapse;background-color:#f0f0f0;height:120px;">
		<tr>
			<td width="10">　</td>
			<td width="360">
			<div align="center">
				<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%">
					<tr>
						<td colspan="3" align="center">工程基础费用</td>
					</tr>
					<tr>
						<td><input type="button" value="工程费" id="jcfy1" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[工程费]',1);jcfytoysf();"></td>
						<td><input type="button" value="建安费" id="jcfy2" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[建安费]',1);jcfytoysf();"></td>
						<td><input type="button" value="人工费" id="jcfy3" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[人工费]',1);jcfytoysf();"></td>
						<td><input type="button" value="直接费" id="jcfy4" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[直接费]',1);jcfytoysf();"></td>
					</tr>
					<tr>
						<td><input type="button" value="总工日" id="jcfy5" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[总工日]',1);jcfytoysf();"></td>
						<td><input type="button" value="技工工日" id="jcfy6" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[技工工日]',1);jcfytoysf();"></td>
						<td><input type="button" value="普工工日" id="jcfy7" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[普工工日]',1);jcfytoysf();"></td>
						<td><input type="button" value="间接费" id="jcfy8" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[间接费]',1);jcfytoysf();"></td>
					</tr>
					<tr>
						<td><input type="button" value="需安设备费" id="jcfy9" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[需安设备费]',1);jcfytoysf();"></td>
						<td><input type="button" value="不需安设备费" id="jcfy10" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[不需安设备费]',1);jcfytoysf();"></td>
						<td><input type="button" value="机械费" id="jcfy11" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[机械费]',1);jcfytoysf();"></td>
						<td><input type="button" value="仪器仪表费" id="jcfy12" name="jcfy" style="width:90px;" onClick="javascript:input(this,'[仪器仪表费]',1);jcfytoysf();"></td>
					</tr>
					<tr>
						<td><input type="button" value="材料费" id="jcfy13"  name="jcfy" style="width:90px;" onClick="javascript:input(this,'[材料费]',1);jcfytoysf();"></td>
						<td><input type="button" value="附表材料费" id="jcfy14"  name="jcfy" style="width:90px;" onClick="javascript:input(this,'[附表材料费]',1);jcfytoysf();"></td>
						<td><input type="button" value="建设其他费" id="jcfy15"  name="jcfy" style="width:90px;" onClick="javascript:input(this,'[建设其他费]',1);jcfytoysf();"></td>
						<td><input type="button" value="(" id="left_kh" name="left_kh" style="width:45px;" onClick="javascript:input(this,'(');kh(1);">
						<input type="button" value=")" id="right_kh" name="right_kh" style="width:45px;" onClick="javascript:input(this,')');kh(2);"></td>
					</tr>
					<tr>
					</tr>
				</table>
			</div>
			</td>
			<td width="20">　</td>
			<td>
			<div align="center">
				<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%">
					<tr>
						<td>　</td>
					</tr>
					<tr>
						<td><input type="button" value="+" id="add" name="ysf" style="width:30px;" onClick="javascript:input(this,'+');ysftojcfy(1)"></td>
					</tr>
					<tr>
						<td><input type="button" value="-" id="sub" name="ysf" style="width:30px;" onClick="javascript:input(this,'-');ysftojcfy(2)"></td>
					</tr>
					<tr>
						<td><input type="button" value="×" id="mult" name="ysf" style="width:30px;" onClick="javascript:input(this,'*');ysftojcfy(3)"></td>
					</tr>
					<tr>
						<td><input type="button" value="/" id="divi" name="ysf" style="width:30px;" onClick="javascript:input(this,'/');ysftojcfy(4)"></td>
					</tr>
				</table>
			</div>
			</td>
			<td width="20">　</td>
			<td width="100">
			<div align="center">
				<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%">
					<tr>
						<td colspan="3" align="center">&nbsp;</td>
					</tr>
					<tr>
						<td><input type="button" value="7" id="sz7" name="sz" style="width:30px;" onClick="javascript:input(this,7);sz(7);"></td>
						<td><input type="button" value="8" id="sz8" name="sz" style="width:30px;" onClick="javascript:input(this,8);sz(8);"></td>
						<td><input type="button" value="9" id="sz9" name="sz" style="width:30px;" onClick="javascript:input(this,9);sz(9);"></td>
						<td><input type="button" value="0" id="sz0" name="sz0" style="width:30px;" onClick="javascript:input(this,0);sz0();"></td>
					</tr>
					<tr>
						<td><input type="button" value="4" id="sz4" name="sz" style="width:30px;" onClick="javascript:input(this,4);sz(4);"></td>
						<td><input type="button" value="5 " id="sz5" name="sz" style="width:30px;" onClick="javascript:input(this,5);sz(5);"></td>
						<td><input type="button" value="6" id="sz6" name="sz" style="width:30px;" onClick="javascript:input(this,6);sz(6);"></td>
						<td><input type="button" value="." id="dian" name="dian" style="width:30px;" onClick="javascript:input(this,'.');dian();"></td>
					</tr>
					<tr>
						<td><input type="button" value="1" id="sz1" name="sz" style="width:30px;" onClick="javascript:input(this,1);sz(1);"></td>
						<td><input type="button" value="2" id="sz2" name="sz" style="width:30px;" onClick="javascript:input(this,2);sz(2);"></td>
						<td><input type="button" value="3" id="sz3" name="sz" style="width:30px;" onClick="javascript:input(this,3);sz(3);"></td>
						<td><input type="button" value="%" id="bfh" name="bfh" style="width:30px;" onClick="javascript:input(this,'%');bfh();"></td>
					</tr>
					<tr>					
						<td colspan="4"><input type="button" value="C" name="GCF10" style="width:120px;" onClick="javascript:clearInput();setBtn(0)"></td>
					</tr>
				</table>
			</div>
			</td>
			<td width="10">　</td>
		</tr>
	</table>
	<br>
	<input type="button" value=" 提交 " id="tj" style="width:200px;" onClick="javascript:js();">
</div>
</body>
</html>
