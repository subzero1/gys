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
<%@page import="com.netsky.baseFormatUtils.StringFormatUtil;"%>
<html>

<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<title>通信工程造价管理系统</title>
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function window.onbeforeunload(){
	opener.focus();
}
</script>
<script laguage="javascript">
<!--
	if(self!=top){top.location=self.location;}
	imgl="<IMG src='../images/al.gif' border=0>"
	imgr="<IMG src='../images/ar.gif' border=0>"
	function switchSysBar(){
		if (hidden.innerText==3){
			hidden.innerText=4
			switchPoint.innerHTML=imgl
			document.all("frmTitle").style.display="none"
		}else{
			hidden.innerText=3
			switchPoint.innerHTML=imgr
			document.all("frmTitle").style.display=""
		}
	}
-->
</script>
<style>
.navPoint {
	cursor: hand; 
	background:url("../images/ar.gif");
}
</style>
</head>
<%
   String dxgc_id=request.getParameter("dxgc_id");
   String gcxm_id=request.getParameter("gcxm_id");
   
   String strSql="";
   
   if(gcxm_id!=null||"".equals(gcxm_id)){
   if(dxgc_id==null||"".equals(dxgc_id))
   {
      Gd02_dxgc gb02=null;
      ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
      QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	  String HSql="select gb02 from Gd02_dxgc gb02 where gb02.gcxm_id="+gcxm_id+" order by cjsj desc";
	  ResultObject ro = queryService.search(HSql);
      
      if(ro.next())
      {
          gb02=(Gd02_dxgc)ro.get("gb02");
          if(gb02.getId()!=null)
          {
            dxgc_id=gb02.getId().toString();
          }  
      }else
      {
          gb02=new Gd02_dxgc();
      }
   }
   strSql="?gcxm_id="+StringFormatUtil.format(gcxm_id) +"&dxgc_id="+StringFormatUtil.format(dxgc_id)+"&gcfl_id="+StringFormatUtil.format(request.getParameter("gcfl_id"));
   }else{
   //dxgc_id="0";
   //gcxm_id="0";
   strSql="?gcfl_id="+request.getParameter("gcfl_id");
   }
 %>
<body style="MARGIN: 0px;height:100%" scroll="no"  id="main-body">
<table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
  <tr>
    <td align="middle" id="frmTitle" nowrap valign="center" name="frmTitle">
      <iframe frameBorder="0" id="left" name="left" scrolling=auto src="projectInfo.jsp<%=strSql%>" style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 270px; Z-INDEX: 2">
      </iframe>
    </td>
    <td>
      <table border="0" cellpadding="0" cellspacing="0" height="100%">
      	<tr>
      		<td height="45"></td>
      	</tr>
        <tr>
          <td style="text-aling:center;vertical-align:middle;background:url('../images/ab.gif');">
	          <div style="display:none" id="hidden">3</div>
	          <div style="position:absolute;width:12px;">
<span class="navPoint" id="switchPoint" title="关闭/打开左栏" style="height:122px;width:12" onClick="switchSysBar()"><IMG src="../images/ar.gif" border=0></span>
	          </div>
	          <br>
	          <br>
	          <div style="height:140px;"></div><font style="font-size:3px;">&nbsp;</font>
          </td>
        </tr>
      </table>
    </td>
    <td style="WIDTH: 100%" bgcolor="#ffffff">
      <iframe frameBorder="0" id="data" name="data" scrolling="yes" src="zhxx.jsp<%=strSql%>" style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1;background:#ffffff">
      </iframe>
    </td>
  </tr>
</table>

</body>


</html>
<script>//if (window.screen.width<'1024'){switchSysBar()}</script>
