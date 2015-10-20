package com.netsky.dataObject;

import java.util.Date;
import java.io.Serializable;

/**
 * ������Ŀ��.
 * 
 * @hibernate.class table="GD01_GCXM"
 * @author wangflan
 * 
 */
public class Gd01_gcxm implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4764122365384654150L;

	/**
	 * ��ʶ ����
	 */
	private Integer id;

	/**
	 * ��Ŀ���
	 */
	private String xmbh;

	/**
	 * ��Ŀ����
	 */
	private String xmmc;

	/**
	 * ��Ŀ˵��
	 */
	private String xmsm;

	/**
	 * ������
	 */
	private String cjr;

	/**
	 * ��������
	 */
	private Date cjrq;

	/**
	 * ������id
	 */
	private Integer cjr_id;

	/**
	 * ���̷���id
	 */
	private Integer gcfl_id;

	/**
	 * ���赥λ
	 */
	private String jsdw;

	/**
	 * �����
	 */
	private String bgbh;

	/**
	 * ����׶�
	 */
	private Integer jsjd;

	/**
	 * ��Ƹ�����
	 */
	private String sjfzr;

	/**
	 * �����
	 */
	private String shr;

	/**
	 * ������
	 */
	private String bzr;

	/**
	 * ��������
	 */
	private Date bzrq;

	/**
	 * ��Ƶ�λ
	 */
	private String sjdw;

	/**
	 * ����˸�Ԥ���
	 */
	private String shrgysh;

	/**
	 * �����˸�Ԥ���
	 */
	private String bzrgysh;

	/**
	 * ��Ʊ��
	 */
	private String sjbh;

	/**
	 * ��������
	 */
	private Integer gcxz;

	/**
	 * ���ʿ�id
	 */
	private Integer flk_id;

	/**
	 * רҵid
	 */
	private Integer zy_id;

	/**
	 * �����ʼҳ��
	 */
	private Integer bgqsym;

	/**
	 * @hibernate.property column="cjr"
	 * @return the cjr
	 */
	public String getCjr() {
		return cjr;
	}

	/**
	 * @param cjr
	 *            the cjr to set
	 */
	public void setCjr(String cjr) {
		this.cjr = cjr;
	}

	/**
	 * @hibernate.property column="cjr_id"
	 * @return the cjr_id
	 */
	public Integer getCjr_id() {
		return cjr_id;
	}

	/**
	 * @param cjr_id
	 *            the cjr_id to set
	 */
	public void setCjr_id(Integer cjr_id) {
		this.cjr_id = cjr_id;
	}

	/**
	 * @hibernate.property column="cjrq"
	 * @return the cjrq
	 */
	public Date getCjrq() {
		return cjrq;
	}

	/**
	 * @param cjrq
	 *            the cjrq to set
	 */
	public void setCjrq(Date cjrq) {
		this.cjrq = cjrq;
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
	 * @hibernate.property column="xmbh"
	 * @return the xmbh
	 */
	public String getXmbh() {
		return xmbh;
	}

	/**
	 * @param xmbh
	 *            the xmbh to set
	 */
	public void setXmbh(String xmbh) {
		this.xmbh = xmbh;
	}

	/**
	 * @hibernate.property column="xmmc"
	 * @return the xmmc
	 */
	public String getXmmc() {
		return xmmc;
	}

	/**
	 * @param xmmc
	 *            the xmmc to set
	 */
	public void setXmmc(String xmmc) {
		this.xmmc = xmmc;
	}

	/**
	 * @hibernate.property column="xmsm"
	 * @return the xmsm
	 */
	public String getXmsm() {
		return xmsm;
	}

	/**
	 * @param xmsm
	 *            the xmsm to set
	 */
	public void setXmsm(String xmsm) {
		this.xmsm = xmsm;
	}

	/**
	 * @return the gcfl_id
	 * @hibernate.property column="gcfl_id"
	 */
	public Integer getGcfl_id() {
		return gcfl_id;
	}

	/**
	 * @param gcfl_id
	 *            the gcfl_id to set
	 */
	public void setGcfl_id(Integer gcfl_id) {
		this.gcfl_id = gcfl_id;
	}

	/**
	 * @return the bgbh
	 * @hibernate.property column="bgbh"
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
	 * @return the bzr
	 * @hibernate.property column="bzr"
	 */
	public String getBzr() {
		return bzr;
	}

	/**
	 * @param bzr
	 *            the bzr to set
	 */
	public void setBzr(String bzr) {
		this.bzr = bzr;
	}

	/**
	 * @return the bzrq
	 * @hibernate.property column="bzrq"
	 */
	public Date getBzrq() {
		return bzrq;
	}

	/**
	 * @param bzrq
	 *            the bzrq to set
	 */
	public void setBzrq(Date bzrq) {
		this.bzrq = bzrq;
	}

	/**
	 * @return the jsdw
	 * @hibernate.property column="jsdw"
	 */
	public String getJsdw() {
		return jsdw;
	}

	/**
	 * @param jsdw
	 *            the jsdw to set
	 */
	public void setJsdw(String jsdw) {
		this.jsdw = jsdw;
	}

	/**
	 * @return the jsjd
	 * @hibernate.property column="jsjd"
	 */
	public Integer getJsjd() {
		return jsjd;
	}

	/**
	 * @param jsjd
	 *            the jsjd to set
	 */
	public void setJsjd(Integer jsjd) {
		this.jsjd = jsjd;
	}

	/**
	 * @return the shr
	 * @hibernate.property column="shr"
	 */
	public String getShr() {
		return shr;
	}

	/**
	 * @param shr
	 *            the shr to set
	 */
	public void setShr(String shr) {
		this.shr = shr;
	}

	/**
	 * @return the sjfzr
	 * @hibernate.property column="sjfzr"
	 */
	public String getSjfzr() {
		return sjfzr;
	}

	/**
	 * @param sjfzr
	 *            the sjfzr to set
	 */
	public void setSjfzr(String sjfzr) {
		this.sjfzr = sjfzr;
	}

	/**
	 * @return the bzrgysh
	 * @hibernate.property column="bzrgysh"
	 */
	public String getBzrgysh() {
		return bzrgysh;
	}

	/**
	 * @param bzrgysh
	 *            the bzrgysh to set
	 */
	public void setBzrgysh(String bzrgysh) {
		this.bzrgysh = bzrgysh;
	}

	/**
	 * @return the shrgysh
	 * @hibernate.property column="shrgysh"
	 */
	public String getShrgysh() {
		return shrgysh;
	}

	/**
	 * @param shrgysh
	 *            the shrgysh to set
	 */
	public void setShrgysh(String shrgysh) {
		this.shrgysh = shrgysh;
	}

	/**
	 * @return the sjbh
	 * @hibernate.property column="sjbh"
	 */
	public String getSjbh() {
		return sjbh;
	}

	/**
	 * @param sjbh
	 *            the sjbh to set
	 */
	public void setSjbh(String sjbh) {
		this.sjbh = sjbh;
	}

	/**
	 * @return the sjdw
	 * @hibernate.property column="sjdw"
	 */
	public String getSjdw() {
		return sjdw;
	}

	/**
	 * @param sjdw
	 *            the sjdw to set
	 */
	public void setSjdw(String sjdw) {
		this.sjdw = sjdw;
	}

	/**
	 * @return the bgqsym
	 * @hibernate.property column="bgqsym"
	 */
	public Integer getBgqsym() {
		return bgqsym;
	}

	/**
	 * @param bgqsym
	 *            the bgqsym to set
	 */
	public void setBgqsym(Integer bgqsym) {
		this.bgqsym = bgqsym;
	}

	/**
	 * @return the flk_id
	 * @hibernate.property column="flk_id"
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
	 * @return the gcxz
	 * @hibernate.property column="gcxz"
	 */
	public Integer getGcxz() {
		return gcxz;
	}

	/**
	 * @param gcxz
	 *            the gcxz to set
	 */
	public void setGcxz(Integer gcxz) {
		this.gcxz = gcxz;
	}

	/**
	 * @return the zy_id
	 * @hibernate.property column="zy_id"
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
