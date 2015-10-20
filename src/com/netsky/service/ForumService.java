package com.netsky.service;

import java.io.UnsupportedEncodingException;

/**
 * 论坛相关Service
 * @author CT
 * @create 2009-09-01
 */
public interface ForumService {
	/**
	 * 论坛回复 并且计算帖子数并更新表bbs01
	 * @param bbs02_id
	 * @param user_id
	 */
	public void reply(Integer bbs02_id,Integer user_id );
	
	/**
	 * 计算点击帖子数 
	 * @param bbs02_id
	 */
	public void hits(Integer bbs02_id);
	/**
	 * 如果是新建时 计算主题数和帖子数并更新bbs01
	 * @param bbs01_id
	 * @throws UnsupportedEncodingException 
	 */
	public void counts(Integer bbs01_id,String username,Integer userid ,String lastsubject,Integer lastbbs02_id) throws UnsupportedEncodingException;
	/**
	 * 审核通过
	 * @param yhb_id
	 * @param flag 1审核通过，2审核不通过
	 */
	public void passcheck(Integer yhb_id,Integer flag);
	/**
	 * 管理主题
	 * @param id 主题ID
	 */
	public void magtopic(Integer id ,String flag);
	/**
	 * 删除板块 板块id
	 * @param boradid
	 */
	public void delboard(Integer boradid);
}
