<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.dataObject.Gb03_bgxx"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Gd01_gcxm"%>
<%@ page import="com.netsky.dataObject.Ga06_zy"%>
<%@ page import="com.netsky.dataObject.Gd03_gcfysz"%>
<%@ page import="com.netsky.dataObject.Ga08_flmx"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.service.ExpenseService" %>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="java.util.*"%>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil"%>
<%@ page import="com.netsky.baseFormatUtils.NumberFormatUtil"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<%
    Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    if(yh==null)
    {
      %> <script language="javascript"> window.location.href="../index.jsp"; </script> <%
      return;
    }
 %>

<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�����</title>
<script language="javascript" src="../js/functionlib.js"></script>
<script language="javascript" src="../js/selectItem.js"></script>
<script language="javascript" src="../js/multiTableSave.js"></script>
<link href="../css/data.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
//gsjsҳ����õķ���
function sjr()
{}
  //���赥λ�����ȡ������ ͨ��ajaxʵ��
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
  function sgdqsz(dxgc_id,zgs_name,qb)
  {
    var zgs=document.getElementById("jgf1").value;
    if(document.all.jgf2.checked)
    {
      var fyz=document.getElementsByName("Gd03_gcfysz.FYZ");
      var zjje=0;
      //0 , 2
      for(var i=0;i<fyz.length-3;i++)
      {
        if(i!=0&&i!=2){
          zjje=zjje+parseFloat(nullto(document.getElementsByName("Gd03_gcfysz.FYZ")[i].value,0));
        }
      }
      zgs=round((parseFloat(zjje)+parseFloat(zgs)),2);
    }
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=cl;
    xmlHttp.open("GET","../afuer/JgfszXml?dxgc_id="+dxgc_id+"&zgs="+zgs+"&qb="+qb);
    xmlHttp.send(null);
  }
  function cl()
  {
    var fl;
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           jgf=xmlHttp.responseText;
           document.getElementById("jsdwglfz").value=tonull(jgf);
           if(document.all.jgf1.checked)
           {
             document.getElementById("gczgs").value="���̷�";
             document.getElementById("gczgsg").value="[���̷�]";
           }
           if(document.all.jgf2.checked)
           {
             document.getElementById("gczgs").value="���̷�+��5������";
             document.getElementById("gczgsg").value="[���̷�]+[��5������]";
           }   
           jaf2(2);
        }
     }
  }
  
    //ͬ��������Ϣ
  function xxtb()
  {
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=xxtbcl;
    xmlHttp.open("GET","../afuer/SynchronizeController?act=b5&dxgc_id="+<%=request.getParameter("dxgc_id")%>);
    xmlHttp.send(null);
  }
  
  function xxtbcl()
  {
    var fl;
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           jgf=xmlHttp.responseText;
           if(tonull(jgf)=="b5")
           {
             alert("����ͬ���ɹ�");
           }
        }
     }
  }
  
</script>
<script language="javascript">

function showsetting(){
	var settingstyle = document.all("setting").style.display
	if (settingstyle=="none"){
		document.all("setting").style.display="block"
	}else{
		document.all("setting").style.display="none"
	}
}

function savecheck(){
    //�����ñ�5�����ѹ�ʽ
    b5qtfgssz();
    //�ύʱ�жϷ�������Ϊ�գ��Ƿ�Ϊ�յķ���������м�¼
    var n=0;
    var fymc_sz=document.getElementsByName("Gd03_gcfysz.FYMC");
    for(n=0;n<fymc_sz.length;n++)
    {
      if(fymc_sz[n].value==null||fymc_sz[n].value=="")
      {
        //document.getElementsByName("Gd03_gcfysz.ID")[n].value="";
        document.getElementsByName("Gd03_gcfysz.DXGC_ID")[n].value="";
        document.getElementsByName("Gd03_gcfysz.GCXM_ID")[n].value="";
        document.getElementsByName("Gd03_gcfysz.GSBDS")[n].value="";
        document.getElementsByName("Gd03_gcfysz.FYZ")[n].value="";
        document.getElementsByName("Gd03_gcfysz.BZ")[n].value="";
        document.getElementsByName("Gd03_gcfysz.BGBH")[n].value="";
        document.getElementsByName("Gd03_gcfysz.FY_ID")[n].value="";
        document.getElementsByName("Gd03_gcfysz.DYYL")[n].value="";
        document.getElementsByName("Gd03_gcfysz.SXH")[n].value="";
      }else{
        document.getElementsByName("Gd03_gcfysz.DXGC_ID")[n].value="<%=request.getParameter("dxgc_id")%>";
        document.getElementsByName("Gd03_gcfysz.GCXM_ID")[n].value="<%=request.getParameter("gcxm_id")%>";
        //document.getElementsByName("Gd03_gcfysz.BGBH")[n].value="B5";
        if(document.getElementsByName("Gd03_gcfysz.DYYL")[n].value=="")
        {
          document.getElementsByName("Gd03_gcfysz.DYYL")[n].value="1";
        }
      }
    }
	document.form1.action="../afuer/dataWriter";
	document.form1.submit();
}

