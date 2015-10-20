package com.netsky.dataObject;

/**
 * ����������ϡ��豸����е���Ǳ�.
 * 
 * @hibernate.class table="GA03_GLCL"
 * @author lx
 * 
 */
public class Ga03_glcl {

	/**
	 * ����
	 */
	private Integer id;

	/**
	 * Number 10 N ����ID( GA01.ID) �����GA01.ID
	 */
	private Integer de_id;

	/**
	 * Number 10 N ����ID (GA02.ID) �����GA02.ID
	 */
	private Integer cl_id;

	/**
	 * Number 5 �������
	 */
	private Integer xh;

	/**
	 * Number 12,3 ��λ�����Ӧ�Ĳ�������
	 */
	private Double clsl;

	/**
	 * ������
	 */
	private String de_bh;

	/**
	 * ���ϱ��
	 */
	private String cl_bh;

	/**
	 * @return the cl_id
	 * @hibernate.property column="cl_id"
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
	 * @return the clsl
	 * @hibernate.property column="clsl"
	 */
	public Double getClsl() {
		return clsl;
	}

	/**
	 * @param clsl
	 *            the clsl to set
	 */
	public void setClsl(Double clsl) {
		this.clsl = clsl;
	}

	/**
	 * @return the de_id
	 * @hibernate.property column="de_id"
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
	 * @return the xh
	 * @hibernate.property column="xh"
	 */
	public Integer getXh() {
		return xh;
	}

	/**
	 * @param xh
	 *            the xh to set
	 */
	public void setXh(Integer xh) {
		this.xh = xh;
	}

	/**
	 * @hibernate.property column="cl_bh"
	 * @return cl_bh
	 */
	public String getCl_bh() {
		return cl_bh;
	}

	/**
	 * @param cl_bh
	 */
	public void setCl_bh(String cl_bh) {
		this.cl_bh = cl_bh;
	}

	/**
	 * @hibernate.property column="de_bh"
	 * @return de_bh
	 */
	public String getDe_bh() {
		return de_bh;
	}

	/**
	 * @param de_bh
	 */
	public void setDe_bh(String de_bh) {
		this.de_bh = de_bh;
	}
}
