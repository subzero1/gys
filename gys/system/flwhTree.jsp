<%@ page contentType="text/html; charset=gb2312"%>
<%
	String flk_id = "1";
	request.setCharacterEncoding("GBK");
	if (request.getParameter("flk_id") != null) {
		flk_id = request.getParameter("flk_id");
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>ϵͳ����ά�����β˵�</title>
		<script language="javascript" src="../js/treemenu.js"></script>
		<link href="../css/list.css" rel="stylesheet" type="text/css">
		<style type="text/css">
</style>
	</head>
	<body style='overflow:scroll;overflow-x:hidden'>

		<div class="CNLTreeMenu" id="CNLTreeMenu">
			<a id="AllOpen" href="#"
				onclick="MyCNLTreeMenu.SetNodes(0);Hd(this);Sw('AllClose');"
				style="display:none;">&nbsp;&nbsp;ȫ��չ��</a><a id="AllClose" href="#"
				onclick="MyCNLTreeMenu.SetNodes(1);Hd(this);Sw('AllOpen');">&nbsp;&nbsp;ȫ���۵�</a>

			<li>
				<a href="#">������װ���̷�</a>
				<ul>
					<li>
						<a href="#">ֱ�ӷ�</a>
						<ul>
							<li>
								<a href="#">ֱ�ӹ��̷�</a>
								<ul>
									<li class="Child" onClick="treego(this,'flwh/rgf.jsp?flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										�˹���
									</li>
									<li class="Child" onClick="treego(this,'flwh/fzcsg.jsp?flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										����������ʩ������
									</li>
									<li class="Child" onClick="treego(this,'flwh/xgrtz.jsp?flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										С���յ���
									</li>
									<!--Child Node-->
									<li>
										<a href="#">���Ϸ�</a>
										<ul>
											<li class="Child" onClick="treego(this,'flwh/yzf.jsp?fy_id=60&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
												���ӷ�
											</li>
											<li class="Child" onClick="treego(this,'flwh/clxgfl.jsp?fy_id=61&flk_id=<%=flk_id%>&type=ZC')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
												���䱣�շ�
											</li>
											<li class="Child" onClick="treego(this,'flwh/cgbgf.jsp?fy_id=62&flk_id=<%=flk_id%>&type=ZC')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
												�ɹ������ܷ�
											</li>
											<li class="Child" onClick="treego(this,'flwh/clxgfl.jsp?fy_id=63&flk_id=<%=flk_id%>&type=ZC')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
												�ɹ���������
											</li>
											<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=9&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
												�������Ϸ���
											</li>
										</ul>
									</li>
								</ul>
							</li>
							<li>
								<a href="#">��ʩ��</a>
								<ul>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=10&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										����������
									</li>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=11&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										����ʩ����
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=12&flk_id=<%=flk_id%>')"style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										�������İ��˷�
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=13&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										���̸��ŷ�
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=14&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										���̵㽻�����������
									</li>
									<li class="Child" onClick="treego(this,'flwh/lsssf.jsp?fy_id=15&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										��ʱ��ʩ��
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=16&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										���̳���ʹ�÷�
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=17&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										ҹ��ʩ�����ӷ�
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=18&flk_id=<%=flk_id%>')"  style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										���꼾ʩ�����ӷ�
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=19&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										���������þ�ʹ�÷�
									</li>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=21&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										�������ʩ�����ӷ�
									</li>
									<li class="Child" onClick="treego(this,'flwh/sgddqf.jsp?fy_id=26&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										ʩ�������ǲ��
									</li>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=27&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										����ʩ����е��ǲ��
									</li>
								</ul>
							</li>
						</ul>
					</li>
					<li>
						<a href="#">��ӷ�</a>
						<ul>
							<li>
								<a href="#">���</a>
								<ul>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=29&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										��ᱣ�Ϸ�
									</li>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=30&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										ס��������
									</li>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=31&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										Σ����ҵ�����˺����շ�
									</li>
								</ul>
							</li>
							<!--Child Node-->
							<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=32&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
								��ҵ�����
							</li>
						</ul>
					</li>
					<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=33&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						����
					</li>
					<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=34&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						˰��
					</li>
				</ul>
			</li>
			<!--Sub Node 2-->
			<li>
				<a href="#">�豸,�����߹��÷�</a>
				<ul>
					<li class="Child" onClick="treego(this,'flwh/yzf.jsp?fy_id=60&flk_id=<%=flk_id%>&type=SB')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						���ӷ�
					</li>
					<li class="Child" onClick="treego(this,'flwh/clxgfl.jsp?fy_id=61&flk_id=<%=flk_id%>&type=SB')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						���䱣�շ�
					</li>
					<li class="Child" onClick="treego(this,'flwh/cgbgf.jsp?fy_id=62&flk_id=<%=flk_id%>&type=SB')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						�ɹ������ܷ�
					</li>
					<li class="Child" onClick="treego(this,'flwh/clxgfl.jsp?fy_id=63&flk_id=<%=flk_id%>&type=SB')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						�ɹ���������
					</li>
				</ul>
			</li>

			<!--Sub Node 3-->
			<li>
				<a href="#">���̽���������</a>
				<ul>
					<li class="Child" onClick="treego(this,'flwh/qjfy.jsp?fy_id=71&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						���赥λ�����
					</li>
					<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=79&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						��ȫ������
					</li>
					<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=88&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						����׼���������
					</li>
				</ul>
			</li>
			<!--Sub Node 2-->
			<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=1&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
				Ԥ����
			</li>
			<!--Sub Node 2-->
			<li class="Child" onClick="treego(this,'flwh/gcxgqj.jsp?fy_id=78&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
				���̽�������
			</li>
			<!--Sub Node 2-->

		</div>
		<!-- CNLTreeMenu -->
		<!--CNLTreeMenu End-->
		<!-- CNLTreeMenu -->
		<!--CNLTreeMenu End-->

		<script type="text/javascript">
var MyCNLTreeMenu=new CNLTreeMenu("CNLTreeMenu","li");
MyCNLTreeMenu.InitCss("Opened","Closed","Child","../images/tree-images/s.gif");
MyCNLTreeMenu.SetNodes(0);
</script>
	</body>
</html>
