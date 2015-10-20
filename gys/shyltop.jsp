<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Gb03_bgxx"%>
<html>
  <head>
    <title></title>
<script laguage="javascript">
  var xmlHttp; 
  function createXMLHttpRequest()
  {
    if(window.ActiveXObject)
    {
      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if(window.XMLHttpRequset)
    {
      xmlHttp=new XMLHttpRequest();
    }
  }
  
 function updateSelect()
  {
    var dxgc_id=document.all.xzgc.value;
    createXMLHttpRequest();
    xmlHttp.onreadystatechange=updateS;
    xmlHttp.open("GET","afuer/YlGcxzXml?dxgc_id="+dxgc_id);
    xmlHttp.send(null);
  }
  
  function updateS()
  {
     if(xmlHttp.readyState==4){
        if(xmlHttp.status==200){
           var doc = new ActiveXObject("MSxml2.DOMDocument")
           doc.loadXML(xmlHttp.responseText);
           result=doc.getElementsByTagName("bg");
           while(document.all.xzbg.options.length>0)
           {
             document.all.xzbg.removeChild(document.all.xzbg.childNodes[0]);
           }
           for(var i=0;i<result.length;i++)
           {
             var option=document.createElement("OPTION");
             option.text=result[i].childNodes[0].childNodes[0].nodeValue;
             option.value=result[i].childNodes[1].childNodes[0].nodeValue;
             document.all.xzbg.options.add(option);
           }
        }
     }
  }
  
  function bgsd(obj_bg)
  {
    var Cb_bgxd=obj_bg.value;
    var dxgc_id=document.all.xzgc.value;
    window.top.data.location="print/print.jsp?type=print&dxgc_id="+dxgc_id+"&Cb_bgxd="+Cb_bgxd+"&gcxm_id=<%=request.getParameter("gcxm_id")%>";
  }
</script>
<base target="data"/>
  </head>
  
  <body>
    <table><tr>
    <td>选择单项工程：</td>
    <td>
    <select size="1" name="xzgc" id="xzgc"   onchange="javascript:updateSelect();">
							<option value="0" selected>选择单项工程</option>
							<%
							ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
                            QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
                            request.setCharacterEncoding("utf-8");
                            String gcxm_id=request.getParameter("gcxm_id");
                            String dxgc_id=request.getParameter("dxgc_id");
							String HSql2="select gd02 from Gd02_dxgc gd02 where gd02.gcxm_id="+gcxm_id;
	  		                ResultObject ro2 = queryService.search(HSql2);
		                    while(ro2.next()){
		                    Gd02_dxgc gd02=(Gd02_dxgc)ro2.get("gd02");
			                if(gd02!=null){ 
							 %>
							<option value="<%=gd02.getId() %>" style="color:red;" <%if(gd02.getId().toString().equals(dxgc_id)) {%>selected<%}%> ><%=gd02.getGcmc() %></option>
							<% }}%>
	</select>
    </td>
    <td>选择表格：</td>
    <td>
    <select size="1" name="xzbg" id="xzbg" onchange="bgsd(this)">
    <option value="0" selected>选择表格</option>	
    <%
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
	                        Gb03_bgxx gb03=null;
		                    while(ro4.next()){
		                    gb03=(Gb03_bgxx)ro4.get("gb03");
			                if(gb03!=null){ 
			                System.out.println("ww="+gb03.getId());
     %>
							<option value="<%=gb03.getId() %>" <%if(gb03.getId().toString().equals("1")){ %>selected <%} %>><%=gb03.getMc() %></option>	
	<%}} %>
	</select>
    </td>
    </tr></table>
  </body>
</html>
