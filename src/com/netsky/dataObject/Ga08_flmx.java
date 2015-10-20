package com.netsky.dataObject;

/**
 * ������ϸ��.
 * 
 * @hibernate.class table="GA08_FLMX"
 * @author wangflan
 * 
 */
public class Ga08_flmx {
	/**
	 * ��ʶ ����
	 */
	private Integer id;

	/**
	 * ���ʿ�ID
	 */
	private Integer flk_id;

	/**
	 * ����ID
	 */
	private Integer fy_id;

	/**
	 * רҵID
	 */
	private Integer zy_id;

	/**
	 * ȡ������ID
	 */
	private Integer qj_id;

	/**
	 * �������
	 */
	private String zclb;

	/**
	 * ����ֵ
	 */
	private Double flz;

	/**
	 * �����
	 */
	private String bgbh;

	/**
	 * ���̷��ʱ�־ 1�����̷���
	 */
	private Integer gcflbz;

	/**
	 * ����˵��
	 */
	private String flsm;

	/**
	 * @hibernate.property column="bgbh"
	 * @return the bgbh
	 */
	public String getBgbh() {
		return bgbh;
	}

	/**
	 * @param bgbh
	 *            the bgbh to set
	 */
	public void setBgbh(String bgbh) {
		this.bgbh = bgbh;
	}

	/**
	 * @hibernate.property column="flk_id"
	 * @return the flk_id
	 */
	public Integer getFlk_id() {
		return flk_id;
	}

	/**
	 * @param flk_id
	 *            the flk_id to set
	 */
	public void setFlk_id(Integer flk_id) {
		this.flk_id = flk_id;
	}

	/**
	 * @hibernate.property column="flsm"
	 * @return the flsm
	 */
	public String getFlsm() {
		return flsm;
	}

	/**
	 * @param flsm
	 *            the flsm to set
	 */
	public void setFlsm(String flsm) {
		this.flsm = flsm;
	}

	/**
	 * @hibernate.property column="flz"
	 * @return the flz
	 */
	public Double getFlz() {
		return flz;
	}

	/**
	 * @param flz
	 *            the flz to set
	 */
	public void setFlz(Double flz) {
		this.flz = flz;
	}

	/**
	 * @hibernate.property column="fy_id"
	 * @return the fy_id
	 */
	public Integer getFy_id() {
		return fy_id;
	}

	/**
	 * @param fy_id
	 *            the fy_id to set
	 */
	public void setFy_id(Integer fy_id) {
		this.fy_id = fy_id;
	}

	/**
	 * @hibernate.property column="gcflbz"
	 * @return the gcflbz
	 */
	public Integer getGcflbz() {
		return gcflbz;
	}

	/**
	 * @param gcflbz
	 *            the gcflbz to set
	 */
	public void setGcflbz(Integer gcflbz) {
		this.gcflbz = gcflbz;
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
	 * @hibernate.property column="qj_id"
	 * @return the qj_id
	 */
	public Integer getQj_id() {
		return qj_id;
	}

	/**
	 * @param qj_id
	 *            the qj_id to set
	 */
	public void setQj_id(Integer qj_id) {
		this.qj_id = qj_id;
	}

	/**
	 * @hibernate.property column="zclb"
	 * @return the zclb
	 */
	public String getZclb() {
		return zclb;
	}

	/**
	 * @param zclb
	 *            the zclb to set
	 */
	public void setZclb(String zclb) {
		this.zclb = zclb;
	}

	/**
	 * @hibernate.property column="zy_id"
	 * @return the zy_id
	 */
	public Integer getZy_id() {
		return zy_id;
	}

	/**
	 * @param zy_id
	 *            the zy_id to set
	 */
	public void setZy_id(Integer zy_id) {
		this.zy_id = zy_id;
	}

}