function jaf()
{  
   var fyz=document.getElementsByName("Gd03_gcfysz.FYZ");
   var zjje=0;
   for(var i=0;i<fyz.length-3;i++)
   {
     if(i!=0){
       zjje=zjje+parseFloat(nullto(document.getElementsByName("Gd03_gcfysz.FYZ")[i].value,0));
     }
   }
   document.getElementById("zj").innerText=round(zjje,2);
   document.getElementById("b5hjqtf").value=round(zjje,2);
   document.getElementsByName("dyyl")[arguments[0]-1].checked=true;
   document.getElementsByName("Gd03_gcfysz.DYYL")[arguments[0]-1].value=1;
   if(document.all.jgf1.checked)
   {
     sgdqsz(<%=request.getParameter("dxgc_id")%>,"jgf1",1);
   }
   if(document.all.jgf2.checked)
   {
     sgdqsz(<%=request.getParameter("dxgc_id")%>,"jgf2",2);
   }
}

function jaf1()
{  
   var fyz=document.getElementsByName("Gd03_gcfysz.FYZ");
   var zjje=0;
   for(var i=0;i<fyz.length-3;i++)
   {
     if(i!=0){
       zjje=zjje+parseFloat(nullto(document.getElementsByName("Gd03_gcfysz.FYZ")[i].value,0));
     }
   }
   document.getElementById("zj").innerText=round(zjje,2);
   document.getElementById("b5hjqtf").value=round(zjje,2);
}

function jaf2()
{  
   var fyz=document.getElementsByName("Gd03_gcfysz.FYZ");
   var zjje=0;
   for(var i=0;i<fyz.length-3;i++)
   {
     if(i!=0){
       zjje=zjje+parseFloat(nullto(document.getElementsByName("Gd03_gcfysz.FYZ")[i].value,0));
     }
   }
   document.getElementById("zj").innerText=round(zjje,2);
   document.getElementById("b5hjqtf").value=round(zjje,2);
   document.getElementsByName("dyyl")[arguments[0]-1].checked=true;
   document.getElementsByName("Gd03_gcfysz.DYYL")[arguments[0]-1].value=1;
}

