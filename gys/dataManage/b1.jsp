<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.dataObject.Gd03_gcfysz"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.service.ExpenseService" %>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="java.util.*"%>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.baseFormatUtils.NumberFormatUtil"%>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<%@ page import="com.netsky.dataObject.Gb03_bgxx"%>
<%
    Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    if(yh==null)
    {
      %> <script language="javascript"> window.location.href="../index.jsp"; </script> <%
      return;
    }

	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
    QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
    ExpenseService expenseService = (ExpenseService) ctx.getBean(ServiceName.ExpenseService);
    Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
    Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
    
    QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd02_dxgc.class);
    queryBuilder9.eq("id",dxgc_id);
    ResultObject ro9 = queryService.search(queryBuilder9);
    Gd02_dxgc data1 = new Gd02_dxgc();
    if(ro9.next()){
    	data1 = (Gd02_dxgc)ro9.get(Gd02_dxgc.class.getName());
    }
    
    //重取费率
	if(request.getParameter("chongqufy")!=null&&request.getParameter("chongqufy").equals("1")){
		expenseService.reBuildFy(data1,new String("B1"),request);
	}
    String HSql3="select gd03 from Gd03_gcfysz gd03 where fy_id is null and bgbh='B1' and dxgc_id="+dxgc_id.intValue();
	ResultObject ro = queryService.search(HSql3);
	
	int m=0;//记录几行显示
	//取出表格信息
	String HSql6="select gb03 from Gb03_bgxx gb03";
	ResultObject ro6 = queryService.search(HSql6);
	Gb03_bgxx gb03=null;
    HashMap bgxx=new HashMap();
    while(ro6.next())
    {
        gb03=(Gb03_bgxx)ro6.get("gb03");
        bgxx.put(gb03.getBgbh(),gb03.getDyscbgbh());
    }
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>表一</title>
<script language="javascript" src="../js/functionlib.js"></script>
<script language="javascript" src="../js/multiTableSave.js"></script>
<link href="../css/data.css" rel="stylesheet" type="text/css">
<script language="javascript">
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
  //同步表一信息
  function xxtb()
  {
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=xxtbcl;
    xmlHttp.open("GET","../afuer/SynchronizeController?act=b1&dxgc_id="+<%=dxgc_id%>);
    xmlHttp.send(null);
  }
  
  function xxtbcl()
  {
    var fl;
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           jgf=xmlHttp.responseText;
           if(tonull(jgf)=="b1")
           {
             alert("表一同步成功");
           }
        }
     }
  }
  
//gsjs页面调用的方法
function sjr()
{}
//gsjs页面调用的方法
function jaf()
{  
   setxg();
   zj_ybf.innerText=document.form1.ybf_gsz.value;
   //document.getElementById("qtf_zj").innerText=round(parseFloat(nullto(document.all.jsqlx_gsz.value,0))+parseFloat(nullto(qtf_td.innerText,0)),2);
   qtf_zj();
}

//设置建设期利息 预备费
function setxg()
{
  //ybf_gs jsqlx_gs
  document.getElementById("ybf_gs2").value=document.getElementById("ybf_gs").value;
  document.getElementById("jsqlx_gs2").value=document.getElementById("jsqlx_gs").value;
}

