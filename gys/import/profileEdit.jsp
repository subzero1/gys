<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.netsky.dataObject.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.dom4j.*"%>
<%@ page import="org.dom4j.io.*"%>
<%
request.setCharacterEncoding("GBK");
String columns[] = new String[]{"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
Gb01_yhb yhb = (Gb01_yhb) request.getSession().getAttribute("yhb");
if(yhb == null){
	out.print("���¼!");
	return;
}
String configName = new String(request.getParameter("configName").getBytes("iso-8859-1"),"GBK");
if(configName == null || configName.length() == 0){
	out.print("��������Ϊ��!");
	return;
}
String webInfPatch = request.getRealPath("WEB-INF");
Map Config = this.getConfinFileName(configName, webInfPatch, yhb.getId());
File f = new File(webInfPatch + Config.get("fileName"));
if (!f.exists()) {
	out.print("δ�ҵ��û������ļ�:" + f.getPath());
}
SAXReader reader = new SAXReader();
Document doc = reader.read(f);
Element root = doc.getRootElement();
Element foo;
Iterator it;
if(request.getParameter("flag") != null && "update".equals(request.getParameter("flag"))){
	it = root.elementIterator("tableInfo");
	while(it.hasNext()){
		foo = (Element) it.next();
		String tableName = foo.elementText("tableName");
		foo.element("sheetNum").setText(request.getParameter(tableName + ".sheetNum"));
		foo.element("startRow").setText(request.getParameter(tableName + ".startRow"));
		foo.element("endRow").setText(request.getParameter(tableName + ".endRow"));
		foo.element("endFlag").setText(request.getParameter(tableName + ".endFlag"));
		foo.element("columns").element("titleRow").setText(request.getParameter(tableName + ".titleRow"));
		foo.element("columns").element("type").setText(request.getParameter(tableName + ".type"));
		Iterator col_it = foo.element("columns").elementIterator("column");
		while(col_it.hasNext()){
			Element col = (Element) col_it.next();
			col.element("name").setText(request.getParameter(tableName + "." + col.elementText("columnName") + ".name"));
			col.element("index").setText(request.getParameter(tableName + "." + col.elementText("columnName") + ".index"));
		}
	}
	String filePath = "/importConfig/" + yhb.getId() + configName + ".xml";
	OutputFormat format = OutputFormat.createPrettyPrint(); 
    format.setEncoding("GBK");
	if(Config.get("user").toString().equals("default")){
		File f1 = new File(webInfPatch + configFile);
		if (!f1.exists()) {
			throw new Exception("δ�ҵ����������ļ�");
		}
		SAXReader reader1 = new SAXReader();
		Document doc1 = reader1.read(f1);
		Element r = doc1.getRootElement();
		Element configElement = r.addElement("config");
		configElement.addElement("name").setText(configName);
		configElement.addElement("fileName").setText(filePath);
		configElement.addElement("user").setText(yhb.getId().toString());
		XMLWriter writer = new XMLWriter(new FileWriter(new File(f1.getPath())),format);
		writer.write(doc1);
		writer.close();
	}
	XMLWriter writer = new XMLWriter(new FileWriter(new File(webInfPatch + filePath)),format);
	writer.write(doc);
	writer.close();
}
it = root.elementIterator("tableInfo");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link href="/gys/css/data.css" rel="stylesheet" type="text/css">
<title>�޸������ļ�</title>
</head>
<body>
<form method="post">
<input type="hidden" name="flag" value="update">
<input type="hidden" name="configName" value="<%=configName%>">
<%
while(it.hasNext()){
	foo = (Element) it.next();
	%>
	<table width="300" align="center" id="profile" border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
	<tr>
		<td width="150" align="right">������ƣ�</td>
		<td width="150" align="left"><%=foo.elementText("tableNameShow")%></td>
	</tr>
	<tr>
		<td width="150"  align="right">������λ�ã���0��ʼ����</td>
		<td width="150"><input type="text" name="<%=foo.elementText("tableName") + ".sheetNum"%>" value="<%=foo.elementText("sheetNum")%>"></td>
	</tr>
	<tr>
		<td width="150"  align="right">���ݿ�ʼ�У���0��ʼ����</td>
		<td width="150"><input type="text" name="<%=foo.elementText("tableName") + ".startRow"%>" value="<%=foo.elementText("startRow")%>"></td>
	</tr>
	<tr>
		<td width="150"  align="right">���ݽ����У���0��ʼ����</td>
		<td width="150"><input type="text" name="<%=foo.elementText("tableName") + ".endRow"%>" value="<%=foo.elementText("endRow")%>"></td>
	</tr>
	<tr>
		<td width="150"  align="right">���ݽ�����־��</td>
		<td width="150"><input type="text" name="<%=foo.elementText("tableName") + ".endFlag"%>" value="<%=foo.elementText("endFlag")%>"></td>
	</tr>
	<%
	/**
	 * �����ֶ���Ϣ
	 */
	Iterator col_it = foo.element("columns").elementIterator("column");
	%>
	<tr>
		<td width="150" align="right">������λ�ã���0��ʼ����</td>
		<td><input type="text" name="<%=foo.elementText("tableName") + ".titleRow"%>" value="<%=foo.element("columns").elementText("titleRow")%>"></td>
	</tr>
	<tr>
		<td width="150"  align="right">��������ʽ��</td>
		<td>
		<select name="<%=foo.elementText("tableName") + ".type"%>">
			<option value="byIndex" <%if(foo.element("columns").elementText("type").equals("byIndex")){out.print("selected");}%>>����˳��</option>
			<option value="byName" <%if(foo.element("columns").elementText("type").equals("byName")){out.print("selected");}%>>����������</option>
		</select>
		</td>
	</tr>
	<tr>
		<td colspan="2">	
			<table width="100%" id="rowtable">
			<tr>
				<td width="80" align="center" bgcolor="#F4F4F4">�ֶ�����</td>
				<td width="80" align="center" bgcolor="#F4F4F4">������</td>
				<td align="center" bgcolor="#F4F4F4">��Ӧ������</td>
			</tr>
			<%
			while(col_it.hasNext()){
				Element col = (Element) col_it.next();
				%>
				<tr>
					<td align="right">
						<input type="hidden" name="<%=foo.elementText("tableName") + ".columnName"%>" value="<%=col.elementText("columnName")%>">
						<%=col.elementText("colName") %>��&nbsp;</td>
					<td>
					<select name="<%=foo.elementText("tableName") + "." + col.elementText("columnName") + ".index"%>">
						<%
						for(int i = 0; i < columns.length; i++){
							%>
							<option value="<%=i%>" <%if(i == Integer.parseInt(col.elementText("index"))){out.print("selected");} %>><%=columns[i] %></option>
							<%
						}
						%>
					</select>
					</td>
					<td><input type="text" name="<%=foo.elementText("tableName") + "." + col.elementText("columnName") + ".name"%>" value="<%=col.elementText("name")%>"></td>
				</tr>
				<%
			}
			%>
			</table>
			<br/>
		</td>
	</tr>
	</table>
	<div align="center" style="padding:5px;">
			<input type="submit" name="����">
	</div>
	<%
}
%>
</form>
</body>
</html>
<%!
private String configFile = "/importConfig/import.xml";
/**
 * �������Ʒ��ض�Ӧ�������ļ�����
 * 
 * @param ConfigName
 *            �������ƣ������import.xml
 * @return �����ļ�����
 */
private Map getConfinFileName(String ConfigName, String webInfPatch, Integer user_id) throws Exception {
	Map map = new HashMap();
	/**
	 * ��ȡ���������ļ�
	 */
	File f = new File(webInfPatch + configFile);
	if (!f.exists()) {
		throw new Exception("δ�ҵ����������ļ�");
	}
	SAXReader reader = new SAXReader();
	Document doc = reader.read(f);
	Element root = doc.getRootElement();
	Element foo;
	Iterator i;
	for (i = root.elementIterator("config"); i.hasNext();) {
		foo = (Element) i.next();
		String configName = foo.elementText("name");
		String user = foo.elementText("user");
		if (configName.equals(ConfigName) && user.equals(user_id.toString())) {
			map.put("fileName",foo.elementText("fileName"));
			map.put("user",user_id.toString());
			return map;
		}
	}
	for (i = root.elementIterator("config"); i.hasNext();) {
		foo = (Element) i.next();
		String configName = foo.elementText("name");
		String user = foo.elementText("user");
		if (configName.equals(ConfigName) && user.equals("default")) {
			map.put("fileName",foo.elementText("fileName"));
			map.put("user",user);
			return map;
		}
	}
	return null;
}
%>