package com.netsky.dataObject;

/**
 * �����������ʱ�
 * 
 * @hibernate.class table="GA14_B3JCFL"
 * @author CT
 * 
 */
public class Ga14_b3jcfl {
	/**
	 * id
	 */
	private Integer id;

	/**
	 * ���ʿ�id GA04.ID
	 */
	private Integer flk_id;

	/**
	 * ����
	 */
	private String mc;

	/**
	 * �˹�����
	 */
	private Double rgfl;

	/**
	 * ��е����
	 */
	private Double jxfl;

	/**
	 * ������� 1���˹���2����е
	 */
	private Integer fylb;

	/**
	 * ʩ��������־ 1����ԭ��2��ɭ��ɳĮ
	 */
	private Integer bz;

	/**
	 * @hibernate.property column="bz"
	 * @return bz
	 */
	public Integer getBz() {
		return bz;
	}

	/**
	 * @param bz
	 */
	public void setBz(Integer bz) {
		this.bz = bz;
	}

	/**
	 * @return the jxfl
	 * @hibernate.property column="jxfl"
	 */
	public Double getJxfl() {
		return jxfl;
	}

	/**
	 * @param jxfl
	 *            the jxfl to set
	 */
	public void setJxfl(Double jxfl) {
		this.jxfl = jxfl;
	}

	/**
	 * @return the rgfl
	 * @hibernate.property column="rgfl"
	 */
	public Double getRgfl() {
		return rgfl;
	}

	/**
	 * @param rgfl
	 *            the rgfl to set
	 */
	public void setRgfl(Double rgfl) {
		this.rgfl = rgfl;
	}

	/**
	 * @hibernate.property column="flk_id"
	 * @return flk_id
	 */
	public Integer getFlk_id() {
		return flk_id;
	}

	/**
	 * @param flk_id
	 */
	public void setFlk_id(Integer flk_id) {
		this.flk_id = flk_id;
	}

	/**
	 * @hibernate.property column="fylb"
	 * @return fylb
	 */
	public Integer getFylb() {
		return fylb;
	}

	/**
	 * @param fylb
	 */
	public void setFylb(Integer fylb) {
		this.fylb = fylb;
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
	 * @hibernate.property column="mc"
	 * @return mc
	 */
	public String getMc() {
		return mc;
	}

	/**
	 * @param mc
	 */
	public void setMc(String mc) {
		this.mc = mc;
	}
}
