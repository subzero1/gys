<%@ page contentType="text/html; charset=gb2312"%>
<HTML>
	<HEAD>
		<TITLE>�û�������������</TITLE>
		<STYLE type=text/css>BODY {
	BACKGROUND: #fff; MARGIN: 80px auto; FONT: 14px/150% Verdana, Georgia, Sans-Serif; COLOR: #000; TEXT-ALIGN: center
}
A:link {
	COLOR: #2c4c78; TEXT-DECORATION: none
}
A:visited {
	COLOR: #2c4c78; TEXT-DECORATION: none
}
A:hover {
	COLOR: #2c4c78; TEXT-DECORATION: none
}
A:active {
	COLOR: #2c4c78; TEXT-DECORATION: none
}
H1 {
	PADDING-RIGHT: 4px; PADDING-LEFT: 4px; FONT-SIZE: 14px; BACKGROUND: #eee; PADDING-BOTTOM: 4px; MARGIN: 0px; PADDING-TOP: 4px; BORDER-BOTTOM: #84b0c7 1px solid
}
DIV {
	BORDER-RIGHT: #84b0c7 1px solid; BORDER-TOP: #84b0c7 1px solid; BACKGROUND: #e5eef5; MARGIN: 0px auto; BORDER-LEFT: #84b0c7 1px solid; WIDTH: 500px; BORDER-BOTTOM: #84b0c7 1px solid
}
P {
	PADDING-RIGHT: 15px; PADDING-LEFT: 15px; PADDING-BOTTOM: 15px; MARGIN: 0px; PADDING-TOP: 15px
}
</STYLE>

		<META content="MSHTML 6.00.2900.2523" name=GENERATOR>
	</HEAD>
	<BODY>
		<%
			String cwbz = request.getParameter("cwbz");
			String cwbz_str;
			if ("1".equals(cwbz)) {
				cwbz_str = "��ʾ���û�������������";
			} else if (cwbz.equals("3")) {
				cwbz_str = "��ʾ�����û����������! ";
			} else if (cwbz.equals("4")) {
				cwbz_str = "��ʾ�����û���˲�ͨ��! ";
			} else {
				cwbz_str = "��ʾ���û����ѹ��ڣ�";
			}
		%>
		<DIV>
			<H1>
				<%=cwbz_str%>
			</H1>
			<P>
				<A href="bbs/login.jsp"><FONT color=blue>����������µ�¼ </FONT>
				</A><span id="count">5����Զ����� ��¼ҳ��</span>
			</P>
		</DIV>
		<script language="javascript">
			var count = 5;
			for(var i = 1; i <= 6; i++){
				setTimeout("setTitle()",1000 * i);
			}
			setTimeout("history.go(-1)",5000);
			
			function setTitle(){
				document.getElementById("count").innerText = (--count) + "����Զ����� ��¼ҳ��";
			}
		</script>
	</BODY>
</HTML>
