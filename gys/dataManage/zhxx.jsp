<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.dataObject.Gb03_bgxx"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Ga04_flk"%>
<%@ page import="com.netsky.dataObject.Ga14_b3jcfl"%>
<%@ page import="com.netsky.dataObject.Gd01_gcxm"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="com.netsky.baseObject.PropertyInject"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@page import="com.netsky.dataObject.Ga06_zy"%>
<%@page import="com.netsky.dataObject.Gd10_b3fl"%>
<%@page import="com.netsky.baseFormatUtils.StringFormatUtil"%>
<%@page import="com.netsky.dataObject.Gb01_yhb"%>

<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>综合信息</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script language="javascript">
function dispArea(obj){
	if(obj.selectedIndex == 1){
		document.getElementById("fzcsz_tr").style.display = "block";
	}else{
		document.getElementById("fzcsz_tr").style.display = "none";
		 var GYDQ=document.getElementsByName("B3_GYDQ_BZ");
		 var SLSM=document.getElementsByName("B3_SLSM_BZ");
		 for(var n=0;n<GYDQ.length;n++)
		 {
		   GYDQ[n].checked=false;
		 }
		 for(var m=0;m<SLSM.length;m++)
		 {
		   SLSM[m].checked=false;
		 }
	}
}
</script>
<script language="javascript">
  var xmlHttp;
  function createXMLHttpRequest()
  {
    if(window.ActiveXObject){
      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if(window.XMLHttpRequset){
      xmlHttp=new XMLHttpRequset();
    }
  }
  
  function updateSelect()
  {
    var selected=document.all.D2.value;
    if(selected=="SB"){//控制综合信息中如果专业类别选择“通信设备安装工程”则下面的表格选定选择“国内需要安装设备表”，如果是其他则选择“国内主要材料表”，也就是这两个表默认时只选其一
    	document.getElementById("xx").checked=false;
    	document.getElementById("oo").checked=true;
    }else{
        document.getElementById("xx").checked=true;
        document.getElementById("oo").checked=false;
    } 
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=updateS;
    xmlHttp.open("GET","../afuer/ShowZyXml?bz=1&lb="+selected);
    xmlHttp.send(null);
  }
  
  function updateS()
  {
     if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           var doc = new ActiveXObject("MSxml2.DOMDocument")
           doc.loadXML(xmlHttp.responseText);
           result=doc.getElementsByTagName("lb");
           while(document.all.D3.options.length>0)
           {
             document.all.D3.removeChild(document.all.D3.childNodes[0]);
           }
           for(var i=0;i<result.length;i++)
           {
             var option=document.createElement("OPTION");
             option.text=result[i].childNodes[0].childNodes[0].nodeValue;
             option.value=result[i].childNodes[1].childNodes[0].nodeValue;
             document.all.D3.options.add(option);
           }
           
        }
     }
  }
  
  function updateFlk(ysz)
  {
    var flkselect=document.all.flkselect.value;
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=updateF;
    xmlHttp.open("GET","../afuer/ShowZyXml?bz=2&ysz="+ysz+"&flk_id="+flkselect+"&dxgc_id=<%=request.getParameter("dxgc_id")%>");
    xmlHttp.send(null);
  }
  function updateF()
  {
     if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           var doc = new ActiveXObject("MSxml2.DOMDocument")
           doc.loadXML(xmlHttp.responseText);
           result=doc.getElementsByTagName("flk");
           var tabObj=document.getElementById("tb_sgqk");
           row_c = tabObj.rows.length;
           var n=1;
           for(n=row_c-1;n>0;n--)//删除
           {	//判断是不是正常的，如果是正常的不删除 (工程费率改变时，取施工情况时，正常施工没了)
           		if(tabObj.rows[n].children[0].children[0].value!=""){
             		tabObj.deleteRow(n);
             	}
           }
           for(var i=0;i<result.length;i++)
           {
             var flid_g=result[i].childNodes[0].childNodes[0].nodeValue;
             var flmc_g=result[i].childNodes[1].childNodes[0].nodeValue;
             var flflag_g=result[i].childNodes[2].childNodes[0].nodeValue;
             var flid_s=result[i].childNodes[3].childNodes[0].nodeValue;
             var flmc_s=result[i].childNodes[4].childNodes[0].nodeValue;
             var flflag_s=result[i].childNodes[5].childNodes[0].nodeValue;
             add_sgqk(flid_g,flmc_g,flflag_g,flid_s,flmc_s,flflag_s);
           }
           //设置重取费率
           var cqfl=document.getElementsByName("CQFL");
           for(var j=1;j-1<cqfl.length;j++)
           {
             cqfl[j-1].checked=true;
             setQf("CQFL_B"+j);
           }   
        }
     }
  }
  
    function add_sgqk(flid_g,flmc_g,flflag_g,flid_s,flmc_s,flflag_s)
    {
      var tb_sgqk = document.all.tb_sgqk;
    
      var row = tb_sgqk.insertRow();
      var cell01 = row.insertCell();
      var cell02 = row.insertCell();
      var cell03 = row.insertCell();
      var cell04 = row.insertCell();
      if(flid_g!="null")
      {
        var che="";
        if(flflag_g!="null"&&flflag_g==1)
        {che="checked"}
        cell01.innerHTML = "<input type='radio' name='B3_GYDQ_BZ' "+che+" value="+flid_g+" >";
        cell02.innerHTML = flmc_g;
      }else{
        cell01.innerHTML = "";
        cell02.innerHTML = "";
      }
      if(flid_s!="null")
      {
        var che="";
        if(flflag_s!="null"&&flflag_s==1)
        {che="checked"}
        cell03.innerHTML = "<input type='radio' name='B3_SLSM_BZ' "+che+" value="+flid_s+" >";
        cell04.innerHTML = flmc_s;
      }else{
        cell03.innerHTML = "";
        cell04.innerHTML = "";
      }
   }
  
