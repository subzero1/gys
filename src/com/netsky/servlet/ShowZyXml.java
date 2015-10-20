package com.netsky.servlet;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga06_zy;
import com.netsky.dataObject.Ga14_b3jcfl;
import com.netsky.dataObject.Gd10_b3fl;
import com.netsky.service.QueryService;

public class ShowZyXml implements Controller {

	private QueryService queryService;

	public QueryService getQueryService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("GBK");

		String bz = request.getParameter("bz");
		if ("1".equals(bz)) {
			Ga06_zy ga06 = null;
			String lb = request.getParameter("lb");
			String HSql = "select ga06 from Ga06_zy ga06 where ga06.lb='" + lb
					+ "'";
			ResultObject ro = queryService.search(HSql);

			out.println("<response>");
			while (ro.next()) {
				ga06 = (Ga06_zy) ro.get("ga06");
				if (ga06 != null) {
					out.println("<lb>");
					out.println("<lb_mc>" + ga06.getMc() + "</lb_mc>");
					out.println("<lb_id>" + ga06.getId() + "</lb_id>");
					out.println("</lb>");
				}
			}
			out.println("</response>");
		}
		if ("2".equals(bz)) {

			String ysz = request.getParameter("ysz");
			String flk_id = request.getParameter("flk_id");
			// ysz=flk_id 费率库还是原来的
			if (!ysz.equals(flk_id)) {
				String HSqll = "select ga14 from Ga14_b3jcfl ga14 where ga14.bz=1 and ga14.fylb=1 and flk_id="+ flk_id+" order by id asc";
				String HSql2 = "select ga14 from Ga14_b3jcfl ga14 where ga14.bz=2 and ga14.fylb=1 and flk_id="
						+ flk_id;
				ResultObject ro1 = queryService.search(HSqll);
				ResultObject ro2 = queryService.search(HSql2);
				Ga14_b3jcfl ga14_1 = null;
				Ga14_b3jcfl ga14_2 = null;

				int n = 0;
				int m = 0;
				if (ro1.getLength() >= ro2.getLength()) {
					m = ro1.getLength();
				} else {
					m = ro2.getLength();
				}
				out.println("<response>");
				while (n < m) {
					ro1.next();
					ro2.next();
					ga14_1 = (Ga14_b3jcfl) ro1.get("ga14");
					ga14_2 = (Ga14_b3jcfl) ro2.get("ga14");
					out.println("<flk>");
					if (ga14_1 != null) {
						out.println("<flid_g>" + ga14_1.getId() + "</flid_g>");
						out.println("<flmc_g>" + ga14_1.getMc() + "</flmc_g>");
						out.println("<flflag_g>null</flflag_g>");
					} else {
						out.println("<flid_g>null</flid_g>");
						out.println("<flmc_g>null</flmc_g>");
						out.println("<flflag_g>null</flflag_g>");
					}
					if (ga14_2 != null) {
						out.println("<flid_s>" + ga14_2.getId() + "</flid_s>");
						out.println("<flmc_s>" + ga14_2.getMc() + "</flmc_s>");
						out.println("<flflag_s>null</flflag_s>");
					} else {
						out.println("<flid_s>null</flid_s>");
						out.println("<flmc_s>null</flmc_s>");
						out.println("<flflag_s>null</flflag_s>");
					}
					out.println("</flk>");
					n++;
				}
				out.println("</response>");
			} else {
				
				String dxgc_id = request.getParameter("dxgc_id");
				String HSql3 = "select gd10 from Gd10_b3fl gd10 where gd10.bz=1 and gd10.fylb=1 and gd10.dxgc_id="
						+ dxgc_id;
				String HSql4 = "select gd10 from Gd10_b3fl gd10 where gd10.bz=2 and gd10.fylb=1 and gd10.dxgc_id="
						+ dxgc_id;
				ResultObject ro1 = queryService.search(HSql3);
				ResultObject ro2 = queryService.search(HSql4);
				Gd10_b3fl gd10_1 = null;
				Gd10_b3fl gd10_2 = null;

				int n = 0;
				int m = 0;
				if (ro1.getLength() >= ro2.getLength()) {
					m = ro1.getLength();
				} else {
					m = ro2.getLength();
				}
				out.println("<response>");
				while (n < m) {
					ro1.next();
					ro2.next();
					gd10_1 = (Gd10_b3fl) ro1.get("gd10");
					gd10_2 = (Gd10_b3fl) ro2.get("gd10");
					out.println("<flk>");
					if (gd10_1 != null) {
						out.println("<flid_g>" + gd10_1.getId() + "</flid_g>");
						out.println("<flmc_g>" + gd10_1.getMc() + "</flmc_g>");
						out.println("<flflag_g>" + gd10_1.getFlag() + "</flflag_g>");
					} else {
						out.println("<flid_g>null</flid_g>");
						out.println("<flmc_g>null</flmc_g>");
						out.println("<flflag_g>null</flflag_g>");
					}
					if (gd10_2 != null) {
						out.println("<flid_s>" + gd10_2.getId() + "</flid_s>");
						out.println("<flmc_s>" + gd10_2.getMc() + "</flmc_s>");
						out.println("<flflag_s>" + gd10_2.getFlag() + "</flflag_s>");
					} else {
						out.println("<flid_s>null</flid_s>");
						out.println("<flmc_s>null</flmc_s>");
						out.println("<flflag_s>null</flflag_s>");
					}
					out.println("</flk>");
					n++;
				}
				out.println("</response>");
			}
		}
		out.flush();
		out.close();

		return new ModelAndView("" + "");
	}
}
