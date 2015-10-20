package com.netsky.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.Date;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Bbs01_board;
import com.netsky.dataObject.Bbs02_post;
import com.netsky.dataObject.Gb01_yhb;
import com.netsky.service.ForumService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

/**
 * 论坛相关服务
 * 
 * @author CT
 * @create 2009-09-01
 */
public class ForumServiceImpl implements ForumService {

	private QueryService queryService;

	private SaveService saveService;

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	/**
	 * 论坛回复
	 */
	public void reply(Integer bbs02_id, Integer user_id) {

		QueryBuilder queryBuilder = new HibernateQueryBuilder(Bbs02_post.class);
		queryBuilder.eq("id", bbs02_id);
		ResultObject ro = queryService.search(queryBuilder);
		Bbs02_post bbs02 = new Bbs02_post();
		if (ro.next()) {
			bbs02 = (Bbs02_post) ro.get(Bbs02_post.class.getName());
		}

		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gb01_yhb.class);
		queryBuilder1.eq("id", user_id);
		ResultObject ro1 = queryService.search(queryBuilder1);
		Gb01_yhb yhb = new Gb01_yhb();
		if (ro1.next()) {
			yhb = (Gb01_yhb) ro1.get(Gb01_yhb.class.getName());
		}

		Date date = new Date();
		bbs02.setLastusername(yhb.getName());
		bbs02.setLastrq(date);
		Integer res = new Integer(0);
		if (bbs02.getResponse() != null) {
			res = bbs02.getResponse();
		}
		bbs02.setResponse(new Integer(res.intValue() + 1));
		saveService.save(bbs02);

		// 计算帖子数
		QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Bbs01_board.class);
		queryBuilder2.eq("id", bbs02.getBoard_id());
		ResultObject ro2 = queryService.search(queryBuilder2);
		Bbs01_board bbs01 = new Bbs01_board();
		if (ro2.next()) {
			bbs01 = (Bbs01_board) ro2.get(Bbs01_board.class.getName());
		}
		Integer subjectcount = new Integer(0);
		if (bbs01.getSubjectcount() != null) {
			subjectcount = bbs01.getSubjectcount();
		}
		bbs01.setSubjectcount(new Integer(subjectcount.intValue() + 1));
		// bbs01.setLastusername(yhb.getName());
		// bbs01.setLastrq(date);
		saveService.save(bbs01);

	}

	/**
	 * 计算帖子点击数
	 */
	public void hits(Integer bbs02_id) {
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Bbs02_post.class);
		queryBuilder.eq("id", bbs02_id);
		ResultObject ro = queryService.search(queryBuilder);
		Bbs02_post bbs02 = new Bbs02_post();
		if (ro.next()) {
			bbs02 = (Bbs02_post) ro.get(Bbs02_post.class.getName());
		}

		Integer hits = new Integer(0);
		if (bbs02.getHits() != null) {
			hits = bbs02.getHits();
		}
		bbs02.setHits(new Integer(hits.intValue() + 1));
		saveService.save(bbs02);
	}

	/**
	 * 新建帖子时计算主题数帖子数
	 * 
	 * @throws UnsupportedEncodingException
	 */
	public void counts(Integer bbs01_id, String username, Integer userid, String lastsubject, Integer lastbbs02_id)
			throws UnsupportedEncodingException {

		QueryBuilder queryBuilder = new HibernateQueryBuilder(Bbs01_board.class);
		queryBuilder.eq("id", bbs01_id);
		ResultObject ro = queryService.search(queryBuilder);
		Bbs01_board bbs01 = new Bbs01_board();
		if (ro.next()) {
			bbs01 = (Bbs01_board) ro.get(Bbs01_board.class.getName());
		}
		Integer subjectcount = new Integer(0);
		if (bbs01.getSubjectcount() != null) {
			subjectcount = bbs01.getSubjectcount();
		}
		Integer topiccount = new Integer(0);
		if (bbs01.getTopiccount() != null) {
			topiccount = bbs01.getTopiccount();
		}
		bbs01.setSubjectcount(new Integer(subjectcount.intValue() + 1));
		bbs01.setTopiccount(new Integer(topiccount.intValue() + 1));
		bbs01.setLastrq(new Date());
		bbs01.setLastuser_id(userid);
		bbs01.setLastusername(new String(username.getBytes("iso-8859-1"), "GBK"));
		bbs01.setLastsubject(new String(lastsubject.getBytes("iso-8859-1"), "GBK"));
		bbs01.setLastbbs02_id(lastbbs02_id);
		saveService.save(bbs01);
	}

	/**
	 * 审核通过
	 */
	public void passcheck(Integer yhb_id, Integer flag) {

		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb01_yhb.class);
		queryBuilder.eq("id", yhb_id);
		ResultObject ro = queryService.search(queryBuilder);
		Gb01_yhb yhb = new Gb01_yhb();
		if (ro.next()) {
			yhb = (Gb01_yhb) ro.get(Gb01_yhb.class.getName());
		}
		if (yhb != null) {
			if (flag.intValue() == 1) {
				yhb.setState("1");
			} else {
				yhb.setState("2");
			}
		}
		saveService.save(yhb);
	}

	/**
	 * 管理主题
	 * 
	 * @param id
	 *            主题ID
	 */
	public void magtopic(Integer id, String flag) {
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Bbs02_post.class);
		queryBuilder.eq("id", id);
		ResultObject ro = queryService.search(queryBuilder);
		Bbs02_post bbs02 = new Bbs02_post();
		if (ro.next()) {
			bbs02 = (Bbs02_post) ro.get(Bbs02_post.class.getName());
		}
		if (bbs02.getStatus() == null)
			bbs02.setStatus(flag);
		else if (bbs02.getStatus().indexOf(flag) == -1)
			bbs02.setStatus(bbs02.getStatus() + flag);
		else
			bbs02.setStatus(bbs02.getStatus().replaceAll("\\" + flag, ""));
		if(flag.equals("[NORMAL]"))
			bbs02.setStatus(null);
		saveService.save(bbs02);
	}

	/**
	 * 删除主题
	 * 
	 */
	public void delboard(Integer id) {
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Bbs01_board.class);
		queryBuilder.eq("id", id);
		ResultObject ro = queryService.search(queryBuilder);
		Bbs01_board bbs01 = new Bbs01_board();
		if (ro.next()) {
			bbs01 = (Bbs01_board) ro.get(Bbs01_board.class.getName());
		}
		saveService.removeObject(bbs01);

		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Bbs02_post.class);
		queryBuilder1.eq("board_id", id);
		ResultObject ro1 = queryService.search(queryBuilder1);
		Bbs02_post bbs02 = new Bbs02_post();
		while (ro1.next()) {
			bbs02 = (Bbs02_post) ro1.get(Bbs02_post.class.getName());
			if (bbs02.getId() != null) {
				saveService.removeObject(bbs02);
			}
		}

	}

}