function save(){
	var obj = document.getElementById("list-table");
	if(obj.rows[obj.rows.length-2].children[2].children[0].value == "" ){
	  		deleteRow(obj.rows[obj.rows.length-2]);
	}
	if(obj.rows[obj.rows.length-3].children[2].children[0].value == "" ){
	  		deleteRow(obj.rows[obj.rows.length-3]);
	}
	if(obj.rows[obj.rows.length-4].children[2].children[0].value == "" ){
	  		deleteRow(obj.rows[obj.rows.length-4]);
	}
	delyhfy();
	document.form1.action="../afuer/SaveB1?gcxm_id="+<%=gcxm_id%>+"&dxgc_id="+<%=dxgc_id%>;
    document.form1.submit(); 
}
function delyhfy()
{
  //提交时判断费用名称为空，是否为空的费用清空所有记录
    var n=0;
    var fymc_sz=document.getElementsByName("Gd03_gcfysz.FYMC");
    for(n=0;n<fymc_sz.length;n++)
    {
      if(fymc_sz[n].value==null||fymc_sz[n].value=="")
      {
        document.getElementsByName("Gd03_gcfysz.FYZ")[n].value="";
      }else{
      }
    }
}
function setybf(flg){
	var ybf_sb = document.getElementById("ybf_sb");
	var ybf_gs = document.getElementById("ybf_gs");
	var ybf_td = document.getElementById("ybf_td");
	var gcf = document.getElementById("gcf_td");
	var sbf = document.getElementById("sbf_td");
	var qtf_td = document.getElementById("qtf_td");
	var jaf_td = document.getElementById("jaf_td");
	var zj_ybf = document.getElementById("zj_ybf");

		if(ybf_sb.checked){
		    document.getElementById("B1_YBF_BZ").value=0;
			ybf_gs.value = "（建安费+工程建设其他费）× 4.0%";
			ybf_td.innerText = "预备费：（建安费+工程建设其他费）× 4.0%";
			document.form1.ybf_gsz.value = round((parseFloat(nullto(jaf_td.innerText,0))+parseFloat(nullto(qtf_td.innerText,0)))*0.04,2);
			zj_ybf.innerText=round((parseFloat(nullto(jaf_td.innerText,0))+parseFloat(nullto(qtf_td.innerText,0)))*0.04,2);
			document.form1.ybf_gsg.value="([建筑安装工程费]+[表5合计其他费])*4.0%";
		}else{
		    document.getElementById("B1_YBF_BZ").value=1;
			ybf_gs.value = "（工程费+工程建设其他费）× 4.0%";
			ybf_td.innerText = "预备费：（工程费+工程建设其他费）× 4.0%";
			document.form1.ybf_gsz.value = round((parseFloat(nullto(sbf.innerText,0))+parseFloat(nullto(jaf_td.innerText,0))+parseFloat(nullto(qtf_td.innerText),0))*0.04,2);
			zj_ybf.innerText=round((parseFloat(nullto(sbf.innerText,0))+parseFloat(nullto(jaf_td.innerText,0))+parseFloat(nullto(qtf_td.innerText,0)))*0.04,2);
			document.form1.ybf_gsg.value="([工程费]+[表5合计其他费])*4.0%";
		}
	zj2();
	setxg();
}

function showsetting(){
	var settingstyle = document.all("setting").style.display
	if (settingstyle=="none"){
		document.all("setting").style.display="block"
	}else{
		document.all("setting").style.display="none"
	}
}

function qtf_zj()
{
    var qtf_zj = document.getElementById("qtf_zj");
    var qtf_td = document.getElementById("qtf_td");
    var sczbhj = document.getElementById("sczbhj");
    var gcf_zj2 = document.getElementById("gcf_zj2");
    qtf_zj.innerText=round(parseFloat(nullto(document.all.jsqlx_gsz.value,0))+parseFloat(nullto(qtf_td.innerText,0)),2);
    gcf_zj2.innerText=document.getElementById("jzgcf_gsz").value;
    zj2();
}

function qtf_zj2()
{
    var qtf_zj = document.getElementById("qtf_zj");
    var qtf_td = document.getElementById("qtf_td");
    var sczbhj = document.getElementById("sczbhj");
    var gcf_zj2 = document.getElementById("gcf_zj2");
    qtf_zj.innerText=round(parseFloat(nullto(document.all.jsqlx_gsz.value,0))+parseFloat(nullto(qtf_td.innerText,0)),2);
    gcf_zj2.innerText=document.getElementById("jzgcf_gsz").value;
}

function fzhj(one,two)
{
    var two_obj = document.getElementById(two);
    two_obj.innerText=parseFloat(nullto(document.all.sczbhj.value,0))+parseFloat(nullto(two_obj.innerText,0));
}

function fz(hs)
{
    var i=1;
    var hjz=0;
    for(i;i<=hs;i++)
    {
      hjz=hjz+parseFloat(nullto(document.getElementById("yhsr"+i).value,0));
    }   
    document.getElementById("sczbhj").innerText=round(hjz+parseFloat(nullto(document.getElementById("skfy").innerText,0)),2);
    document.getElementById("qt_hj").innerText=round(parseFloat(nullto(document.getElementById("sczbhj").innerText,0))+parseFloat(nullto(document.getElementById("hj3_1").innerText,0))+parseFloat(nullto(document.getElementById("hj3_2").innerText,0)),2);
}

