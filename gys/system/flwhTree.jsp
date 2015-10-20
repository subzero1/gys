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
		<title>系统费率维护树形菜单</title>
		<script language="javascript" src="../js/treemenu.js"></script>
		<link href="../css/list.css" rel="stylesheet" type="text/css">
		<style type="text/css">
</style>
	</head>
	<body style='overflow:scroll;overflow-x:hidden'>

		<div class="CNLTreeMenu" id="CNLTreeMenu">
			<a id="AllOpen" href="#"
				onclick="MyCNLTreeMenu.SetNodes(0);Hd(this);Sw('AllClose');"
				style="display:none;">&nbsp;&nbsp;全部展开</a><a id="AllClose" href="#"
				onclick="MyCNLTreeMenu.SetNodes(1);Hd(this);Sw('AllOpen');">&nbsp;&nbsp;全部折叠</a>

			<li>
				<a href="#">建筑安装工程费</a>
				<ul>
					<li>
						<a href="#">直接费</a>
						<ul>
							<li>
								<a href="#">直接工程费</a>
								<ul>
									<li class="Child" onClick="treego(this,'flwh/rgf.jsp?flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										人工费
									</li>
									<li class="Child" onClick="treego(this,'flwh/fzcsg.jsp?flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										非正常地区施工调整
									</li>
									<li class="Child" onClick="treego(this,'flwh/xgrtz.jsp?flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										小工日调增
									</li>
									<!--Child Node-->
									<li>
										<a href="#">材料费</a>
										<ul>
											<li class="Child" onClick="treego(this,'flwh/yzf.jsp?fy_id=60&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
												运杂费
											</li>
											<li class="Child" onClick="treego(this,'flwh/clxgfl.jsp?fy_id=61&flk_id=<%=flk_id%>&type=ZC')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
												运输保险费
											</li>
											<li class="Child" onClick="treego(this,'flwh/cgbgf.jsp?fy_id=62&flk_id=<%=flk_id%>&type=ZC')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
												采购及保管费
											</li>
											<li class="Child" onClick="treego(this,'flwh/clxgfl.jsp?fy_id=63&flk_id=<%=flk_id%>&type=ZC')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
												采购代理服务费
											</li>
											<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=9&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
												辅助材料费率
											</li>
										</ul>
									</li>
								</ul>
							</li>
							<li>
								<a href="#">措施费</a>
								<ul>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=10&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										环境保护费
									</li>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=11&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										文明施工费
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=12&flk_id=<%=flk_id%>')"style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										工地器材搬运费
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=13&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										工程干扰费
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=14&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										工程点交、场地清理费
									</li>
									<li class="Child" onClick="treego(this,'flwh/lsssf.jsp?fy_id=15&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										临时设施费
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=16&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										工程车辆使用费
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=17&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										夜间施工增加费
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=18&flk_id=<%=flk_id%>')"  style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										冬雨季施工增加费
									</li>
									<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=19&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										生产工具用具使用费
									</li>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=21&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										特殊地区施工增加费
									</li>
									<li class="Child" onClick="treego(this,'flwh/sgddqf.jsp?fy_id=26&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										施工队伍调遣费
									</li>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=27&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										大型施工机械调遣费
									</li>
								</ul>
							</li>
						</ul>
					</li>
					<li>
						<a href="#">间接费</a>
						<ul>
							<li>
								<a href="#">规费</a>
								<ul>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=29&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										社会保障费
									</li>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=30&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										住房公积金
									</li>
									<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=31&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
										危险作业意外伤害保险费
									</li>
								</ul>
							</li>
							<!--Child Node-->
							<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=32&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
								企业管理费
							</li>
						</ul>
					</li>
					<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=33&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						利润
					</li>
					<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=34&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						税金
					</li>
				</ul>
			</li>
			<!--Sub Node 2-->
			<li>
				<a href="#">设备,工器具购置费</a>
				<ul>
					<li class="Child" onClick="treego(this,'flwh/yzf.jsp?fy_id=60&flk_id=<%=flk_id%>&type=SB')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						运杂费
					</li>
					<li class="Child" onClick="treego(this,'flwh/clxgfl.jsp?fy_id=61&flk_id=<%=flk_id%>&type=SB')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						运输保险费
					</li>
					<li class="Child" onClick="treego(this,'flwh/cgbgf.jsp?fy_id=62&flk_id=<%=flk_id%>&type=SB')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						采购及保管费
					</li>
					<li class="Child" onClick="treego(this,'flwh/clxgfl.jsp?fy_id=63&flk_id=<%=flk_id%>&type=SB')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						采购代理服务费
					</li>
				</ul>
			</li>

			<!--Sub Node 3-->
			<li>
				<a href="#">工程建设其他费</a>
				<ul>
					<li class="Child" onClick="treego(this,'flwh/qjfy.jsp?fy_id=71&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						建设单位管理费
					</li>
					<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=79&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						安全生产费
					</li>
					<li class="Child" onClick="treego(this,'flwh/fglfl.jsp?fy_id=88&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
						生产准备及开办费
					</li>
				</ul>
			</li>
			<!--Sub Node 2-->
			<li class="Child" onClick="treego(this,'flwh/gcxgfl.jsp?fy_id=1&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
				预备费
			</li>
			<!--Sub Node 2-->
			<li class="Child" onClick="treego(this,'flwh/gcxgqj.jsp?fy_id=78&flk_id=<%=flk_id%>')" style="cursor:hand" onmouseover="this.style.color='#43BEE5';" onmouseout="this.style.color='#1E4F75'">
				工程建设监理费
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
