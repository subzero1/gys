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
import com.netsky.service.ForumService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;
/**
 * 回复
 * @author CT
 * @create 2009-08-27
 */
public class Reply implements Controller {
	/**
	 * 查询service
	 */
	private QueryService queryService;
	/**
	 * 保存service
	 */
	private SaveService saveService;
	/**
	 * 论坛service
	 */
	private ForumService forumService;
		
	public void setForumService(ForumService forumService) {
		this.forumService = forumService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("GBK");
		
		String topic = request.getParameter("subject");
		String body = request.getParameter("message");
		Integer user_id = new Integer(request.getParameter("user_id"));
		Integer bbs02_id = new Integer(request.getParameter("bbs02"));
		Integer bbs01_id = new Integer(request.getParameter("bbs01_id"));
		
		QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gb01_yhb.class);
		queryBuilder9.eq("id", user_id);
		ResultObject ro9 = queryService.search(queryBuilder9);
		Gb01_yhb yhb= new Gb01_yhb();
		if(ro9.next()){
			yhb = (Gb01_yhb)ro9.get(Gb01_yhb.class.getName());
		}
		
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Bbs02_post.class);
		queryBuilder.eq("id", bbs02_id);
		ResultObject ro = queryService.search(queryBuilder);
		Bbs02_post bbs02 = new Bbs02_post();
		if(ro.next()){
			bbs02 = (Bbs02_post)ro.get(Bbs02_post.class.getName());
		}
		Date date= new Date();
		bbs02.setLastusername(yhb.getName());
		bbs02.setLastrq(date);
		saveService.save(bbs02);
		
		Bbs02_post reply = new Bbs02_post();
		reply.setBoard_id(bbs02.getBoard_id());
		reply.setBody(bbs02.getBody());
		reply.setTopic(topic);
		reply.setBody(body);
		reply.setRootid(bbs02.getId());
		reply.setUser_id(user_id);
		reply.setUser_name(yhb.getName());
		reply.setRq(date);
		saveService.save(reply);
		
		forumService.reply(bbs02_id, user_id);
		
		return new ModelAndView("redirect:../bbs/viewthread.jsp?bbs02_id="+bbs02_id+"&bbs01_id="+bbs01_id);
	}

}
