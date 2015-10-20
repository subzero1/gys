<%@ page contentType="text/html; charset=gb2312"%>
<HTML>
<HEAD>
<TITLE>选择日期</TITLE>
<style>
<!--
BODY{MARGIN-TOP: 0PX; MARGIN-RIGHT: 0PX; MARGIN-LEFT: 0PX; FONT-SIZE:9PT; SCROLLBAR-FACE-COLOR:#CCCCCC; SCROLLBAR-HIGHLIGHT-COLOR:#FFFFFF; SCROLLBAR-SHADOW-COLOR:#FFFFFF; SCROLLBAR-3DLIGHT-COLOR:#999999; SCROLLBAR-ARROW-COLOR:#000000; SCROLLBAR-TRACK-COLOR:#CCCCCC; SCROLLBAR-DARKSHADOW-COLOR:#666666}
TABLE{FONT-SIZE:9PT;FONT-FAMILY:VERDANA; }
TD{FONT-SIZE:9PT; }
A1{FONT-SIZE:9PT; COLOR:#FFFFFF; }
A1:LINK{COLOR:#FF0000; }
A1:ACTIVE{COLOR:#FFFFFF; TEXT-DECORATION:NONE}
A1:VISITED{COLOR:#FFFFFF; TEXT-DECORATION:NONE}
A1:HOVER{COLOR:#FF0000; TEXT-DECORATION:NONE}
A.B1{COLOR:WHITE;TEXT-DECORATION:NONE;FONT-FAMILY: "ARIAL"; FONT-SIZE: 9PT;COLOR: WHITE;}
A.B1:HOVER{COLOR:WHITE;TEXT-DECORATION:UNDERLINE;FONT-FAMILY: "ARIAL"; FONT-SIZE: 9PT;COLOR: WHITE;}

BR.PAGE{PAGE-BREAK-AFTER:ALWAYS; }
TEXTAREA{FONT-FAMILY:VERDANA;WIDTH:100%;BORDER-BOTTOM:#4A3163 1PX SOLID; BORDER-LEFT:#4A3163 1PX SOLID; BORDER-RIGHT:#4A3163 1PX SOLID; BORDER-TOP:#4A3163 1PX SOLID; FONT-SIZE:9PT}
.TEXTAREA_READONLY{FONT-FAMILY:VERDANA;WIDTH:100%;BORDER-BOTTOM:#4A3163 1PX SOLID; BORDER-LEFT:#4A3163 1PX SOLID; BORDER-RIGHT:#4A3163 1PX SOLID; BORDER-TOP:#4A3163 1PX SOLID; FONT-SIZE:9PT;BACKGROUND-COLOR:#DCDCDC;}
SELECT{FONT-SIZE:9PT;FONT-FAMILY:VERDANA;}
INPUT{FONT-FAMILY:VERDANA;BORDER-BOTTOM:#4A3163 1PX SOLID; BORDER-LEFT:#4A3163 1PX SOLID; BORDER-RIGHT:#4A3163 1PX SOLID; BORDER-TOP:#4A3163 1PX SOLID; FONT-SIZE:9PT}
.INPUT_READONLY{FONT-FAMILY:VERDANA;BORDER-BOTTOM:#4A3163 1PX SOLID; BORDER-LEFT:#4A3163 1PX SOLID; BORDER-RIGHT:#4A3163 1PX SOLID; BORDER-TOP:#4A3163 1PX SOLID; FONT-SIZE:9PT; BACKGROUND-COLOR:#DCDCDC}
.INPUT_NEED{FONT-FAMILY:VERDANA;BORDER-BOTTOM:#4A3163 1PX SOLID; BORDER-LEFT:#4A3163 1PX SOLID; BORDER-RIGHT:#4A3163 1PX SOLID; BORDER-TOP:#4A3163 1PX SOLID; FONT-SIZE:9PT;BORDER-COLOR:#FF0000;}

.RESULTSET_TABLE{BACKGROUND-COLOR:#000000; WIDTH:100%;}
.RESULTSET_TABLE_TR_HEAD{BACKGROUND-COLOR:#FF6600; HEIGHT:15PT; COLOR:BLACK; FONT-WEIGHT:BOLD}
.RESULTSET_TABLE_TR_LIST{BACKGROUND-COLOR:#FF9933; CURSOR:HAND; HEIGHT:10PT; COLOR:BLACK; }
.RESULTSET_TABLE_TR_LIST_SELECTED{BACKGROUND-COLOR:red; HEIGHT:10PT; COLOR:BLACK; }
.INFO_TABLE{BACKGROUND-COLOR:#CCCC99; WIDTH:100%; }
.INFO_TABLE_TD_LEFT{BACKGROUND-COLOR:#EEEEEE; HEIGHT:15PT; COLOR:BLACK;TEXT-ALIGN:CENTER; }
.INFO_TABLE_TD_RIGHT{BACKGROUND-COLOR:#FFFFFF; HEIGHT:15PT; COLOR:BLACK; }
.INFO_TABLE_TR_HEAD{BACKGROUND-COLOR:#EEEEEE; WIDTH:100%; HEIGHT:15PT; COLOR:BLACK; }
.INFO_TABLE_TR_LIST{BACKGROUND-COLOR:#FFFFFF; WIDTH:100%; HEIGHT:15PT; COLOR:BLACK; }
.PAGE_TITLE{BACKGROUND-COLOR:#ECF5FF}

.HOT{	COLOR: #FF3300}
.BUTTON {
BORDER-LEFT: 1PX SOLID RGB(0,0,0);
BORDER-RIGHT: 1PX SOLID RGB(0,0,0);
 BORDER-TOP: 1PX SOLID RGB(0,0,0);
BORDER-BOTTOM:1PX SOLID RGB(0,0,0);
FONT-FAMILY: "COURIER", "ARIAL";
FONT-SIZE: 12PX;
COLOR: #000000;
BACKGROUND:#FFFFFF;
FONT-WEIGHT: NORMAL;
COLOR: #000000;
HEIGHT: 20PX;
WIDTH: 75PX}
.BUTTON_REDLINE {
BORDER-LEFT: 1PX SOLID RGB(0,0,0);
BORDER-RIGHT: 1PX SOLID RGB(0,0,0);
BORDER-TOP: 3PX SOLID RGB(226,142,115);
BORDER-BOTTOM:1PX SOLID RGB(0,0,0);
FONT-FAMILY: "COURIER", "ARIAL";
FONT-SIZE: 12PX;
COLOR: #000000;
BACKGROUND:#FFFFFF;
FONT-WEIGHT: NORMAL;
COLOR: #000000;
HEIGHT: 22PX;
WIDTH: 75PX}
.ERRORTABLE {  BACKGROUND-ATTACHMENT: FIXED; BACKGROUND-IMAGE: URL("../images/error.gif"); BACKGROUND-REPEAT: NO-REPEAT; BACKGROUND-POSITION: LEFT TOP}
.OKTABLE {  BACKGROUND-ATTACHMENT: FIXED; BACKGROUND-IMAGE: URL("../images/ok.gif"); BACKGROUND-REPEAT: NO-REPEAT; BACKGROUND-POSITION: LEFT TOP}
.MULTILINETAG{BACKGROUND-COLOR:#E7F5FE;}
.MULTILINESIGNDIFFERENTTAG{BACKGROUND-COLOR:#A3F5A3;}
-->
</style>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<body bgcolor="#CCFF99">
<div align="center">
<center>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
var dDate = new Date();
var dCurMonth = dDate.getMonth();
var dCurDayOfMonth = dDate.getDate();
var dCurYear = dDate.getFullYear();
var objPrevElement = new Object();
var dDay = dDate.getDate();

function fToggleColor(myElement) {
var toggleColor = "#ff0000";
if (myElement.id == "calDateText") {
if (myElement.color == toggleColor) {
myElement.color = "";
} else {
myElement.color = toggleColor;
   }
} else if (myElement.id == "calCell") {
for (var i in myElement.children) {
if (myElement.children[i].id == "calDateText") {
if (myElement.children[i].color == toggleColor) {
myElement.children[i].color = "";
} else {
myElement.children[i].color = toggleColor;
            }
         }
      }
   }
}
function fSetSelectedDay(myElement){
if (isNaN(parseInt(myElement.innerText))) return false;
if (myElement.id == "calCell")
{
if (!isNaN(parseInt(myElement.children["calDateText"].innerText)))
 {
 myElement.bgColor = "#c0c0c0";
 objPrevElement.bgColor = "";
 document.all.calSelectedDate.value = parseInt(myElement.children["calDateText"].innerText);
 objPrevElement = myElement;
 }
}

   return true;
}

function fGetDaysInMonth(iMonth, iYear) {
var dPrevDate = new Date(iYear, iMonth, 0);
return dPrevDate.getDate();
}
function fBuildCal(iYear, iMonth, iDayStyle) {
var aMonth = new Array();
aMonth[0] = new Array(7);
aMonth[1] = new Array(7);
aMonth[2] = new Array(7);
aMonth[3] = new Array(7);
aMonth[4] = new Array(7);
aMonth[5] = new Array(7);
aMonth[6] = new Array(7);
var dCalDate = new Date(iYear, iMonth-1, 1);
var iDayOfFirst = dCalDate.getDay();
var iDaysInMonth = fGetDaysInMonth(iMonth, iYear);
var iVarDate = 1;
var i, d, w;
if (iDayStyle == 2) {
aMonth[0][0] = "Sunday";
aMonth[0][1] = "Monday";
aMonth[0][2] = "Tuesday";
aMonth[0][3] = "Wednesday";
aMonth[0][4] = "Thursday";
aMonth[0][5] = "Friday";
aMonth[0][6] = "Saturday";
} else if (iDayStyle == 1) {
aMonth[0][0] = "日";
aMonth[0][1] = "一";
aMonth[0][2] = "二";
aMonth[0][3] = "三";
aMonth[0][4] = "四";
aMonth[0][5] = "五";
aMonth[0][6] = "六";
} else {
aMonth[0][0] = "Su";
aMonth[0][1] = "Mo";
aMonth[0][2] = "Tu";
aMonth[0][3] = "We";
aMonth[0][4] = "Th";
aMonth[0][5] = "Fr";
aMonth[0][6] = "Sa";
}
for (d = iDayOfFirst; d < 7; d++) {
aMonth[1][d] = iVarDate;
iVarDate++;
}
for (w = 2; w < 7; w++) {
for (d = 0; d < 7; d++) {
if (iVarDate <= iDaysInMonth) {
aMonth[w][d] = iVarDate;
iVarDate++;
      }
   }
}
return aMonth;
}
function fDrawCal(iYear, iMonth, iCellWidth, iCellHeight, sDateTextSize, sDateTextWeight, iDayStyle) {
var myMonth;
myMonth = fBuildCal(iYear, iMonth, iDayStyle);
document.write("<table class=RESULTSET_TABLE cellspacing='1' width=100% cellpadding='3' align=center>")
document.write("<tr class=RESULTSET_TABLE_TR_HEAD>");
document.write("<td align='center' style='FONT-FAMILY:Arial;FONT-SIZE:12px;FONT-WEIGHT: bold'>" + myMonth[0][0] + "</td>");
document.write("<td align='center' style='FONT-FAMILY:Arial;FONT-SIZE:12px;FONT-WEIGHT: bold'>" + myMonth[0][1] + "</td>");
document.write("<td align='center' style='FONT-FAMILY:Arial;FONT-SIZE:12px;FONT-WEIGHT: bold'>" + myMonth[0][2] + "</td>");
document.write("<td align='center' style='FONT-FAMILY:Arial;FONT-SIZE:12px;FONT-WEIGHT: bold'>" + myMonth[0][3] + "</td>");
document.write("<td align='center' style='FONT-FAMILY:Arial;FONT-SIZE:12px;FONT-WEIGHT: bold'>" + myMonth[0][4] + "</td>");
document.write("<td align='center' style='FONT-FAMILY:Arial;FONT-SIZE:12px;FONT-WEIGHT: bold'>" + myMonth[0][5] + "</td>");
document.write("<td align='center' style='FONT-FAMILY:Arial;FONT-SIZE:12px;FONT-WEIGHT: bold'>" + myMonth[0][6] + "</td>");
document.write("</tr>");
  for (w = 1; w < 7; w++)
  {
    document.write("<tr  class=RESULTSET_TABLE_TR_LIST>")
    for (d = 0; d < 7; d++)
    {
      if (!isNaN(myMonth[w][d]))
      {
        if(myMonth[w][d]==dDay)
           document.write("<td class=RESULTSET_TABLE_TR_LIST_SELECTED style='CURSOR:Hand' onMouseOver='fToggleColor(this)' onMouseOut='fToggleColor(this)' onclick='if(fSetSelectedDay(this)){selectOver(this);}' >");
        else
           document.write("<td  class=RESULTSET_TABLE_TR_LIST onmouseover=\"this.className='RESULTSET_TABLE_TR_LIST_SELECTED';\" onmouseout=\"this.className='RESULTSET_TABLE_TR_LIST';\"  onclick=';if(fSetSelectedDay(this)){selectOver(this);}' >");
        document.write("<font id=calDateText style='FONT-FAMILY:Arial;FONT-SIZE:12px;FONT-WEIGHT: bold'>" + myMonth[w][d] + "</font>");
      }
      else
      {
        document.write("<td class=RESULTSET_TABLE_TR_LIST onmouseover=\"this.className='RESULTSET_TABLE_TR_LIST_SELECTED';\" onmouseout=\"this.className='RESULTSET_TABLE_TR_LIST';\" onclick='if(fSetSelectedDay(this)){selectOver(this);}'  >");
        document.write("<font id=calDateText style='FONT-FAMILY:Arial;FONT-SIZE:12px;FONT-WEIGHT: bold'>&nbsp;</font>");
      }
      document.write("</td>")
    }
    document.write("</tr>");
  }
document.write("</table>")
}

function fUpdateCal(iYear, iMonth) {
myMonth = fBuildCal(iYear, iMonth);
objPrevElement.bgColor = "";
document.all.calSelectedDate.value = "";
for (w = 1; w < 7; w++) {
for (d = 0; d < 7; d++) {
if (!isNaN(myMonth[w][d])) {
calDateText[((7*w)+d)-7].innerText = myMonth[w][d];
} else {
calDateText[((7*w)+d)-7].innerText = " ";
         }
      }
   }
}

function selectOver(dayObj)
{
  var year = document.all.tbSelYear.value;
  var month = document.all.tbSelMonth.value;
  var day = dayObj.innerText;

  if(month<10) month="0"+month;
  if(day<10) day="0"+day;
  returnValue= year+month+day;
  self.close();
}

// End -->
</script>

<script language="JavaScript" for=window event=onload>
<!-- Begin
var dCurDate = new Date();
frmCalendarSample.tbSelMonth.options[dCurDate.getMonth()].selected = true;
for (i = 0; i < frmCalendarSample.tbSelYear.length; i++)
if (frmCalendarSample.tbSelYear.options[i].value == dCurDate.getFullYear())
frmCalendarSample.tbSelYear.options[i].selected = true;
//  End -->
</script>

<form name="frmCalendarSample" method="post" action="">
<input type="hidden" name="calSelectedDate" value="">

<table border="0">
<tr>
<td align=center>
月份<select name="tbSelMonth" onchange='fUpdateCal(frmCalendarSample.tbSelYear.value, frmCalendarSample.tbSelMonth.value)'>
<option value="1">一月</option>
<option value="2">二月</option>
<option value="3">三月</option>
<option value="4">四月</option>
<option value="5">五月</option>
<option value="6">六月</option>
<option value="7">七月</option>
<option value="8">八月</option>
<option value="9">九月</option>
<option value="10">十月</option>
<option value="11">十一月</option>
<option value="12">十二月</option>
</select>
年份<select name="tbSelYear" onchange='fUpdateCal(frmCalendarSample.tbSelYear.value, frmCalendarSample.tbSelMonth.value)'>
<option value="1998">1998</option>
<option value="1999">1999</option>
<option value="2000">2000</option>
<option value="2001">2001</option>
<option value="2002">2002</option>
<option value="2003">2003</option>
<option value="2004">2004</option>
<option value="2005">2005</option>
<option value="2006">2006</option>
<option value="2007">2007</option>
<option value="2008">2008</option>
<option value="2009">2009</option>
<option value="2010">2010</option>
</select>
</td>
</tr>
<tr>
<td>
<script language="JavaScript">
var dCurDate = new Date();
fDrawCal(dCurDate.getFullYear(), dCurDate.getMonth()+1, 30, 30, "12px", "bold", 1);
</script>
</td>
</tr>
</table></form>
</center>
</div>
</BODY>
</HTML>