</script>
<script type="text/javascript">
  function box_bgxd(b,name,h_name)
  {
    var b=document.getElementsByName(name);
    var b_v="";
    var n=0;
    for(var i=0;i<b.length;i++)
    {
      if(b[i].checked)
      {
        if(n==1)
        {
           b_v=b_v+","+b[i].value;
        }
        else
        {
          b_v=b[i].value;
          n=1;
        }
      }
    }
    document.getElementsByName(h_name)[0].value=b_v;
  }
  function setQf(id)
  {
    var b=document.getElementById(id);
    if(b.value==1){
        b.value=0;
    }else{
        b.value=1;
    }
  }
  
  //删除工程
	function xmdel()
	{
	  if(confirm('确定要删除此工程吗?'))   
      {
	    document.form1.action="../afuer/GcxmDelController?gcxm_id=<%=request.getParameter("gcxm_id")%>&dxgc_id=<%=request.getParameter("dxgc_id")%>";
	    document.form1.submit(); 
	  }
	}
	//保存
	function save()
	{
       if(document.getElementById("mcyz_bz").value==0)
	   {
	      if(listValidateChk("form1","Gd02_dxgc.GCMC")&&listValidateChk("form1","Gd02_dxgc.GCBH")&&listValidateChk("form1","Gd02_dxgc.JSDW")&&listValidateChk("form1","Gd02_dxgc.SJDW")
  		    &&listValidateChk("form1","Gd02_dxgc.SJFZR")&&listValidateChk("form1","Gd02_dxgc.SHR")&&listValidateChk("form1","Gd02_dxgc.SHRGYSH")
  		    &&listValidateChk("form1","Gd02_dxgc.BZR")&&listValidateChk("form1","Gd02_dxgc.BZRGYSH")&&listValidateChk("form1","Gd02_dxgc.BZRQ")
  		    &&listValidateChk("form1","Gd02_dxgc.BGBH")&&listValidateChk("form1","Gd02_dxgc.BGQSYM")&&listValidateChk("form1","Gd02_dxgc.GCSM")){
  	 	    document.form1.submit();
          } 
       }else if(document.getElementById("mcyz_bz").value==1){
         alert("工程名称不能重复！");
       }else{
         alert("工程名称不能为空！");
       }
	}
	
	//施工条件 设置
	function sgtj_set()
	{
	  if(document.getElementById("sgtj_zc1").checked&&document.getElementById("sgtj_zc2").checked)
	  {
	    document.getElementById("sgtj").value="1";
	  }
	  else
	  {
	    document.getElementById("sgtj").value="0";
	  }
	}
</script>
<script language="javascript">
  //ajax 验证工程名称唯一性

  function gcmc_yz(gcmcObj)
  {
    var gcmc=gcmcObj.value;
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=yzcl;
    xmlHttp.open("GET","../afuer/XmmcYz?lb=gc&dxgc_id=<%=request.getParameter("dxgc_id")%>&gcmc="+encodeURIComponent(gcmc));
    xmlHttp.send(null);
  }
  function yzcl()
  {
    var mcyz;
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           mcyz=xmlHttp.responseText;
           if(mcyz=="0")
           {
             //document.getElementById("mcyz_ts").innerText="V";
             //document.getElementById("mcyz").innerText="工程名称可用";
             document.getElementById("mcyz_bz").value=0;
           }else if(mcyz=="1"){
             //document.getElementById("mcyz_ts").innerText="X";
             //document.getElementById("mcyz").innerText="工程名称不可用";
             document.getElementById("mcyz_bz").value=1;
           }else{
             //document.getElementById("mcyz_ts").innerText="X";
             //document.getElementById("mcyz").innerText="工程名称不能为空";
             document.getElementById("mcyz_bz").value=2;
           }
        }
     }
  }
  function xxtb(){
  	if(confirm('确定将建设项目的信息都同步为单项工程的信息吗？（确认已经保存综合信息）'))   
      {   
          document.form1.action="../afuer/DxgctbController?gcxm_id=<%=request.getParameter("gcxm_id")%>&dxgc_id=<%=request.getParameter("dxgc_id")%>&gcfl_id=<%=request.getParameter("gcfl_id")%>";
	      document.form1.submit(); 
      }
  }
  function jsjg(){
  	if(document.getElementsByName("Gd02_dxgc.ID")[0].value==""){
  		alert("该单项工程不存在！");
  	}else{
  		winOpen('../dataManage/totalValue.jsp?dxgc_id=<%=request.getParameter("dxgc_id")%>','580','480','0');
  	}
  }
