<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Ga04_flk"%>
<%@ page import="com.netsky.dataObject.Gd01_gcxm"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page import="com.netsky.dataObject.Gb04_gcfl"%>
<%@ page import="com.netsky.dataObject.Gd10_b3fl"%>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<%@page import="com.netsky.baseFormatUtils.DateFormatUtil"%>
<%@page import="com.netsky.dataObject.Ga06_zy"%>

<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>综合信息</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script language="javascript">
    //删除工程项目
	function gcdel()
	{
	    if(confirm('确定要删除项目!'))   
        {   
           document.form1.action="../afuer/GcxmDelController?gcdel_id=<%=request.getParameter("gcxm_id")%>&gcfl_id=<%=StringFormatUtil.format(request.getParameter("gcfl_id"))%>&xmxx=1";
	       document.form1.submit();  
        }   
	}
	
	function save()
	{
	  if(document.getElementById("mcyz_bz").value==0)
	  {
	    if(listValidateChk("form1","Gd01_gcxm.XMMC")&&listValidateChk("form1","Gd01_gcxm.XMBH")&&listValidateChk("form1","Gd01_gcxm.JSDW")
  		  &&listValidateChk("form1","Gd01_gcxm.SJFZR")&&listValidateChk("form1","Gd01_gcxm.SHR")&&listValidateChk("form1","Gd01_gcxm.BGBH")
  		  &&listValidateChk("form1","Gd01_gcxm.BZR")&&listValidateChk("form1","Gd01_gcxm.BZRQ")&&listValidateChk("form1","Gd01_gcxm.XMSM")){
  	 	   document.form1.submit();
         }
       }else if(document.getElementById("mcyz_bz").value==1){
         alert("项目名称不能重复！");
       }else{
         alert("项目名称不能为空！");
       }
	}
	
	function xxtb()
	{
	  if(confirm('确定将单项工程的信息都同步为建设项目的信息吗？（确认已经保存项目信息）'))   
      {   
          document.form1.action="../afuer/XxtbController?gcxm_id=<%=request.getParameter("gcxm_id")%>&dxgc_id=<%=request.getParameter("dxgc_id")%>";
	      document.form1.submit(); 
      }
	}
</script>
<script language="javascript">
  //ajax 验证项目名称唯一性
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
  
  function xmmc_yz(xmmcObj)
  {
    var xmmc=xmmcObj.value;
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=yzcl;
    xmlHttp.open("GET","../afuer/XmmcYz?lb=xm&gcxm_id=<%=request.getParameter("gcxm_id")%>&xmmc="+encodeURIComponent(xmmc));
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
             //document.getElementById("mcyz").innerText="项目名称可用";
             document.getElementById("mcyz_bz").value=0;
           }else if(mcyz=="1"){
             //document.getElementById("mcyz_ts").innerText="X";
             //document.getElementById("mcyz").innerText="项目名称不可用";
             document.getElementById("mcyz_bz").value=1;
           }else{
             //document.getElementById("mcyz_ts").innerText="X";
             //document.getElementById("mcyz").innerText="项目名称不能为空";
             document.getElementById("mcyz_bz").value=2;
           }
        }
     }
  }
  function updateSelect()
  {
    var selected=document.all.D2.value;
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
</script>

</head>

<body leftmargin="0" topmargin="0" id="main-body" style="height:100%;">
<table border="0" cellpadding="2" style="height:45px;border-collapse:collapse;" width="100%">
	<tr>
		<td style="height:15px"></td>
	</tr>
	<tr>
		<td style="vertical-aling:bottom;">
			&nbsp;<button name="" onClick="javascript:save();"> 保存信息 </button>
            <input type="hidden" id="mcyz_bz" value="0">
			&nbsp;<button name="" onClick="gcdel()"> 删除项目 </button>
			&nbsp;<button name="" onClick="javascript:winOpen('../print/ProjectPrint.jsp?gcxm_id=<%=request.getParameter("gcxm_id")%>'
					,'580','450','0')"> 打印预览 </button>
			&nbsp;<button name="" onClick="javascript:xxtb();"> 信息同步 </button>
		</td>
	</tr>
