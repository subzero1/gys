package com.netsky.dataObject;

import java.io.Serializable;

/**
 * ��������Ļ�е�������Ǳ����ϡ��豸��ϵ��.
 * 
 * @hibernate.class table="GD09_DEGL"
 * @author wangflan
 * 
 */
public class Gd09_degl implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5631623164782484512L;

	/**
	 * ��ʶ ����
	 */
	private Integer id;

	/**
	 * ��ĿID
	 */
	private Integer gcxm_id;

	/**
	 * �����ID
	 */
	private Integer dxgc_id;

	/**
	 * �����ʶ
	 */
	private Integer de_id;

	/**
	 * ���ϱ�ʶ
	 */
	private Integer cl_id;

	/**
	 * ��������
	 */
	private Double glsl;

	/**
	 * �������
	 */
	private String zclb;

	/**
	 * @hibernate.property column="cl_id"
	 * @return the cl_id
	 */
	public Integer getCl_id() {
		return cl_id;
	}

	/**
	 * @param cl_id
	 *            the cl_id to set
	 */
	public void setCl_id(Integer cl_id) {
		this.cl_id = cl_id;
	}

	/**
	 * @hibernate.property column="de_id"
	 * @return the de_id
	 */
	public Integer getDe_id() {
		return de_id;
	}

	/**
	 * @param de_id
	 *            the de_id to set
	 */
	public void setDe_id(Integer de_id) {
		this.de_id = de_id;
	}

	/**
	 * @hibernate.property column="dxgc_id"
	 * @return the dxgc_id
	 */
	public Integer getDxgc_id() {
		return dxgc_id;
	}

	/**
	 * @param dxgc_id
	 *            the dxgc_id to set
	 */
	public void setDxgc_id(Integer dxgc_id) {
		this.dxgc_id = dxgc_id;
	}

	/**
	 * @hibernate.property column="gcxm_id"
	 * @return the gcxm_id
	 */
	public Integer getGcxm_id() {
		return gcxm_id;
	}

	/**
	 * @param gcxm_id
	 *            the gcxm_id to set
	 */
	public void setGcxm_id(Integer gcxm_id) {
		this.gcxm_id = gcxm_id;
	}

	/**
	 * @hibernate.property column="glsl"
	 * @return the glsl
	 */
	public Double getGlsl() {
		return glsl;
	}

	/**
	 * @param glsl
	 *            the glsl to set
	 */
	public void setGlsl(Double glsl) {
		this.glsl = glsl;
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
	 * @hibernate.property column="sclb"
	 * @return the sclb
	 */
	public String getZclb() {
		return zclb;
	}

	/**
	 * @param sclb
	 *            the sclb to set
	 */
	public void setZclb(String zclb) {
		this.zclb = zclb;
	}

}
