<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.dataObject.Gd01_gcxm"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<%@ page import="com.netsky.baseFormatUtils.DateFormatUtil"%>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil"%>
<%@page import="org.hibernate.criterion.MatchMode"%>
<%@ page import="org.hibernate.criterion.Restrictions" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%
           request.setCharacterEncoding("gb2312");
           Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
           if(yh==null)
           {
             %> <script language="javascript"> window.location.href="../index.jsp"; </script> <%
             return;
           }
              String user = yh.getName();
              Integer user_id=yh.getId();
              String searchKey=request.getParameter("searchKey");
	  		  ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	          QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	  		  Gd01_gcxm data;
	  		  QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd01_gcxm.class);
	  		  String gcfl_str=request.getParameter("gcfl_id");
	  		  int gcfl_int=0;
	  		  if(gcfl_str!=null&&!"".equals(gcfl_str))
	  		  {
	  		     gcfl_int=Integer.parseInt(gcfl_str);
	  		     Integer gcfl_integer = new Integer( gcfl_int );
		         queryBuilder.eq("gcfl_id", gcfl_integer);
		         //queryBuilder.like("xmmc",searchKey,MatchMode.ANYWHERE);
		         if(request.getParameter("searchKey") != null)
		         {
		           queryBuilder.addCriterion(Restrictions.or(Restrictions.like("xmmc",searchKey,MatchMode.ANYWHERE),Restrictions.like("xmbh",searchKey,MatchMode.ANYWHERE)));
		         }
	  		  }else{
	  		     queryBuilder.isNull("gcfl_id");
	  		     //queryBuilder.like("xmmc",searchKey,MatchMode.ANYWHERE);
	  		     if(request.getParameter("searchKey") != null)
		         {
		           queryBuilder.addCriterion(Restrictions.or(Restrictions.like("xmmc",searchKey,MatchMode.ANYWHERE),Restrictions.like("xmbh",searchKey,MatchMode.ANYWHERE)));
		         }
	  		  } 
		      //queryBuilder.eq("cjr",user);
		      queryBuilder.eq("cjr_id",user_id);
		      queryBuilder.addOrderBy(Order.desc("cjrq"));
		      int pageNum = 1;
              int pageRowSize = 0;
              if(request.getParameter("pageRowSize") != null&& request.getParameter("pageRowSize").length() > 0)
              {
	              pageRowSize = Integer.parseInt(request.getParameter("pageRowSize"));
              }else{
	              pageRowSize = 18;
              }
              if(request.getParameter("CurrentPage") != null && request.getParameter("CurrentPage").length() > 0)
              {
	              pageNum = Integer.parseInt(request.getParameter("CurrentPage"));
              }
		      ResultObject ro = queryService.searchByPage(queryBuilder,pageNum,pageRowSize);
              int totalRows = ro.getTotalRows();
              int totalPages = ro.getTotalPages();
 %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>工程造价管理系统</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/list.css" rel="stylesheet" type="text/css">
