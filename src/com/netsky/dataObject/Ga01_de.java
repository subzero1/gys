package com.netsky.dataObject;

/**
 * ��׼�����.
 * 
 * @hibernate.class table="GA01_DE"
 * @author lx
 * 
 */
public class Ga01_de {
	/**
	 * Number 10 N ��ʶ
	 * 
	 */
	private Integer id;

	/**
	 * Varchar 20 N ���
	 */
	private String bh;

	/**
	 * Varchar 200 N ����
	 */
	private String mc;

	/**
	 * Varchar 20 ��λ
	 */
	private String dw;

	/**
	 * Number 12,2 ��������
	 */
	private Double jggr;

	/**
	 * Number 12,2 �չ�����
	 */
	private Double pggr;

	/**
	 * Varchar 200 ��ע
	 */
	private String bz;
	
	/**
	 * Varchar 10 �¾�
	 */
	private String xj;
	/**
	 * �����
	 */
	private Integer dek_id;
	
	private String lb;
	/**
	 * @hibernate.property column="lb"
	 * @return lb
	 */
	public String getLb() {
		return lb;
	}
	/**
	 * @param lb
	 */
	public void setLb(String lb) {
		this.lb = lb;
	}

	/**
	 * @return the bh
	 * @hibernate.property column="bh"
	 */
	public String getBh() {
		return bh;
	}

	/**
	 * @param bh
	 *            the bh to set
	 */
	public void setBh(String bh) {
		this.bh = bh;
	}

	/**
	 * @return the bz
	 * @hibernate.property column="bz"
	 */
	public String getBz() {
		return bz;
	}

	/**
	 * @param bz
	 *            the bz to set
	 */
	public void setBz(String bz) {
		this.bz = bz;
	}

	/**
	 * @return the dw
	 * @hibernate.property column="dw"
	 */
	public String getDw() {
		return dw;
	}

	/**
	 * @param dw
	 *            the dw to set
	 */
	public void setDw(String dw) {
		this.dw = dw;
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
	 * @return the jggr
	 * @hibernate.property column="jggr"
	 */
	public Double getJggr() {
		return jggr;
	}

	/**
	 * @param jggr
	 *            the jggr to set
	 */
	public void setJggr(Double jggr) {
		this.jggr = jggr;
	}

	/**
	 * @return the mc
	 * @hibernate.property column="mc"
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
	 * @return the pggr
	 * @hibernate.property column="pggr"
	 */
	public Double getPggr() {
		return pggr;
	}

	/**
	 * @param pggr
	 *            the pggr to set
	 */
	public void setPggr(Double pggr) {
		this.pggr = pggr;
	}
	/**
	 * @hibernate.property column="dek_id"
	 * @return dek_id
	 */
	public Integer getDek_id() {
		return dek_id;
	}
	/**
	 * 
	 * @param dek_id
	 */
	public void setDek_id(Integer dek_id) {
		this.dek_id = dek_id;
	}
	
	/**
	 * @hibernate.property column="xj"
	 * @return xj
	 */
	public String getXj() {
		return xj;
	}
	public void setXj(String xj) {
		this.xj = xj;
	}

}
