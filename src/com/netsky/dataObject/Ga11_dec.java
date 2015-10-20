package com.netsky.dataObject;

/**
 * 定额手册——册.
 * 
 * @hibernate.class table="GA11_DEC"
 * @author wangflan
 * 
 */
public class Ga11_dec {
	/**
	 * 标识 主键
	 */
	private Integer id;

	/**
	 * 编号
	 */
	private String bm;

	/**
	 * 名称
	 */
	private String mc;

	/**
	 * 说明
	 */
	private String sm;

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
	 * @hibernate.property column="bm"
	 * @return the bm
	 */
	public String getBm() {
		return bm;
	}

	/**
	 * @param bm
	 *            the bm to set
	 */
	public void setBm(String bm) {
		this.bm = bm;
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

}
