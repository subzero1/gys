<%@ page contentType="text/html; charset=GBK"%>
<%@   page   import="java.sql.*"%>  
<%@   page   import="java.util.*"%> 
<%@   page   import="java.text.*"%>    

<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ͨ�Ź�����۹���ϵͳ(�����)</title>
<script language="javascript" src="js/functionlib.js"></script>
<LINK href="css/main.css" rel=stylesheet>
<script language="javascript">
function logchk_onsubmit() {
	document.form1.action="afuer/LoginController";
	var f = document.getElementById("form1");
  
	if (document.form1.loginID.value=="")
	{
	  alert("�������û�����")
	  document.form1.loginID.focus()
	  return false
	 }	 
	if (document.form1.password.value=="")
	{
	  alert("���������룡")
	  document.form1.password.focus()
	  return false
	}
	var arg = "width=" + new String(screen.width - 10) + ",height=" + new String(screen.height - 80) + ",scrollbars=1,menubar=0,status=yes,resize=1";
	var pop = window.open('','gys_main',arg);
	pop.moveTo(0,0);
	document.form1.target="gys_main";
	closeWin();
}

function loadfocus()
{
	window.name="login";
	document.form1.loginID.focus();
}
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
<!--
var isn1=null;
var isn2=false;
today=new Date();
function stopit()
{
if(isn2)
{
clearTimeout(isn1);
}
isn2=false;
}
function startit()
{
stopit();
isnclock();
}
function isnclock()
{
var now=new Date();
var hrs=now.getHours();
var min=now.getMinutes();
var sec=now.getSeconds();
//document.clckh.disp1.value=hrs;
//document.clckh.disp2.value=((min<10)?"0":"")+min;
//document.clckh.disp3.value=((sec<10)?"0":"")+sec;
isn1=setTimeout("isnclock()",1000);
isn2=true;
}
function isnArray()
{
argnr=isnArray.arguments.length
for(var i=0;
i<argnr;
i++)
{
this[i+1]=isnArray.arguments[i];
}
}

var isnMonths=new isnArray("1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��");
var isnDays=new isnArray("����һ","���ڶ�","������","������","������","������","������");isnDays[0]="������";
//-->

</script>
<style type="text/css">
<!--
.timetext{
	border: 1px solid #FFFFFF;
	FILTER: Alpha(opacity=50);
	text-align: center;
}
.STYLE1 {
	font-size: 14px;
	font-weight: bold;
	color: #005F37;
}
.input-1 {
	border-left: 1px solid #43637F;
	border-top: 1px solid #43637F;
	border-bottom: 1px solid #FFFFFF;
	border-right: 1px solid #FFFFFF;
	color: #B27B1B
	height: 18px;
	width : 160px;
}
-->
</style>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadfocus();startit()" oncontextmenu="return false;">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#3B98DC">&nbsp;</td>
  </tr>
  <tr>
    <td height="494" background="images/index-images/gypms_index_bg.png"><table width="100%" height="413" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td rowspan="5">&nbsp;</td>
        <td width="580" height="35">&nbsp;</td>
        <td rowspan="5">&nbsp;</td>
      </tr>
      <tr>
        <td height="367"><img src="images/index-images/A-4_r2_c2.gif" width="580" height="367"></td>
      </tr>
      <tr>
        <td height="40" background="images/index-images/A-4_r3_c2.gif" align="center">
        <form name="form1" method="post"  onSubmit="return logchk_onsubmit()">	    
          <table width="" height="36" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
			  <td align="center"> </td>	    
              <td width="60" height="36" align="right"><font style="font-size:12px;color:#FFFFFF;font-weight:bold">�û���:&nbsp;</font></td>
              <td width="100"><input type="text" id="loginID" name="loginID" style="height:20px;width:100px;border:1px solid #ffffff;background:#ececec"/></td>
              <td width="60" height="40" align="right"><font style="font-size:12px;color:#FFFFFF;font-weight:bold">��  ��:&nbsp;</font></td>
              <td width="100"><input type="password" name="password" style="height:20px;width:100px;border:1px solid #ffffff;background:#ececec"/></td>
              <td width="60" align="center"><input name="submit" type="image" src="images/index-images/login.gif" border="0"/></td>
            </tr>
          </table>
          </form>
        </td>
      </tr>
      <tr>
        <td height="81"></td>
      </tr>
      <tr>
      	<td height="23"></td>
     </tr>
    </table></td>
  </tr>
  <tr>
    <td bgcolor="#ccdae6">&nbsp;</td>
  </tr>
</table>
</body>
</html>