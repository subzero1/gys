/**
 * 
 */
package com.netsky.dataObject;

/**
 * ȡ������.
 * 
 * @hibernate.class table="GA07_QFQJ"
 * @author wangflan
 * 
 */
public class Ga07_qfqj {
	/**
	 * ��ʶ ����
	 */
	private Integer id;

	/**
	 * ����
	 */
	private Integer sx;

	/**
	 * ����
	 */
	private Integer xx;

	/**
	 * ÿ����
	 */
	private Integer mzj;

	/**
	 * ���
	 */
	private String qjlb;

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
	 * @hibernate.property column="mzj"
	 * @return the mzj
	 */
	public Integer getMzj() {
		return mzj;
	}

	/**
	 * @param mzj
	 *            the mzj to set
	 */
	public void setMzj(Integer mzj) {
		this.mzj = mzj;
	}

	/**
	 * @hibernate.property column="qjlb"
	 * @return the qjlb
	 */
	public String getQjlb() {
		return qjlb;
	}

	/**
	 * @param qjlb
	 *            the qjlb to set
	 */
	public void setQjlb(String qjlb) {
		this.qjlb = qjlb;
	}

	/**
	 * @hibernate.property column="sx"
	 * @return the sx
	 */
	public Integer getSx() {
		return sx;
	}

	/**
	 * @param sx
	 *            the sx to set
	 */
	public void setSx(Integer sx) {
		this.sx = sx;
	}

	/**
	 * @hibernate.property column="xx"
	 * @return the xx
	 */
	public Integer getXx() {
		return xx;
	}

	/**
	 * @param xx
	 *            the xx to set
	 */
	public void setXx(Integer xx) {
		this.xx = xx;
	}

}
