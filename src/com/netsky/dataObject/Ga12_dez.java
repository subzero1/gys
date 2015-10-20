/**
 * 
 */
package com.netsky.dataObject;

/**
 * 定额手册——章.
 * 
 * @hibernate.class table="GA12_DEZ"
 * @author wangflan
 * 
 */
public class Ga12_dez {
	/**
	 * 标识 主键
	 */
	private Integer id;

	/**
	 * 册ID
	 */
	private Integer c_id;

	/**
	 * 名称
	 */
	private String mc;

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
