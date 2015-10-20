package com.netsky.dataObject;

import java.io.Serializable;

/**
 * ��������Ļ�е�������Ǳ����ϡ��豸��ϵ��
 * 
 * @hibernate.class table="GD10_B3FL"
 * @author CT
 * 
 */
public class Gd10_b3fl implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 620453722781145847L;

	/**
	 * id
	 */
	private Integer id;

	/**
	 * ������ĿID
	 */
	private Integer gcxm_id;

	/**
	 * �����ID
	 */
	private Integer dxgc_id;

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
	 * �������1���˹���2����е
	 */
	private Integer fylb;

	/**
	 * ʩ��������־1����ԭ��2��ɭ��ɳĮ
	 */
	private Integer bz;

	/**
	 * ��־
	 */
	private Integer flag;

	/**
	 * @hibernate.property column="flag"
	 * @return flag
	 */
	public Integer getFlag() {
		return flag;
	}

	/**
	 * @param flag
	 */
	public void setFlag(Integer flag) {
		this.flag = flag;
	}

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
	 * @hibernate.property column="dxgc_id"
	 * @return dxgc_id
	 */
	public Integer getDxgc_id() {
		return dxgc_id;
	}

	/**
	 * @param dxgc_id
	 */
	public void setDxgc_id(Integer dxgc_id) {
		this.dxgc_id = dxgc_id;
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
	 * @hibernate.property column="gcxm_id"
	 * @return
	 */
	public Integer getGcxm_id() {
		return gcxm_id;
	}

	/**
	 * @param gcxm_id
	 */
	public void setGcxm_id(Integer gcxm_id) {
		this.gcxm_id = gcxm_id;
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
