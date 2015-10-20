<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.dataObject.Gb03_bgxx"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Gd01_gcxm"%>
<%@ page import="com.netsky.dataObject.Ga06_zy"%>
<%@ page import="com.netsky.dataObject.Gd03_gcfysz"%>
<%@ page import="com.netsky.dataObject.Ga08_flmx" %>
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

    //String user = (String)session.getAttribute("user");
  	String gcxm_id=request.getParameter("gcxm_id");
 	String dxgc_id=request.getParameter("dxgc_id");
     ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
         QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
         ExpenseService expenseService = (ExpenseService) ctx.getBean(ServiceName.ExpenseService);
     String HSql1="select gd02 from Gd02_dxgc gd02 where id="+dxgc_id;
     ResultObject ro1 = queryService.search(HSql1);
     Gd02_dxgc gd02=null;
     int B2_sgdqf_wfbz=2;
     Double B2_sgdqlc=new Double(0);
     int B2_jxdqf_wfbz=2;
     Double B2_jxdqdw=new Double(0);
     Double B2_jxdqlc=new Double(0);
     Double B2_tzxs=new Double(0);
     int Sj_bgbbl=0;
     int B2_bgbbl=1;
     String jd_str="����";
     if(ro1.next())
     {
        gd02=(Gd02_dxgc)ro1.get("gd02");
        if(gd02.getB2_sgdqf_wfbz()==null){
          B2_sgdqf_wfbz=0;
        }else{
          B2_sgdqf_wfbz=gd02.getB2_sgdqf_wfbz().intValue();
        }
        B2_sgdqlc=gd02.getB2_sgdqlc();
        if(gd02.getB2_jxdqf_wfbz()==null){
          B2_jxdqf_wfbz=0;
        }else{
          B2_jxdqf_wfbz=gd02.getB2_jxdqf_wfbz().intValue();
        }
        
        B2_jxdqdw=gd02.getB2_jxdqdw();
        B2_jxdqlc=gd02.getB2_jxdqlc();
        if(gd02.getSj_bgbbl()==null){
          Sj_bgbbl=0;
        }else{
          Sj_bgbbl=gd02.getSj_bgbbl().intValue();
        }
        if(gd02.getB2_bgbbl()==null){
          B2_bgbbl=0;
        }else{
          B2_bgbbl=gd02.getB2_bgbbl().intValue();
        }
        
        B2_tzxs=gd02.getB2_tzxs();
       		                
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
     
     //ȡ���ͻ�е��ǲ��                       
     QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Ga08_flmx.class); 
     queryBuilder9.eq("fy_id",new Integer(27));
	 queryBuilder9.eq("flk_id",gd02.getFlk_id());
	 ResultObject ro9 = queryService.search(queryBuilder9);
	 Ga08_flmx ga08 = new Ga08_flmx();
	 if(ro9.next()){
	 	ga08 = (Ga08_flmx)ro9.get(Ga08_flmx.class.getName());
	 }
                       
    //��ȡ����
	if(request.getParameter("chongqufy")!=null&&request.getParameter("chongqufy").equals("1")){
		expenseService.reBuildFy(gd02,new String("B2"),request);
	}
 %>
 <%   
     String HSql2="select gd03 from Gd03_gcfysz gd03 where gd03.dxgc_id="+dxgc_id;
     ResultObject ro2 = queryService.search(HSql2);
     Gd03_gcfysz gd03=null;
     HashMap gs=new HashMap();
     HashMap hj=new HashMap();
     HashMap fy_id=new HashMap();
     HashMap jsgs=new HashMap();
     while(ro2.next())
     {
        gd03=(Gd03_gcfysz)ro2.get("gd03");
        gs.put(gd03.getFymc(),gd03.getGsbds());
        hj.put(gd03.getFymc(),gd03.getFyz());
        fy_id.put(gd03.getFymc(),gd03.getId());
        jsgs.put(gd03.getFymc(),gd03.getJsgs());
     }
%>