function yhfyz(yhfy,hs,fyhj)
{
    //数字验证
    if(!isNaN(yhfy.value)){
       //执行合计
       document.getElementById(fyhj).innerText=yhfy.value;
       fz(hs);
    }else{
       alert("请输入数字");
       yhfy.value="";
       yhfy.focus() ;
    }
}

function zj2()
{
    document.getElementById("zj2").innerText=round(parseFloat(nullto(document.getElementById("gcf_zj2").innerText,0))+parseFloat(nullto(document.getElementById("xa_zj2").innerText,0))+parseFloat(nullto(document.getElementById("bxa_zj2").innerText,0))+parseFloat(nullto(document.getElementById("jaf_zj2").innerText,0))+parseFloat(nullto(document.getElementById("qtf_zj").innerText,0))+parseFloat(nullto(document.getElementById("zj_ybf").innerText,0)),2);
}

  //把null和“”的合计费用设为v=0
  function nullto(isnull,v)
  {
    if(isnull==""||isnull=="null")
    {
        isnull=0;
    }
    return isnull;
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


//复选框设置
  function jsjf_set(dy)
  {
    var oldv=document.getElementById(dy).value;
    if(oldv==1)
    {
      document.getElementById(dy).value=0;
    }else{
      document.getElementById(dy).value=1;
    }
  }
  //调整系数验证
  function xsyz(obj)
  {
    var xs=obj.value;
    if(xs=="")
    {
      alert("表一调整系数不能为空，默认为1");
      obj.value=1;
      obj.focus();
    }
    else if(isNaN(xs))
    {
       alert("请输入数字");
       obj.value=1;
       obj.focus() ;
    }
    else
    {
      if(xs<=0)
      {
        alert("表一调整系数不能小于等于0！");
        obj.value=1;
        obj.focus();
      }
    } 
  }
  //删除行
  function delRow(mc,fyz,fyhj)
  {
    document.getElementById(mc).value="";
    document.getElementById(fyz).value="";
    document.getElementById(fyhj).innerText="";
  }
  //数字合法验证
  function szyz(yzobj)
  {
    if(!isNaN(yzobj.value)){
       
    }else{
       alert("请输入数字");
       yzobj.value="";
       yzobj.focus() ;
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

<body leftmargin="0" topmargin="0" id="main-body">
<div id="menuDiv" onmouseover="javascript:this.style.display='block';" onmouseout="javascript:this.style.display='none';" style="display:none;position: absolute;left:111;top:39;width:88;background-color:#FFFFFF;border:1px solid gray">
<table border="0" width="100%">
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="allwinOpen('../print/print.jsp?type=print&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%=2%>')">单表预览</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=pdf&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%=2%>');">PDF输出</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=doc&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%=2%>');">WORD输出</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../export/SingleProject_excel.jsp?dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=<%=2%>');">EXCEL输出</td>
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
			&nbsp;<input type="button" name="b1" value=" 保存信息 " onclick="save()">
			<!--  
			<%if(yh.getOperate()!=null&&yh.getOperate().intValue()==1){ %>
			&nbsp;<input type="button" name="" value=" 信息同步 " onClick="xxtb()"> 
			<%} %>
			&nbsp;<input type="button" style="width:110px;" name="b" value=" 重取表一费率 " onclick="javascript:reBuildFy()">
			-->
			<%} %>
			&nbsp;<input type="button" name="b2" value=" 单表预览 " onclick="javascript:dbyl(this)">
			&nbsp;<input type="button" name=""   value=" 全部预览 "onclick="javascript:winOpen('../print/SingleProject_print.jsp?gcxm_id=<%=request.getParameter("gcxm_id")%>&dxgc_id=<%=request.getParameter("dxgc_id")%>'
					,'580','295','0')" >
		</td>
	</tr>