function yhhj()
{  
   var fyz=document.getElementsByName("Gd03_gcfysz.FYZ");
   var zjje=0;
   for(var i=0;i<fyz.length-3;i++)
   {
     if(i!=0){
       zjje=zjje+parseFloat(nullto(document.getElementsByName("Gd03_gcfysz.FYZ")[i].value,0));
     }
   }
   document.getElementById("zj").innerText=round(zjje,2);
   document.getElementById("b5hjqtf").value=round(zjje,2);
   if(document.all.jgf1.checked)
   {
     sgdqsz(<%=request.getParameter("dxgc_id")%>,"jgf1",1);
   }
   if(document.all.jgf2.checked)
   {
     sgdqsz(<%=request.getParameter("dxgc_id")%>,"jgf2",2);
   }
}
  //������֤
  function szyz(yzobj)
  {
    if(!isNaN(yzobj.value)){
       yhhj();
       yyf();
    }else{
       alert("����������");
       yzobj.value="";
       yzobj.focus() ;
    }
  }
  //����׼����ָ�� ----ʧȥ�����¼�,����������֤
  function szyz2(yzobj)
  {
    if(!isNaN(yzobj.value)){
       yyf();
    }else{
       alert("����������");
       yzobj.value="";
       yzobj.focus() ;
    }
  }

  //��null�͡����ĺϼƷ�����Ϊv=0
  function nullto(isnull,v)
  {
    if(isnull==""||isnull=="null")
    {
        isnull=0;
    }
    return isnull;
  }
  	//����С��
	function round(v,e) 
    { 
      var t=1; 
      for(;e>0;t*=10,e--); 
      for(;e<0;t/=10,e ); 
      //return Math.round(v*t)/t; 
      //��0��ɡ�������
      return tonull(Math.round(v*t)/t);
    } 
    //��0ת����""
  function tonull(d)
  {
    if(0==d)
    {
      d="";
    }
    return d;
  }
  
  function delRow(obj){
	 var listtable= document.getElementById("list-table");
	 deleteRow(listtable.rows[obj]);
	 jaf1();
  }
  
  //����׼����ָ�� ----ʧȥ�����¼�
  function yyf()
  {
    var kbfz=document.getElementById("kbfz");
    kbfz.value=parseFloat(nullto(document.getElementById("sjdy").value,0))*parseFloat(nullto(document.getElementById("sczbfzb").value,0));
    document.getElementById("kbf").value="��ƶ�Ա*"+parseFloat(nullto(document.getElementById("sczbfzb").value,0))+"Ԫ/��";
    document.getElementById("kbfg").value="[��ƶ�Ա]*"+parseFloat(nullto(document.getElementById("sczbfzb").value,0));
  }

  //��ӡԤ������
  function dyyl_set(dy,fyxx)
  {
    var oldv=document.getElementById(dy).value;
    
    if(oldv==1)
    {
      document.getElementById(dy).value=0;
      document.getElementById(fyxx).value=0;
      document.getElementById(fyxx+"z").value=0;
      document.getElementById(fyxx+"g").value=0;
    }else{
      document.getElementById(dy).value=1;
    }
  }
  
  //��5�����ѹ�ʽ����
  function b5qtfgssz()
  {
    var b5qtfgs="";
    var k=0;
    var fymc=document.getElementsByName("Gd03_gcfysz.FYMC");
    for(var i=0;i<fymc.length-3;i++)
    {
    
      if(i!=0&&i!=2){
        if(fymc[i].value!=null&&fymc[i].value!="")
        {
          if(k==0)
          {
             b5qtfgs="["+fymc[i].value+"]";
             k++;
          }else{
             b5qtfgs=b5qtfgs+"+["+fymc[i].value+"]";
          }
        }
      }
    }
    document.getElementById("b5qtfgs").value=b5qtfgs;
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
</script>
</head>
<%
                            //String user = (String)session.getAttribute("user");
							String gcxm_id=request.getParameter("gcxm_id");
							String dxgc_id=request.getParameter("dxgc_id");
	  		                ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	                        QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	  		                ExpenseService expenseService = (ExpenseService) ctx.getBean(ServiceName.ExpenseService);
	  		                
	  		                String HSql1="select gd02 from Gd02_dxgc gd02 where id="+dxgc_id;
	  		                ResultObject ro1 = queryService.search(HSql1);
	  		                Gd02_dxgc gd02=null;
	  		                String jd_str="����";
	  		                while(ro1.next())
	  		                {
	  		                   gd02=(Gd02_dxgc)ro1.get("gd02");
	  		                   Integer jd_int=gd02.getJsjd();
                               if(jd_int!=null)
                               {
                                  if(jd_int.intValue()==1)
                                  {
                                     jd_str="����";
                                  }
                                  if(jd_int.intValue()==2)
                                  {
                                     jd_str="Ԥ��";
                                  }
                                  if(jd_int.intValue()==3)
                                  {
                                     jd_str="����";
                                  }
                                  if(jd_int.intValue()==4)
                                  {
                                     jd_str="����";
                                  }
                               }
	  		                }
	  		                //��ȡ����
						if(request.getParameter("chongqufy")!=null&&request.getParameter("chongqufy").equals("1")){
							expenseService.reBuildFy(gd02,new String("B5"),request);
						}
 %>
<body leftmargin="0" topmargin="0" id="main-body" onload="javascript:addNumSelect()">
<div id="menuDiv" onmouseover="javascript:this.style.display='block';" onmouseout="javascript:this.style.display='none';" style="display:none;position: absolute;left:195;top:39;width:88;background-color:#FFFFFF;border:1px solid gray">
<table border="0" width="100%">
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="allwinOpen('../print/print.jsp?type=print&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=13')">����Ԥ��</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=pdf&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=13');">PDF���</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=doc&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=13');">WORD���</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../export/SingleProject_excel.jsp?dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=13');">EXCEL���</td>
	</tr>
