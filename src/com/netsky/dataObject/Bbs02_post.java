package com.netsky.dataObject;

import java.util.Date;

/**
 * �����
 * @author CT
 * @create 2009-08-26
 * @hibernate.class table="BBS02_POST"
 */
public class Bbs02_post {
	/**
	 * id
	 */
	private Integer id;
	/**
	 * ���ID
	 */
	private Integer board_id;
	/**
	 * ����
	 */
	private String topic;
	/**
	 * ����
	 */
	private String body;
	/**
	 * �ظ�¥ID
	 */
	private Integer parentid;
	/**
	 * ����ID
	 */
	private Integer rootid;
	/**
	 * �û�ID
	 */
	private Integer user_id;
	/**
	 * �û�����
	 */
	private String user_name;
	/**
	 * ����
	 */
	private Date rq;
	/**
	 * ����״̬
	 */
	private String status;
	/**
	 * ���ظ��û�����
	 */
	private String lastusername;
	/**
	 * ���ظ�����
	 */
	private Date lastrq;
	/**
	 * �����
	 */
	private Integer hits;
	/**
	 * �ظ���
	 */
	private Integer response;
	/**
	 * ɾ����־ 0 ɾ�� 1 ����
	 */
	private Integer delflag;
	/**
	 * @hibernate.property column="delflag"
	 * @return delflag
	 */
	public Integer getDelflag() {
		return delflag;
	}
	/**
	 * @param delflag
	 */
	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}
	/**
	 * @hibernate.property column="hits"
	 * @return hits
	 */
	public Integer getHits() {
		return hits;
	}
	/**
	 * @param hits
	 */
	public void setHits(Integer hits) {
		this.hits = hits;
	}
	/**
	 * @hibernate.property column="response"
	 * @return response
	 */
	public Integer getResponse() {
		return response;
	}
	/**
	 * @param response
	 */
	public void setResponse(Integer response) {
		this.response = response;
	}
	/**
	 * @hibernate.property column="board_id"
	 * @return board_id
	 */
	public Integer getBoard_id() {
		return board_id;
	}
	/**
	 * @param board_id
	 */
	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
	}
	/**
	 * @hibernate.property column="body"
	 * @return body
	 */
	public String getBody() {
		return body;
	}
	/**
	 * @param body
	 */
	public void setBody(String body) {
		this.body = body;
	}
	/**
	 * @hibernate.id generator-class="increment"
	 * @return id
	 */
	public Integer getId() {
		return id;
	}
	/**
	 * @param id
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	/**
	 * @hibernate.property column="lastrq"
	 * @return lastrq
	 */
	public Date getLastrq() {
		return lastrq;
	}
	/**
	 * @param lastrq
	 */
	public void setLastrq(Date lastrq) {
		this.lastrq = lastrq;
	}
	/**
	 * @hibernate.property column="lastusername"
	 * @return lastusername
	 */
	public String getLastusername() {
		return lastusername;
	}
	/**
	 * @param lastusername
	 */
	public void setLastusername(String lastusername) {
		this.lastusername = lastusername;
	}
	/**
	 * @hibernate.property column="parentid"
	 * @return parentid
	 */
	public Integer getParentid() {
		return parentid;
	}
	/**
	 * @param parentid
	 */
	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}
	/**
	 * @hibernate.property column="rootid"
	 * @return rootid
	 */
	public Integer getRootid() {
		return rootid;
	}
	/**
	 * @param rootid
	 */
	public void setRootid(Integer rootid) {
		this.rootid = rootid;
	}
	/**
	 * @hibernate.property column="rq"
	 * @return rq
	 */
	public Date getRq() {
		return rq;
	}
	/**
	 * @param rq
	 */
	public void setRq(Date rq) {
		this.rq = rq;
	}
	/**
	 * @hibernate.property column="status"
	 * @return status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @hibernate.property column="topic"
	 * @return topic
	 */
	public String getTopic() {
		return topic;
	}
	/**
	 * @param topic
	 */
	public void setTopic(String topic) {
		this.topic = topic;
	}
	/**
	 * @hibernate.property column="user_id"
	 * @return
	 */
	public Integer getUser_id() {
		return user_id;
	}
	/**
	 * @param user_id
	 */
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	/**
	 * @hibernate.property column="user_name"
	 * @return user_name
	 */
	public String getUser_name() {
		return user_name;
	}
	/**
	 * @param user_name
	 */
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	
}