</script>
</head>
<%
           Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
           if(yh==null)
           {
             %> <script language="javascript"> window.location.href="../index.jsp"; </script> <%
             return;
           }
           
        String user = yh.getName();
        Integer user_id=yh.getId();
     	String gcxm_id=request.getParameter("gcxm_id");
		String dxgc_id=request.getParameter("dxgc_id");
		String gcfl_id=request.getParameter("gcfl_id");
        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	    QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	    if("".equals(dxgc_id))
	    {
	      dxgc_id=null;
	    }
	  	String HSql1="select gd02 from Gd02_dxgc gd02 where id="+dxgc_id;
	  	ResultObject ro1 = queryService.search(HSql1);
	  	Gd02_dxgc gd02=null;
	  	String gcmc="";
	  	String gcbh="";
	  	Integer gcxz=new Integer(0);
	  	Integer jsjd=new Integer(0);
	  	String jsdw="";
	  	Integer sgtj=new Integer(1);
	  	Integer mb=new Integer(0);
	  	String sjdw="";
	  	String sjdwfzr="";
	  	String shr="";
	  	String shrgysh="";
	  	String sjbh="";
	  	String bzr="";
	  	String bzrgysh="";
	  	Date bzrq=new Date();
	  	Date gdsj = null;
	  	Integer flk_id=new Integer(0);
	  	String bgbh="";
	  	Integer qsym=new Integer(1);
	  	String GCSM="";
	  	Integer CJR_ID=new Integer(0);
	  	Integer zy=new Integer(1);
	  	if(ro1.next())
	  	{
	  	  gd02=(Gd02_dxgc)ro1.get("gd02");	  	  
	  	}else{
	  	  if("".equals(gcxm_id))
	      {
	        gcxm_id=null;
	      }
	  	  String HSql_gcxm="select gd01 from Gd01_gcxm gd01 where id="+gcxm_id;
	  	  ResultObject ro_gcxm = queryService.search(HSql_gcxm);
	  	  Gd01_gcxm gd01=null;
	  	  if(ro_gcxm.next())
	  	  {
	  	    gd01=(Gd01_gcxm)ro_gcxm.get("gd01");
	  	    gd02 = new Gd02_dxgc();
	  	    PropertyInject.copyProperty(gd01, gd02, new String[] { "id" });
	  	    gd02.setGcbh(gd01.getXmbh());
	  	    gd02.setGcmc(gd01.getXmmc());
	  	    gd02.setGcsm(gd01.getXmsm());
	  	  }
	  	}
	  	if(gd02 != null){
	  	  gcmc=gd02.getGcmc();
	  	  gcbh=gd02.getGcbh();
	  	  if(gd02.getGcxz() != null)
	  	  	gcxz=gd02.getGcxz();
	  	  if(gd02.getJsjd() != null)
	  	 	jsjd=gd02.getJsjd();
	  	  jsdw=gd02.getJsdw();
	  	  if(gd02.getB3_sgtj_bz() != null)
	  	  	sgtj=gd02.getB3_sgtj_bz();
	  	  if(gd02.getMb()!=null){
	  	    mb=gd02.getMb();
	  	  }
	  	  sjdw=gd02.getSjdw();
	  	  sjdwfzr=gd02.getSjfzr();
	  	  shr=gd02.getShr();
	  	  shrgysh=gd02.getShrgysh();
	  	  sjbh=gd02.getSjbh();
	  	  bzr=gd02.getBzr();
	  	  bzrgysh=gd02.getBzrgysh();
	  	  bzrq=gd02.getBzrq();
	  	  if(gd02.getFlk_id() != null)
	  	  	flk_id=gd02.getFlk_id();
	  	  bgbh=gd02.getBgbh();
	  	  qsym=gd02.getBgqsym();
	  	  GCSM=gd02.getGcsm();
	  	  CJR_ID=gd02.getCjr_id();
	  	  zy=gd02.getZy_id();
	  	  gdsj = gd02.getGdsj();
	  	}
	  	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	  	String bzrq_str ="";
	  	if(bzrq!=null){
        	bzrq_str = sdf.format(bzrq);
        }

 %>
