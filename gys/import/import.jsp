<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.baseObject.*"%>
<html>
	<head>
		<script language="javascript" src="../js/functionlib.js"></script>
		<meta http-equiv="Content-Type"
			content="text/html; charset=gb2312">
		<title>���ݵ���</title>
		<link href="/gys/css/data.css" rel="stylesheet" type="text/css">		
	</head>
	<body>
	<div align="center">
		<form method="post" enctype="multipart/form-data" action="../afuer/importer">
			<input type="hidden" name="DXGC_ID" value="<%=request.getParameter("DXGC_ID")%>">
			<input type="hidden" name="GCXM_ID" value="<%=request.getParameter("GCXM_ID") %>">
			<input type="hidden" name="BGBH" value="<%=request.getParameter("BGBH") %>">
			<input type="hidden" name="config" value="<%=request.getParameter("config") %>">
			<input type="hidden" name="TZXS" value="1">
			<input type="hidden" name="dispatchStr" value="../import/import.jsp">
			<input type="hidden" name="perproty" value="DXGC_ID/GCXM_ID/BGBH/config">
			<table width="400" border="0"  cellspacing="0" cellpadding="0" id="import">
				<tr>
					<td bgcolor="#F4F4F4">
						ѡ���ļ���
					</td>
				</tr>
				<tr>
					<td>
						<input type="file" name="F1" size="30" class="file">
					</td>
				</tr>
				<tr>
					<td>					
						<input type="button" value="�޸�����" onclick="javascript:winOpen('profileEdit.jsp?configName=<%=request.getParameter("config")%>','350','500','1')">
						<input type="submit" value=" �� �� ">
						<input type="button" value=" �� �� " onclick="javascript:window.close();">
					</td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>
