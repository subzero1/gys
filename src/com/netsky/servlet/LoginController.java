package com.netsky.servlet;

import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseFormatUtils.DateFormatUtil;
import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Gb01_yhb;
import com.netsky.dataObject.Gb02_dlrz;
import com.netsky.listener.LoginListener;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

import java.util.Date;

public class LoginController implements Controller {

	private QueryService queryService;

	public QueryService getQueryService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	private SaveService saveService;

	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("GBK");
		String yh_ip = request.getRemoteAddr();
		String user = request.getParameter("loginID");
		String pass = request.getParameter("password");
		String url = null;
		if (request.getParameter("url") != null) {
			url = request.getParameter("url");
		}
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb01_yhb.class);
		queryBuilder.eq("login_id", user);
		queryBuilder.eq("passwd", pass);
		ResultObject ro = queryService.search(queryBuilder);
		Date nowtime = new Date();
		if (ro.next()) {
			Gb01_yhb yhb = (Gb01_yhb) ro.get(Gb01_yhb.class.getName());
			String limit_date = DateFormatUtil.Format(yhb.getLimit_date(), "yyyy-MM-dd");

			if (limit_date != null && !"".equals(limit_date)) {
				if (nowtime.before(yhb.getLimit_date())) {
					HttpSession session = request.getSession();
					session.removeAttribute("LoginListener");
					session.setAttribute("yhb", yhb);
					session.setAttribute("LoginListener", new LoginListener(yhb));
					dlrz(yhb.getName(), yhb.getLogin_id(), yh_ip, nowtime, new Integer(0));
					if (yhb.getState().equals("1")) {// ÉóºËÍ¨¹ý
						if (url != null) {
							return new ModelAndView("redirect:" + url);
						} else {
							return new ModelAndView("redirect:" + "../main.jsp");
						}
					} else if (yhb.getState().equals("0")) {// ´ýÉó
						return new ModelAndView("redirect:" + "../loginError.jsp?cwbz=3");
					} else {
						return new ModelAndView("redirect:" + "../loginError.jsp?cwbz=4");
					}
				} else {
					return new ModelAndView("redirect:" + "../loginError.jsp?cwbz=2");
				}
			} else {
				HttpSession session = request.getSession();
				session.removeAttribute("LoginListener");
				session.setAttribute("yhb", yhb);
				session.setAttribute("LoginListener", new LoginListener(yhb));
				dlrz(yhb.getName(), yhb.getLogin_id(), yh_ip, nowtime, new Integer(0));
				if (yhb.getState().equals("1")) {// ÉóºËÍ¨¹ý
					if (url != null) {
						return new ModelAndView("redirect:" + url);
					} else {
						return new ModelAndView("redirect:" + "../main.jsp");
					}
				} else if (yhb.getState().equals("0")) {// ´ýÉó
					return new ModelAndView("redirect:" + "../loginError.jsp?cwbz=3");
				} else {
					return new ModelAndView("redirect:" + "../loginError.jsp?cwbz=4");
				}
			}

		} else {
			return new ModelAndView("redirect:" + "../loginError.jsp?cwbz=1");
		}

	}

	private void dlrz(String name, String login_id, String ip, Date op_date, Integer flag) throws UnknownHostException {
		Gb02_dlrz gb02 = new Gb02_dlrz();
		gb02.setName(name);
		gb02.setLogin_id(login_id);
		gb02.setIp(ip);
		gb02.setOp_date(op_date);
		gb02.setFlag(flag);
		saveService.save(gb02);
	}
}