<STYLE>
 .navigator_bg{position:absolute; width:100%; height:1000px; background-color:#234f74; filter:alpha(opacity=40); -moz-opacity:0.4;}
 </STYLE>
<script language="javascript">
 /* 生成页面遮盖的方法 */
 function gernateDivBg(){
         var bg = document.createElement("DIV");
         document.documentElement.style.overflow = "hidden";
         with(bg.style){
                 position = "absolute";
                 top = "0px";
                 left = "0px";
                 width = document.documentElement.scrollWidth;
                 height = document.documentElement.scrollHeight;
         }
         return bg;
 };
 var Mark = new Object();
 Mark.showHintDiv = function(){
         var bg = gernateDivBg();
                 bg.id = Mark.id;
                 bg.className = "navigator_bg";
 
         document.body.appendChild(bg);
         var container = document.getElementById("operate")
         document.body.appendChild(container);
 }
 Mark.close = function(){
         if(document.getElementById(Mark.id)){
                 document.body.removeChild(document.getElementById(Mark.id));
         } 
                
         if(document.getElementById("operate"))
                 document.getElementById("operate").style.display   = 'none';
                 //document.body.removeChild(document.getElementById("operate"));
                 //document.documentElement.style.overflowX= "hidden";
                 //document.documentElement.style.overflowY= "auto";
 };
</script>
<script language="javascript">
  var xmlHttp;
  function createXMLHttpRequest()
  {
    if(window.ActiveXObject){
      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    else{
      xmlHttp=new XMLHttpRequest();
    }
  }
  function openDxgc(gcxm)
  {
    var gcxm_id=gcxm;
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=showDxgc;
    xmlHttp.open("GET","../afuer/ShowDxgcXml?gcxm_id="+gcxm_id);
    xmlHttp.send(null);
  }
  function showDxgc()
  {
    var responseContext;
    if(xmlHttp.readyState==4){
      if(xmlHttp.status==200){
        var doc = new ActiveXObject("MSxml2.DOMDocument")
        doc.loadXML(xmlHttp.responseText);
        result=doc.getElementsByTagName("dxgc");
        responseContext=xmlHttp.responseText;
        var tabObj=document.getElementById("tb_dxgc");
        row_c = tabObj.rows.length;
        var n=1;
        for(n=row_c-1;n>0;n--)
        {
          tabObj.deleteRow(n);
        }
        var i=0;
        for(i=0;i<result.length;i++)
        {
          var dxgc_name=result[i].childNodes[0].childNodes[0].nodeValue;
          var dxgc_Gcxz=result[i].childNodes[1].childNodes[0].nodeValue;
          var dxgc_Zy=result[i].childNodes[2].childNodes[0].nodeValue;
          
          var dxgc_b1hj=result[i].childNodes[3].childNodes[0].nodeValue;
          var dxgc_zgr=result[i].childNodes[4].childNodes[0].nodeValue;
          
          var dxgc_Cjsj=result[i].childNodes[5].childNodes[0].nodeValue;
          var dxgc_Jsjd=result[i].childNodes[6].childNodes[0].nodeValue;
          
          var dxgc_id=result[i].childNodes[7].childNodes[0].nodeValue;
          var gcxm_id=result[i].childNodes[8].childNodes[0].nodeValue;
          add(dxgc_name,dxgc_Gcxz,dxgc_Zy,dxgc_b1hj,dxgc_zgr,dxgc_Cjsj,dxgc_Jsjd,dxgc_id,gcxm_id);
        }
        for(var j=0;j<6-i;j++)
        {
          add("&nbsp;","","","","","","","","");
        }
      }
    }
  }
  
  function add(dxgc_name,dxgc_Gcxz,dxgc_Zy,dxgc_b1hj,dxgc_zgr,dxgc_Cjsj,dxgc_Jsjd,dxgc_id,gcxm_id){
    var tb_dxgc = document.all.tb_dxgc;
    
    var row = tb_dxgc.insertRow();
    var cell01 = row.insertCell();
    var cell02 = row.insertCell();
    var cell03 = row.insertCell();
    var cell04 = row.insertCell();
    var cell05 = row.insertCell();
    var cell06 = row.insertCell();
    var cell07 = row.insertCell();
    cell01.innerHTML = "<a href='projectMain.jsp?gcxm_id="+gcxm_id+"&dxgc_id="+dxgc_id+"' target='_blank'>"+dxgc_name+"</a>";
    cell02.innerHTML = gcxz(nullto(dxgc_Gcxz));
    cell03.innerHTML = nullto(dxgc_Zy);
    cell04.innerHTML = nullto(dxgc_b1hj);
    cell05.innerHTML = nullto(dxgc_zgr);
    cell06.innerHTML = nullto(dxgc_Cjsj);
    cell07.innerHTML = jsjd(nullto(dxgc_Jsjd));
   }
   
  function gcxz(bz)
  {
    var xz="新建";
    if(bz=="")
    {
      xz="";
    }
    if(bz==2)
    {
      xz="全部扩建";
    }
    if(bz==3)
    {
      xz="部分扩建";
    }
    if(bz==4)
    {
      xz="改建";
    }
    if(bz==5)
    {
      xz="恢复";
    }
    if(bz==6)
    {
      xz="迁建";
    }
    return xz;
  }
  
  function jsjd(bz)
  {
    var jd="概算";
    if(bz=="")
    {
      jd="";
    }
    if(bz==2)
    {
      jd="预算";
    }
    if(bz==3)
    {
      jd="结算";
    }
    if(bz==4)
    {
      jd="决算";
    }
    return jd;
  }
   
     //把null和“”的合计费用设为v=0
  function nullto(isnull)
  {
    if(isnull=="null")
    {
        isnull="";
    }
    return isnull;
  }
  
</script>
<script language="javascript">
   function change(el) 
   {
      whichEl = document.getElementById(el)   //获得指定ID值的对象
      if (whichEl.style.display == 'none')
      {   
         whichEl.style.display   = 'block'; //block是默认值为显示,none为隐藏
      }else {
         //whichEl.style.display   = 'none';
      }
}
	function listDxgc(obj){
		var exam = document.getElementById("example");
		var showline =document.getElementById("iff");
		var len = showline.children.length;
		if(exam.style.display=="none"){
		exam.style.display="block";
			for (i=0;i<len;i++){
				showline.children[i].style.borderBottom="solid 1px #ffffff";
			}
		}
		else{ 
		exam.style.display="none";
			for (i=0;i<len;i++){
				showline.children[i].style.borderBottom="solid 1px #a4bec8";
			}		
		}
	}
	
	//删除工程项目
	function gcdel()
	{
	  var bz=0;
	  for(var i=0;i<document.getElementsByName("gcdel_id").length;i++)
	  {
	    if(document.getElementsByName("gcdel_id")[i].checked)
        {
           bz=1;
        }
	  }
	  if(bz==1)
	  {
	    if(confirm('确定要删除项目吗?'))   
        {   
           document.form1.action="../afuer/GcxmDelController?gcfl_id=<%=StringFormatUtil.format(request.getParameter("gcfl_id"))%>&pageRowSize=<%=pageRowSize %>";
	       document.form1.submit();  
        }   
	  }else{
	    alert("请选择要删除的项目");
	  }

	}

function allwinOpen222(URL) {
	var arg = "width=" + new String(screen.width - 10) + ",height=" + new String(screen.height - 80) + ",scrollbars=1,menubar=0,status=yes,resize=1";
	var allpop = window.open(URL,"p_page",arg);
	allpop.moveTo(0,0);
	allpop.focus();
}

</script>
</head>
<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onLoad="iframeAutoFit();" style="height:100%; background:#FFFFFF">
<form name="form1" id="form1" method="post" action="projectList.jsp?gcfl_id=<%=StringFormatUtil.format(request.getParameter("gcfl_id"))  %>&pageRowSize=<%=pageRowSize %>">
<input type="hidden" name="CurrentPage" value="<%=pageNum%>">
<input type="hidden" name="TotalOfPages" value="<%=totalPages%>">
<input type="hidden" name="pageRowSize" value="<%=pageRowSize%>">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="../images/main-images/gypms_main_blue.png" height="30" valign="top" align="right">
		<table width="100%" height="24" border="0" cellpadding="0" cellspacing="0" id="desk_menu">
			<tr>	
				<td width="10"></td>			
				<td>&nbsp;<font id="list_name"> </font></td>
				<td width="95"><a href="javascript:winOpen('copyProject.jsp?gcfl_id=<%=StringFormatUtil.format(request.getParameter("gcfl_id")) %>',750,400,1);"><img src="../images/mb.gif" border="0"/></a></td>
				<td width="60"><a href="javascript:allwinOpen('projectMain.jsp?gcfl_id=<%=StringFormatUtil.format(request.getParameter("gcfl_id")) %>');"><img src="../images/add.gif" border="0"/></a></td>
				<td width="60"><a href="javascript:gcdel();"><img src="../images/del.gif" border="0"/></a></td>
				<td width="10"></td>
				<td width="160" align="right" nowrap >
				<%if("".equals(StringFormatUtil.format(searchKey))) {%>
				<div style="position:absolute;color:white;padding-top:-3px;" onClick="blankit(this,document.form1.searchKey);">&nbsp;在此输入要搜索的信息</div>
				<%} %>
				<input type="text" id="searchKey" name="searchKey" class="input-text" onkeypress="javascript:if(event.keyCode==13) document.form1.submit();" value="<%=StringFormatUtil.format(searchKey) %>">
				</td>
				<td width="60" valign="middle" align="left"><a href="javascript:document.form1.submit();"><img src="../images/search.gif" border="0" alt="搜索"></a></td>
				<td width="40"><a href="javascript:window.location.reload();" title="刷新工作列表"><img src="../images/refresh.gif" border="0"/></a></td>
				<td width="15">&nbsp;</td>
			</tr>
		</table>	
	</td>
  </tr>
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" style=" border-collapse:collapse" id="list">
      <tr height="24">
        <td id="list_title" width="25"></td>
	    <td id="list_title" width="25"></td>
	    <td id="list_title" >项目名称</td>
        <td id="list_title" width="100">项目编号</td>
        <td id="list_title" width="100">创建日期</td>
        <td id="list_title" width="100">单项工程数</td>
        <td id="list_title" width="30"></td>
        <td id="list_title" width="30"></td>
      </tr>
      		  <%
		      int n=1;
		      while(ro.next()){
		      data = (Gd01_gcxm) ro.get(Gd01_gcxm.class.getName());
		      if(data!=null){
	  		  %>
      <tr id="iff" onMouseOver="this.style.backgroundColor='#edf3f5'" onMouseOut="this.style.backgroundColor=''">
        <td><input type="checkbox" id="gcdel_id" name="gcdel_id" value="<%=data.getId()%>"></td>
		<td align="center"><%=n++ %></td>
		<td><a href="#" onclick="allwinOpen222('projectMain.jsp?gcxm_id=<%=data.getId() %>')"><%=StringFormatUtil.format(data.getXmmc()) %></a></td>
		<td align="left"><%=StringFormatUtil.format(data.getXmbh()) %></td>
		<td><%=DateFormatUtil.Format(data.getCjrq(),"yyyy-MM-dd HH:mm")%></td>
		<td align="center">
		<a href="javascript:change('operate');openDxgc('<%=data.getId()%>');Mark.showHintDiv();"  title="查看单项工程">
		<%
		   //QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd02_dxgc.class);
		   //queryBuilder1.eq("gcxm_id", data.getId());
		   //ResultObject ro1 = queryService.search(queryBuilder1);
		   String gcxm_id = data.getId().toString();
		   String HSql4="select gd02,ga06,gd03_b1hj,gd03_zgr from Gd02_dxgc gd02,Ga06_zy ga06,Gd03_gcfysz gd03_b1hj,Gd03_gcfysz gd03_zgr where ga06.id=gd02.zy_id and gd02.id=gd03_b1hj.dxgc_id and gd03_b1hj.fymc='工程总费用' and gd02.id=gd03_zgr.dxgc_id and gd03_zgr.fymc='总工日' and gd02.gcxm_id='"+gcxm_id+"'";
		   ResultObject ro1 = queryService.search(HSql4);
		   int m=0;
		   while(ro1.next())
		   {
		     m++;
		   }
		   out.println(m);
		 %>
		</a></td>
		<td><a href="javascript:allwinOpen('projectMain.jsp?gcxm_id=<%=gcxm_id %>');" title="浏览所属单项工程"><img src="../images/new_p.gif" border="0"></a></td>
		<td><a href="javascript:winOpen('../print/ProjectPrint.jsp?gcxm_id=<%=gcxm_id%>'
					,'580','450','0')" title="表格输出"><img src="../images/print.gif" border="0"></a></td>
	  </tr>
	  <%}}%>
	  
	  <tr id="example" style="display:none;">
		<td>&nbsp;</td>
	  	<td colspan="5" align="center" style="background:#f2f7f9;color:">

	  		<table id="tb_dxgc1" name="tb_dxgc1" width="98%" border="0" cellspacing="0" cellpadding="2" style="margin:5px;border-collapse:collapse;">
	  		
	  			<tr>
	  				<td align="center">工程名称</td>
	  				<td width="70" align="center">工程性质</td>
	  				<td width="150" align="center">专业类别</td>
	  				<td width="70" align="center">工程总投资</td>
	  				<td width="50" align="center">总工日</td>
	  				<td width="100" align="center">创建日期</td>
	  				<td width="80" align="center">建设阶段</td>
	  			</tr>
	  		</table>
	  	
	  	</td>
	  </tr>
      <%
      for(int i=1; i<pageRowSize-n+2; i++){
      %>
	  <tr>
	    <td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	  </tr>
	  <%}%>
    </table></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="38" bgcolor="#dce8ec"><table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td>&nbsp;</td>
          <td align="center" style="color:#2C4866"><span>共 <b><%=totalPages%></b> 页&nbsp;<b><%=totalRows%></b>&nbsp;条记录&nbsp;</span></td>
          <td style="color:#2C4866">&nbsp;</td>
          <td align="right" style="color:#2C4866">
             <a href="javascript:pageUp(document.all.form1)" title="上一页"><img src="../images/main-images/back.png" width="41" height="12" border="0"></a>
             <a href="javascript:pageDown(document.all.form1)" title="下一页"><img src="../images/main-images/next.png" width="41" height="12" border="0"></a>
            &nbsp;第<b><%=pageNum%></b>页&nbsp;
            <input type="text" name="selectPage" size="3" style="font-size: 10px" class="input-text">
            <a href="javascript:setPage();">go</a></td>
          <td align="right" style="color:#2C4866">&nbsp;</td>
        </tr>
    </table></td>
  </tr>
</table>
</div>
<div id="operate" style="display:none;background:#f2f7f9;color:;margin:5px;border-collapse:collapse;LIFT: 1000px; WIDTH: 97%; POSITION: absolute; TOP: 258px; HEIGHT: 260px; left: 10px;OVERFLOW-y:auto;">
	  <table id="tb_dxgc" name="tb_dxgc" width="99%" border="1" cellspacing="0" cellpadding="2" style="margin:5px;border-collapse:collapse;">
	  			<tr>
	  				<td align="center">工程名称</td>
	  				<td width="70" align="center">工程性质</td>
	  				<td width="150" align="center">专业类别</td>
	  				<td width="70" align="center">工程总投资</td>
	  				<td width="50" align="center">总工日</td>
	  				<td width="100" align="center">创建日期</td>
	  				<td width="80" align="center">建设阶段</td>
	  			</tr>
	  		</table>
	  	    <table width="98%">
	  			<tr>
	  				<td align="center"><a href='javascript:Mark.close();'>关闭</a></td>
	  			</tr>
	  		</table>
	  		
	  </div>
</form>
	
	  
</body>
</html>