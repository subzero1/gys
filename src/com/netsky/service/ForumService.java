package com.netsky.service;

import java.io.UnsupportedEncodingException;

/**
 * ��̳���Service
 * @author CT
 * @create 2009-09-01
 */
public interface ForumService {
	/**
	 * ��̳�ظ� ���Ҽ��������������±�bbs01
	 * @param bbs02_id
	 * @param user_id
	 */
	public void reply(Integer bbs02_id,Integer user_id );
	
	/**
	 * ������������ 
	 * @param bbs02_id
	 */
	public void hits(Integer bbs02_id);
	/**
	 * ������½�ʱ ������������������������bbs01
	 * @param bbs01_id
	 * @throws UnsupportedEncodingException 
	 */
	public void counts(Integer bbs01_id,String username,Integer userid ,String lastsubject,Integer lastbbs02_id) throws UnsupportedEncodingException;
	/**
	 * ���ͨ��
	 * @param yhb_id
	 * @param flag 1���ͨ����2��˲�ͨ��
	 */
	public void passcheck(Integer yhb_id,Integer flag);
	/**
	 * ��������
	 * @param id ����ID
	 */
	public void magtopic(Integer id ,String flag);
	/**
	 * ɾ����� ���id
	 * @param boradid
	 */
	public void delboard(Integer boradid);
}
