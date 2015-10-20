<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	
	Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
%>
<html>
  <head>
	<title></title>
	<script type="text/javascript">
	function openSp(obj,pid){
		var spobj = document.getElementById('spshow_'+pid);
		if(spobj.style.display=='none'){
			spobj.style.display='block';
			obj.src='../images/zhedie.gif';
		}else{
			spobj.style.display='none';
			obj.src='../images/zhankai.gif';
		}
	}
	function checksubmit(){
		var pobjs = document.getElementsByName('prj_id');
		var j;
		for(j=0;j<pobjs.length;j++)
			if(pobjs[j].checked==true)
				break;
		if(j==pobjs.length)
			document.getElementById('expBtn').disabled=true;
		else
			document.getElementById('expBtn').disabled=false;
	}
	function bigitem(obj,pid){
		var spobjs = document.getElementsByName('spid_'+pid);
		if(spobjs!=null){
			for(var i=0;i<spobjs.length;i++){
				if(obj.checked==true)
					spobjs[i].checked=true;
				else
					spobjs[i].checked=false;
			}
		}
		checksubmit();
	}
	function smallitem(obj,pid){
		if(obj.checked==true){
			document.getElementById('prj_'+pid).checked=true;
		}else{
			var spobjs = document.getElementsByName('spid_'+pid);
			var i;
			for(i=0;i<spobjs.length;i++)
				if(spobjs[i].checked==true)
					break;
			if(i==spobjs.length)
				document.getElementById('prj_'+pid).checked=false;
		}
		checksubmit();
	}
	</script>
  </head>
  
  <body>
  	<form name="form1" action="../afuer/bakServlet">
		<table width="100%" border="1">
		<%
			ResultObject prjRs = queryService.search("select gd01.id,gd01.xmmc from Gd01_gcxm gd01 where cjr_id="+yh.getId());
			while(prjRs.next()){
				Integer prjid = (Integer)prjRs.get("gd01.id");
				String prjname = (String)prjRs.get("gd01.xmmc");
		%>
				  <tr>
				  	<td width="30" align="right"><a href="#"><img src="../images/zhankai.gif" border="0" onclick="openSp(this,'<%=prjid.toString()%>')"/></a></td>
				    <td width="30" align="right"><input type="checkbox" id="prj_<%=prjid.toString()%>" name="prj_id" value="<%=prjid.toString()%>" onclick="bigitem(this,'<%=prjid.toString()%>')"/></td>
				    <td colspan="2"><%=prjname%></td>
				  </tr>
				  <tbody id="spshow_<%=prjid.toString()%>" style="display:none">
		<%
				int count=0;
				ResultObject spRs = queryService.search("select gd02.id,gd02.gcmc from Gd02_dxgc gd02 where gcxm_id="+prjid.toString());
				while(spRs.next()){
					Integer spid = (Integer)spRs.get("gd02.id");
					String spname = (String)spRs.get("gd02.gcmc");
		%>
				  <tr>
				  	<td align="right">&nbsp;</td>
				    <td align="right">&nbsp;</td>
				    <td width="40"><input type="checkbox" name="spid_<%=prjid.toString()%>" value="<%=spid.toString()%>" onclick="smallitem(this,'<%=prjid.toString()%>')"/></td>
				    <td><%=spname%></td>
				  </tr>
		<%
					count++;
				}
				if(count==0)out.println("<script>document.getElementById('prj_"+prjid.toString()+"').disabled=true;</script>");
				out.println("</tbody>");
			}
		%>
		</table>
		<input type="submit" id="expBtn" name="expBtn" value="µ¼³ö" disabled>&nbsp;&nbsp;<input type="button" name="closeBtn" value="¹Ø±Õ" onclick="javascript:window.close();">
	</form>
  </body>
</html>
