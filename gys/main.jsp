<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.dataObject.Gb04_gcfl"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@page import="com.netsky.dataObject.Gb01_yhb"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%
	ServletContext a = session.getServletContext();
	Map onlineUserList = (Map) a.getAttribute("onlineUserList");
Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
if(yh==null){
	%> <script language="javascript"> window.location.href="index.jsp"; </script> <%
	return;
}
 %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>通信工程造价管理系统</title>
<link href="css/main.css" rel="stylesheet" type="text/css">
<base target="right"/>
<script language="JavaScript">
	/************************
	//定义浏览器的可见区域
	************************/
	var cur_client_width = null;
	var cur_client_height = null;
	
	var listNum = 18;
	
	/************************
	//设置客户端浏览器的属性
	************************/
	function setClientAttribute() {
		//cur_client_height = parent.document.body.clientHeight;
		cur_client_height = right.document.body.clientHeight;
		
		cur_client_width = parent.document.body.clientWidth;
		
		listNum = String(parseInt(String((cur_client_height - 115)/25),10));
		
		//设置框架页面
		right.location.href = "dataManage/projectList.jsp?pageRowSize=" + listNum;
		
		//设置页面所有链接
		var obj = document.getElementsByTagName("a");
		for(var i=0;i<obj.length;i++) {
			var temp = obj[i].href;
			var temp1 = temp.substring(temp.length-1,temp.length);
			var temp2 = temp.indexOf("?");
			if(temp1 != '/' && temp.indexOf("javascript") == -1) {
				if(temp2 == -1){
					obj[i].href = obj[i].href + "?pageRowSize=" + listNum;
				}else{
					obj[i].href = obj[i].href + "&pageRowSize=" + listNum;
				}
			}
		}
	}
	//切换菜单
	function setCard(n){
		for(var i=1; i<4; i++){
			var obj = document.getElementById("menu"+i);
			if( i==n )obj.style.display = "block";
			else obj.style.display = "none";
		}
	}
	
	function loginOut(){
		//window.location.href = "http:///gypms/logout.jsp";
		<%//=request.getRequestURL().substring(7,request.getRequestURL().length()-16)%>
		//window.location.href='../bbs/txzjweb.jsp';
		window.location.href='../logout.jsp';
		/*
		window.open('/gypms/logout.jsp','_blank','');
		parent.close();
		*/
	} 
	function allwinOpen(URL) {
		var arg = "width=" + new String(screen.width - 10) + ",height=" + new String(screen.height - 80) + ",scrollbars=1,menubar=0,status=yes,resize=1";
		var allpop = window.open(URL,"_blank",arg);
		allpop.moveTo(0,0);
		allpop.focus();
	}
