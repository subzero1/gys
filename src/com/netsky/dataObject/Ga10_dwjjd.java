/**
 * 
 */
package com.netsky.dataObject;

/**
 * ��λ������.
 * 
 * @hibernate.class table="GA10_DWJJD"
 * @author wangflan
 * 
 */
public class Ga10_dwjjd {
	/**
	 * ��ʶ ����
	 */
	private Integer id;

	/**
	 * ��λ����
	 */
	private String dwmc;

	/**
	 * ��� DE������ ZC������ SB���豸
	 */
	private String lb;

	/**
	 * ���ȣ�������λС���� 0��ȡ��
	 */
	private Integer jd;


	/**
	 * @hibernate.property column="dwmc"
	 * @return the dwmc
	 */
	public String getDwmc() {
		return dwmc;
	}

	/**
	 * @param dwmc
	 *            the dwmc to set
	 */
	public void setDwmc(String dwmc) {
		this.dwmc = dwmc;
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
	 * @hibernate.property column="jd"
	 * @return the jd
	 */
	public Integer getJd() {
		return jd;
	}

	/**
	 * @param jd
	 *            the jd to set
	 */
	public void setJd(Integer jd) {
		this.jd = jd;
	}

	/**
	 * @hibernate.property column="lb"
	 * @return the lb
	 */
	public String getLb() {
		return lb;
	}

	/**
	 * @param lb
	 *            the lb to set
	 */
	public void setLb(String lb) {
		this.lb = lb;
	}


}