<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>���</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/data.css" rel="stylesheet" type="text/css">
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
  
  function sgdqsz()
  {
    var dqlc=document.all.dqlc.value;
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=cl;
    xmlHttp.open("GET","../afuer/SgddqdeXml?bz=1&b2_yj="+dqlc+"&dxgc_id="+<%=dxgc_id%>);
    xmlHttp.send(null);
  }
  
  function cl()
  {
    var fl;
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           //fl=xmlHttp.responseText;
           //setValue(fl);
           var doc = new ActiveXObject("MSxml2.DOMDocument")
           doc.loadXML(xmlHttp.responseText);
           result=doc.getElementsByTagName("gg");
           var fl=result[0].childNodes[0].childNodes[0].nodeValue;
           setValue(fl);
           var ff=result[0].childNodes[1].childNodes[0].nodeValue;
           
           document.getElementById("lsssf").value="�˹��ѡ�"+ff+"0%";
      	   document.getElementById("lsssfz").value=(document.getElementById("rgf_h").value*ff/100).toFixed(2);
      	   document.getElementById("lsssfg").value="[�˹���]*"+ff+"%";
      	   jaf();
        }
     }
  }
  //ͬ����2��Ϣ
    function xxtb()
  {
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=xxtbcl;
    xmlHttp.open("GET","../afuer/SynchronizeController?act=b2&dxgc_id="+<%=dxgc_id%>);
    xmlHttp.send(null);
  }
  
  function xxtbcl()
  {
    var fl;
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           jgf=xmlHttp.responseText;
           if(tonull(jgf)=="b2")
           {
             alert("���ͬ���ɹ�");
           }
        }
     }
  }
   
    //����ҳ��ֵ
  function setValue(fl)
  {
    var dqde=document.getElementById("dqde");
    dqde.value=fl;
    document.getElementById("sgdqf"+"z").value=document.getElementById("box1").value*document.getElementById("dqrs").value*fl;
	jaf();
  }
  
    //���ø�ѡ��box1
  function setbox1(boxid)
  {
    var oldv=document.getElementById(boxid).value;
    var obj = document.getElementById("sgdqf");
	var objz = document.getElementById("sgdqf"+"z");
	var objg = document.getElementById("sgdqf"+"g");
    if(oldv==1)
    {
      document.getElementById(boxid).value=2;
	  objz.value=2*document.getElementById("dqrs").value*document.getElementById("dqde").value;
	  objg.value ="2*[����ʩ�������ǲ�Ѷ���]*[ʩ�������ǲ�ѵ�ǲ����]";
	  obj.value ="2�����̵�ǲ�������ǲ����";
    }else{
      document.getElementById(boxid).value=1;
	  objz.value=1*document.getElementById("dqrs").value*document.getElementById("dqde").value;
	  objg.value = "1*[����ʩ�������ǲ�Ѷ���]*[ʩ�������ǲ�ѵ�ǲ����]";
	  obj.value ="���̵�ǲ�������ǲ����";
    }
    jaf();
  }
  
  function jxdq()
  {
    document.getElementById("jxdqf"+"z").value="dddd";
    document.getElementById("jxdqf"+"z").value=round(document.getElementById("box2").value*document.getElementById("jxdw").value*document.getElementById("dqyj").value*document.getElementById("dcyj").value,2);
    jaf();
  }
  
      //���ø�ѡ��box2
  function setbox2(boxid)
  {
    var oldv=document.getElementById(boxid).value;
    var obj = document.getElementById("jxdqf");
	var objz = document.getElementById("jxdqf"+"z");
	var objg = document.getElementById("jxdqf"+"g");
    if(oldv==1)
    {
      document.getElementById(boxid).value=2;
	  objz.value=round(2*document.getElementById("jxdw").value*document.getElementById("dqyj").value*document.getElementById("dcyj").value,2);
	  //objg.value ="2*[����ʩ����е�����˼�]*[��ǲ�˾�]*[�ܶ�λ]";
	  objg.value ="2*"+document.getElementById('dcyj').value+"*[��ǲ�˾�]*[�ܶ�λ]";
	  //alert(objg.value);
	  obj.value ="2�������˼ۡ���ǲ�˾���ܶ�λ";
    }else{
      document.getElementById(boxid).value=1;
	  objz.value=round(1*document.getElementById("jxdw").value*document.getElementById("dqyj").value*document.getElementById("dcyj").value,2);
	  //objg.value = "1*[����ʩ����е�����˼�]*[��ǲ�˾�]*[�ܶ�λ]";
	  objg.value = "1*"+document.getElementById('dcyj').value+"*[��ǲ�˾�]*[�ܶ�λ]";
	  //alert(objg.value);
	  obj.value ="�����˼ۡ���ǲ�˾���ܶ�λ";
    }
    jaf();
  }
  
        //���ø�ѡ��box4
  function setbox4(boxid)
  {
    var oldv=document.getElementById(boxid).value;
    if(oldv==0)
    {
      document.getElementById(boxid).value=1;
      document.getElementById("zyclf").innerText="0";
      document.getElementById("fzclf_xs").value="0";
      document.getElementById("clf").innerText="0";
      document.getElementById("zyclf_h").value="0";
      document.getElementById("fzclfz").value="0";
      document.getElementById("clf_h").value="0";
    }else{
      document.getElementById(boxid).value=0;    
      document.getElementById("zyclf").innerText=document.getElementById("g").value;
      document.getElementById("fzclf_xs").value=document.getElementById("gg").value;
      document.getElementById("clf").innerText=document.getElementById("ggg").value;
      
      document.getElementById("zyclf_h").value=document.getElementById("g").value;
      document.getElementById("fzclfz").value=document.getElementById("gg").value;
      document.getElementById("clf_h").value=document.getElementById("ggg").value;
     // document.getElementById("zyclf").innerText=document.getElementById("zyclf_h").value;
     // document.getElementById("fzclf_xs").value=document.getElementById("fzclfz").value;
     // document.getElementById("clf").innerText=document.getElementById("clf_h").value;
    }
    jaf();
  }
  //��ʼ��
  function setbox4_csh(boxid)
  {
    var oldv=document.getElementById("box4").value;
    if(oldv==1)
    {
      document.getElementById("zyclf").innerText="0";
      document.getElementById("fzclf_xs").value="0";
      document.getElementById("clf").innerText="0";
      document.getElementById("zyclf_h").value="0";
      document.getElementById("fzclfz").value="0";
      document.getElementById("clf_h").value="0";
    }else{
      document.getElementById("zyclf").innerText=document.getElementById("zyclf_h").value;
      document.getElementById("fzclf_xs").value=document.getElementById("fzclfz").value;
      document.getElementById("clf").innerText=document.getElementById("clf_h").value;
    }
    jaf();
  }
  
  //���������ϲ��Ʋ��Ϸ� ����
  
  function bgbbl()
  {
    if(document.getElementById("box4").value==0)
    {
      document.getElementById("fzclf_xs").value=document.getElementById("fzclfz").value;
    }else{
    }
  }
  
  //˰����� ֱ�ӷ� ��ӷ� ����
  function sjcs(csmc)
  {
    var csz=0;
    if(csmc=="zjf")
    {
      csz=parseFloat(nullto(document.getElementById("zjf").innerText,0));
    }
    if(csmc=="jjf")
    {
      csz=parseFloat(nullto(document.getElementById("jjf").innerText,0));
    }
    if(csmc=="lr")
    {
      csz=parseFloat(nullto(document.getElementById("lrz").value,0));
    }
    if(csmc=="clf")
    {
      csz=parseFloat(nullto(document.getElementById("clf").innerText,0));
    }
    return csz;
  }
  
  //���õ�ѡ��ť
  function sjr()
  {
    var jsgs;
    var zjf=parseFloat(nullto(document.getElementById("zjf").innerText,0));
    var jjf=parseFloat(nullto(document.getElementById("jjf").innerText,0));
    var lrz=parseFloat(nullto(document.getElementById("lrz").value,0));
    var clf=parseFloat(nullto(document.getElementById("clf").innerText,0));
    if(document.all.jssjr[0].checked)
    {
      if(<%=Sj_bgbbl%>=="0")
      {
        jsgs="<%=StringFormatUtil.format((String)jsgs.get("˰��")) %>";
      }else{
        jsgs="([ֱ�ӷ�]+[��ӷ�]+[����]-[��ȡ˰����Ϸ�])*[˰��]";
      } 
      //jsgs="("+zjf+"+"+jjf+"+"+lrz+"-[��ȡ˰����Ϸ�])";
      document.all.jssj.value=0;
    }
    if(document.all.jssjr[1].checked)
    {
      if(<%=Sj_bgbbl%>=="1")
      {
        jsgs="<%=StringFormatUtil.format((String)jsgs.get("˰��")) %>";
      }else{
        jsgs="([ֱ�ӷ�]+[��ӷ�]+[����]-[���Ϸ�])*[˰��]";
      } 
      //jsgs="("+zjf+"+"+jjf+"+"+lrz+"-"+clf+")";
      document.all.jssj.value=1;
    }
    if(document.all.jssjr[2].checked)
    {
      if(<%=Sj_bgbbl%>=="2")
      {
        jsgs="<%=StringFormatUtil.format((String)jsgs.get("˰��")) %>";
      }else{
        jsgs="([ֱ�ӷ�]+[��ӷ�]+[����]-[��ȡ˰����Ϸ�]-[�������ķ�])*[˰��]";
      } 
      //jsgs="("+zjf+"+"+jjf+"+"+lrz+"-[��ȡ˰����Ϸ�]-[�������ķ�])";
      document.all.jssj.value=2;
    }
    var zjf=sjcs('zjf');
    var jjf=sjcs('jjf');
    var lr=sjcs('lr');
    var clf=sjcs('clf');
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=clr;
    xmlHttp.open("GET","../afuer/SgddqdeXml?bz=2&dxgc_id=<%=request.getParameter("dxgc_id")%>&jsgs="+encodeURIComponent(jsgs)+"&zjf="+zjf+"&jjf="+jjf+"&lr="+lr+"&clf="+clf);
    xmlHttp.send(null);
  }
  function clr()
  {
    var sl;
    var jg;
    var jsgs;
    if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           var doc = new ActiveXObject("MSxml2.DOMDocument")
           doc.loadXML(xmlHttp.responseText);
           result=doc.getElementsByTagName("b2");
           sl=result[0].childNodes[0].childNodes[0].nodeValue;
           jg=result[0].childNodes[1].childNodes[0].nodeValue;
           jsgs=result[0].childNodes[2].childNodes[0].nodeValue;
           setsj(sl,jg,jsgs);
        }
     }
  }
  function setsj(sl,jg,jsgs)
  {
    var sj=document.getElementById("sj");
    var sjz=document.getElementById("sjz");
    var sjg=document.getElementById("sjg");
    if(document.all.jssjr[0].checked)
    {
      //sjg.value="([ֱ�ӷ�]+[��ӷ�]+[����]-[��ȡ˰����Ϸ�])*"+sl+"%";
      sjg.value=jsgs;
      sjz.value=round(jg,2);
      //sj.value="(ֱ�ӷ�+��ӷ�+����-��ȡ˰����Ϸ�)��"+sl+"%";
      sj.value="(ֱ�ӷ�+��ӷ�+����)��"+sl+"%";
    }
    if(document.all.jssjr[1].checked)
    {
      //sjg.value="([ֱ�ӷ�]+[��ӷ�]+[����]-[���Ϸ�])*"+sl+"%";
      sjg.value=jsgs;
      sjz.value=round(jg,2);
      //sj.value="(ֱ�ӷ�+��ӷ�+����-���Ϸ�)��"+sl+"%";
      sj.value="(ֱ�ӷ�+��ӷ�+����)��"+sl+"%";
    }
    if(document.all.jssjr[2].checked)
    {
      //sjg.value="([ֱ�ӷ�]+[��ӷ�]+[����]-[��ȡ˰����Ϸ�]-[�������ķ�])*"+sl+"%";
      sjg.value=jsgs;
      sjz.value=round(jg,2);
      //sj.value="(ֱ�ӷ�+��ӷ�+����-��ȡ˰����Ϸ�-�������ķ�)��"+sl+"%";
      sj.value="(ֱ�ӷ�+��ӷ�+����)��"+sl+"%";
    }
    jaf();
  }
  
  //������ϵ������
  function jaftzxs(jafxs)
  {
    var xs=jafxs.value;
    if(xs!=null&&xs!=""&&xs!=1.00)
    {
       document.getElementById("jafs").value="([ֱ�ӷ�]+[��ӷ�]+[����]+[˰��])*"+xs;
       document.getElementById("jafg").value="(һ + �� + �� + ��)*"+xs;
       document.getElementById("tdg").innerText="(һ + �� + �� + ��)*"+xs;
    }else{
       document.getElementById("jafs").value="[ֱ�ӷ�]+[��ӷ�]+[����]+[˰��]";
       document.getElementById("jafg").value="һ + �� + �� + ��";
       document.getElementById("tdg").innerText="һ + �� + �� + ��";
    }
    jaf();
  }
  function reBuildFy(){//������ȡ����
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
		document.form1.action="../afuer/dataWriter";
		document.form1.submit();
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
</script>

<script language="javascript">
  // һ��
  function jaf()
  {
    rgf();
    clf();
    
    gf();
    csf();
    zjgcf();
    
    jjf();
    zjf();
    
    //�жϵ���ϵ��
    var xs=document.getElementById("tzxs").value;
    if(xs==null&&xs=="")
    {
       xs=1;
    }
    document.getElementById("jaf").innerText=round((parseFloat(nullto(document.all.lrz.value,0))+parseFloat(nullto(document.all.sjz.value,0))+parseFloat(nullto(document.getElementById("zjf").innerText,0))+parseFloat(nullto(document.getElementById("jjf").innerText,0)))*xs,2);
    document.getElementById("jaf_h").value=document.getElementById("jaf").innerText;
    zjf();
    bgbbl();
  }
  
  //����
  //һֱ�ӷ�
  function zjf()
  {
    document.getElementById("zjf").innerText=round(parseFloat(nullto(document.getElementById("zjgcf").innerText,0))+parseFloat(nullto(document.getElementById("csf").innerText,0)),2);
    document.getElementById("zjf_h").value=document.getElementById("zjf").innerText;
    
  }
  //����ӷ�
  function jjf()
  {
    document.getElementById("jjf").innerText=round(parseFloat(nullto(document.getElementById("gf").innerText,0))+parseFloat(nullto(document.all.qyglfz.value,0)),2)
    document.getElementById("jjf_h").value=document.getElementById("jjf").innerText;
  }
  //������
  //˰��
  
  
  //����
  function zjgcf()
  {
    if(document.getElementById("box4").value==0)
    {
      document.getElementById("zjgcf").innerText=round(parseFloat(nullto(document.getElementById("rgf").innerText,0))+parseFloat(nullto(document.getElementById("clf").innerText,0))+parseFloat(nullto(document.getElementById("jxsyf").innerText,0))+parseFloat(nullto(document.getElementById("ybsyf").innerText,0)),2)
    }else{
      document.getElementById("zjgcf").innerText=round(parseFloat(nullto(document.getElementById("rgf").innerText,0))+parseFloat(nullto(document.getElementById("jxsyf").innerText,0))+parseFloat(nullto(document.getElementById("ybsyf").innerText,0)),2)
    }
    document.getElementById("zjgcf_h").value=document.getElementById("zjgcf").innerText
  }
  function csf()
  {
  
    var hjbhfz=parseFloat(nullto(document.getElementById("hjbhfz").value,0));
    var wmsgfz=parseFloat(nullto(document.getElementById("wmsgfz").value,0));
    var gdqcbyfz=parseFloat(nullto(document.getElementById("gdqcbyfz").value,0));
    var gcgrfz=parseFloat(nullto(document.getElementById("gcgrfz").value,0));
    var qlfz=parseFloat(nullto(document.getElementById("qlfz").value,0));
    var lsssfz=parseFloat(nullto(document.getElementById("lsssfz").value,0));
    var clsyfz=parseFloat(nullto(document.getElementById("clsyfz").value,0));
    var yjzjfz=parseFloat(nullto(document.getElementById("yjzjfz").value,0));
    
    var dyzjfz=parseFloat(nullto(document.getElementById("dyzjfz").value,0));
    var gjsyfz=parseFloat(nullto(document.getElementById("gjsyfz").value,0));
    var sgzqfz=parseFloat(nullto(document.getElementById("sdzqfz").value,0));
    var tsdqzjfz=parseFloat(nullto(document.getElementById("tsdqzjfz").value,0));
    var sbbhfz=parseFloat(nullto(document.getElementById("sbbhfz").value,0));
    var ytfz=parseFloat(nullto(document.getElementById("ytfz").value,0));
    var sgdqfz=parseFloat(nullto(document.getElementById("sgdqfz").value,0));
    var jxdqfz=parseFloat(nullto(document.getElementById("jxdqfz").value,0));
    document.getElementById("csf").innerText=round(hjbhfz+wmsgfz+gdqcbyfz+gcgrfz+qlfz+lsssfz+clsyfz+yjzjfz+dyzjfz+gjsyfz+sgzqfz+tsdqzjfz+sbbhfz+ytfz+sgdqfz+jxdqfz,2);
    
    document.getElementById("csf_h").value=document.getElementById("csf").innerText;
  }
  
  //���
  function gf()
  {
    document.getElementById("gf").innerText=round(parseFloat(nullto(document.getElementById("gcpwfz").value,0))+parseFloat(nullto(document.getElementById("shbzfz").value,0))+parseFloat(nullto(document.getElementById("zfgjjz").value,0))+parseFloat(nullto(document.getElementById("bxfz").value,0)),2)
    document.getElementById("gf_h").value=document.getElementById("gf").innerText;
  }
  
  //�ļ�
  function rgf()
  {
    document.getElementById("rgf").innerText=round(parseFloat(nullto(document.getElementById("pgfz").value,0))+parseFloat(nullto(document.getElementById("jgfz").value,0)),2);
    document.getElementById("rgf_h").value=document.getElementById("rgf").innerText;
  }
  function clf()
  {
    document.getElementById("clf_h").value=round(parseFloat(nullto(document.getElementById("zyclf_h").value,0))+parseFloat(nullto(document.getElementById("fzclfz").value,0)),2);
    //document.getElementById("clf").innerText=document.getElementById("clf").innerText;
    var oldv=document.getElementById("box4").value;
    if(oldv==1)
    {
    }else{
      document.getElementById("clf").innerText=document.getElementById("clf_h").value;
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
  //��0ת����""
  function tonull(d)
  {
    if(0==d)
    {
      d="";
    }
    return d;
  }
  //����ϵ����֤
  function xsyz(obj)
  {
    var xs=obj.value;
    if(xs=="")
    {
      alert("��������ѵ���ϵ������Ϊ�գ�Ĭ��Ϊ1");
      obj.value=1;
      obj.focus();
    }
    else if(isNaN(xs))
    {
       alert("����������");
       obj.value=1;
       obj.focus() ;
    }
    else
    {
      if(xs<=0)
      {
        alert("��������ѵ���ϵ������С�ڵ���0��");
        obj.value=1;
        obj.focus();
      }else
      {
        jaftzxs(obj);
      }
    } 
  }
  //���ֺϷ���֤
  function szyz(yzobj)
  {
    if(yzobj.value=="")
    {
       alert("���벻��Ϊ��");
       yzobj.value="1";
       yzobj.focus() ;
    }else if(!isNaN(yzobj.value)){
       sgdqsz();
    }else{
       alert("����������");
       yzobj.value="1";
       yzobj.focus() ;
    }
  }
  //���ֺϷ���֤
  function ptszyz(yzobj)
  {
    if(!isNaN(yzobj.value)){
       jxdq();
    }else{
       alert("����������");
       yzobj.value="";
       yzobj.focus() ;
    }
  }
  function SET_WIDTH(){
  	document.getElementById('xgsz').style.width=screen.width-325;
  }
</script>

</head>
<body leftmargin="0" topmargin="0" id="main-body">
<div id="menuDiv" onmouseover="javascript:this.style.display='block';" onmouseout="javascript:this.style.display='none';" style="display:none;position: absolute;left:111;top:39;width:88;background-color:#FFFFFF;border:1px solid gray">
<table border="0" width="100%">
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="allwinOpen('../print/print.jsp?type=print&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=3')">����Ԥ��</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=pdf&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=3');">PDF���</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../print/transformer.jsp?type=doc&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=3');">WORD���</td>
	</tr>
	<tr>
		<td style="cursor:hand;" onmouseover="javascript:this.bgColor='4ca6f2'" onmouseout="javascript:this.bgColor=''" onclick="javascript:window.open('../export/SingleProject_excel.jsp?dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>&Cb_bgxd=3');">EXCEL���</td>
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
			<!--  
			<%if(yh.getOperate()!=null&&yh.getOperate().intValue()==1){ %>
			&nbsp;<input type="button" name="" value=" ��Ϣͬ�� " onClick="xxtb()"> 
			<%} %>
			&nbsp;<input type="button" style="width:110px;" name="b" value=" ��ȡ������� " onclick="javascript:reBuildFy()">
			<%} %>
			-->
			&nbsp;<input type="button" name="b2" value=" ����Ԥ�� " onclick="javascript:dbyl(this);">
			&nbsp;<input type="button" name=""   value=" ȫ��Ԥ�� "onclick="javascript:winOpen('../print/SingleProject_print.jsp?gcxm_id=<%=request.getParameter("gcxm_id")%>&dxgc_id=<%=request.getParameter("dxgc_id")%>'
					,'580','295','0')" >
		</td>
	</tr>