</table> 
<div align="center" style="width:100%;height:94%;background:#ffffff">
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
     	if("".equals(gcxm_id))
     	{
     	  gcxm_id=null;
     	}
		String dxgc_id=request.getParameter("dxgc_id");
		if(dxgc_id==null||"null".equals(dxgc_id))
		{
		  dxgc_id="";
		}
		String gcfl_id=request.getParameter("gcfl_id");
        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	    QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	  	String HSql1="select gd01 from Gd01_gcxm gd01 where id="+gcxm_id;
	  	ResultObject ro1 = queryService.search(HSql1);
	  	Gd01_gcxm gd01=null;
	  	String bzrq_str;
	  	String cjrq_str;
	  	if(ro1.next())
		{
		    gd01=(Gd01_gcxm)ro1.get("gd01");
		    bzrq_str=DateFormatUtil.Format(gd01.getBzrq(),"yyyy-MM-dd");
		    cjrq_str=DateFormatUtil.Format(gd01.getCjrq(),"yyyy-MM-dd");
		}else{
			gd01 = new Gd01_gcxm();
			Date bzrq=new Date();
		    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            bzrq_str = sdf.format(bzrq);
            cjrq_str = sdf.format(bzrq);
		}
		
		
 %>
 	<form action="../afuer/dataWriter" method="post" id="form1" name="form1">
	<input type="hidden" name="dispatchStr" value="/dataManage/xmxx.jsp?dxgc_id=<%=dxgc_id %>">
	<input type="hidden" name="tableInfomation" value="noFatherTable:Gd01_gcxm">
	<input type="hidden" name="perproty" value="gcxm_id,Gd01_gcxm,ID">
	<input type="hidden" name="Gd01_gcxm.ID" value="<%=StringFormatUtil.format(gcxm_id)%>">
	<table border="0" cellpadding="2" style="border-collapse: collapse" width="700">
		<tr style="height:20px;">
			<td colspan="6"></td>
		</tr>
		<tr style="height:40px;">
			<td colspan="6" align="center"><img src="../images/xmxx.gif" border="0" title="项目信息设置"></td>
		</tr>
		<tr>
			<td align="right">项目名称：</td>
			<td colspan="3"><input type="text" name="Gd01_gcxm.XMMC" size="20" class="td-input" value="<%=StringFormatUtil.format(gd01.getXmmc()) %>" onblur="xmmc_yz(this)"></td>
			
			<td align="right" width="80" id="mcyz_ts"></td>
			<td width="140" id="mcyz"></td>
		</tr>

		<tr>
			<td width="90" align="right">项目编号：</td>
			<td width="150"><input type="text" name="Gd01_gcxm.XMBH" size="20" class="td-input" value="<%=StringFormatUtil.format(gd01.getXmbh()) %>"></td>
			<td width="90" align="right">所属分类：</td>
			<td width="150">
				<select size="1" name="Gd01_gcxm.GCFL_ID" class="td-input">
				<option value="" >未分类项目</option>
			<%
			  if(gd01.getGcfl_id()!=null)
			  {
			    gcfl_id=gd01.getGcfl_id().toString();
			  }
			  String HSql="select gb04 from Gb04_gcfl gb04 where czy_id="+user_id;
		      ResultObject ro = queryService.search(HSql);
		      Gb04_gcfl gb04=null;
		      while(ro.next()){
		        gb04 = (Gb04_gcfl) ro.get("gb04");
			 %>
				<option value="<%=gb04.getId() %>" <%if(StringFormatUtil.format(gcfl_id).equals(StringFormatUtil.format(gb04.getId(),"0"))){%>selected<%}%> ><%=gb04.getMc() %></option>
			 <%} %>
				</select>
			</td>
			<td align="right">建设阶段：</td>
			<td>
				<select size="1" name="Gd01_gcxm.JSJD" class="td-input">
				<option value="2" <%if("2".equals(StringFormatUtil.format(gd01.getJsjd(),"0"))){%>selected<%}%> >预算</option>
				<option value="1" <%if("1".equals(StringFormatUtil.format(gd01.getJsjd(),"0"))){%>selected<%}%> >概算</option>
				<option value="3" <%if("3".equals(StringFormatUtil.format(gd01.getJsjd(),"0"))){%>selected<%}%> >结算</option>
				<option value="4" <%if("4".equals(StringFormatUtil.format(gd01.getJsjd(),"0"))){%>selected<%}%> >决算</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right"></td>
			<td colspan="3"><input type="hidden" name="Gd01_gcxm.CJR" size="20" class="td-input" value="<%=user%>" readOnly></td>
			<input type="hidden" name="Gd01_gcxm.CJR_ID" value="<%=user_id %>">
			<td align="right"></td>
			<td><input type="hidden" name="Gd01_gcxm.CJRQ" size="20" class="td-input" value="<%=cjrq_str %>" readOnly></td>
		</tr>
		<tr>
			<td align="right">建设单位：</td>
			<td colspan="3"><input type="text" name="Gd01_gcxm.JSDW" size="20" class="td-input" value="<%=StringFormatUtil.format(gd01.getJsdw()) %>"></td>
			<td align="right">工程性质：</td>
			<td>
				<select size="1" name="Gd01_gcxm.GCXZ" class="td-input">
					<option value="1" <%if(gd01.getGcxz() != null && gd01.getGcxz().intValue()==1){%>selected<%}%>>新建工程</option>
					<option value="2" <%if(gd01.getGcxz() != null && gd01.getGcxz().intValue()==2){%>selected<%}%>>全部扩建</option>
					<option value="3" <%if(gd01.getGcxz() != null && gd01.getGcxz().intValue()==3){%>selected<%}%>>部分扩建</option>
					<option value="4" <%if(gd01.getGcxz() != null && gd01.getGcxz().intValue()==4){%>selected<%}%>>改建工程</option>
					<option value="5" <%if(gd01.getGcxz() != null && gd01.getGcxz().intValue()==5){%>selected<%}%>>恢复工程</option>
					<option value="6" <%if(gd01.getGcxz() != null && gd01.getGcxz().intValue()==6){%>selected<%}%>>迁建工程</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">设计单位：</td>
			<td colspan="3"><input type="text" name="Gd01_gcxm.SJDW" size="20" class="td-input" value="<%=StringFormatUtil.format(gd01.getSjdw()) %>"></td>
			<td align="right">设计负责人：</td>
			<td><input type="text" name="Gd01_gcxm.SJFZR" size="20" class="td-input" value="<%=StringFormatUtil.format(gd01.getSjfzr())%>"></td>
		</tr>
		<tr>
			<td align="right">审核人：</td>
			<td><input type="text" name="Gd01_gcxm.SHR" size="20" class="td-input" value="<%=StringFormatUtil.format(gd01.getShr())%>"></td>
			<td align="right">概预算号：</td>
			<td><input type="text" name="Gd01_gcxm.SHRGYSH" size="20" class="td-input" value="<%=StringFormatUtil.format(gd01.getShrgysh()) %>"></td>
			<td align="right">设计编号：</td>
			<td><input type="text" name="Gd01_gcxm.SJBH" size="20" class="td-input" value="<%=StringFormatUtil.format(gd01.getSjbh()) %>"></td>
		</tr>
		<tr>
			<td align="right">编制人：</td>
			<td><input type="text" name="Gd01_gcxm.BZR" size="20" class="td-input" value="<%if(!"".equals(StringFormatUtil.format(gd01.getBzr()))){out.print(StringFormatUtil.format(gd01.getBzr()));}else{out.print(user);} %>"></td>
			<td align="right">概预算号：</td>
			<td><input type="text" name="Gd01_gcxm.BZRGYSH" size="20" class="td-input" value="<%=StringFormatUtil.format(gd01.getBzrgysh())%>"></td>
			<td align="right">编制日期：</td>
			<td><input type="text" name="Gd01_gcxm.BZRQ" size="20" class="td-input" value="<%=StringFormatUtil.format(bzrq_str) %>"></td>
		</tr>
		<tr>
			<td align="right">工程费率：</td>
			<td>
			
			<select size="1" id="flkselect" name="Gd01_gcxm.FLK_ID" class="td-input">
			<%
			  String HSql2="select ga04 from Ga04_flk ga04 order by id asc";
	  	      ResultObject ro2 = queryService.search(HSql2);
	  	      Ga04_flk ga04=null;
	  	      
	  	      while(ro2.next())
	  	      {
	  	         ga04=(Ga04_flk)ro2.get("ga04");
	  	         
			 %>
			<option value="<%=ga04.getId()%>" <%if(gd01.getFlk_id() != null && gd01.getFlk_id().intValue()==ga04.getId().intValue()){%>selected<%}%> ><%=ga04.getMc() %></option>
			<%} %>
			</select></td>
			<td align="right">表格编号前缀：</td>
			<td><input type="text" name="Gd01_gcxm.BGBH" size="20" class="td-input" value="<%=StringFormatUtil.format(gd01.getBgbh()) %>"></td>
			<td align="right">起始页码：</td>
			<td><input type="text" name="Gd01_gcxm.BGQSYM" size="20" class="td-input" value="<%=StringFormatUtil.format(gd01.getBgqsym())%>"></td>
		</tr>
		<tr>
		    			<td width="80" align="right">专业类别：</td>
			<td width="150">
				<%
				String lb="XL";
				String HSql5="select ga06 from Ga06_zy ga06 where ga06.lb=(select lb from Ga06_zy ga06 where ga06.id = "+StringFormatUtil.format(gd01.getZy_id(),"0")+")";
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
				<select name="Gd01_gcxm.ZY_ID" id="D3" class="td-input">
				<%
							ro5.reSet();
		                    while(ro5.next())
		                    {
		                         Ga06_zy ga06=null;
		                         ga06=(Ga06_zy)ro5.get("ga06");
				 %>
				<option value="<%=ga06.getId() %>" <%if(gd01.getZy_id()!=null&&gd01.getZy_id().intValue()==ga06.getId().intValue()){%>selected<%}%>><%=ga06.getMc()%></option>
				<%} %>
				</select></td>
			<td align="right"></td>
			<td>
			</td>
		</tr>
		<tr>
			<td>　</td>
			<td>　</td>
			<td>　</td>
			<td>　</td>
			<td>　</td>
			<td>　</td>
		</tr>

		<tr>
			<td align="right" height="100">项目说明：</td>
			<td colspan="5"><textarea rows="5" name="Gd01_gcxm.XMSM" cols="20" class="td-textarea"><%=StringFormatUtil.format(gd01.getXmsm()) %></textarea></td>
		</tr>
	</table>
	<input type="hidden" name="list_validate" value="项目名称:Gd01_gcxm.XMMC:VARCHAR2:300:0;项目编号:Gd01_gcxm.XMBH:VARCHAR2:50:1;
			建设单位:Gd01_gcxm.JSDW:VARCHAR2:100:1;设计负责人:Gd01_gcxm.SJFZR:VARCHAR2:10:1;审核人:Gd01_gcxm.SHR:VARCHAR2:10:1;
			表格编号:Gd01_gcxm.BGBH:VARCHAR2:20:1;编制人:Gd01_gcxm.BZR:VARCHAR2:10:1;编制日期:Gd01_gcxm.BZRQ:DATE:100:1;项目说明:Gd01_gcxm.XMSM:VARCHAR2:500:1;起始页码:Gd01_gcxm.BGQSYM:NUMBER:10:1">
</form>
</div>
<script language="javascript">
window.parent.document.frames('left').location.href="projectInfo.jsp?gcxm_id=<%=StringFormatUtil.format(gcxm_id)%>&dxgc_id=<%=StringFormatUtil.format(dxgc_id)%>&gcfl_id=<%=StringFormatUtil.format(gcfl_id)%>";
</script>
</body>
</html>