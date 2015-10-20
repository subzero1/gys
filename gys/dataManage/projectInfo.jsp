 <%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Gd01_gcxm"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.dataObject.Gb04_gcfl"%>
<%@ page import="com.netsky.dataObject.Gb03_bgxx"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<%@ page import="com.netsky.baseFormatUtils.DateFormatUtil"%>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil;"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>项目综合信息</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/data.css" rel="stylesheet" type="text/css">
<base target="data"/>
<style>
#bt{
	background-color:#f2f7f9;
	margin-left: 10;
	color:#000000;
}
</style>

</head>
<script language="javascript">
  var xmlHttp;
  function createXMLHttpRequest()
  {
    if(window.ActiveXObject)
    {
      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    else{
      xmlHttp=new XMLHttpRequest();
    }
  }
  
  function updateD1()
  {
    var gd02_id=document.all.D1.value;

    var gd01_id=document.getElementsByName("Gd01_gcxm.ID")[0].value

    if(gd02_id==0)
    {
        var tabObj=document.getElementById("bgxx");
        row_c = tabObj.rows.length;
        for(var n=row_c-1;n>1;n--)
        {
          tabObj.deleteRow(n);
        }
        add("项目信息设置","xmxx.jsp?gcxm_id="+gd01_id);
        add("综合信息设置","zhxx.jsp?gcxm_id="+gd01_id);   
        if(gd01_id!=null)
        {
          add("建设项目汇总表","hzb.jsp?startPage=1&gcxm_id="+gd01_id);
        }
    }else{
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=showBg;
    xmlHttp.open("GET","../afuer/ShowBgXml?gd02_id="+gd02_id);
    xmlHttp.send(null);
    }
  }
  
  function xinjian()
  {
    var obj=document.all.D1;
    var xj=obj.options;
    xj[0].selected = true;
    updateD1();
    openzhxx();
  }
  
  function showBg()
  {
    var gd02_id=document.all.D1.value;
    if(xmlHttp.readyState==4){
      if(xmlHttp.status==200){
        var doc = new ActiveXObject("MSxml2.DOMDocument")
        doc.loadXML(xmlHttp.responseText);
        result=doc.getElementsByTagName("bgxx");
        var tabObj=document.getElementById("bgxx");
        row_c = tabObj.rows.length;
        var n=1;
        for(n=row_c-1;n>1;n--)
        {
          tabObj.deleteRow(n);
        }
        add("项目信息设置","xmxx.jsp?dxgc_id="+gd02_id+"&gcxm_id=<%=request.getParameter("gcxm_id")%>");
        add("综合信息设置","zhxx.jsp?dxgc_id="+gd02_id+"&gcxm_id=<%=request.getParameter("gcxm_id")%>");
        if("<%=request.getParameter("gcxm_id")%>"!=null)
        {
          add("建设项目汇总表","hzb.jsp?startPage=1&dxgc_id="+gd02_id+"&gcxm_id=<%=request.getParameter("gcxm_id")%>");
        } 
        for(var i=0;i<result.length;i++)
        {
          var bgxx_name=result[i].childNodes[0].childNodes[0].nodeValue;
          var bgxx_url=result[i].childNodes[1].childNodes[0].nodeValue;
          add(bgxx_name,bgxx_url+"&dxgc_id="+gd02_id+"&gcxm_id=<%=StringFormatUtil.format(request.getParameter("gcxm_id"))%>");
        }
      }
    }
  }
  
  function add(bgxx_name,bgxx_url){
    var tb_bgxx = document.all.bgxx;
    var row = tb_bgxx.insertRow();
    var cell01 = row.insertCell();
    cell01.innerHTML = "&nbsp;<img border='0' src='../images/icon.gif'>&nbsp;<a href='"+bgxx_url+"'>"+bgxx_name+"</a>";
    cell01.id="bt";
   }
  
  function openzhxx()
  {
    var d=document.all.D1.value;
    var gd01_id=document.getElementsByName("Gd01_gcxm.ID")[0].value;
    if(d==0)
    {
      window.top.data.location='zhxx.jsp?gcxm_id='+gd01_id;
    }else if(d == -1){
    	winOpen('copyProject.jsp?gcxm_id='+gd01_id,750,400,1);
    }
    else
    {
      window.top.data.location='zhxx.jsp?dxgc_id='+d+'&gcxm_id='+gd01_id;
    }
  }
</script>

<body topmargin="0" rightmargin="0" id="main-body" style="overflow-x:hidden;overflow-y:auto">
<form name="form1" method="post" action="">
<div align="right" style="width:100%">
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;" width="100%">
		<tr>
			<td height="45"><img src="../images/main-images/gys_project_logo.png" border="0"></td>
		</tr>	
	        <tr>
	          	<td colspan="2" height="4" background="../images/main-images/gypms_main_menu_top.png"></td>
	        </tr>	
		<tr>
			<td bgcolor="#c7dbe0" colspan="2" align="left">
					<table width="100%" border="0" cellpadding="0" style="border-collapse: collapse;background:#c7dbe0 url(../images/main-images/menu_bg.png) repeat-y;" cellspacing="0">
		<%
		                    Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
		                    if(yh==null)
                            {
                               %> <script language="javascript"> window.location.href="../index.jsp"; </script> <%
                                return;
                            }
                            String user = yh.getName();
							String gcxm_id=request.getParameter("gcxm_id");
							if("".equals(gcxm_id))
							{
							  gcxm_id=null;
							}
							String dxgc_id=request.getParameter("dxgc_id");
							if("".equals(dxgc_id))
							{
							  dxgc_id=null;
							}
							
							String gcfl_id=request.getParameter("gcfl_id");
	  		                ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	                        QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	  		                String HSql1="select gd01 from Gd01_gcxm gd01 where gd01.id="+gcxm_id;
	  		                ResultObject ro1 = queryService.search(HSql1);
	  		                Gd01_gcxm gd01=null;
	  		                String xmbh="";
	  		                String xmmc="";
	  		                String xmsm="";
	  		                String cjr="";
	  		                String cjrq="";
	  		                //int Gcfl_id=0;
	  		                if(ro1.next())
	  		                {
	  		                   gd01=(Gd01_gcxm)ro1.get("gd01");
	  		                   xmbh=gd01.getXmbh();
	  		                   xmmc=gd01.getXmmc();
	  		                   xmsm=gd01.getXmsm();
	  		                   cjr=gd01.getCjr();
	  		                   cjrq=DateFormatUtil.Format(gd01.getCjrq(),"yyyy-MM-dd");
	  		                   //Gcfl_id=gd01.getGcfl_id().intValue();
	  		                }
		 %>
		 				<input type="hidden" name="Gd01_gcxm.ID" value="<%=StringFormatUtil.format(gcxm_id)%>">
						<tr>
							<td height="45" align="center" style="background:url(../images/main-images/gypms_menubg.png) left middle no-repeat">
	                        	<table border="0" cellPadding="0" cellSpacing="0">
	                        		<tr>
	                        			<td width="20"><img src="../images/main-images/gypms_main_menuicon.gif" border="0"></td>
	                        			<td width="10"></td>
	                        			<td id="main-title">项目信息</td>
	                        			<td width="20"></td>
	                        		</tr>
	                        	</table>
							</td>
						</tr>
						<tr>
							<td  align="center" style="padding:5px 2px;">
								<table border="0" cellpadding="2" cellspacing="0" style="width:99%;">								 
								  <%
								  if(xmmc!=null&&!"".equals(xmmc)){%>					
								  <tr>
						
									<td height="25" style="padding-left:10px;font-size:12px;font-weight:bold;">
										<%=StringFormatUtil.format(xmmc) %>
									</td>
								  </tr>		
								  <%} %>											
								</table>
							</td>
						</tr>	
					</table>
				</td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF" colspan="2" align="center" style="background:#c7dbe0 url(../images/main-images/menu_bg.png) repeat-y;">
					<table border="0" id="bgxx" name="bgxx" cellpadding="2" style="border-collapse: collapse" width="95%" cellspacing="1">
						<tr>
							
						</tr>
						<tr>
							<td height="5"></td>
						</tr>
						<%
						         String cz="dxgc_id="+StringFormatUtil.format(dxgc_id)+"&gcxm_id="+StringFormatUtil.format(gcxm_id)+"&gcfl_id="+StringFormatUtil.format(gcfl_id);
                                 if(dxgc_id==null&&gcxm_id==null)
                                 {
                                   cz="gcfl_id="+StringFormatUtil.format(gcfl_id);
                                 }
						 %>
						  
						<tr>
							<td id="bt">&nbsp;<img border="0" src="../images/icon.gif">&nbsp;<a href="zhxx.jsp?<%=cz %>">综合信息设置</a></td>
						</tr>
						<%
						if(gcxm_id!=null)
                        {
                        	if(yh.getOperate()!=null&&yh.getOperate().intValue()==1){
                            %>
                            <tr>
							<td id="bt">&nbsp;<img border="0" src="../images/icon.gif">&nbsp;<a href="hzb.jsp?startPage=1&<%=cz %>">建设项目汇总表</a></td>
						    </tr>
                            <%}
                        }
						 %>
						
						<%				   
						    String HSql3="select gd02 from Gd02_dxgc gd02 where gd02.id ="+dxgc_id;
	  		                ResultObject ro3 = queryService.search(HSql3);
	  		                Gd02_dxgc gd02=null;
	  		                String bgxd="00";
		                    if(ro3.next()){
		                       gd02=(Gd02_dxgc)ro3.get("gd02");
		                       bgxd=gd02.getBgxd();
		                    }
		                    //String HSql4="select gb03 from Gb03_bgxx gb03 where sxh in ("+bgxd+")";
		                    String HSql4="select gb03 from Gb03_bgxx gb03 where id in ("+bgxd+") order by sxh asc";
		                    ResultObject ro4 = queryService.search(HSql4);
		                    while(ro4.next())
		                    {
		                         Gb03_bgxx gb03=null;
		                         gb03=(Gb03_bgxx)ro4.get("gb03");
                                 String mc=gb03.getFbt();
                                 if(mc==null||"".equals(mc))
                                 {
            	                    mc=gb03.getMc();
                                 }
						 %>
						<tr>
							<td id="bt">&nbsp;<img border="0" src="../images/icon.gif">&nbsp;<a href="<%=gb03.getBdwj() %>&dxgc_id=<%=dxgc_id %>&gcxm_id=<%=gcxm_id %>"><%=mc %></a></td>
						</tr>
						<%} %>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center" style="background:#c7dbe0 url(../images/main-images/menu_bg.png) repeat-y;">
					<table width="98%" border="0" cellpadding="0" style="border-collapse: collapse;" cellspacing="2">
						<br/>
						<tr>
							<td colspan="2" height="20" align="center"><input type="button" name="pss" class="td-input" onclick="javascript:parent.window.close();" value="返回到PSS系统"></td>
						</tr>
						<tr>
							<td colspan="2" height="5">.</td>
						</tr>
					</table>
				</td>
			</tr>

		</table>
</div>
</form>
</body>
</html>