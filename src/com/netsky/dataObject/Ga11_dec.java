package com.netsky.dataObject;

/**
 * �����ֲᡪ����.
 * 
 * @hibernate.class table="GA11_DEC"
 * @author wangflan
 * 
 */
public class Ga11_dec {
	/**
	 * ��ʶ ����
	 */
	private Integer id;

	/**
	 * ���
	 */
	private String bm;

	/**
	 * ����
	 */
	private String mc;

	/**
	 * ˵��
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
