package com.netsky.dataObject;
import java.io.Serializable;
/**
 * ������.
 * 
 * @hibernate.class table="GD05_B3J"
 * @author wangflan
 * 
 */
public class Gd05_b3j implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3826617745711016726L;

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
	 * ������
	 */
	private String debh;

	/**
	 * ��������
	 */
	private String demc;

	/**
	 * ��λ
	 */
	private String dw;

	/**
	 * ����
	 */
	private Double sl;

	/**
	 * ��������
	 */
	private Double jggr;

	/**
	 * �չ�����
	 */
	private Double pggr;

	/**
	 * ��ע
	 */
	private String bz;

	/**
	 * ����ϵ��
	 */
	private Double tzxs;

	/**
	 * ������־ 1�½� 2���� 3��������� 4����������� 5���� 6��׼
	 */
	private Integer ck_bz;

	/**
	 * ҹ��ʩ����־ 0������ȡ 1����ȡ Ĭ�ϣ�1
	 */
	private Integer yj_bz;

	/**
	 * ���̸��ŷѱ�־ 0������ȡ 1����ȡ Ĭ�ϣ�1
	 */
	private Integer grf_bz;

	/**
	 * ���꼾��־ 0������ȡ 1����ȡ Ĭ�ϣ�1
	 */
	private Integer dyj_bz;

	/**
	 * ���������־ 0������ȡ 1����ȡ Ĭ�ϣ�1
	 */
	private Integer tsdq_bz;

	/**
	 * ���
	 */
	private Integer xh;

	/**
	 * @hibernate.property column="bz"
	 * @return the bz
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
	 * @hibernate.property column="ck_bz"
	 * @return the ck_bz
	 */
	public Integer getCk_bz() {
		return ck_bz;
	}

	/**
	 * @param ck_bz
	 *            the ck_bz to set
	 */
	public void setCk_bz(Integer ck_bz) {
		this.ck_bz = ck_bz;
	}

	/**
	 * @hibernate.property column="debh"
	 * @return the debh
	 */
	public String getDebh() {
		return debh;
	}

	/**
	 * @param debh
	 *            the debh to set
	 */
	public void setDebh(String debh) {
		this.debh = debh;
	}

	/**
	 * @hibernate.property column="demc"
	 * @return the demc
	 */
	public String getDemc() {
		return demc;
	}

	/**
	 * @param demc
	 *            the demc to set
	 */
	public void setDemc(String demc) {
		this.demc = demc;
	}

	/**
	 * @hibernate.property column="dw"
	 * @return the dw
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
	 * @hibernate.property column="dyj_bz"
	 * @return the dyj_bz
	 */
	public Integer getDyj_bz() {
		return dyj_bz;
	}

	/**
	 * @param dyj_bz
	 *            the dyj_bz to set
	 */
	public void setDyj_bz(Integer dyj_bz) {
		this.dyj_bz = dyj_bz;
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
	 * @hibernate.property column="grf_bz"
	 * @return the grf_bz
	 */
	public Integer getGrf_bz() {
		return grf_bz;
	}

	/**
	 * @param grf_bz
	 *            the grf_bz to set
	 */
	public void setGrf_bz(Integer grf_bz) {
		this.grf_bz = grf_bz;
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
	 * @hibernate.property column="jggr"
	 * @return the jggr
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
	 * @hibernate.property column="pggr"
	 * @return the pggr
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
	 * @hibernate.property column="sl"
	 * @return the sl
	 */
	public Double getSl() {
		return sl;
	}

	/**
	 * @param sl
	 *            the sl to set
	 */
	public void setSl(Double sl) {
		this.sl = sl;
	}

	/**
	 * @hibernate.property column="tsdq_bz"
	 * @return the tsdq_bz
	 */
	public Integer getTsdq_bz() {
		return tsdq_bz;
	}

	/**
	 * @param tsdq_bz
	 *            the tsdq_bz to set
	 */
	public void setTsdq_bz(Integer tsdq_bz) {
		this.tsdq_bz = tsdq_bz;
	}

	/**
	 * @hibernate.property column="tzxs"
	 * @return the tzxs
	 */
	public Double getTzxs() {
		return tzxs;
	}

	/**
	 * @param tzxs
	 *            the tzxs to set
	 */
	public void setTzxs(Double tzxs) {
		this.tzxs = tzxs;
	}

	/**
	 * @hibernate.property column="xh"
	 * @return the xh
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
	 * @hibernate.property column="yj_bz"
	 * @return the yj_bz
	 */
	public Integer getYj_bz() {
		return yj_bz;
	}

	/**
	 * @param yj_bz
	 *            the yj_bz to set
	 */
	public void setYj_bz(Integer yj_bz) {
		this.yj_bz = yj_bz;
	}

}
