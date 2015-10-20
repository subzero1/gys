package com.netsky.dataObject;

import java.util.Date;

/**
 * 登录日志.
 * 
 * @hibernate.class table="GB02_DLRZ"
 * @author wangflan
 * 
 */
public class Gb02_dlrz {
	/**
	 * 标识 主键
	 */
	private Integer id;

	/**
	 * 登录人姓名
	 */
	private String name;

	/**
	 * 登录人登录号
	 */
	private String login_id;

	/**
	 * 登录人IP
	 */
	private String ip;

	/**
	 * 操作时间
	 */
	private Date op_date;

	/**
	 * 标识 0：登录 1：注销
	 */
	private Integer flag;

	/**
	 * @hibernate.property column="flag"
	 * @return the flag
	 */
	public Integer getFlag() {
		return flag;
	}

	/**
	 * @param flag
	 *            the flag to set
	 */
	public void setFlag(Integer flag) {
		this.flag = flag;
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
	 *            the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @hibernate.property column="ip"
	 * @return the ip
	 */
	public String getIp() {
		return ip;
	}

	/**
	 * @param ip
	 *            the ip to set
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}

	/**
	 * @hibernate.property column="login_id"
	 * @return the login_id
	 */
	public String getLogin_id() {
		return login_id;
	}

	/**
	 * @param login_id
	 *            the login_id to set
	 */
	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}

	/**
	 * @hibernate.property column="name"
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @hibernate.property column="op_date"
	 * @return the op_date
	 */
	public Date getOp_date() {
		return op_date;
	}

	/**
	 * @param op_date
	 *            the op_date to set
	 */
	public void setOp_date(Date op_date) {
		this.op_date = op_date;
	}

}