</table>
			<%
  		        //String user = (String)session.getAttribute("user");
                String HSql1="select gd03 from Gd03_gcfysz gd03 where dxgc_id="+dxgc_id;
                ResultObject ro1 = queryService.search(HSql1);
                Gd03_gcfysz gd03=null;
                HashMap bg=new HashMap();
                HashMap gd03_id=new HashMap();
                HashMap gs=new HashMap();
                HashMap jsgs=new HashMap();
                while(ro1.next())
                {
                   gd03=(Gd03_gcfysz)ro1.get("gd03");
                   bg.put(gd03.getFymc(),gd03.getFyz());
                   gd03_id.put(gd03.getFymc(),gd03.getId());
                   gs.put(gd03.getFymc(),gd03.getGsbds());
	  		       jsgs.put(gd03.getFymc(),gd03.getJsgs());
                }
   
                String HSql4="select gd02 from Gd02_dxgc gd02 where id="+dxgc_id;
	            ResultObject ro4 = queryService.search(HSql4);
	            Gd02_dxgc gd02=null;
	            String jd_str="概算";
	            if(ro4.next())
                {
                   gd02=(Gd02_dxgc)ro4.get("gd02");
                   Integer jd_int=gd02.getJsjd();
                   if(jd_int!=null)
                   {
                     if(jd_int.intValue()==1)
                     {
                       jd_str="概算";
                     }
                     if(jd_int.intValue()==2)
                     {
                       jd_str="预算";
                     }
                     if(jd_int.intValue()==3)
                     {
                       jd_str="结算";
                     }
                     if(jd_int.intValue()==4)
                     {
                       jd_str="决算";
                     }
                   }
                }
                
			 %>