<body leftmargin="0" topmargin="0" id="main-body">
<table border="0" cellpadding="2" style="height:45px;border-collapse:collapse;" width="100%">
	<tr>
		<td style="height:15px"></td>
	</tr>
	<tr>
		<td style="vertical-aling:bottom;">
			<input type="hidden" id="mcyz_bz" value="0">
			<%
			if(gdsj == null){
			%>
			&nbsp;<button name="" onClick="javascript:save();"> 保存信息 </button>
			<%if(dxgc_id != null && dxgc_id.length() >0){ 
				if(yh.getOperate()!=null&&yh.getOperate().intValue()==1){ %>
			&nbsp;<button name="" onClick="xmdel()"> 删除工程 </button>
			<!-- &nbsp;<button name="" onClick="xxtb()"> 信息同步 </button> -->
			<%}}} %>
			<%if(dxgc_id != null && dxgc_id.length() >0){ %>
			&nbsp;<button name="" onclick="javascript:winOpen('../print/SingleProject_print.jsp?gcxm_id=<%=request.getParameter("gcxm_id")%>&dxgc_id=<%=request.getParameter("dxgc_id")%>'
					,'580','300','0')" > 打印预览 </button>
			&nbsp;<button name="" style="width:130px;" onClick="jsjg()">查看各表计算结果</button>
			<%} %>
		</td>
	</tr>