</table>

<div style="width:100%;background:#ffffff;">
<form name="form1" method="post" action="">
<input type="hidden" id="chongqufy" name="chongqufy" value="0">
<div class="file_title">������װ���̷���<%=jd_str %>�������</div>
<input type="hidden" name="dispatchStr" value="/dataManage/b2.jsp?gcxm_id=<%=request.getParameter("gcxm_id") %>&dxgc_id=<%=request.getParameter("dxgc_id") %>">
<input type="hidden" name="tableInfomation" value="noFatherTable:Gd03_gcfysz">
<input type="hidden" name="tableInfomation" value="noFatherTable:Gd02_dxgc">
    <input type="hidden" name="ServiceName" value="calculateService">
    <input type="hidden" name="ServiceFunction" value="Calculate">
    <input type="hidden" name="ServicePerproty" value="dxgc_id">
    <input type="hidden" name="dxgc_id" value="<%=request.getParameter("dxgc_id") %>">
	<div style="text-align:left;color:1E4F75;font-size:13px;font-weight:bold;padding:3px 6px;"><img src="../images/setting.gif" border="0" onClick="showsetting()" style="cursor:hand;"></div>
		<div align="left">		
		<div id="setting" style="display:none;">
		<table id="xgsz" border="0" cellpadding="0" style="border-collapse: collapse;background-color:#f0f0f0;border:solid 1px #cccccc" width="960">
		<tr style="height:6px;">
			<td colspan="6" align="center"><div style="position:relative;"><div style="position:absolute;right:2px;cursor: hand;"><img src="../images/ca.jpg" border="0" onClick="showsetting()"></div></div><br></td>
		</tr>
		<tr>
			<td width="30" align="right">�� <br></td>
			<td>ʩ�������ǲ��<br></td>
			<td width="30" align="right">�� <br></td>
			<td>���ͻ�е��ǲ��<br></td>		
		</tr>
		<tr>
			<td><br></td>
			<input type="hidden" name="Gd02_dxgc.ID" value="<%=dxgc_id %>">
			<td valign="top">
				ʩ�������ǲ���Ƿ񰴵��̼��� <input type="checkbox" name="" value="" <%if(B2_sgdqf_wfbz==1){ %> checked<%} %> onClick="javascript:setbox1('box1');" ><br>
				<input type="hidden" id="box1" name="Gd02_dxgc.B2_SGDQF_WFBZ" value="<%=B2_sgdqf_wfbz %>" >
				ʩ����ҵ���ֳ����루��ǲ��̣���<input type="text" id="dqlc" name="Gd02_dxgc.B2_SGDQLC" value="<%=NumberFormatUtil.roundToString(B2_sgdqlc) %>" style="width:52px;color:red;" onblur="szyz(this)"><br>
				����ʩ�������ǲ�Ѷ��<input type="text" id="dqde" name="Gd03_gcfysz.FYZ" value="<%=NumberFormatUtil.roundToString((Double)hj.get("����ʩ�������ǲ�Ѷ���"))%>" style="width:100px;color:red;" readOnly><br>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("����ʩ�������ǲ�Ѷ���") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="24">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="����ʩ�������ǲ�Ѷ���">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="">
			<input type="hidden" name="Gd03_gcfysz.JSGS" value="">
				
				ʩ�������ǲ�ѵ�ǲ������<input type="text" id="dqrs" name="Gd03_gcfysz.FYZ" value="<%=NumberFormatUtil.roundToString((Double)hj.get("ʩ�������ǲ�ѵ�ǲ����"))%>" style="width:100px;color:red;" readOnly>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("ʩ�������ǲ�ѵ�ǲ����") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="25">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="ʩ�������ǲ�ѵ�ǲ����">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="">
			<input type="hidden" name="Gd03_gcfysz.JSGS" value="">
			
			<br></td>
			<td><br></td>
			<td valign="top">
				���ͻ�е��ǲ���Ƿ񰴵��̼��� <input type="checkbox" name="" value="1" <%if(B2_jxdqf_wfbz==1){ %> checked<%} %> onClick="javascript:setbox2('box2');"><br>
				<input type="hidden" id="box2" name="Gd02_dxgc.B2_JXDQF_WFBZ" value="<%=B2_jxdqf_wfbz %>" >
				���ͻ�е�ܶ�λ��<input type="text" id="jxdw" name="Gd02_dxgc.B2_JXDQDW" value="<%=NumberFormatUtil.roundToString(B2_jxdqdw )%>" style="width:30px;color:red;" onblur="ptszyz(this)">
				���ͻ�е��ǲ�˾ࣺ<input type="text" id="dqyj" name="Gd02_dxgc.B2_JXDQLC" value="<%=NumberFormatUtil.roundToString(B2_jxdqlc )%>" style="width:30px;color:red;" onblur="ptszyz(this)"><br>
				���ͻ�е��ǲ�ѵ����˼ۣ�<input type="text" id="dcyj" name="" value="<%=ga08.getFlz() %>" style="width:114px;color:red;" onblur="ptszyz(this)">
			<br></td>
			<td><br></td>
			
		</tr>
		<tr>
			<td width="30" align="right">�� <br></td>
			<td>����ϼ�<br></td>
			<td width="30" align="right">�� <br></td>
			<td>˰��<br></td>
		</tr>
		<tr>
			<td width="30"><br></td>
			<td>��������ѵ���ϵ����<input type="text" id="tzxs" name="Gd02_dxgc.B2_TZXS" value="<%=NumberFormatUtil.roundToString(B2_tzxs) %>" onblur="xsyz(this)"  style="width:50px;color:red;"><br>
			���������ϲ��Ʋ��Ϸ� <input type="checkbox" name="" value="1" <%if(B2_bgbbl==1){ %> checked<%} %> onClick="javascript:setbox4('box4');">
			<input type="hidden" id="box4" name="Gd02_dxgc.B2_BGBBL" value="<%=B2_bgbbl %>" ><br></td>
			<td width="30"><br></td>
			<td valign="top">
				<input type="radio" name="jssjr" id="jssjr" value="0" <%if(Sj_bgbbl==0){ %>checked<%} %> onClick="javascript:sjr();">�������ϼ���˰��<br>
				<input type="radio" name="jssjr" id="jssjr" value="1" <%if(Sj_bgbbl==1){ %>checked<%} %> onClick="javascript:sjr();">���������ϼ���˰��<br>
				<input type="radio" name="jssjr" id="jssjr" value="2" <%if(Sj_bgbbl==2){ %>checked<%} %> onClick="javascript:sjr();">�������ϲ��Ƹ�����Ϸ�<br>
				<input type="hidden" id="jssj" name="Gd02_dxgc.SJ_BGBBL" value="<%=Sj_bgbbl %>" >
			<br></td>
			<td width="30"><br></td>
			<td><br></td>
		</tr>
		
	</table>
	<br>
	</div>
		<table id="list-table" border="0" cellpadding="0" style="border-collapse: collapse;table-layout:fixed" width="1000">
		<tr class="list-title">
			<td style="width:30">���</td>
			<td style="width:150">��������</td>
			<td style="width:200">���ݺͼ��㷽��</td>
			<td style="width:100">�ϼ�(Ԫ)</td>
			<td style="width:30">���</td>
			<td style="width:150">��������</td>
			<td style="width:200">���ݺͼ��㷽��</td>
			<td style="width:100">�ϼ�(Ԫ)</td>
		</tr>
		<tr class="list-title">
			<td>1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
			<td>1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
		</tr>

		<tr>
			<td align="center">��</td>		
			<td>������װ���̷�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("������װ���̷�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="40">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="������װ���̷�">
			<input type="hidden" id="jafg" name="Gd03_gcfysz.GSBDS" value="һ + �� + �� + ��">
			<input type="hidden" id="jafs" name="Gd03_gcfysz.JSGS" value="[ֱ�ӷ�]+[��ӷ�]+[����]+[˰��]">
			<input type="hidden" id="jaf_h" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)hj.get("������װ���̷�"))%>">	
			<td id="tdg"><%=StringFormatUtil.format((String)gs.get("������װ���̷�")) %></td>
			<td align="right" id="jaf"><%=StringFormatUtil.format((Double)hj.get("������װ���̷�")) %></td>
			<td align="center">8</td>
			
			<td>ҹ��ʩ�����ӷ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("ҹ��ʩ�����ӷ�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="17">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="ҹ��ʩ�����ӷ�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="yjzjfg" value="<%=StringFormatUtil.format((String)jsgs.get("ҹ��ʩ�����ӷ�")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="yjzjf" value="<%=StringFormatUtil.format((String)gs.get("ҹ��ʩ�����ӷ�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=yjzjf&fy_id=17&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="yjzjfz" value="<%=StringFormatUtil.format((Double)hj.get("ҹ��ʩ�����ӷ�")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">һ</td>
			
			<td>ֱ�ӷ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("ֱ�ӷ�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="35">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="ֱ�ӷ�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="" value="<%=StringFormatUtil.format((String)jsgs.get("ֱ�ӷ�")) %>">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="(һ) + (��)">
			<input type="hidden" id="zjf_h" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)hj.get("ֱ�ӷ�")) %>">
			<td>(һ) + (��)</td>
			<td align="right" id="zjf"><%=StringFormatUtil.format((Double)hj.get("ֱ�ӷ�")) %></td>
			<td align="center">9</td>
			
			<td>���꼾ʩ�����ӷ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("���꼾ʩ�����ӷ�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="18">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���꼾ʩ�����ӷ�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="dyzjfg" value="<%=StringFormatUtil.format((String)jsgs.get("���꼾ʩ�����ӷ�")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="dyzjf" value="<%=StringFormatUtil.format((String)gs.get("���꼾ʩ�����ӷ�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=dyzjf&fy_id=18&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="dyzjfz" value="<%=StringFormatUtil.format((Double)hj.get("���꼾ʩ�����ӷ�")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">(һ)</td>
			
			<td>ֱ�ӹ��̷�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("ֱ�ӹ��̷�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="37">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="ֱ�ӹ��̷�">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="1 + 2 + 3 + 4">
			<input type="hidden" id="zjgcf_h" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)hj.get("ֱ�ӹ��̷�")) %>">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="" value="<%=StringFormatUtil.format((String)jsgs.get("ֱ�ӹ��̷�")) %>">
			<td>1 + 2 + 3 + 4</td>
			<td align="right" id="zjgcf"><%=StringFormatUtil.format((Double)hj.get("ֱ�ӹ��̷�")) %></td>
			<td align="center">10</td>
			
			<td>���������þ�ʹ�÷�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("���������þ�ʹ�÷�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="19">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���������þ�ʹ�÷�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="gjsyfg" value="<%=StringFormatUtil.format((String)jsgs.get("���������þ�ʹ�÷�")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="gjsyf" value="<%=StringFormatUtil.format((String)gs.get("���������þ�ʹ�÷�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=gjsyf&fy_id=19&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="gjsyfz" value="<%=StringFormatUtil.format((Double)hj.get("���������þ�ʹ�÷�")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">1</td>
			
			<td>�˹���</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("�˹���") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="7">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�˹���">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="(1) + (2)">
			<input type="hidden" id="rgf_h" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)hj.get("�˹���")) %>">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="" value="<%=StringFormatUtil.format((String)jsgs.get("�˹���")) %>">
			<td>(1) + (2)</td>
			<td align="right" id="rgf"><%=StringFormatUtil.format((Double)hj.get("�˹���")) %></td>
			<td align="center">11</td>
			
			<td>ʩ����ˮ��������</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("ʩ����ˮ��������") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="20">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="ʩ����ˮ��������">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="sdzqfg" value="<%=StringFormatUtil.format((String)jsgs.get("ʩ����ˮ��������")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="sdzqf" value="<%=StringFormatUtil.format((String)gs.get("ʩ����ˮ��������")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=sdzqf&fy_id=20&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="sdzqfz" value="<%=StringFormatUtil.format((Double)hj.get("ʩ����ˮ��������")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">(1)</td>
			
			<td>������</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("������") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="5">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="������">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="jgfg" value="<%=StringFormatUtil.format((String)jsgs.get("������")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="jgf" value="<%=StringFormatUtil.format((String)gs.get("������")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=jgf&title=������&fy_id=5&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="jgfz" value="<%=StringFormatUtil.format((Double)hj.get("������")) %>" style="text-align:right;" readOnly></td>
			<td align="center">12</td>
			
			<td>�������ʩ�����ӷ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("�������ʩ�����ӷ�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="21">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�������ʩ�����ӷ�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="tsdqzjfg" value="<%=StringFormatUtil.format((String)jsgs.get("�������ʩ�����ӷ�")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="tsdqzjf" value="<%=StringFormatUtil.format((String)gs.get("�������ʩ�����ӷ�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=tsdqzjf&fy_id=21&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="tsdqzjfz" value="<%=StringFormatUtil.format((Double)hj.get("�������ʩ�����ӷ�")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">(2)</td>
			
			<td>�չ���</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("�չ���") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="6">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�չ���">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="pgfg" value="<%=StringFormatUtil.format((String)jsgs.get("�չ���")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="pgf" value="<%=StringFormatUtil.format((String)gs.get("�չ���")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=pgf&title=�չ���&fy_id=6&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="pgfz" value="<%=StringFormatUtil.format((Double)hj.get("�չ���")) %>" style="text-align:right;" readOnly></td>
			<td align="center">13</td>
			
			<td>���깤�̼��豸������</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("���깤�̼��豸������") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="22">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���깤�̼��豸������">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="sbbhfg" value="<%=StringFormatUtil.format((String)jsgs.get("���깤�̼��豸������")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="sbbhf" value="<%=StringFormatUtil.format((String)gs.get("���깤�̼��豸������")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=sbbhf&fy_id=22&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="sbbhfz" value="<%=StringFormatUtil.format((Double)hj.get("���깤�̼��豸������")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">2</td>
			
			<td>���Ϸ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("���Ϸ�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="8">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���Ϸ�">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="(1) + (2)">
			<input type="hidden" id="clf_h" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)hj.get("���Ϸ�")) %>">
			<input type="hidden" id="ggg" value="<%=StringFormatUtil.format((Double)hj.get("���Ϸ�"))%>">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="" value="<%=StringFormatUtil.format((String)jsgs.get("���Ϸ�")) %>">
			<td>(1) + (2)</td>
			<td align="right" id="clf"><%=StringFormatUtil.format((Double)hj.get("���Ϸ�")) %></td>
			<td align="center">14</td>
			
			<td>������</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("������") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="23">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="������">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="ytfg" value="<%=StringFormatUtil.format((String)jsgs.get("������")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="ytf" value="<%=StringFormatUtil.format((String)gs.get("������")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=ytf&fy_id=23&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="ytfz" value="<%=StringFormatUtil.format((Double)hj.get("������")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">(1)</td>
			<td>��Ҫ���Ϸ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("��Ҫ���Ϸ�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="59">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="��Ҫ���Ϸ�">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="�������ķ�">
			<input type="hidden" id="zyclf_h" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)hj.get("��Ҫ���Ϸ�"))) %>">
			<input type="hidden" id="g" value="<%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)hj.get("��Ҫ���Ϸ�"))) %>">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="" value="<%=StringFormatUtil.format((String)jsgs.get("��Ҫ���Ϸ�")) %>">
			<td>�������ķ�</td>
			<td align="right" id="zyclf"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)hj.get("��Ҫ���Ϸ�")))%></td>
			<td align="center">15</td>
			<td>ʩ�������ǲ��</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("ʩ�������ǲ��") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="26">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="ʩ�������ǲ��">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="sgdqfg" value="<%=StringFormatUtil.format((String)jsgs.get("ʩ�������ǲ��")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="sgdqf" value="<%=StringFormatUtil.format((String)gs.get("ʩ�������ǲ��")) %>" readOnly></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="sgdqfz" value="<%=StringFormatUtil.format((Double)hj.get("ʩ�������ǲ��")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">(2)</td>
			<td>�������Ϸ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("�������Ϸ�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="9">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�������Ϸ�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="fzclfg" value="<%=StringFormatUtil.format((String)jsgs.get("�������Ϸ�")) %>">
			<input type="hidden" id="gg" value="<%=StringFormatUtil.format((Double)hj.get("�������Ϸ�"))%>">
			<input type="hidden" name="Gd03_gcfysz.FYZ" id="fzclfz" value="<%=StringFormatUtil.format((Double)hj.get("�������Ϸ�")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="fzclf" value="<%=StringFormatUtil.format((String)gs.get("�������Ϸ�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=fzclf&fy_id=9&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="" id="fzclf_xs" value="<%=StringFormatUtil.format((Double)hj.get("�������Ϸ�")) %>" style="text-align:right;" readOnly></td>
			<td align="center">16</td>
			<td>����ʩ����е��ǲ��</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("����ʩ����е��ǲ��") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="27">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="����ʩ����е��ǲ��">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="jxdqfg" value="<%=StringFormatUtil.format((String)jsgs.get("����ʩ����е��ǲ��")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="jxdqf" value="<%=StringFormatUtil.format((String)gs.get("����ʩ����е��ǲ��")) %>" readOnly></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="jxdqfz" value="<%=StringFormatUtil.format((Double)hj.get("����ʩ����е��ǲ��")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">3</td>
			<td>��еʹ�÷�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("��еʹ�÷�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="52">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="��еʹ�÷�">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="��е̨�൥�� * ��е̨����">
			<input type="hidden" id="jxsyf_h" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)hj.get("��еʹ�÷�")) %>">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="" value="<%=StringFormatUtil.format((String)jsgs.get("��еʹ�÷�")) %>">
			<td>��е̨�൥�� * ��е̨����</td>
			<td align="right" id="jxsyf"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)hj.get("��еʹ�÷�"))) %></td>
			<td align="center">��</td>
			<td>��ӷ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("��ӷ�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="36">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="��ӷ�">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="(һ) + (��)">
			<input type="hidden" id="jjf_h" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)hj.get("��ӷ�")) %>">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="" value="<%=StringFormatUtil.format((String)jsgs.get("��ӷ�")) %>">
			<td>(һ) + (��)</td>
			<td align="right" id="jjf"><%=StringFormatUtil.format((Double)hj.get("��ӷ�")) %></td>
		</tr>
		<tr>
			<td align="center">4</td>
			<td>�����Ǳ�ʹ�÷�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("�����Ǳ�ʹ�÷�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="53">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�����Ǳ�ʹ�÷�">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="�Ǳ�̨�൥�� * �Ǳ�̨����">
			<input type="hidden" id="ybsyf_h" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)hj.get("�����Ǳ�ʹ�÷�")) %>">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="" value="<%=StringFormatUtil.format((String)jsgs.get("�����Ǳ�ʹ�÷�")) %>">
			<td>�Ǳ�̨�൥�� * �Ǳ�̨����</td>
			<td align="right" id="ybsyf"><%=StringFormatUtil.nullstring(NumberFormatUtil.roundToString((Double)hj.get("�����Ǳ�ʹ�÷�"))) %></td>
			<td align="center">(һ)</td>
			<td>���</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("���") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="39">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="1 + 2 + 3 + 4">
			<input type="hidden" id="gf_h" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)hj.get("���")) %>">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="" value="<%=StringFormatUtil.format((String)jsgs.get("���")) %>">
			<td>1 + 2 + 3 + 4</td>
			<td align="right" id="gf"><%=StringFormatUtil.format((Double)hj.get("���")) %></td>
		</tr>
		<tr>
			<td align="center">(��)</td>
			<td>��ʩ��</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("��ʩ��") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="38">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="��ʩ��">
			<input type="hidden" name="Gd03_gcfysz.GSBDS" value="1 + 2 + 3 + ���� + 16">
			<input type="hidden" id="csf_h" name="Gd03_gcfysz.FYZ" value="<%=StringFormatUtil.format((Double)hj.get("��ʩ��")) %>">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="" value="<%=StringFormatUtil.format((String)jsgs.get("��ʩ��")) %>">
			<td>1 + 2 + 3 + ���� + 16</td>
			<td align="right" id="csf"><%=StringFormatUtil.format((Double)hj.get("��ʩ��")) %></td>
			<td align="center">1</td>
			<td>�������۷�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("�������۷�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="28">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�������۷�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="gcpwfg" value="<%=StringFormatUtil.format((String)jsgs.get("�������۷�")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="gcpwf" value="<%=StringFormatUtil.format((String)gs.get("�������۷�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=gcpwf&fy_id=28&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="gcpwfz" value="<%=StringFormatUtil.format((Double)hj.get("�������۷�")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">1</td>
			<td>����������</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("����������") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="10">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="����������">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="hjbhfg" value="<%=StringFormatUtil.format((String)jsgs.get("����������")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="hjbhf" value="<%=StringFormatUtil.format((String)gs.get("����������")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=hjbhf&fy_id=10&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="hjbhfz" value="<%=StringFormatUtil.format((Double)hj.get("����������")) %>" style="text-align:right;" readOnly></td>
			<td align="center">2</td>
			<td>��ᱣ�Ϸ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("��ᱣ�Ϸ�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="29">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="��ᱣ�Ϸ�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="shbzfg" value="<%=StringFormatUtil.format((String)jsgs.get("��ᱣ�Ϸ�")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="shbzf" value="<%=StringFormatUtil.format((String)gs.get("��ᱣ�Ϸ�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=shbzf&fy_id=29&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="shbzfz" value="<%=StringFormatUtil.format((Double)hj.get("��ᱣ�Ϸ�")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">2</td>
			<td>����ʩ����</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("����ʩ����") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="11">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="����ʩ����">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="wmsgfg" value="<%=StringFormatUtil.format((String)jsgs.get("����ʩ����")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="wmsgf" value="<%=StringFormatUtil.format((String)gs.get("����ʩ����")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=wmsgf&fy_id=11&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="wmsgfz" value="<%=StringFormatUtil.format((Double)hj.get("����ʩ����")) %>" style="text-align:right;" readOnly></td>
			<td align="center">3</td>
			<td>ס��������</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("ס��������") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="30">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="ס��������">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="zfgjjg" value="<%=StringFormatUtil.format((String)jsgs.get("ס��������")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="zfgjj" value="<%=StringFormatUtil.format((String)gs.get("ס��������")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=zfgjj&fy_id=30&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="zfgjjz" value="<%=StringFormatUtil.format((Double)hj.get("ס��������")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">3</td>
			<td>�������İ��˷�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("�������İ��˷�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="12">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="�������İ��˷�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="gdqcbyfg" value="<%=StringFormatUtil.format((String)jsgs.get("�������İ��˷�")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="gdqcbyf" value="<%=StringFormatUtil.format((String)gs.get("�������İ��˷�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=gdqcbyf&fy_id=12&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="gdqcbyfz" value="<%=StringFormatUtil.format((Double)hj.get("�������İ��˷�")) %>" style="text-align:right;" readOnly></td>
			<td align="center">4</td>
			<td>Σ����ҵ�����˺����շ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("Σ����ҵ�����˺����շ�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="31">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="Σ����ҵ�����˺����շ�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="bxfg" value="<%=StringFormatUtil.format((String)jsgs.get("Σ����ҵ�����˺����շ�")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="bxf" value="<%=StringFormatUtil.format((String)gs.get("Σ����ҵ�����˺����շ�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=bxf&fy_id=31&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="bxfz" value="<%=StringFormatUtil.format((Double)hj.get("Σ����ҵ�����˺����շ�")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">4</td>
			<td>���̸��ŷ�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("���̸��ŷ�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="13">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���̸��ŷ�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="gcgrfg" value="<%=StringFormatUtil.format((String)jsgs.get("���̸��ŷ�")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="gcgrf" value="<%=StringFormatUtil.format((String)gs.get("���̸��ŷ�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=gcgrf&fy_id=13&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="gcgrfz" value="<%=StringFormatUtil.format((Double)hj.get("���̸��ŷ�")) %>" style="text-align:right;" readOnly></td>
			<td align="center">(��)</td>
			<td>��ҵ�����</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("��ҵ�����") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="32">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="��ҵ�����">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="qyglfg" value="<%=StringFormatUtil.format((String)jsgs.get("��ҵ�����")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="qyglf" value="<%=StringFormatUtil.format((String)gs.get("��ҵ�����")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=qyglf&fy_id=32&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="qyglfz" value="<%=StringFormatUtil.format((Double)hj.get("��ҵ�����")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">5</td>
			<td>���̵㽻�����������</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("���̵㽻�����������")%>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="14">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���̵㽻�����������">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="qlfg" value="<%=StringFormatUtil.format((String)jsgs.get("���̵㽻�����������")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="qlf" value="<%=StringFormatUtil.format((String)gs.get("���̵㽻�����������")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=qlf&fy_id=14&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="qlfz" value="<%=StringFormatUtil.format((Double)hj.get("���̵㽻�����������")) %>" style="text-align:right;" readOnly></td>
			<td align="center">��</td>
			<td>����</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("����") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="33">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="����">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="lrg" value="<%=StringFormatUtil.format((String)jsgs.get("����")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="lr" value="<%=StringFormatUtil.format((String)gs.get("����")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=lr&fy_id=33&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="lrz" value="<%=StringFormatUtil.format((Double)hj.get("����")) %>" style="text-align:right;" readOnly></td>
		</tr>
		<tr>
			<td align="center">6</td>
			<td>��ʱ��ʩ��</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("��ʱ��ʩ����") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="15">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="��ʱ��ʩ����">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="lsssfg" value="<%=StringFormatUtil.format((String)jsgs.get("��ʱ��ʩ����")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="lsssf" value="<%=StringFormatUtil.format((String)gs.get("��ʱ��ʩ����")) %>"  readOnly ></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="lsssfz" value="<%=StringFormatUtil.format((Double)hj.get("��ʱ��ʩ����")) %>"  style="text-align:right;" readOnly></td>
			<td align="center">��</td>
			<td>˰��</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("˰��") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="34">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="˰��">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="sjg" value="<%=StringFormatUtil.format((String)jsgs.get("˰��")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="sj" value="<%=StringFormatUtil.format((String)gs.get("˰��")) %>" style="width:100%;" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=sj&fy_id=34&dxgc_id=<%=dxgc_id %>&zjf='+sjcs('zjf')+'&jjf='+sjcs('jjf')+'&lr='+sjcs('lr')+'&clf='+sjcs('clf'),'600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="sjz" value="<%=StringFormatUtil.format((Double)hj.get("˰��")) %>"  style="text-align:right;" readOnly ></td>
		</tr>
		<tr>
			<td align="center">7</td>
			<td>���̳���ʹ�÷�</td>
			<input type="hidden" name="Gd03_gcfysz.ID" value="<%=fy_id.get("���̳���ʹ�÷�") %>">
			<input type="hidden" name="Gd03_gcfysz.FY_ID" value="16">
			<input type="hidden" name="Gd03_gcfysz.DXGC_ID" value="<%=dxgc_id %>">
			<input type="hidden" name="Gd03_gcfysz.GCXM_ID" value="<%=gcxm_id %>">
			<input type="hidden" name="Gd03_gcfysz.FYMC" value="���̳���ʹ�÷�">
			<input type="hidden" name="Gd03_gcfysz.JSGS" id="clsyfg" value="<%=StringFormatUtil.format((String)jsgs.get("���̳���ʹ�÷�")) %>">
			<td><input type="text" name="Gd03_gcfysz.GSBDS" id="clsyf" value="<%=StringFormatUtil.format((String)gs.get("���̳���ʹ�÷�")) %>" title="˫�����ü��㹫ʽ" readOnly ondblclick="javascript:winOpen('gssz.jsp?id=clsyf&fy_id=16&dxgc_id=<%=dxgc_id %>','600','300','0');"></td>
			<td><input type="text" name="Gd03_gcfysz.FYZ" id="clsyfz" value="<%=StringFormatUtil.format((Double)hj.get("���̳���ʹ�÷�")) %>" style="text-align:right;" readOnly></td><td>��</td>
			<td>��</td>
			<td>��</td>
			<td>��</td>
		</tr>
	</table>
	<br>
</form>
</div>
</body>
<script defer>   
  setbox4_csh("box4");
  SET_WIDTH();
</script>
</html>