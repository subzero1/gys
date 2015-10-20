package com.netsky.servlet;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Gb01_yhb;
import com.netsky.service.QueryService;
/**
 * 用于检查用户注册的用户名是否在数据库里存在
 * @author CT
 * @create 2009-09-02
 */
public class CheckUserName implements Controller {
	/**
	 * 查寻Servcie
	 */
	private QueryService queryService;
	
	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("GBK");
		request.setCharacterEncoding("GBK");
		PrintWriter out = response.getWriter();
		
		String username = request.getParameter("username");
		
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb01_yhb.class);
		queryBuilder.eq("login_id", username);
		ResultObject ro = queryService.search(queryBuilder);
		
		Integer flag = new Integer(0);
		if(ro.getLength()==1){
			flag=new Integer(1);
		}
		out.print(flag);
		out.flush();
		out.close();
		return new ModelAndView("" + "");
	}

}
