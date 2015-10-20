package com.netsky.servlet;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Bbs02_post;
import com.netsky.dataObject.Gb01_yhb;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;
/**
 * ·¢Ìû
 * @author CT
 * @create 2009-08-28
 */
public class PostSubject implements Controller {
	/**
	 * ²éÑ¯service
	 */
	private QueryService queryService;
	/**
	 * ±£´æservice
	 */
	private SaveService saveService;
	
	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("GBK");
		Integer user_id = new Integer(request.getParameter("user_id"));
		Integer boardid = new Integer(request.getParameter("boardid"));
		String topic = request.getParameter("subject");
		String body = request.getParameter("message");
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb01_yhb.class);
		queryBuilder.eq("id", user_id);
		ResultObject ro = queryService.search(queryBuilder);
		Gb01_yhb yhb = new Gb01_yhb();
		if(ro.next()){
			yhb = (Gb01_yhb)ro.get(Gb01_yhb.class.getName());
		}
		
		Bbs02_post bbs02 = new Bbs02_post();
		bbs02.setBoard_id(boardid);
		bbs02.setBody(body);
		bbs02.setRq(new Date());
		bbs02.setTopic(topic);
		bbs02.setUser_id(yhb.getId());
		bbs02.setUser_name(yhb.getName());
		bbs02.setStatus(new String("NORMAL"));
		saveService.save(bbs02);
		return new ModelAndView("redirect:../bbs/forumdisplay.jsp?boardid="+boardid);
	}

}
