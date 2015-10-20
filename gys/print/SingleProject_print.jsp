<%@ page contentType="text/html; charset=gbk"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.dataObject.Gd02_dxgc" %>
<%@ page import="com.netsky.dataObject.Gb03_bgxx" %>
<%@ page import="com.netsky.baseObject.*" %>
<%
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	
	Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
	Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
	String HSql3="select gd02 from Gd02_dxgc gd02 where gd02.id ="+dxgc_id;
    ResultObject ro3 = queryService.search(HSql3);
    Gd02_dxgc gd=null;
    String bgxd=null;
     if(ro3.next()){
        gd=(Gd02_dxgc)ro3.get("gd02");
        bgxd=gd.getBgxd();
     }
     String HSql4="select gb03 from Gb03_bgxx gb03 where id in ("+bgxd+")";
     ResultObject ro4 = queryService.search(HSql4);
     int[] bgxx_xh=new int[18];
     for(int j=0;j<18;j++)
     {
       bgxx_xh[j]=0;
     }
     while(ro4.next())
     {
          Gb03_bgxx gb03=null;
          gb03=(Gb03_bgxx)ro4.get("gb03");
          bgxx_xh[gb03.getId().intValue()]=gb03.getId().intValue();
     }   
%>
<html>
<head>
<title>����̴�ӡ</title>
<link href="../css/list.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script language='javascript'>
function abc()
{  
	var selectbgflag=0;
	for(j=0;j<document.all("Cb_bgxd").length;j++){
		if(document.all("Cb_bgxd")(j).checked){       
			selectbgflag =1;
		}  
	}
	if(selectbgflag==0){
		alert("��ѡ����");
		return ;
	}
  document.form1.action="../print/print.jsp?type=print&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>" 
  document.form1.submit();
  window.close(); 
  return true;
}
function PDF(){
	var selectbgflag=0;
	for(j=0;j<document.all("Cb_bgxd").length;j++){
		if(document.all("Cb_bgxd")(j).checked){       
			selectbgflag =1;
		}  
	}
	if(selectbgflag==0){
		alert("��ѡ����");
		return ;
	}
	document.form1.action="../print/transformer.jsp?type=pdf&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>";
	document.form1.submit();
	window.close();
	return true;
}
function Word(){
	var selectbgflag=0;
	for(j=0;j<document.all("Cb_bgxd").length;j++){
		if(document.all("Cb_bgxd")(j).checked){       
			selectbgflag =1;
		}  
	}
	if(selectbgflag==0){
		alert("��ѡ����");
		return ;
	}
	document.form1.action="../print/transformer.jsp?type=doc&dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>";
	document.form1.submit();
	window.close();
	return true;
}
function Excel(){
	var selectbgflag=0;
	for(j=0;j<document.all("Cb_bgxd").length;j++){
		if(document.all("Cb_bgxd")(j).checked){       
			selectbgflag =1;
		}  
	}
	if(selectbgflag==0){
		alert("��ѡ����");
		return ;
	}
	document.form1.action="../export/SingleProject_excel.jsp?dxgc_id=<%=dxgc_id%>&gcxm_id=<%=gcxm_id%>"
	document.form1.submit();
	window.close();
	return true;
}
function checkal(){
	if(document.form1.aaa.checked==true){
		 for(var i=0;i<document.getElementsByName("Cb_bgxd").length;i++){
		 	if(document.getElementsByName("Cb_bgxd")[i].disabled!=true){
		 		document.getElementsByName("Cb_bgxd")[i].checked=true;
		 	}
		 }
	}else{
		for(var i=0;i<document.getElementsByName("Cb_bgxd").length;i++){
		 	document.getElementsByName("Cb_bgxd")[i].checked=false;
		 }
	}
}
</script>
</head>
<body>
<form name="form1"  method=post   action="" target="blank"  >   
	<table border="0" cellpadding="0" style="border-collapse: collapse" width="100%">
		<tr>
			<td><input type="checkbox" name="aaa" value=""  onclick="checkal()"></td>
			<td><font color="#FF0000">ѡ�����б��</font></td>
		</tr>
		<tr>
			<td width="35"><input type="checkbox" name="Cb_bgxd"  value="1" ></td>
			<td width="290">������Ŀ�ܱ����ܱ�</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="2"<%if(bgxx_xh[2]==2){ %> <%}else{%> disabled <%} %> ></td>
			<td>��Ԥ���ܱ���һ��</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="9" <%if(bgxx_xh[9]==9){ %> <%}else{%> disabled <%} %>></td>
			<td>���ڱ�Ʒ���������ģ���</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="3"<%if(bgxx_xh[3]==3){ %> <%}else{%> disabled <%} %> ></td>
			<td>������װ���̷��ã������</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="10"<%if(bgxx_xh[10]==10){ %><%}else{%> disabled <%} %> ></td>
			<td>����ά�����߱����ģ���</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="4" <%if(bgxx_xh[4]==4){ %><%}else{%> disabled <%} %> ></td>
			<td>������װ����������������</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="11"<%if(bgxx_xh[11]==11){ %><%}else{%> disabled <%} %> ></td>
			<td>������Ҫ���ϱ����ģ���</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="5"<%if(bgxx_xh[5]==5){ %><%}else{%> disabled <%} %> ></td>
			<td>������װ���̻�еʹ�÷ѣ���������</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="12" <%if(bgxx_xh[12]==12){ %><%}else{%> disabled <%} %>  ></td>
			<td>������Ҫ���ϸ������ģ���</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="6" <%if(bgxx_xh[6]==6){ %><%}else{%> disabled <%} %>  ></td>
			<td>������װ���������Ǳ�ʹ�÷ѣ���������</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="13" <%if(bgxx_xh[13]==13){ %> <%}else{%> disabled <%} %>  ></td>
			<td>���̽����������ã����壩��</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="7" <%if(bgxx_xh[7]==7){ %><%}else{%> disabled <%} %>  ></td>
			<td>������Ҫ��װ�豸�����ģ���</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="14" <%if(bgxx_xh[14]==14){ %><%}else{%> disabled <%} %> ></td>
			<td>�������̱�</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="8" <%if(bgxx_xh[8]==8){ %><%}else{%> disabled <%} %> ></td>
			<td>���ڲ���Ҫ��װ�豸�����ģ���</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="15" <%if(bgxx_xh[15]==15){ %>	<%}else{%> disabled <%} %>></td>
			<td>�����豸��</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="Cb_bgxd"  value="17"<%if(bgxx_xh[17]==17){ %> <%}else{%> disabled <%} %>></td>
			<td>���ڹ�����豸��</td>
			<td><input type="checkbox" name="Cb_bgxd"  value="16" <%if(bgxx_xh[16]==16){ %><%}else{%> disabled <%} %>></td>
			<td>���ղ��ϱ�</td>

		</tr>
	</table>
	<table border="0" cellpadding="2" style="height:35px;border-collapse:collapse;" width="100%">
		<tr>
			<td style="height:5px"></td>
		</tr>
		<tr>
		<td style="vertical-aling:bottom;">
			&nbsp;<input type="button" name="b2" value=" ��ӡԤ�� "  onclick="abc()">
			&nbsp;<input type="button" name="b2" value=" PDF��� "  onclick="PDF()">
			&nbsp;<input type="button" name="b2" value=" Word��� "  onclick="Word()">
			&nbsp;<input type="button" name="b2" value=" Excel��� "  onclick="Excel()">
		</td>
		</tr>
	</table>
</form>	
</body>

</html>
