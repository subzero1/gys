package com.netsky.dataObject;

import java.util.Date;

/**
 * 论坛附件表
 * 
 * @author Chiang 2008-08-20
 * @hibernate.class table="BBS03_SLAVE"
 */
public class Bbs03_slave implements SlaveObject{

	/**
	 * 标识
	 */
	private Integer id;

	/**
	 * 论坛贴标识
	 */
	private Integer bbs_id;

	/**
	 * 目标文件地址
	 */
	private String source_name;

	/**
	 * 文件名
	 */
	private String cur_name;

	/**
	 * 创建日期
	 */
	private Date dis_date;

	/**
	 * @return the bbs_id
	 * @hibernate.property column="bbs_id"
	 */
	public Integer getBbs_id() {
		return bbs_id;
	}

	/**
	 * @param bbs_id the bbs_id to set
	 */
	public void setBbs_id(Integer bbs_id) {
		this.bbs_id = bbs_id;
	}

	/**
	 * @return the cur_name
	 * @hibernate.property column="cur_name"
	 */
	public String getCur_name() {
		return cur_name;
	}

	/**
	 * @param cur_name the cur_name to set
	 */
	public void setCur_name(String cur_name) {
		this.cur_name = cur_name;
	}

	/**
	 * @return the dis_date
	 * @hibernate.property column="dis_date"
	 */
	public Date getDis_date() {
		return dis_date;
	}

	/**
	 * @param dis_date the dis_date to set
	 */
	public void setDis_date(Date dis_date) {
		this.dis_date = dis_date;
	}

	/**
	 * @hibernate.id generator-class="increment"
	 * @return id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return the source_name
	 * @hibernate.property column="source_name"
	 */
	public String getSource_name() {
		return source_name;
	}

	/**
	 * @param source_name the source_name to set
	 */
	public void setSource_name(String source_name) {
		this.source_name = source_name;
	}

	public String getSlaveIdentifier() {
		return "Bbs03_slave";
	}

	public void setFileName(String FileName) {
		this.setCur_name(FileName);
	}

	public void setFilePatch(String FilePatch) {
		this.setSource_name(FilePatch);
		
	}
	
	

}