</table>
</div>
<table border="0" cellpadding="2" style="height:45px;border-collapse:collapse;" width="100%">
	<tr>
		<td style="height:15px"></td>
	</tr>
	<tr>
		<td style="vertical-aling:bottom;">
			<%if(gd02.getGdsj() == null){ %>	
			&nbsp;<input type="button" name="b1" value=" ������Ϣ " onclick="savecheck()">
			&nbsp;<input type="button" name="b2" value=" ׷���� "  onclick="addList('list-table',2)">
			<!--  
			<%if(yh.getOperate()!=null&&yh.getOperate().intValue()==1){ %>
			&nbsp;<input type="button" name="" value=" ��Ϣͬ�� " onClick="xxtb()"> 
			<%} %>
			&nbsp;<input type="button" style="width:110px;" name="b" value=" ��ȡ������� " onclick="javascript:reBuildFy()">
			-->
			<%} %>
			&nbsp;<input type="button" name="b2" value=" ����Ԥ�� " onclick="javascript:dbyl(this);">
			&nbsp;<input type="button" name=""   value=" ȫ��Ԥ�� "onclick="javascript:winOpen('../print/SingleProject_print.jsp?gcxm_id=<%=request.getParameter("gcxm_id")%>&dxgc_id=<%=request.getParameter("dxgc_id")%>'
					,'580','295','0')" >
		</td>
	</tr>
</table>