</table> 
<div align="center" style="width:100%;background:#ffffff">

 	<form action="../afuer/SaveZhxx" method="post" id="form1" name="form1">
	<input type="hidden" name="dispatchStr" value="/dataManage/zhxx.jsp">
	<input type="hidden" name="tableInfomation" value="noFatherTable:Gd02_dxgc">
	<input type="hidden" name="perproty" value="dxgc_id,Gd02_dxgc,ID/Gd02_dxgc.ZY_ID/D2/gcxm_id">
	<input type="hidden" name="Gd02_dxgc.ID" value="<%=StringFormatUtil.format(dxgc_id)%>">
	<input type="hidden" name="GCXM_ID" value="<%=StringFormatUtil.format(gcxm_id) %>">
	<input type="hidden" name="GCFL_ID" value="<%=StringFormatUtil.format(request.getParameter("gcfl_id")) %>">
	<table border="0" cellpadding="2" style="border-collapse: collapse" width="700">
		<tr style="height:20px;">
			<td colspan="6" ></td>
		</tr>
		<tr style="height:40px;">
			<td colspan="6" align="center"><img src="../images/zhxx.gif" border="0" title="综合信息设置"></td>
		</tr>
		<tr>
			<td align="right">工程名称：</td>
			<td colspan="3"><input type="text" name="Gd02_dxgc.GCMC" size="20" class="td-input" value="<%=StringFormatUtil.format(gcmc) %>" onblur="gcmc_yz(this)" ></td>
			<td align="right">工程编号：</td>
			<td ><input type="text" name="Gd02_dxgc.GCBH" size="20" class="td-input" value="<%=StringFormatUtil.format(gcbh) %>" ></td>
		</tr>
		<tr>
		    			<td width="80" align="right">专业类别：</td>
			<td width="150">
				<%
				String lb="XL";
				String HSql5="select ga06 from Ga06_zy ga06 where ga06.lb=(select lb from Ga06_zy ga06 where ga06.id = "+zy+")";
		        ResultObject ro5 = queryService.search(HSql5);
		        if(ro5.next()){
		        	Ga06_zy ga06=null;
		            ga06=(Ga06_zy)ro5.get("ga06");
		            lb = ga06.getLb();
		        }
				%>
				<select size="1" name="D2" id="D2" class="td-input" onchange="updateSelect()" >
				<option value="XL" <%if(lb.equals("XL")){%>selected<%}%>>通信线路工程</option>
				<option value="GD" <%if(lb.equals("GD")){%>selected<%}%>>通信管道工程</option>
				<option value="SB" <%if(lb.equals("SB")){%>selected<%}%>>通信设备安装工程</option>
				<option value="QT" <%if(lb.equals("QT")){%>selected<%}%>>自由归类工程</option>
				</select>
			</td>
			<td width="100" align="right">所属专业：</td>
			<td width="150">
				<select size="1" name="Gd02_dxgc.ZY_ID" id="D3" class="td-input">
				<%
							ro5.reSet();
		                    while(ro5.next())
		                    {
		                         Ga06_zy ga06=null;
		                         ga06=(Ga06_zy)ro5.get("ga06");
				 %>
				<option value="<%=ga06.getId() %>" <%if(zy.intValue()==ga06.getId().intValue()){%>selected<%}%>><%=ga06.getMc()%></option>
				<%} %>
				</select></td>
			<td align="right">建设阶段：</td>
			<td>
				<select size="1" name="Gd02_dxgc.JSJD" class="td-input">
				<option value="2" <%if(jsjd.intValue()==2){%>selected<%}%> >预算</option>
				<option value="1" <%if(jsjd.intValue()==1){%>selected<%}%> >概算</option>
				<option value="3" <%if(jsjd.intValue()==3){%>selected<%}%> >结算</option>
				<option value="4" <%if(jsjd.intValue()==4){%>selected<%}%> >决算</option>
				</select>
			</td>
		</tr>
		<tr>
						<td align="right">建设单位：</td>
			<td colspan="3"><input type="text" name="Gd02_dxgc.JSDW" size="20" class="td-input" value="<%=StringFormatUtil.format(jsdw) %>"></td>
			<td align="right" width="80">工程性质：</td>
			<td width="140">
				<select size="1" name="Gd02_dxgc.GCXZ" class="td-input">
				<option value="1" <%if(gcxz.intValue()==1){%>selected<%}%>>新建工程</option>
				<option value="2" <%if(gcxz.intValue()==2){%>selected<%}%>>全部扩建</option>
				<option value="3" <%if(gcxz.intValue()==3){%>selected<%}%>>部分扩建</option>
				<option value="4" <%if(gcxz.intValue()==4){%>selected<%}%>>改建工程</option>
				<option value="5" <%if(gcxz.intValue()==5){%>selected<%}%>>恢复工程</option>
				<option value="6" <%if(gcxz.intValue()==6){%>selected<%}%>>迁建工程</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">设计单位：</td>
			<td colspan="3"><input type="text" name="Gd02_dxgc.SJDW" size="20" class="td-input" value="<%=StringFormatUtil.format(sjdw) %>"></td>
			<td align="right">设计负责人：</td>
			<td><input type="text" name="Gd02_dxgc.SJFZR" size="20" class="td-input" value="<%=StringFormatUtil.format(sjdwfzr)%>"></td>
		</tr>
		<tr>
			<td align="right">审核人：</td>
			<td><input type="text" name="Gd02_dxgc.SHR" size="20" class="td-input" value="<%=StringFormatUtil.format(shr)%>"></td>
			<td align="right">概预算号：</td>
			<td><input type="text" name="Gd02_dxgc.SHRGYSH" size="20" class="td-input" value="<%=StringFormatUtil.format(shrgysh) %>"></td>
			<td align="right">设计编号：</td>
			<td><input type="text" name="Gd02_dxgc.SJBH" size="20" class="td-input" value="<%=StringFormatUtil.format(sjbh) %>"></td>
		</tr>
		<tr>
			<td align="right">编制人：</td>
			<td><input type="text" name="Gd02_dxgc.BZR" size="20" class="td-input" value="<%if(!"".equals(StringFormatUtil.format(bzr))){out.print(StringFormatUtil.format(bzr));}else{out.print(user);} %>"></td>
			<input type="hidden" name="Gd02_dxgc.CJR_ID" value="<%if(!"0".equals(StringFormatUtil.format(CJR_ID))){out.print(StringFormatUtil.format(CJR_ID));}else{out.print(user_id.intValue());} %>" />
			<input type="hidden" name="Gd02_dxgc.CJR" value="<%if(!"".equals(StringFormatUtil.format(bzr))){out.print(StringFormatUtil.format(bzr));}else{out.print(user);} %>" />
			<td align="right">概预算号：</td>
			<td><input type="text" name="Gd02_dxgc.BZRGYSH" size="20" class="td-input" value="<%=StringFormatUtil.format(bzrgysh)%>"></td>
			<td align="right">编制日期：</td>
			<td><input type="text" name="Gd02_dxgc.BZRQ" size="20" class="td-input" value="<%=StringFormatUtil.format(bzrq_str) %>"></td>
		</tr>
		<tr>
			<td align="right">工程费率：</td>
			<td>
			
			<select size="1" id="flkselect" name="Gd02_dxgc.FLK_ID" class="td-input" onchange="updateFlk(<%=flk_id.intValue() %>)">
			<%
			  String HSql2="select ga04 from Ga04_flk ga04 order by id asc";
	  	      ResultObject ro2 = queryService.search(HSql2);
	  	      Ga04_flk ga04=null;
	  	      
	  	      while(ro2.next())
	  	      {
	  	         ga04=(Ga04_flk)ro2.get("ga04");
	  	         
			 %>
			<option value="<%=ga04.getId()%>" <%if(flk_id.intValue()==ga04.getId().intValue()){%>selected<%}%> ><%=ga04.getMc() %></option>
			<%} %>
			</select></td>
			<td align="right">表格编号前缀：</td>
			<td><input type="text" name="Gd02_dxgc.BGBH" size="20" class="td-input" value="<%=StringFormatUtil.format(bgbh) %>"></td>
			<td align="right">起始页码：</td>
			<td><input type="text" name="Gd02_dxgc.BGQSYM" size="20" class="td-input" value="<%=StringFormatUtil.format(qsym)%>"></td>
		</tr>
		<tr>
			<td align="right">模板标志：</td>
			<td>
				<select name="Gd02_dxgc.MB" class="td-input">
				<option value="1" <%if(mb.intValue()==1){%>selected<%}%>>模板</option>
				<option value="0" <%if(mb.intValue()==0){%>selected<%}%>>非模板</option>
				</select>
			</td>
			<td>　</td>
			<td>　</td>
			<td>　</td>
			<td>　</td>
		</tr>
		<tr>
			<td>　</td>
			<td>　</td>
			<td>　</td>
			<td>　</td>
			<td>　</td>
			<td>　</td>
		</tr>
		<tr id="fzcsz_tr" style="display:block;">
			<td align="right">施工情况：</td>
			<td colspan="5" style="border:1px solid #1E4F75;overflow:hidden;">
				<table id="tb_sgqk" name="tb_sgqk" border="0" cellpadding="0" style="border-collapse: collapse" width="100%">
				<input type="hidden" id="sgtj" name="Gd02_dxgc.B3_SGTJ_BZ" value="<%=sgtj.intValue() %>">
					<tr>
						<td colspan="2" style="font-weight:bold;">高原地区</td>
						<td colspan="2" style="font-weight:bold;">森林及沙漠地区</td>
					</tr>
					<tr>
						<td width="35"><input type="radio" id="sgtj_zc1" name="B3_GYDQ_BZ" value="" onclick="sgtj_set()" checked></td>
						<td width="276">正常施工</td>
						<td width="35"><input type="radio" id="sgtj_zc2" name="B3_SLSM_BZ" value="" onclick="sgtj_set()" checked></td>
		                <td>正常施工</td>
					</tr>
					<%
					      String HSql6="";
					      String HSql7="";
					      if("".equals(request.getParameter("dxgc_id"))||request.getParameter("dxgc_id")==null)
					      {
					        int flkid=flk_id.intValue();
					        if(flkid==0)
					        {
					          flkid=1;
					        }
					        HSql6="select ga14 from Ga14_b3jcfl ga14 where ga14.bz=1 and ga14.fylb=1 and flk_id="+flkid+" order by id asc";
					        HSql7="select ga14 from Ga14_b3jcfl ga14 where ga14.bz=2 and ga14.fylb=1 and flk_id="+flkid+" order by id asc";
					        ResultObject ro6 = queryService.search(HSql6);
					        ResultObject ro7 = queryService.search(HSql7);
					        int n=0;
					        int m=0;
					        if(ro6.getLength()>=ro7.getLength())
					        {
					          m=ro6.getLength();
					        }else
					        {
					          m=ro7.getLength();
					        }
		                    while(n<m)
		                    {
		                      ro6.next();
		                      ro7.next();
		                      Ga14_b3jcfl ga14a=null;
		                      ga14a=(Ga14_b3jcfl)ro6.get("ga14");
		                      Ga14_b3jcfl ga14b=null;
		                      ga14b=(Ga14_b3jcfl)ro7.get("ga14");
		                      %><tr><%
		                      if(ga14a!=null)
		                      {
		                      %>
		                      <td width="35"><input type="radio" name="B3_GYDQ_BZ" value="<%=ga14a.getId()%>" onclick="sgtj_set()"></td>
						      <td width="276"><%=ga14a.getMc() %></td>
		                      <%                    
		                      }else
		                      {
		                        %><td width="35"></td><td width="276"></td><%
		                      }                
		                      if(ga14b!=null)
		                      {                   
		                      %>
		                      <td width="35"><input type="radio" name="B3_SLSM_BZ" value="<%=ga14b.getId() %>" onclick="sgtj_set()" ></td>
		                      <td><%=ga14b.getMc() %></td>
		                      <%		                        
		                      }else
		                      {
		                        %>
		                      <td width="35"></td><td></td>
		                      <%
		                      }
		                      %></tr><%                   
		                      n++;        
		                    }
					      }
					      else
					      {
					        HSql6="select gd10 from Gd10_b3fl gd10 where gd10.bz=1 and gd10.fylb=1 and gd10.dxgc_id="+dxgc_id+" order by id asc";
					        HSql7="select gd10 from Gd10_b3fl gd10 where gd10.bz=2 and gd10.fylb=1 and gd10.dxgc_id="+dxgc_id+" order by id asc";
					        ResultObject ro6 = queryService.search(HSql6);
					        ResultObject ro7 = queryService.search(HSql7);
					        int n=0;
					        int m=0;
					        if(ro6.getLength()>=ro7.getLength())
					        {
					          m=ro6.getLength();
					        }else
					        {
					          m=ro7.getLength();
					        }
		                    while(n<m)
		                    {
		                      ro6.next();
		                      ro7.next();
		                      Gd10_b3fl gd10a=null;
		                      gd10a=(Gd10_b3fl)ro6.get("gd10");
		                      Gd10_b3fl gd10b=null;
		                      gd10b=(Gd10_b3fl)ro7.get("gd10");
		                      %><tr><%
		                      if(gd10a!=null)
		                      {
		                      %>
		                      <td width="35"><input type="radio" name="B3_GYDQ_BZ" value="<%=gd10a.getId() %>" <%if(gd10a.getFlag()!=null&&gd10a.getFlag().intValue()==1){ %>checked<%} %> onclick="sgtj_set()"></td>
						      <td width="276"><%=gd10a.getMc() %></td>
		                      <%          
		                      }else
		                      {
		                        %><td width="35"></td><td width="276"></td><%
		                      } 
		                      if(gd10b!=null)
		                      {
		                      %>
		                      <td width="35"><input type="radio" name="B3_SLSM_BZ" value="<%=gd10b.getId()%>" <%if(gd10b.getFlag()!=null&&gd10b.getFlag().intValue()==1){ %>checked<%} %> onclick="sgtj_set()"></td>
		                      <td><%=gd10b.getMc() %></td>
		                      <%            
		                      }else
		                      {
		                        %>
		                      <td width="35"></td><td></td>
		                      <%
		                      }
		                      %></tr><%      	                      
		                      n++;        
		                    }
					      }  
					 %>
				</table>
			</td>
		</tr>

		<tr>
			<td align="right" colspan="6">&nbsp;</td>
		</tr>
		<tr>
			<td align="right">表格选定：</td>
			<td colspan="5" style="border:1px solid #1E4F75;overflow:hidden;">
				<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%">
				<%
				  			String HSql3="select gd02 from Gd02_dxgc gd02 where gd02.id ="+dxgc_id;
	  		                ResultObject ro3 = queryService.search(HSql3);
	  		                Gd02_dxgc gd=null;
	  		                String bgxd=null;
		                    if(ro3.next()){
		                       gd=(Gd02_dxgc)ro3.get("gd02");
		                       bgxd=gd.getBgxd();
		                    }
		                    String HSql4="select gb03 from Gb03_bgxx gb03 where id in ("+bgxd+")";
		                    ResultObject ro4 = queryService.search(HSql4);
		                    int[] bgxx_xh=new int[18];
		                    for(int j=0;j<18;j++)
		                    {
		                      bgxx_xh[j]=0;
		                      if(dxgc_id==null||"".equals(dxgc_id))
		                      {
		                        if(j==2||j==3||j==4||j==5||j==11||j==13)
		                        {
		                          bgxx_xh[j]=j;
		                        }
		                      }
		                    }
		                    while(ro4.next())
		                    {
		                         Gb03_bgxx gb03=null;
		                         gb03=(Gb03_bgxx)ro4.get("gb03");
		                         bgxx_xh[gb03.getId().intValue()]=gb03.getId().intValue();
		                    }
				 %>
					<tr>
						<td><input type="checkbox" name="Cb_bgxd" onclick="this.checked=!this.checked" value="2" <%if(bgxx_xh[2]==2){ %> checked<%} %>></td>
						<td><font color=red>概预算总表（表一）---[必选]</font></td>
						<td><input type="checkbox" name="Cb_bgxd" onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="9" <%if(bgxx_xh[9]==9){ %> checked<%} %>></td>
						<td>国内备品备件表（表四）甲</td>
					</tr>
					<tr>
						<td><input type="checkbox" name="Cb_bgxd" onclick="this.checked=!this.checked" value="3" <%if(bgxx_xh[3]==3){ %> checked<%} %>></td>
						<td><font color=red>建筑安装工程费用（表二）---[必选]</font></td>
						<td width="35"><input type="checkbox" name="Cb_bgxd" onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="10" <%if(bgxx_xh[10]==10){ %> checked<%} %>></td>
						<td>国内维护器具表（表四）甲</td>
					</tr>
					<tr>
						<td><input type="checkbox" name="Cb_bgxd" onclick="this.checked=!this.checked" value="4" <%if(bgxx_xh[4]==4){ %> checked<%} %>></td>
						<td><font color=red>建筑安装工程量（表三）甲---[必选]</font></td>
						<td><input type="checkbox" name="Cb_bgxd" id="xx" onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="11" <%if(bgxx_xh[11]==11){ %> checked<%} %>></td>
						<td>国内主要材料表（表四）甲</td>
					</tr>
					<tr>
						<td><input type="checkbox" name="Cb_bgxd" onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="5" <%if(bgxx_xh[5]==5){ %> checked<%} %>></td>
						<td>建筑安装工程机械使用费（表三）乙</td>
						<td><input type="checkbox" name="Cb_bgxd"  onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="12" <%if(bgxx_xh[12]==12){ %> checked<%} %>></td>
						<td>国内主要材料附表（表四）甲</td>
					</tr>
					<tr>
						<td><input type="checkbox" name="Cb_bgxd" onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="6" <%if(bgxx_xh[6]==6){ %> checked<%} %>></td>
						<td>建筑安装工程仪器仪表使用费（表三）丙</td>
						<td><input type="checkbox" name="Cb_bgxd" onclick="this.checked=!this.checked" value="13" <%if(bgxx_xh[13]==13){ %> checked<%} %>></td>
						<td><font color=red>工程建设其他费（表五）甲---[必选]</font></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="Cb_bgxd" id="oo" onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="7" <%if(bgxx_xh[7]==7){ %> checked<%} %>></td>
						<td>国内需要安装设备表（表四）甲</td>
						<td><input type="checkbox" name="Cb_bgxd" onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="14" <%if(bgxx_xh[14]==14){ %> checked<%} %>></td>
						<td>建筑工程表</td>
					</tr>
					<tr>
						<td><input type="checkbox" name="Cb_bgxd" onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="8" <%if(bgxx_xh[8]==8){ %> checked<%} %>></td>
						<td>国内不需要安装设备表（表四）甲</td>
						<td><input type="checkbox" name="Cb_bgxd" onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="15" <%if(bgxx_xh[15]==15){ %> checked<%} %>></td>
						<td>回收设备表</td>
					</tr>
					<tr>
						<td><input type="checkbox" name="Cb_bgxd" onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="17" <%if(bgxx_xh[17]==17){ %> checked<%} %>></td>
						<td>国内光电缆设备表</td>
						<td><input type="checkbox" name="Cb_bgxd" onClick="box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD')" value="16" <%if(bgxx_xh[16]==16){ %> checked<%} %>></td>
						<td>回收材料表</td>
					</tr>
					<input type="hidden" name="Gd02_dxgc.BGXD" value="<%=StringFormatUtil.format(bgxd) %>" />
				</table>
			</td>
		</tr>
		<tr>
			<td align="right" colspan="6">
				　</td>
		</tr>
		<tr>
			<td align="right" height="100">工程说明：</td>
			<td colspan="5"><textarea rows="5" name="Gd02_dxgc.GCSM" cols="20" class="td-textarea"><%=StringFormatUtil.format(GCSM) %></textarea></td>
		</tr>
	</table>
		<input type="hidden" name="list_validate" value="工程名称:Gd02_dxgc.GCMC:VARCHAR2:200:0;工程编号:Gd02_dxgc.GCBH:VARCHAR2:50:1;建设单位:Gd02_dxgc.JSDW:VARCHAR2:100:1;设计单位:Gd02_dxgc.SJDW:VARCHAR2:100:1;
		设计负责人:Gd02_dxgc.SJFZR:VARCHAR2:10:1;审核人:Gd02_dxgc.SHR:VARCHAR2:10:1;审核人概预算号:Gd02_dxgc.SHRGYSH:VARCHAR2:20:1;编制人:Gd02_dxgc.BZR:VARCHAR2:10:1;
		编制人概预算号:Gd02_dxgc.BZRGYSH:VARCHAR2:20:1;编制日期:Gd02_dxgc.BZRQ:DATE:100:1;表格编号前缀:Gd02_dxgc.BGBH:VARCHAR2:20:0;
		起始页码:Gd02_dxgc.BGQSYM:NUMBER:10:1;项目说明:Gd02_dxgc.GCSM:VARCHAR2:500:1;">
</form>
</div>
<script language="javascript">
<%
if(request.getParameter("flag") != null && request.getParameter("flag").equals("save")){
%>
window.parent.document.frames('left').location.href="projectInfo.jsp?gcxm_id=<%=StringFormatUtil.format(gcxm_id)%>&dxgc_id=<%=StringFormatUtil.format(dxgc_id)%>&gcfl_id=<%=StringFormatUtil.format(gcfl_id)%>";
<%
}
%>
</script>

<script defer>  
  box_bgxd(this,'Cb_bgxd','Gd02_dxgc.BGXD');
</script>
</body>

</html>