<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.jspsmart.upload.*,java.io.*,java.util.*,com.netsky.viewObject.BakVo" %>
<%@ page import="com.netsky.dataObject.Gd01_gcxm" %>
<%@ page import="com.netsky.dataObject.Gd02_dxgc" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%  
	ArrayList dataList = null;
	//实例化上载bean    
	SmartUpload mySmartUpload=new SmartUpload();  
	try{
		//初始化    
		mySmartUpload.initialize(pageContext);     
		//设置上载的最大值    
		//mySmartUpload.setMaxFileSize(500*1024*1024);    
		//上载文件    
		mySmartUpload.upload();    
		//循环取得所有上载的文件    
		   
		//取得上载的文件    
		com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);    
		if (!myFile.isMissing()){    
			//取得上载的文件的文件名    
			//String myFileName=myFile.getFileName();     
			//保存路径    
			//String aa="/files/upload/"; 
			//String trace=aa+myFileName;       
			//将文件保存在服务器端     
			//myFile.saveAs(trace,mySmartUpload.SAVE_VIRTUAL);
			//String doc_id=(String)mySmartUpload.getRequest().getParameter("doc_id"); 
			//String sql = "select sign_pic from ta03_employee where id="+doc_id+" for update";
			//stmt.executeUpdate("update ta03_employee set sign_pic=empty_blob() where id="+doc_id);    
			//conn.commit();
			//下面的是将上载的文件保存到数据库中    
			//将文件读到流中     
			 
            byte[] b = new byte[myFile.getSize()];   
            for(int i=0;i<myFile.getSize();i++){
            	b[i]=myFile.getBinaryData(i);
            }
            ByteArrayInputStream byteIn = new ByteArrayInputStream(b);  
            ObjectInputStream in  = new ObjectInputStream(byteIn);
			dataList = (ArrayList)in.readObject();
            

			in.close();
			byteIn.close();

			out.println("<script>alert('上传成功');</script>");    
		}else{
			out.println("<script>alert('上传失败');window.close();</script>");    
		}     
	}catch(Exception e){
		e=null;
	}
	session.setAttribute("bakobj",dataList);
%>
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
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
			document.getElementById('impBtn').disabled=true;
		else
			document.getElementById('impBtn').disabled=false;
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
	function validupload(){
		var upfile = String(document.form1.upLoadFile.value);
		if(upfile=='')
			alert("请选择导出的备份文件");
		else
			form1.submit();

	}
	var xmlHttp;
	function createXMLHttpRequest(){
		if(window.ActiveXObject){
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}else if(window.XMLHttpRequset){
		 	xmlHttp=new XMLHttpRequset();
		}
	}
	function validExist(){
		var pids = document.getElementsByName("prj_id");
		var par='';
		for(var i=0;i<pids.length;i++){
			if(pids[i].checked==true){
				par += '&prj_id='+pids[i].value;
				var spids = document.getElementsByName("spid_"+pids[i].value);
				for(var j=0;j<spids.length;j++){
					if(spids[j].checked==true)
						par += '&spid_'+pids[i].value+'='+spids[j].value;
				}
			}
		}
		createXMLHttpRequest();
	   	xmlHttp.onreadystatechange=importdata;
	   	xmlHttp.open("GET","../afuer/bakServlet?flag=ext"+par);
	   	xmlHttp.send(null);
	}
	function importdata(){
		if(xmlHttp.readyState==4){
			if(xmlHttp.status==200){
	           var doc = new ActiveXObject("MSxml2.DOMDocument")
	           doc.loadXML(xmlHttp.responseText);
	           result=doc.getElementsByTagName("exist");
	           var exist = result[0].childNodes[0].nodeValue;
	           if(exist=='true'){
	           		if(confirm('相关工程已经存在是否覆盖？')){
	           			form1.action='../afuer/bakServlet?flag=imp&op=1';
	           		}else{
	           			form1.action='../afuer/bakServlet?flag=imp';
	           		}
	           }else{
	           		form1.action='../afuer/bakServlet?flag=imp';
	           }
	           form1.enctype='';
			   form1.submit();
	        }
		}
	}
	</script>
  </head>
  
  <body>
  	<form name="form1" method="post" action="" enctype="multipart/form-data">
		<table width="100%" height="60" border="1">
			<tr>
				<td width="100" align="right">选择备份文件：</td>
				<td><input type="file" name="upLoadFile" size="20">&nbsp;&nbsp;<input type="button" name="sveBtn" value=" 上 传 " onclick="validupload()"></td>
			</tr>
		</table>
		<%
			if(dataList!=null){
		%>
		<table width="100%" border="1">
		<%
			for(int i=0;i<dataList.size();i++){
				BakVo bak = (BakVo)dataList.get(i);
				Gd01_gcxm gd01 = (Gd01_gcxm)bak.getBasicInfo();
		%>
			  <tr>
			  	<td width="30" align="right"><a href="#"><img src="../images/zhankai.gif" border="0" onclick="openSp(this,'<%=gd01.getId().toString()%>')"/></a></td>
			    <td width="30" align="right"><input type="checkbox" id="prj_<%=gd01.getId().toString()%>" name="prj_id" value="<%=gd01.getId().toString()%>" onclick="bigitem(this,'<%=gd01.getId().toString()%>')"/></td>
			    <td colspan="2"><%=gd01.getXmmc()%></td>
			  </tr>
			  <tbody id="spshow_<%=gd01.getId().toString()%>" style="display:none">
		<%
				ArrayList spList = bak.getList();
				for(int j=0;j<spList.size();j++){
					BakVo spBak = (BakVo)spList.get(j);
					Gd02_dxgc gd02 = (Gd02_dxgc)spBak.getBasicInfo();
		%>
				  <tr>
				  	<td align="right">&nbsp;</td>
				    <td align="right">&nbsp;</td>
				    <td width="40"><input type="checkbox" name="spid_<%=gd01.getId().toString()%>" value="<%=gd02.getId().toString()%>" onclick="smallitem(this,'<%=gd01.getId().toString()%>')"/></td>
				    <td><%=gd02.getGcmc()%></td>
				  </tr>		
		<%
				}
			%>
			</tbody>
			<%
			}
			%>
			</table>
			<%
			}

			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
			Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
			ResultObject flRs = queryService.search("select gb04.id,gb04.mc from Gb04_gcfl gb04 where czy_id="+yh.getId());
		%>
		工程分类:<select name="gcfl">
		<%
			while(flRs.next()){
				Integer flid = (Integer)flRs.get("gb04.id");
				String flname = (String)flRs.get("gb04.mc");
				out.println("<option value='"+flid.toString()+"'>"+flname+"</option>");
			}
		%>
		</select>
		<input type="button" onclick="validExist()" id="impBtn" name="impBtn" value="导入" disabled>&nbsp;&nbsp;<input type="button" name="closeBtn" value="关闭" onclick="javascript:window.close();">
		</form>
  </body>
</html>