<div style="width:100%;background:#ffffff;">
<form name="form1" method="post" action="">
<input type="hidden" id="chongqufy" name="chongqufy" value="0">
<div class="file_title">工程<%=jd_str%>总表（表一）</div>
	<div style="text-align:left;color:1E4F75;font-size:13px;font-weight:bold;padding:3px 6px;"><img src="../images/setting.gif" border="0" onClick="showsetting()" style="cursor:hand;"></div>
	<div align="left">
		<div id="setting" style="display:none;">
		<table border="0" cellpadding="0" style="border-collapse: collapse;background-color:#f0f0f0;border:solid 1px #cccccc" width="98%">
			<tr style="height:6px;">
				<td colspan="6" align="center"><div style="position:relative;"><div style="position:absolute;right:2px;cursor: hand;"><img src="../images/ca.jpg" border="0" onClick="showsetting()"></div></div></td>
			</tr>

			<tr>
				<td width="30" align="right">※ </td>
				<td>预备费</td>
				<td width="30" align="right">※ </td>
				<td>建设期利息</td>
			</tr>
			<tr>
				<td width="30"></td>
				<td>
					<input type="checkbox" name="ybf_sb" value="0" <%if("0".equals(StringFormatUtil.format(gd02.getB1_ybf_bz(),"0"))){%>checked<%} %> onclick="javascript:setybf(1);">不计取需安设备费<br>
					<input type="hidden" id="ybf_sb" name="B1_YBF_BZ" value="<%=StringFormatUtil.format(gd02.getB1_ybf_bz(),"0") %>">
					计算依据：<input type="text" id="ybf_gs" value="<%=StringFormatUtil.format((String)gs.get("预备费")) %>" readOnly ondblclick="javascript:winOpen('../dataManage/gssz.jsp?id=ybf_gs&fy_id=1&dxgc_id=<%=dxgc_id %>','600','300','0');" title="双击设置计算公式" style="width:190px;color:red;" >
				</td>
				<td width="30"></td>
				<td><br>
					计算依据：<input type="text" id="jsqlx_gs" readOnly onDblClick="javascript:winOpen('../dataManage/gssz.jsp?id=jsqlx_gs&fy_id=2&dxgc_id=<%=dxgc_id %>','600','300','0');" title="双击设置计算公式" style="width:190px;color:red;" value="<%=StringFormatUtil.format((String)gs.get("建设期利息")) %>">
				</td>
			</tr>
			<tr>
				<td width="30" align="right">※ </td>
				<td>表一合计</td>
			</tr>
			<tr>
				<td width="30"></td>
				<td>
				<% 
				    int qzbz=1;
				    if(gd02.getB1_qzbz()!=null)
				    {
				      qzbz=gd02.getB1_qzbz().intValue();
				    }
				%>
					<input type="checkbox" name="" value="1" onclick="jsjf_set('jsjf');"<%if(qzbz==1){ %> checked<%} %> >表一合计计算角分
					<input type="hidden" id="jsjf" name="B1_QZBZ" value="<%=StringFormatUtil.format(gd02.getB1_qzbz(),"0") %>">
				</td>
				<td width="30"></td>
				<td>
					表一调整系数：<input type="text" name="B1_TZXS" value="<%=NumberFormatUtil.roundToDouble(gd02.getB1_tzxs()) %>" onblur="xsyz(this)" style="width:80px;color:red;">
				</td>
			</tr>
			<tr style="height:6px;">
				<td colspan="6"> </td>
			</tr>
		</table>
		<br>
		</div>	
		<table width="990" id="list-table" border="0" cellpadding="0" style="border-collapse: collapse;word-break:break-all"  >
			<tr class="list-title">
				<td width="30" rowspan="2">序号</td>
				<td  rowspan="2">表格编号</td>
				<td  rowspan="2">费用名称</td>
				<td width="70">小型建筑<br>工程费</td>
				<td width="70">需要安装<br>的设备费</td>
				<td width="100">不需要安装的<br>设备、工器具费</td>
				<td width="70">建筑安装<br>工程费</td>
				<td width="70">其他费用</td>
				<td width="55">预备费</td>
				<td colspan="2">总价值</td>
			</tr>
			<tr class="list-title">
				<td colspan="6">（元）</td>
				<td >人民币（元）</td>
				<td >其中外币（）</td>
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
			</tr>
			<%
			if(NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费"))!=""&&!"0.00".equals(NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费")))) {
			m++;
			%>
			<tr>
				<td align="center"><%=m %></td>
				<td align="left"><%=gd02.getBgbh() %>-<%=bgxx.get("B2")%></td>
				<td>建筑安装工程费</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费"))) %></td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费"))) %></td>
				<td>　</td>
			</tr>
			<%} if(NumberFormatUtil.roundToString((Double)bg.get("光电缆设备费"))!=""&&!"0.00".equals(NumberFormatUtil.roundToString((Double)bg.get("光电缆设备费")))) {
			m++;
			%>
			<tr>
				<td align="center"><%=m %></td>
				<td align="left"><%=gd02.getBgbh() %>-<%=bgxx.get("B4JGDLSB")%></td>
				<td>光电缆设备费</td>
				<td>　</td>
				<td>  </td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("光电缆设备费"))) %></td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("光电缆设备费"))) %></td>
				<td>　</td>
			</tr>
			<%} if(NumberFormatUtil.roundToString((Double)bg.get("需安设备费"))!=""&&!"0.00".equals(NumberFormatUtil.roundToString((Double)bg.get("需安设备费")))) {
			m++;
			%>
			<tr>
				<td align="center"><%=m %></td>
				<td align="left"><%=gd02.getBgbh() %>-<%=bgxx.get("B4JXASB")%></td>
				<td>国内需安设备费</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("需安设备费"))) %></td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("需安设备费"))) %></td>
				<td>　</td>
			</tr>
			<%} if(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费"))!=""&&!"0.00".equals(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")))) {
			m++;
			%>
			<tr>
				<td align="center"><%=m %></td>
				<td align="left"><%=gd02.getBgbh() %>-<%=bgxx.get("B4JBXASB")%></td>
				<td>国内不需安设备费</td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费"))) %></td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费"))) %></td>
				<td>　</td>
			</tr>
			<%} if(NumberFormatUtil.roundToString((Double)bg.get("备品备件"))!=""&&!"0.00".equals(NumberFormatUtil.roundToString((Double)bg.get("备品备件")))) {
			m++;
			%>
			<tr>
				<td align="center"><%=m %></td>
				<td align="left"><%=gd02.getBgbh() %>-<%=bgxx.get("B4JBPBJ")%></td>
				<td>国内备品备件费</td>
				<td>　</td>
				<td> </td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("备品备件"))) %></td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("备品备件"))) %></td>
				<td>　</td>
			</tr>
			<%} if(NumberFormatUtil.roundToString((Double)bg.get("表5合计其他费"))!=""&&!"0.00".equals(NumberFormatUtil.roundToString((Double)bg.get("表5合计其他费")))) {
			m++;
			%>
			<tr>
				<td align="center"><%=m %></td>
				<td align="left"><%=gd02.getBgbh() %>-<%=bgxx.get("B5J")%></td>
				<td>工程建设其他费</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("表5合计其他费"))) %></td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("表5合计其他费"))) %></td>
				<td>　</td>
			</tr>
			<%} %>
			<tr>
				<td>　</td>
				<td>　</td>
				<td align="center">合 计</td>
				<td>　</td>
				<td id="sbf_td" align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("需安设备费"))) %></td>
				<td id="bxsbf_td" align="right">　<%=StringFormatUtil.nullstring(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")),NumberFormatUtil.roundToString((Double)bg.get("备品备件"))))%></td>
				<td id="jaf_td" align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费"))) %></td>
				<td id="qtf_td" align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.roundToDouble((Double)bg.get("光电缆设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("表5合计其他费"))))) %></td>
				<td>　</td>
				<td id="zj_td" align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToDouble((Double)bg.get("需安设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("不需安设备费"))),NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToDouble((Double)bg.get("建筑安装工程费")),NumberFormatUtil.roundToDouble((Double)bg.get("光电缆设备费"))),NumberFormatUtil.roundToString((Double)bg.get("表5合计其他费")))),NumberFormatUtil.roundToString((Double)bg.get("备品备件"))))%></td>
				<td>　</td>
			</tr>
			<tr>
				<td align="center"></td>
				<td>　</td>
				<td id="ybf_td">预备费：<%=StringFormatUtil.format((String)gs.get("预备费")) %></td>
				<input type="hidden" name="Gd03_gcfysz.FYMC" value="预备费">
				<input type="hidden" name="Gd03_gcfysz.ID" value="<%=gd03_id.get("预备费") %>">
				<input type="hidden" id="ybf_gs2" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("预备费")) %>">
				<input type="hidden" id="ybf_gsg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("预备费")) %>">
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td><input type="text" name="Gd03_gcfysz.FYZ" id="ybf_gsz"  value="<%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("预备费"))) %>" readOnly style="text-align:right;"></td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("预备费"))) %></td>
				<td>　</td>
			</tr>
			<tr>
				<td align="center"></td>
				<td>　</td>
				<td>建设期利息</td>
				<input type="hidden" name="Gd03_gcfysz.FYMC" value="建设期利息">
				<input type="hidden" name="Gd03_gcfysz.ID" value="<%=gd03_id.get("建设期利息") %>">
				<input type="hidden" id="jsqlx_gs2" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("建设期利息")) %>">
				<input type="hidden" id="jsqlx_gsg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("建设期利息")) %>">
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td><input id="jsqlx_gsz" type="text" onblur="qtf_zj()" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("建设期利息"))) %>" style="text-align:right;"></td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("建设期利息"))) %></td>
				<td>　</td>
			</tr>
			<tr>
				<td align="center"></td>
				<td>　</td>
				<td>建筑工程费(自供料)</td>
				<input type="hidden" name="Gd03_gcfysz.FYMC" value="建筑工程费">
				<input type="hidden" name="Gd03_gcfysz.ID" value="<%=gd03_id.get("建筑工程费") %>">
				<input type="hidden" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("建筑工程费")) %>">
				<input type="hidden" id="jzgcf_gsg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("建筑工程费")) %>">
				<td><input id="jzgcf_gsz" type="text" onblur="qtf_zj()" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("建筑工程费"))) %>" style="text-align:right;" readOnly></td>
				<td>　</td>
				<td>　</td>
				<td> </td>
				<td> </td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
			</tr>
			<tr>
				<td>　</td>
				<td>　</td>
				<td align="center" >总 计</td>
				<td align="right" id="gcf_zj2"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("建筑工程费")))%></td>
				<td id="xa_zj2" align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("需安设备费"))) %></td>
				<td id="bxa_zj2" align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")),NumberFormatUtil.roundToString((Double)bg.get("备品备件")))) %></td>
				<td id="jaf_zj2" align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费"))) %></td>
				<td id="qtf_zj" align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.roundToDouble((Double)bg.get("光电缆设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("表5合计其他费"))))) %></td>
				<td id="zj_ybf" align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("预备费"))) %></td>
				<td id="zj2" align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("工程总费用")))%></td>
				<td>　</td>
			</tr>
			<tr>
				<td align="center">1</td>
				<td>　</td>
				<td>生产准备及开办费</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td align="right" id="skfy"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("生产准备及开办费"))) %></td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("生产准备及开办费"))) %></td>
				<td>　</td>
			</tr>
			<tr>
				<td align="center">2</td>
				<td align="left"><%=gd02.getBgbh() %>-<%=bgxx.get("B4JWHQJ")%></td>
				<td>国内维护器具费</td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("维护器具费"))) %></td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("维护器具费"))) %></td>
				<td>　</td>
			</tr>
			<tr>
				<td align="center">3</td>
				<td align="left"><%=gd02.getBgbh() %>-<%=bgxx.get("HSSB")%></td>
				<td>回收设备费</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("回收设备费"))) %></td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("回收设备费"))) %></td>
				<td>　</td>
			</tr>
			<tr>
				<td align="center">4</td>
				<td align="left"><%=gd02.getBgbh() %>-<%=bgxx.get("HSZC")%></td>
				<td>回收主材费</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("回收主材费"))) %></td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("回收主材费"))) %></td>
				<td>　</td>
			</tr>
			<%
				Gd03_gcfysz gd032 = new Gd03_gcfysz();
				int i=0;
				while(ro.next()||i<(9-m)){
					i++;
					//data = (Gd03_gcfysz)ro.get(Gd03_gcfysz.class.getName());
					gd032=(Gd03_gcfysz)ro.get("gd03");
					if(gd032!=null){
			 %>
			<tr>
				<td align="center" ondblclick="delRow('yhfy<%=i%>','yhsr<%=i%>','userfy<%=i%>')" title="双击删除"><%=i+4 %></td>
				<td>　</td>
				<td>
					<input type="text" id="yhfy<%=i%>" name="Gd03_gcfysz.FYMC" value="<%=gd032.getFymc()%>">
					<input type="hidden" name="Gd03_gcfysz.ID" value="<%=gd032.getId()%>">
					<input type="hidden" name="Gd03_gcfysz.GSBDS" value="">
					<input type="hidden" name="Gd03_gcfysz.JSGS" value="">
				</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td><input type="text" name="Gd03_gcfysz.FYZ" id="yhsr<%=i%>" value="<%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString(gd032.getFyz()))%>" style="text-align:right;" onblur="yhfyz(this,<%=9-m %>,'userfy<%=i%>')"></td>
				<td>　</td>
				<td align="right" id="userfy<%=i%>" style="text-align:right;"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString(gd032.getFyz()))%></td>
				<td>　</td>
			</tr>
			<%}else{%>
			<tr>
				<td>　</td>
				<td>　</td>
				<td>
					<input type="text" name="Gd03_gcfysz.FYMC" value="">
					<input type="hidden" name="Gd03_gcfysz.ID" value="">
					<input type="hidden" name="Gd03_gcfysz.GSBDS" value="">
					<input type="hidden" name="Gd03_gcfysz.JSGS" value="">
				</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td>　</td>
				<td><input type="text" name="Gd03_gcfysz.FYZ" id="yhsr<%=i%>" value="" style="text-align:right;" onblur="yhfyz(this,<%=9-m %>,'userfy<%=i%>')"></td>
				<td>　</td>
				<td align="right" id="userfy<%=i%>"></td>
				<td>　</td>
			</tr>
			<%}}%>
			
			<tr>
				<td>　</td>
				<td>　</td>
				<td align="center">合 计</td>
				<td>　</td>
				<td align="right" id="hj3_1"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString(NumberFormatUtil.addToString( NumberFormatUtil.roundToDouble((Double)bg.get("回收设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("回收主材费"))))) %></td>
				<td align="right" id="hj3_2"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("维护器具费")))%></td>
				<td align="right"></td>
				<td align="right" id="sczbhj"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)bg.get("生产准备及开办费")))%></td>
				<td>　</td>
				<td id="qt_hj" align="right"><%=StringFormatUtil.nullstring(NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("生产准备及开办费")),NumberFormatUtil.roundToString((Double)bg.get("维护器具费"))),NumberFormatUtil.roundToString(NumberFormatUtil.addToString( NumberFormatUtil.roundToDouble((Double)bg.get("回收设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("回收主材费")))))) %></td>
				<td>　</td>
			</tr>
		</table>
		<br>
	</div>
</form>
</div>
<script defer>   
  qtf_zj2();
  fz(<%=9-m%>);
</script>
</body>
</html>
