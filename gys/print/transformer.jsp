<%@ page contentType="text/html; charset=GB2312"%>
<%@ page
	import="com.netsky.embedding.*,java.net.URL,java.net.HttpURLConnection,java.io.*"%>
<%
		try {
		String realPath = request.getRealPath("WEB-INF");
		response.reset();
		String type = "pdf";
		if (request.getParameter("type") == null || request.getParameter("type").equals("pdf"))
			response.setContentType("application/pdf;charset=GB2312");
		else if (request.getParameter("type").equals("doc")) {
			response.setContentType("application/msword;charset=GB2312");
			type = "doc";
		}
		String gcxm_id = request.getParameter("gcxm_id");
		String dxgc_id = request.getParameter("dxgc_id");
		String[] results = request.getParameterValues("Cb_bgxd");
		StringBuffer result = new StringBuffer();
		for (int i = 0; i < results.length; i++) {
			if (results[i] != null && !results[i].equals("") && i != results.length - 1) {
		result.append(results[i]);
		result.append(",");
			}
			if (i == results.length - 1) {
		result.append(results[i]);
			}
		}
		String xx = new String(result);
		URL url = new URL("http://" + request.getLocalAddr() + ":" + request.getLocalPort() + "/" + request.getContextPath()
		+ "/print/print.jsp?type=print&dxgc_id=" + dxgc_id + "&gcxm_id=" + gcxm_id + "&xx=" + xx);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		XML2PDF_DOC transformer = new XML2PDF_DOC();
		OutputStream o = response.getOutputStream();
		transformer.transformer(type, con.getInputStream(), realPath, o);
		o.flush();
		o.close();
		out.clear();
		out = pageContext.pushBody();
	} catch (Exception ex) {
		response.reset();
		response.setContentType("text/html; charset=GB2312");
		out.print(ex);
	}
%>