</script>
</head>
<body topmargin="1" leftmargin="0" bottommargin="0" rightmargin="0" onbeforeunload="return '[ 当前用户：<netsky:userInfo type='name'/> ]';" onLoad="setClientAttribute();" id="main-body">
<div align="center">
  <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="background:url(images/main-images/wave.png) no-repeat right top">
    <tr>
      <td width="14" valign="top">&nbsp;</td>
      <td width="196" valign="top"><table width="196" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="92" background="images/main-images/gypms_main_logo.png">&nbsp;</td>
        </tr>
        <tr>
          <td height="4" background="images/main-images/gypms_main_menu_top.png" style="border-right:solid 1px #a4bec8"></td>
        </tr>
        <tr>
          <td style="border-right:solid 1px #a4bec8"><div>
            <table width="196" border="0" align="center" cellPadding="0" cellSpacing="0" id="mainmenutable">
            	<tr>
                  <td valign="top">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td height="45" align="center" background="images/main-images/gypms_main_menubg1.png" style="cursor:hand;" onclick="javascript:setCard(1);">                       
                        	<table width="150" border="0" cellPadding="0" cellSpacing="0">
                        		<tr>
                        			<td width="20"><img src="images/main-images/gypms_main_menuicon.gif" border="0"></td>
                        			<td width="5"></td>
                        			<td id="main-title">工程造价管理</td>
                        			<td width="20"></td>
                        		</tr>
                        	</table>
                        </td>
                      </tr>
					  <tbody id="menu1" style="display:block;">
					  	<tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							<span style="font-family: Webdings;">4</span><a href="dataManage/projectList.jsp?gcfl_id=">未分类项目</a>
						</td>
					  </tr>
		  <%
              String user = yh.getName();
              Integer user_id = yh.getId();
	  		  ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	          QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	  		  Gb04_gcfl data;
	  		  //QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb04_gcfl.class);
	  		  String HSql="select gb04 from Gb04_gcfl gb04,Gb01_yhb gb01 where gb04.czy_id=gb01.id and gb01.id='"+user_id+"' order by gb04.id asc";
		      //queryBuilder.eq("id", 1);
		      //queryBuilder.eq("passwd", "pass");
		      ResultObject ro = queryService.search(HSql);
		      int i=0;
		      while(ro.next()){
		      data = (Gb04_gcfl) ro.get("gb04");
			  if(data!=null){ 
			  i++;
	  		  %>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							<span style="font-family: Webdings;">4</span><a href="dataManage/projectList.jsp?gcfl_id=<%=data.getId() %>"><%=data.getMc()%></a>
						</td>
					  </tr>
			 <%} }
			 for(int n=0;n<9-i;n++)
			 {
			 %>				  
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							
						</td>
					  </tr>
			<%} %>
					 </tbody>
					  
                      <tr>
                        <td height="45" align="center" background="images/main-images/gypms_main_menubg1.png" style="cursor:hand;" onclick="javascript:setCard(2);">                       
                        	<table width="150" border="0" cellPadding="0" cellSpacing="0">
                        		<tr>
                        			<td width="20"><img src="images/main-images/gypms_main_menuicon.gif" border="0"></td>
                        			<td width="5"></td>
                        			<td id="main-title">基础数据维护</td>
                         			<td width="20"></td>
                        		</tr>
                        	</table>
                        </td>
                      </tr>
					  <tbody id="menu2" style="display:none;">
					  <%
					      if(yh.getRole().intValue()==0){
					  %>
					  <tr style="padding-left:25px">
					    <td height="30" background="images/main-images/gypms_main_menubg2.png">
					    	<span style="font-family: Webdings;">4</span><a href="system/userclwh.jsp">基础库维护</a>
					    </td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							<span style="font-family: Webdings;">4</span><a href="system/qfqjwh.jsp">取费区间维护</a>
						</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							<span style="font-family: Webdings;">4</span><a href="system/flwh/flkwh.jsp">系统费率维护</a>
						</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							<span style="font-family: Webdings;">4</span><a href="system/unitwh.jsp">计量单位维护</a>
						</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							<span style="font-family: Webdings;">4</span><a href="system/xskwh.jsp">拆扩更系数维护</a>
						</td>
					  </tr>
					  <tr style="padding-left:25px">
					  	<td height="30" background="images/main-images/gypms_main_menubg2.png">
					  		<span style="font-family: Webdings;">4</span><a href="system/userwh.jsp">用户维护</a>
					  	</td>
					  </tr>
					  <%} %>
					  <tr style="padding-left:25px">
					  	<td height="30" background="images/main-images/gypms_main_menubg2.png">
					  	    <span style="font-family: Webdings;">4</span><a href="system/fenleiwh.jsp">项目分类维护</a>
					  	</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							<span style="font-family: Webdings;">4</span><a href="javascript:winOpen('../system/personalInfo.jsp','380','180','0')">用户密码修改</a>
						</td>
					  </tr>
					  
					  </tbody>
                      <tr>
                        <td height="45" align="center" background="images/main-images/gypms_main_menubg1.png" style="cursor:hand;" onclick="javascript:setCard(3);">                       
                        	<table width="150" border="0" cellPadding="0" cellSpacing="0">
                        		<tr>
                        			<td width="20"><img src="images/main-images/gypms_main_menuicon.gif" border="0"></td>
                        			<td width="5"></td>
                        			<td id="main-title">数据查询功能</td>
                        			<td width="20"></td>
                        		</tr>
                        	</table>
                        </td>
                      </tr>
                      <tbody id="menu3" style="display:none;">
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							<span style="font-family: Webdings;">4</span><a href="javascript:allwinOpen('../dataSearch/decx.jsp')">通信定额查询</a>
						</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							<span style="font-family: Webdings;">4</span><a href="javascript:allwinOpen('../dataSearch/searchMaterial.jsp')">通信器材查询</a>
						</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							<span style="font-family: Webdings;">4</span><a href="javascript:allwinOpen('../dataSearch/projectStat.jsp')">项目汇总查询</a>
						</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							<span style="font-family: Webdings;">4</span><a href="javascript:allwinOpen('../dataSearch/userStat.jsp')">使用情况查询</a>
						</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							
						</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							
						</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							
						</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							
						</td>
					  </tr>					  
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							
						</td>
					  </tr>
					  <tr style="padding-left:25px">
						<td height="30" background="images/main-images/gypms_main_menubg2.png">
							
						</td>
					  </tr>
					  </tbody>
                  </table></td>
                </tr>
            </table>
          </div></td>
        </tr>
        <tr>
          <td height="7" background="images/main-images/gypms_main_menu_bottom.gif" style="border-right:solid 1px #a4bec8"></td>
        </tr>
        <tr>
          <td height="6"></td>
        </tr>
        <tr>
        	<td height="20" style="background:url(images/main-images/msg_top.gif) no-repeat"></td>
        </tr>
        <tr>
          <td align="center" valign="middle" style="background:url(images/main-images/msg_bg.gif) repeat-y">
          <table width="150" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="22" align="center" valign="bottom">您好,<%=user %>。&nbsp;<a href="javascript:parent.loginOut();">[注销]</a></td>
            </tr>
             <!-- <tr>
            	<td height="22" align="center" valign="bottom"><a href="bbs/index.jsp" target="_blank">进入概预算论坛</a></td>
            </tr>
            
             <tr>
              <td height="21" align="center"></td>
              <td>&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;<a href="javascript:winOpen('../dataManage/export.jsp','400','500','1')">备份项目</a>
              &nbsp;&nbsp;<a href="javascript:winOpen('../dataManage/import.jsp','400','500','1')">导入项目</a> 
              </td>
            </tr>
            -->         
            </table>
          </td>
        </tr>
        <tr>
        	<td height="20" style="background:url(images/main-images/msg_bottom.gif) no-repeat"></td>
        </tr>        
      </table></td>
      <td valign="top">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td height="26">&nbsp;</td>
        </tr>
        <tr>
          <td height="40"><table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10"><img src="images/main-images/gypms_main_bar_left.gif" width="10" height="40"></td>
              <td background="images/main-images/gypms_main_bar_bg.gif">&nbsp;</td>
              <td width="240" align="right" valign="middle" background="images/main-images/gypms_main_bar_bg.gif">
              &nbsp;<div>当前日期：<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>&nbsp;&nbsp;&nbsp;&nbsp;<em></em>在线人数：<em style="color:red;"><%if(a.getAttribute("totalSessions")!=null){out.print((Integer) a.getAttribute("totalSessions"));}else{out.print("0");}%></em> &nbsp;&nbsp;&nbsp;</div>
              </td>              
              <td width="10"><img src="images/main-images/gypms_main_bar_right.gif" width="10" height="40"></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td valign="top"><iframe id="right" name='right' frameborder=0 marginheight=0 marginwidth=0 src='' scrolling="no" border='0' style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1"> </iframe></td>
        </tr>
      </table></td>
      <td width="14" valign="top">&nbsp;</td>
    </tr>
  </table>
</div>
</body>
</html>