<div style="width:100%;background:#ffffff;">
<form name="form1" method="post" action="">
<input type="hidden" id="chongqufy" name="chongqufy" value="0">
<div class="file_title">���̽���������<%=jd_str %>�����壩��</div>
<input type="hidden" name="dispatchStr" value="/dataManage/b5j.jsp?gcxm_id=<%=request.getParameter("gcxm_id") %>&dxgc_id=<%=request.getParameter("dxgc_id") %>">
<input type="hidden" name="tableInfomation" value="noFatherTable:Gd03_gcfysz">
<input type="hidden" name="tableInfomation" value="noFatherTable:Gd02_dxgc">
	<input type="hidden" name="ServiceName" value="calculateService">
    <input type="hidden" name="ServiceFunction" value="Calculate">
    <input type="hidden" name="ServicePerproty" value="dxgc_id">
    <input type="hidden" name="dxgc_id" value="<%=request.getParameter("dxgc_id") %>">
	<div style="text-align:left;color:1E4F75;font-size:13px;font-weight:bold;padding:3px 6px;"><img src="../images/setting.gif" border="0" onClick="showsetting()" style="cursor:hand;"></div>
		<div align="left">		
		<div id="setting" style="display:none;">
		<table border="0" cellpadding="0" style="border-collapse: collapse;background-color:#f0f0f0;border:solid 1px #cccccc" width="98%">
		<tr style="height:6px;">
			<td colspan="6" align="center"><div style="position:relative;"><div style="position:absolute;right:2px;cursor: hand;"><img src="../images/ca.jpg" border="0" onClick="showsetting()"></div></div></td>
		</tr>		
						<%                    
	  		                //ȡ����---����׼����ָ��
	  		                String HSql_zb="select ga08 from Ga08_flmx ga08 where fy_id=88 and flk_id="+gd02.getFlk_id();
	  		                ResultObject ro_zb = queryService.search(HSql_zb);
	  		                Ga08_flmx ga08=null;
	  		                while(ro_zb.next())
	  		                {
	  		                   ga08=(Ga08_flmx)ro_zb.get("ga08");
	  		                }
	  		                String HSql2="select gd03 from Gd03_gcfysz gd03 where gd03.dxgc_id="+dxgc_id;
	  		                ResultObject ro2 = queryService.search(HSql2);
	  		                Gd03_gcfysz gd03=null;
	  		                HashMap gs=new HashMap();
	  		                HashMap fyz=new HashMap();
	  		                HashMap fy_id=new HashMap();
	  		                HashMap jsgs=new HashMap();
	  		                HashMap bz=new HashMap();
	  		                HashMap dyyl=new HashMap();
	  		                HashMap sxh=new HashMap();
	  		                while(ro2.next())
	  		                {
	  		                   gd03=(Gd03_gcfysz)ro2.get("gd03");
	  		                   gs.put(gd03.getFymc(),gd03.getGsbds());
	  		                   fyz.put(gd03.getFymc(),gd03.getFyz());
	  		                   fy_id.put(gd03.getFymc(),gd03.getId());
	  		                   jsgs.put(gd03.getFymc(),gd03.getJsgs());
	  		                   bz.put(gd03.getFymc(),gd03.getBz());
	  		                   dyyl.put(gd03.getFymc(),gd03.getDyyl());
	  		                   sxh.put(gd03.getFymc(),gd03.getSxh());
	  		                }
		 %>
		<tr>
			<td width="30" align="right">�� </td>
			<td>����׼���������</td>
			<td width="30" align="right">�� </td>
			<td>���赥λ�����ȡ������</td>
			<td width="30" align="right"> </td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td valign="top">
			    <input type="hidden" name="Gd02_dxgc.ID" value="<%=dxgc_id %>">
				����׼������ƶ�Ա��<input type="text" id="sjdy" name="B5_SCZBF_SJDY" value="<%=StringFormatUtil.format(gd02.getB5_sczbf_sjdy())%>" onblur="szyz(this)" style="width:50px;color:red;">&nbsp;&nbsp;
				����׼����ָ�꣺<input type="text" id="sczbfzb" name="" value="<%=StringFormatUtil.format(ga08.getFlz()) %>" style="width:50px;color:red;" onblur="szyz2(this)">&nbsp;&nbsp;
				<input type="hidden" name="Gd02_dxgc.GCMC" value="<%=StringFormatUtil.format(gd02.getGcmc()) %>">
			</td>
			<td ></td>
			<td ><input type="radio" name="jgf" id="jgf1" <%if("���̷�".equals(gs.get("�����ܸ���"))){ %>checked<%} %> value="<%=StringFormatUtil.format((Double)fyz.get("���̷�")) %>" onClick="sgdqsz(<%=dxgc_id %>,'jgf1',3)">���̷�
			<input type="radio" name="jgf" id="jgf2" <%if("���̷�+��5������".equals(gs.get("�����ܸ���"))){ %>checked<%} %> value="<%=NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)fyz.get("���̷�")),NumberFormatUtil.roundToString((Double)fyz.get("��5������"))) %>" onClick="sgdqsz(<%=dxgc_id %>,'jgf2',4)">���̷�+��5������</td>
			
		    <input type="hidden" name="Gd03_gcfysz.DYYL" value="1">
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("�����ܸ���")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="92">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�����ܸ���">
			<input type="hidden" id="gczgs" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("�����ܸ���")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("�����ܸ���")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("�����ܸ���")) %>">
			<input type="hidden" id="gczgsg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("�����ܸ���")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B1">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("�����ܸ���") %>">
			<td> </td>
			<td></td>
		</tr>
		<tr style="height:6px;">
			<td colspan="6"> </td>
		</tr>
	</table>
	<br>
	</div>
	
		<table id="list-table" border="0" cellpadding="0" style="border-collapse: collapse;table-layout:fixed" width="980">
		<tr class="list-title">
			<td width="50">���</td>
			<td width="200">��������</td>
			<td width="300">�������ݼ�����</td>
			<td width="100">���(Ԫ)</td>
			<td >��ע</td>
			<td width="60">��ӡ</td>
		</tr>
		<tr class="list-title">
			<td>1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
			<td>5</td>
		    <td width="60"></td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl1" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("�����õؼ��ۺ��ⲹ��")) %>">
			<td align="center">1</td>
			<td>�����õؼ��ۺ��ⲹ��</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("�����õؼ��ۺ��ⲹ��")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="70">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�����õؼ��ۺ��ⲹ��">
			<td><input type="text" id="zhpbf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("�����õؼ��ۺ��ⲹ��")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=zhpbf&fy_id=70&dyyl=1&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" id="zhpbfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("�����õؼ��ۺ��ⲹ��")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("�����õؼ��ۺ��ⲹ��")) %>"></td>
			<input type="hidden" id="zhpbfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("�����õؼ��ۺ��ⲹ��")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("�����õؼ��ۺ��ⲹ��") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl1','zhpbf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("�����õؼ��ۺ��ⲹ��")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl2" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("���赥λ�����")) %>">
			<td align="center">2</td>
			<td>���赥λ�����</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("���赥λ�����")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="71">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���赥λ�����">
			<td><input type="text" id="jsdwglf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("���赥λ�����")) %>"  readOnly ></td>
			<td><input type="text" id="jsdwglfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("���赥λ�����")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("���赥λ�����")) %>"></td>
			<input type="hidden" id="jsdwglfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("���赥λ�����")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("���赥λ�����") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl2','jsdwglf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("���赥λ�����")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl3" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("�������о���")) %>">
			<td align="center">3</td>
			<td>�������о���</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("�������о���")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="72">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�������о���">
			<td><input type="text" id="kxxyjf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("�������о���")) %>" readOnly ></td>
			<td><input type="text" id="kxxyjfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("�������о���")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("�������о���")) %>"></td>
			<input type="hidden" id="kxxyjfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("�������о���")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("�������о���") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl3','kxxyjf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("�������о���")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl4" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("�о������")) %>">
			<td align="center">4</td>
			<td>�о������</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("�о������")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="73">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�о������">
			<td><input type="text" id="yjsyf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("�о������")) %>"  readOnly ></td>
			<td><input type="text" id="yjsyfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("�о������")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("�о������")) %>"></td>
			<input type="hidden" id="yjsyfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("�о������")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("�о������") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl4','yjsyf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("�о������")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl5" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("������Ʒ�")) %>">
			<td align="center">5</td>
			<td>������Ʒ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("������Ʒ�")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="93">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="������Ʒ�">
			<td><input type="text" id="kcf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("������Ʒ�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=kcf&fy_id=93&dyyl=5&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" id="kcfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("������Ʒ�")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("������Ʒ�")) %>"></td>
			<input type="hidden" id="kcfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("������Ʒ�")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("������Ʒ�") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl5','kcf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("������Ʒ�")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<!--  
		<tr>
		    <input type="hidden" id="dyyl6" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("��Ʒ�")) %>">
			<td align="center">6</td>
			<td>��Ʒ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("��Ʒ�")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="75">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="��Ʒ�">
			<td><input type="text" id="sjf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("��Ʒ�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=sjf&fy_id=75&dyyl=6&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" id="sjfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("��Ʒ�")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("��Ʒ�")) %>"></td>
			<input type="hidden" id="sjfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("��Ʒ�")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("��Ʒ�") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl6','sjf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("��Ʒ�")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		-->
		<tr>
		    <input type="hidden" id="dyyl6" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("����Ӱ�����۷�")) %>">
			<td align="center">6</td>
			<td>����Ӱ�����۷�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("����Ӱ�����۷�")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="76">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="����Ӱ�����۷�">
			<td><input type="text" id="hjyxpjf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("����Ӱ�����۷�")) %>" readOnly></td>
			<td><input type="text" id="hjyxpjfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("����Ӱ�����۷�")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("����Ӱ�����۷�")) %>"></td>
			<input type="hidden" id="hjyxpjfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("����Ӱ�����۷�")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("����Ӱ�����۷�") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl6','hjyxpjf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("����Ӱ�����۷�")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl7" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("�Ͷ���ȫ�������۷�")) %>">
			<td align="center">7</td>
			<td>�Ͷ���ȫ�������۷�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("�Ͷ���ȫ�������۷�")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="77">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�Ͷ���ȫ�������۷�">
			<td><input type="text" id="ldaqwspjf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("�Ͷ���ȫ�������۷�")) %>" readOnly></td>
			<td><input type="text" id="ldaqwspjfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("�Ͷ���ȫ�������۷�")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("�Ͷ���ȫ�������۷�")) %>"></td>
			<input type="hidden" id="ldaqwspjfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("�Ͷ���ȫ�������۷�")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("�Ͷ���ȫ�������۷�") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl7','ldaqwspjf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("�Ͷ���ȫ�������۷�")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl8" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("���蹤�̼����")) %>">
			<td align="center">8</td>
			<td>���蹤�̼����</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("���蹤�̼����")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="78">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���蹤�̼����">
			<td><input type="text" id="jsgcjlf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("���蹤�̼����")) %>" readOnly></td>
			<td><input type="text" id="jsgcjlfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("���蹤�̼����")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("���蹤�̼����")) %>"></td>
			<input type="hidden" id="jsgcjlfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("���蹤�̼����")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("���蹤�̼����") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl8','jsgcjlf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("���蹤�̼����")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl9" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("��ȫ������")) %>">
			<td align="center">9</td>
			<td>��ȫ������</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("��ȫ������")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="79">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="��ȫ������">
			<td><input type="text" id="aqscf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("��ȫ������")) %>" readOnly></td>
			<td><input type="text" id="aqscfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("��ȫ������")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("��ȫ������")) %>"></td>
			<input type="hidden" id="aqscfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("��ȫ������")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("��ȫ������") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl9','aqscf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("��ȫ������")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>

		<tr>
		    <input type="hidden" id="dyyl10" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("���������������豸������")) %>">
			<td align="center">10</td>
			<td>���������������豸������</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("���������������豸������")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="82">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���������������豸������">
			<td><input type="text" id="ylqtf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("���������������豸������")) %>" readOnly></td>
			<td><input type="text" id="ylqtfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("���������������豸������")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("���������������豸������")) %>"></td>
			<input type="hidden" id="ylqtfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("���������������豸������")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("���������������豸������") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl10','ylqtf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("���������������豸������")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl11" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("���̱��շ�")) %>">
			<td align="center">11</td>
			<td>���̱��շ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("���̱��շ�")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="83">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���̱��շ�">
			<td><input type="text" id="gcbxf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("���̱��շ�")) %>" readOnly></td>
			<td><input type="text" id="gcbxfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("���̱��շ�")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("���̱��շ�")) %>"></td>
			<input type="hidden" id="gcbxfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("���̱��շ�")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("���̱��շ�") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl11','gcbxf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("���̱��շ�")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl12" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("�����б�����")) %>">
			<td align="center">12</td>
			<td>�����б�����</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("�����б�����")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="84">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�����б�����">
			<td><input type="text" id="zbdlf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("�����б�����")) %>" readOnly></td>
			<td><input type="text" id="zbdlfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("�����б�����")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("�����б�����")) %>"></td>
			<input type="hidden" id="zbdlfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("�����б�����")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("�����б�����") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl12','zbdlf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("�����б�����")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl13" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("ר����ר������ʹ�÷�")) %>">
			<td align="center">13</td>
			<td>ר����ר������ʹ�÷�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("ר����ר������ʹ�÷�")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="85">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="ר����ר������ʹ�÷�">
			<td><input type="text" id="zlsyf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("ר����ר������ʹ�÷�")) %>" readOnly></td>
			<td><input type="text" id="zlsyfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("ר����ר������ʹ�÷�")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("ר����ר������ʹ�÷�")) %>"></td>
			<input type="hidden" id="zlsyfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("ר����ר������ʹ�÷�")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("ר����ר������ʹ�÷�") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl13','zlsyf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("ר����ר������ʹ�÷�")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
		<%
		    String HSql3="select gd03 from Gd03_gcfysz gd03 where fy_id is null and bgbh='B5' and dxgc_id="+dxgc_id;
	  		ResultObject ro3 = queryService.search(HSql3);
	  		Gd03_gcfysz gd032=null;
	  		int k=14;
	  		while(ro3.next())
	  		{
	  		      gd032=(Gd03_gcfysz)ro3.get("gd03");
		 %>
		 
		<tr>
		    <input type="hidden" name="Gd03_gcfysz.DYYL" value="1">
			<td align="center"  ondblclick="delRow(this.parentNode.rowIndex)" title="˫��ɾ��"><%=k++ %></td>
			<input type="hidden" id="" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
	        <input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<td><input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format(gd032.getId())  %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="<%=StringFormatUtil.format(gd032.getFy_id())  %>">
			<input type="text" name="Gd03_gcfysz.FYMC" value="<%=StringFormatUtil.format(gd032.getFymc())  %>"></td>
			<td><input type="text" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format(gd032.getGsbds())  %>"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format(gd032.getFyz())  %>" style="text-align:right;" onblur="szyz(this)"></td>
			<td><input type="text" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format(gd032.getBz())  %>">
			<input type="hidden" id="" name="Gd03_gcfysz.JSGS" value=""></td>
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="29">
		    <td width="60" > </td>
		</tr>
		<%} 
		  if(k==14)
		  {
		%>
		
		<tr>
		    <input type="hidden" name="Gd03_gcfysz.DYYL" value="1">
			<td align="center" ondblclick="delRow(this.parentNode.rowIndex)" title="˫��ɾ��"><%=k %></td>
			<input type="hidden" id="" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
		    <input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id%>">
			<td><input type="hidden" name="Gd03_gcfysz.ID" value="">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="">
			<input type="text" name="Gd03_gcfysz.FYMC" value=""></td>
			<td><input type="text" name="Gd03_gcfysz.GSBDS" value=""></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" value="" style="text-align:right;" onblur="szyz(this)"></td>
			<td><input type="text" name="Gd03_gcfysz.BZ" value="">
			<input type="hidden" id="" name="Gd03_gcfysz.JSGS" value=""></td>
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="29">
		    <td width="60" > </td>
		</tr>
		<%} %>
		</table>
		
		    <input type="hidden" name="Gd03_gcfysz.DYYL" value="1">
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("��5������")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="87">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="��5������">
			<input type="hidden" id="" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("��5������")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("��5������")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("��5������")) %>">
			<input type="hidden" id="b5qtfgs" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("��5������")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5HJ">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("��5������") %>">
		
		<table id="list-table" border="0" cellpadding="0" style="border-collapse: collapse;table-layout:fixed" width="980">
		<tr>
		    <input type="hidden" name="Gd03_gcfysz.DYYL" value="1">
			<td width="50"> </td>
			<td width="200">�ܼ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("��5�ϼ�������")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="86">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="��5�ϼ�������">
			<td width="300"><%=StringFormatUtil.format((String)gs.get("��5�ϼ�������")) %></td>
			<td width="100" id="zj" align="right" ><%=StringFormatUtil.format((Double)fyz.get("��5�ϼ�������"))%></td>
			<td ><%=StringFormatUtil.format((String)bz.get("��5�ϼ�������")) %></td>
			<input type="hidden" id="" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("��5�ϼ�������")) %>">
			<input type="hidden" id="b5hjqtf" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("��5�ϼ�������")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("��5�ϼ�������")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("��5�ϼ�������")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5HJ">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("��5�ϼ�������") %>">
		    <td width="60" > </td>
		</tr>
		<tr>
		    <input type="hidden" id="dyyl17" name="Gd03_gcfysz.DYYL" value="<%=StringFormatUtil.format((Integer)dyyl.get("����׼���������")) %>">
			<td align="center"><%=++k %></td>
			<td>����׼���������(��Ӫ��)</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=StringFormatUtil.format((Integer)fy_id.get("����׼���������")) %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="88">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="����׼���������">
			<td><input type="text" id="kbf" name="Gd03_gcfysz.GSBDS" value="<%=StringFormatUtil.format((String)gs.get("����׼���������")) %>" readOnly ></td>
			<td><input type="text" id="kbfz" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)fyz.get("����׼���������")) %>" style="text-align:right;" readOnly></td>
			<td><input type="text" id="" name="Gd03_gcfysz.BZ" value="<%=StringFormatUtil.format((String)bz.get("����׼���������")) %>"></td>
			<input type="hidden" id="kbfg" name="Gd03_gcfysz.JSGS" value="<%=StringFormatUtil.format((String)jsgs.get("����׼���������")) %>">
			<input type="hidden" id="" name="Gd03_gcfysz.BGBH" value="B5SCZBF">
			<input type="hidden" id="" name="Gd03_gcfysz.SXH" value="<%=sxh.get("����׼���������") %>">
		    <td width="60"><input type="checkbox" name="dyyl" onClick="dyyl_set('dyyl17','kbf')" value="" <%if("1".equals(StringFormatUtil.format((Integer)dyyl.get("����׼���������")))){ %> checked<%} %> style="width:60px;"></td>
		</tr>
	</table>
	<br>

</form>
</div>
</body>

</html>