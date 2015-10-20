package com.netsky.dataObject;

import java.util.Date;

/**
 * 板块表
 * @author CT
 * @create 2009-08-25
 * @hibernate.class table="BBS01_BOARD"
 */
public class Bbs01_board {
	/**
	 * id
	 */
	private Integer id;
	/**
	 * 父类模板ID
	 */
	private Integer parentid;
	/**
	 * 模板名称
	 */
	private String name;
	/**
	 * 模板描述
	 */
	private String description;
	/**
	 * 最后发布主题
	 */
	private String lastsubject;
	/**
	 * 最后用户名称
	 */
	private String lastusername;
	/**
	 * 最后发布日期
	 */
	private Date lastrq;
	/**
	 * 最大帖子数
	 */
	private Integer topiccount;
	/**
	 * 最大主题数
	 */
	private Integer subjectcount;
	/**
	 * 最后一个主题ID
	 */
	private Integer lastbbs02_id;
	/**
	 * 最后一个发表主题的用户ID
	 */
	private Integer lastuser_id;
	/**
	 * 顺序
	 */
	private Integer ord;
	/**
	 * 显示标志
	 */
	private Integer showflag;
	/**
	 * 管理员控制；只有管理员才能回复的版块
	 */
	private Integer admincontrol;
	/**
	 * @hibernate.property column="admincontrol"
	 * @return admincontrol
	 */
	public Integer getAdmincontrol() {
		return admincontrol;
	}
	/**
	 * @param admincontrol
	 */
	public void setAdmincontrol(Integer admincontrol) {
		this.admincontrol = admincontrol;
	}
	/**
	 * @hibernate.property column="ord"
	 * @return ord
	 */
	public Integer getOrd() {
		return ord;
	}
	/**
	 * @param ord
	 */
	public void setOrd(Integer ord) {
		this.ord = ord;
	}
	/**
	 * @hibernate.property column="showflag"
	 * @return showflag
	 */
	public Integer getShowflag() {
		return showflag;
	}
	/**
	 * @param showflag
	 */
	public void setShowflag(Integer showflag) {
		this.showflag = showflag;
	}
	/**
	 * @hibernate.property column="lastuser_id"
	 * @return lastuser_id
	 */
	public Integer getLastuser_id() {
		return lastuser_id;
	}
	/**
	 * @param lastuser_id
	 */
	public void setLastuser_id(Integer lastuser_id) {
		this.lastuser_id = lastuser_id;
	}
	/**
	 * @hibernate.property column="lastbbs02_id"
	 * @return lastbbs02_id
	 */
	public Integer getLastbbs02_id() {
		return lastbbs02_id;
	}
	/**
	 * @param lastbbs02_id
	 */
	public void setLastbbs02_id(Integer lastbbs02_id) {
		this.lastbbs02_id = lastbbs02_id;
	}
	/**
	 * @return description
	 * @hibernate.property column="description"
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @return id
	 * @hibernate.id generator-class="increment"
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
	 * @return
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
	 * @hibernate.property column="lastsubject"
	 * @return
	 */
	public String getLastsubject() {
		return lastsubject;
	}
	/**
	 * @param lastsubject
	 */
	public void setLastsubject(String lastsubject) {
		this.lastsubject = lastsubject;
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
	 * @hibernate.property column="name"
	 * @return
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
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
	 * @hibernate.property column="subjectcount"
	 * @return subjectcount
	 */
	public Integer getSubjectcount() {
		return subjectcount;
	}
	/**
	 * @param subjectcount
	 */
	public void setSubjectcount(Integer subjectcount) {
		this.subjectcount = subjectcount;
	}
	/**
	 * @hibernate.property column="topiccount"
	 * @return topiccount
	 */
	public Integer getTopiccount() {
		return topiccount;
	}
	/**
	 * @param topiccount
	 */
	public void setTopiccount(Integer topiccount) {
		this.topiccount = topiccount;
	}
	
	
	
}
