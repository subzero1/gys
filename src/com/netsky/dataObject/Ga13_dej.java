package com.netsky.dataObject;

/**
 * 定额手册——节(段).
 * 
 * @hibernate.class table="GA13_DEJ"
 * @author wangflan
 * 
 */
public class Ga13_dej {
	/**
	 * 标识 主键
	 */
	private Integer id;

	/**
	 * 册ID
	 */
	private Integer c_id;

	/**
	 * 章ID
	 */
	private Integer z_id;

	/**
	 * 名称
	 */
	private String mc;

	/**
	 * 起始编号
	 */
	private String qsbh;

	/**
	 * 终止编号
	 */
	private String jzbh;

	/**
	 * 说明
	 */
	private String sm;

	/**
	 * @hibernate.property column="c_id"
	 * @return the c_id
	 */
	public Integer getC_id() {
		return c_id;
	}

	/**
	 * @param c_id
	 *            the c_id to set
	 */
	public void setC_id(Integer c_id) {
		this.c_id = c_id;
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
	 * @hibernate.property column="jzbh"
	 * @return the jzbh
	 */
	public String getJzbh() {
		return jzbh;
	}

	/**
	 * @param jzbh
	 *            the jzbh to set
	 */
	public void setJzbh(String jzbh) {
		this.jzbh = jzbh;
	}

	/**
	 * @hibernate.property column="mc"
	 * @return the mc
	 */
	public String getMc() {
		return mc;
	}

	/**
	 * @param mc
	 *            the mc to set
	 */
	public void setMc(String mc) {
		this.mc = mc;
	}

	/**
	 * @hibernate.property column="qsbh"
	 * @return the qsbh
	 */
	public String getQsbh() {
		return qsbh;
	}

	/**
	 * @param qsbh
	 *            the qsbh to set
	 */
	public void setQsbh(String qsbh) {
		this.qsbh = qsbh;
	}

	/**
	 * @hibernate.property column="sm"
	 *                     type="org.springframework.orm.hibernate3.support.ClobStringType"
	 * @return the sm
	 */
	public String getSm() {
		return sm;
	}

	/**
	 * @param sm
	 *            the sm to set
	 */
	public void setSm(String sm) {
		this.sm = sm;
	}

	/**
	 * @hibernate.property column="z_id"
	 * @return the z_id
	 */
	public Integer getZ_id() {
		return z_id;
	}

	/**
	 * @param z_id
	 *            the z_id to set
	 */
	public void setZ_id(Integer z_id) {
		this.z_id = z_id;
	}

}
