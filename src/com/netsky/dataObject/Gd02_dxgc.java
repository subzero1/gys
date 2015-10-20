package com.netsky.dataObject;

import java.util.Date;
import java.io.Serializable;

/**
 * ����̱�.
 * 
 * @hibernate.class table="GD02_DXGC"
 * @author wangflan
 * 
 */
public class Gd02_dxgc implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8523781799252896189L;

	/**
	 * ��ʶ ����
	 */
	private Integer id;

	/**
	 * ��ĿID
	 */
	private Integer gcxm_id;

	/**
	 * ��������
	 */
	private String gcmc;

	/**
	 * ���赥λ
	 */
	private String jsdw;

	/**
	 * ��Ƶ�λ
	 */
	private String sjdw;

	/**
	 * ��Ƹ�����
	 */
	private String sjfzr;

	/**
	 * �����
	 */
	private String shr;

	/**
	 * ����˸�Ԥ���
	 */
	private String shrgysh;

	/**
	 * ������
	 */
	private String bzr;

	/**
	 * �����˸�Ԥ���
	 */
	private String bzrgysh;

	/**
	 * ��������
	 */
	private Date bzrq;

	/**
	 * �����
	 */
	private String bgbh;

	/**
	 * ����׶� 1������ 2��Ԥ�� 3������ 4������
	 */
	private Integer jsjd;

	/**
	 * �������� 1���½� 2��ȫ������ 3���������� 4���Ľ� 5���ָ� 6��Ǩ��
	 */
	private Integer gcxz;

	/**
	 * רҵID
	 */
	private Integer zy_id;

	/**
	 * ���ʿ�ID
	 */
	private Integer flk_id;

	/**
	 * С���ձ�־ 0����ȡ 1��ȡ Ĭ�ϣ�0
	 */
	private Integer xgr_bz;

	/**
	 * ��һ�ϼ��Ƿ��ȡ�Ƿ� 0����ȡ 1��ȡ Ĭ�ϣ�0
	 */
	private Integer b1_qzbz;

	/**
	 * �Ƿ��ȡ�豸�� 0����ȡ 1��ȡ Ĭ�ϣ�1
	 */
	private Integer b1_ybf_bz;

	/**
	 * ��һ����ϵ��
	 */
	private Double b1_tzxs;

	/**
	 * ���ʩ����ǲ���Ƿ񰴵��̼��� 1������ 2������ Ĭ�ϣ�2
	 */
	private Integer b2_sgdqf_wfbz;

	/**
	 * ���ʩ����ǲ���
	 */
	private Double b2_sgdqlc;

	/**
	 * �����е��ǲ���Ƿ񰴵��̼��� 1������ 2������ Ĭ�ϣ�2
	 */
	private Integer b2_jxdqf_wfbz;

	/**
	 * �����е��ǲ��λ
	 */
	private Double b2_jxdqdw;

	/**
	 * �����е��ǲ���
	 */
	private Double b2_jxdqlc;

	/**
	 * ˰�𰴰��������ϼ��㣬 0���������� 1������������
	 */
	private Integer sj_bgbbl;

	/**
	 * ��������������ϼ��� 0���������� 1������������
	 */
	private Integer b2_bgbbl;

	/**
	 * �������ϵ��
	 */
	private Double b2_tzxs;

	/**
	 * ����ʩ��������־λ 0�������� 1������
	 */
	private Integer b3_sgtj_bz;

	/**
	 * �������յ���ϵ��
	 */
	private Double b3_jggr_tzxs;

	/**
	 * �չ����յ���ϵ��
	 */
	private Double b3_pggr_tzxs;

	/**
	 * ��е�ѵ���ϵ��
	 */
	private Double b3_jxf_tzxs;

	/**
	 * �Ǳ�ѵ���ϵ��
	 */
	private Double b3_ybf_tzxs;

	/**
	 * �����һ�е�۸� BDJ�����ؼ� QGJ��ȫ����
	 */
	private String b3_jxjg;

	/**
	 * �������Ǳ�۸� BDJ�����ؼ� QGJ��ȫ����
	 */
	private String b3_ybjg;

	/**
	 * �������ļ۸� BDJ�����ؼ� BSJ����ʡ�� QGJ��ȫ���� YSJ��Ԥ���
	 */
	private String b4_zcjg;

	/**
	 * �����豸�۸� BDJ�����ؼ� BSJ����ʡ�� QGJ��ȫ���� YSJ��Ԥ���
	 */
	private String b4_sbjg;

	/**
	 * ����׼������ƶ�Ա
	 */
	private Integer b5_sczbf_sjdy;

	/**
	 * ���ѡ�� 1,2,3,5
	 */
	private String bgxd;

	/**
	 * ��ʼҳ�� Ĭ��1
	 */
	private Integer bgqsym;

	/**
	 * ������ID
	 */
	private Integer cjr_id;

	/**
	 * ����ʱ��
	 */
	private Date cjsj;

	/**
	 * �鵵ʱ��
	 */
	private Date gdsj;

	/**
	 * ����˵��
	 */
	private String gcsm;

	/**
	 * ������
	 */
	private String cjr;

	/**
	 * ģ���־λ��0����ģ�壬1��ģ��
	 */
	private Integer mb;

	/**
	 * ��Ʊ��
	 */
	private String sjbh;

	/**
	 * ���̱��
	 */
	private String gcbh;

	/**
	 * @hibernate.property column="b1_qzbz"
	 * @return the b1_qzbz
	 */
	public Integer getB1_qzbz() {
		return b1_qzbz;
	}

	/**
	 * @param b1_qzbz
	 *            the b1_qzbz to set
	 */
	public void setB1_qzbz(Integer b1_qzbz) {
		this.b1_qzbz = b1_qzbz;
	}

	/**
	 * @hibernate.property column="b1_tzxs"
	 * @return the b1_tzxs
	 */
	public Double getB1_tzxs() {
		return b1_tzxs;
	}

	/**
	 * @param b1_tzxs
	 *            the b1_tzxs to set
	 */
	public void setB1_tzxs(Double b1_tzxs) {
		this.b1_tzxs = b1_tzxs;
	}

	/**
	 * @hibernate.property column="b1_ybf_bz"
	 * @return the b1_ybf_bz
	 */
	public Integer getB1_ybf_bz() {
		return b1_ybf_bz;
	}

	/**
	 * @param b1_ybf_bz
	 *            the b1_ybf_bz to set
	 */
	public void setB1_ybf_bz(Integer b1_ybf_bz) {
		this.b1_ybf_bz = b1_ybf_bz;
	}

	/**
	 * @hibernate.property column="b2_bgbbl"
	 * @return the b2_bgbbl
	 */
	public Integer getB2_bgbbl() {
		return b2_bgbbl;
	}

	/**
	 * @param b2_bgbbl
	 *            the b2_bgbbl to set
	 */
	public void setB2_bgbbl(Integer b2_bgbbl) {
		this.b2_bgbbl = b2_bgbbl;
	}

	/**
	 * @hibernate.property column="b2_jxdqdw"
	 * @return the b2_jxdqdw
	 */
	public Double getB2_jxdqdw() {
		return b2_jxdqdw;
	}

	/**
	 * @param b2_jxdqdw
	 *            the b2_jxdqdw to set
	 */
	public void setB2_jxdqdw(Double b2_jxdqdw) {
		this.b2_jxdqdw = b2_jxdqdw;
	}

	/**
	 * @hibernate.property column="b2_jxdqf_wfbz"
	 * @return the b2_jxdqf_wfbz
	 */
	public Integer getB2_jxdqf_wfbz() {
		return b2_jxdqf_wfbz;
	}

	/**
	 * @param b2_jxdqf_wfbz
	 *            the b2_jxdqf_wfbz to set
	 */
	public void setB2_jxdqf_wfbz(Integer b2_jxdqf_wfbz) {
		this.b2_jxdqf_wfbz = b2_jxdqf_wfbz;
	}

	/**
	 * @hibernate.property column="b2_jxdqlc"
	 * @return the b2_jxdqlc
	 */
	public Double getB2_jxdqlc() {
		return b2_jxdqlc;
	}

	/**
	 * @param b2_jxdqlc
	 *            the b2_jxdqlc to set
	 */
	public void setB2_jxdqlc(Double b2_jxdqlc) {
		this.b2_jxdqlc = b2_jxdqlc;
	}

	/**
	 * @hibernate.property column="b2_sgdqf_wfbz"
	 * @return the b2_sgdqf_wfbz
	 */
	public Integer getB2_sgdqf_wfbz() {
		return b2_sgdqf_wfbz;
	}

	/**
	 * @param b2_sgdqf_wfbz
	 *            the b2_sgdqf_wfbz to set
	 */
	public void setB2_sgdqf_wfbz(Integer b2_sgdqf_wfbz) {
		this.b2_sgdqf_wfbz = b2_sgdqf_wfbz;
	}

	/**
	 * @hibernate.property column="b2_sgdqlc"
	 * @return the b2_sgdqlc
	 */
	public Double getB2_sgdqlc() {
		return b2_sgdqlc;
	}

	/**
	 * @param b2_sgdqlc
	 *            the b2_sgdqlc to set
	 */
	public void setB2_sgdqlc(Double b2_sgdqlc) {
		this.b2_sgdqlc = b2_sgdqlc;
	}

	/**
	 * @hibernate.property column="b2_tzxs"
	 * @return the b2_tzxs
	 */
	public Double getB2_tzxs() {
		return b2_tzxs;
	}

	/**
	 * @param b2_tzxs
	 *            the b2_tzxs to set
	 */
	public void setB2_tzxs(Double b2_tzxs) {
		this.b2_tzxs = b2_tzxs;
	}

	/**
	 * @hibernate.property column="b3_jggr_tzxs"
	 * @return the b3_jggr_tzxs
	 */
	public Double getB3_jggr_tzxs() {
		return b3_jggr_tzxs;
	}

	/**
	 * @param b3_jggr_tzxs
	 *            the b3_jggr_tzxs to set
	 */
	public void setB3_jggr_tzxs(Double b3_jggr_tzxs) {
		this.b3_jggr_tzxs = b3_jggr_tzxs;
	}

	/**
	 * @hibernate.property column="b3_jxf_tzxs"
	 * @return the b3_jxf_tzxs
	 */
	public Double getB3_jxf_tzxs() {
		return b3_jxf_tzxs;
	}

	/**
	 * @param b3_jxf_tzxs
	 *            the b3_jxf_tzxs to set
	 */
	public void setB3_jxf_tzxs(Double b3_jxf_tzxs) {
		this.b3_jxf_tzxs = b3_jxf_tzxs;
	}

	/**
	 * @hibernate.property column="b3_jxjg"
	 * @return the b3_jxjg
	 */
	public String getB3_jxjg() {
		return b3_jxjg;
	}

	/**
	 * @param b3_jxjg
	 *            the b3_jxjg to set
	 */
	public void setB3_jxjg(String b3_jxjg) {
		this.b3_jxjg = b3_jxjg;
	}

	/**
	 * @hibernate.property column="b3_pggr_tzxs"
	 * @return the b3_pggr_tzxs
	 */
	public Double getB3_pggr_tzxs() {
		return b3_pggr_tzxs;
	}

	/**
	 * @param b3_pggr_tzxs
	 *            the b3_pggr_tzxs to set
	 */
	public void setB3_pggr_tzxs(Double b3_pggr_tzxs) {
		this.b3_pggr_tzxs = b3_pggr_tzxs;
	}

	/**
	 * @hibernate.property column="b3_sgtj_bz"
	 * @return the b3_sgtj_bz
	 */
	public Integer getB3_sgtj_bz() {
		return b3_sgtj_bz;
	}

	/**
	 * @param b3_sgtj_bz
	 *            the b3_sgtj_bz to set
	 */
	public void setB3_sgtj_bz(Integer b3_sgtj_bz) {
		this.b3_sgtj_bz = b3_sgtj_bz;
	}

	/**
	 * @hibernate.property column="b3_ybf_tzxs"
	 * @return the b3_ybf_tzxs
	 */
	public Double getB3_ybf_tzxs() {
		return b3_ybf_tzxs;
	}

	/**
	 * @param b3_ybf_tzxs
	 *            the b3_ybf_tzxs to set
	 */
	public void setB3_ybf_tzxs(Double b3_ybf_tzxs) {
		this.b3_ybf_tzxs = b3_ybf_tzxs;
	}

	/**
	 * @hibernate.property column="b3_ybjg"
	 * @return the b3_ybjg
	 */
	public String getB3_ybjg() {
		return b3_ybjg;
	}

	/**
	 * @param b3_ybjg
	 *            the b3_ybjg to set
	 */
	public void setB3_ybjg(String b3_ybjg) {
		this.b3_ybjg = b3_ybjg;
	}

	/**
	 * @hibernate.property column="b4_sbjg"
	 * @return the b4_sbjg
	 */
	public String getB4_sbjg() {
		return b4_sbjg;
	}

	/**
	 * @param b4_sbjg
	 *            the b4_sbjg to set
	 */
	public void setB4_sbjg(String b4_sbjg) {
		this.b4_sbjg = b4_sbjg;
	}

	/**
	 * @hibernate.property column="b4_zcjg"
	 * @return the b4_zcjg
	 */
	public String getB4_zcjg() {
		return b4_zcjg;
	}

	/**
	 * @param b4_zcjg
	 *            the b4_zcjg to set
	 */
	public void setB4_zcjg(String b4_zcjg) {
		this.b4_zcjg = b4_zcjg;
	}

	/**
	 * @hibernate.property column="b5_sczbf_sjdy"
	 * @return the b5_sczbf_sjdy
	 */
	public Integer getB5_sczbf_sjdy() {
		return b5_sczbf_sjdy;
	}

	/**
	 * @param b5_sczbf_sjdy
	 *            the b5_sczbf_sjdy to set
	 */
	public void setB5_sczbf_sjdy(Integer b5_sczbf_sjdy) {
		this.b5_sczbf_sjdy = b5_sczbf_sjdy;
	}

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
	 * @hibernate.property column="bgqsym"
	 * @return the bgqsym
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
	 * @hibernate.property column="bgxd"
	 * @return the bgxd
	 */
	public String getBgxd() {
		return bgxd;
	}

	/**
	 * @param bgxd
	 *            the bgxd to set
	 */
	public void setBgxd(String bgxd) {
		this.bgxd = bgxd;
	}

	/**
	 * @hibernate.property column="bzr"
	 * @return the bzr
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
	 * @hibernate.property column="bzrgysh"
	 * @return the bzrgysh
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
	 * @hibernate.property column="bzrq"
	 * @return the bzrq
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
	 * @hibernate.property column="cjsj"
	 * @return the cjsj
	 */
	public Date getCjsj() {
		return cjsj;
	}

	/**
	 * @param cjsj
	 *            the cjsj to set
	 */
	public void setCjsj(Date cjsj) {
		this.cjsj = cjsj;
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
	 * @hibernate.property column="gcmc"
	 * @return the gcmc
	 */
	public String getGcmc() {
		return gcmc;
	}

	/**
	 * @param gcmc
	 *            the gcmc to set
	 */
	public void setGcmc(String gcmc) {
		this.gcmc = gcmc;
	}

	/**
	 * @hibernate.property column="gcsm"
	 * @return the gcsm
	 */
	public String getGcsm() {
		return gcsm;
	}

	/**
	 * @param gcsm
	 *            the gcsm to set
	 */
	public void setGcsm(String gcsm) {
		this.gcsm = gcsm;
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
	 * @hibernate.property column="gcxz"
	 * @return the gcxz
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
	 * @hibernate.property column="gdsj"
	 * @return the gdsj
	 */
	public Date getGdsj() {
		return gdsj;
	}

	/**
	 * @param gdsj
	 *            the gdsj to set
	 */
	public void setGdsj(Date gdsj) {
		this.gdsj = gdsj;
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
	 * @hibernate.property column="jsdw"
	 * @return the jsdw
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
	 * @hibernate.property column="jsjd"
	 * @return the jsjd
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
	 * @hibernate.property column="shr"
	 * @return the shr
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
	 * @hibernate.property column="shrgysh"
	 * @return the shrgysh
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
	 * @hibernate.property column="sj_bgbbl"
	 * @return the sj_bgbbl
	 */
	public Integer getSj_bgbbl() {
		return sj_bgbbl;
	}

	/**
	 * @param sj_bgbbl
	 *            the sj_bgbbl to set
	 */
	public void setSj_bgbbl(Integer sj_bgbbl) {
		this.sj_bgbbl = sj_bgbbl;
	}

	/**
	 * @hibernate.property column="sjdw"
	 * @return the sjdw
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
	 * @hibernate.property column="sjfzr"
	 * @return the sjfzr
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
	 * @hibernate.property column="xgr_bz"
	 * @return the xgr_bz
	 */
	public Integer getXgr_bz() {
		return xgr_bz;
	}

	/**
	 * @param xgr_bz
	 *            the xgr_bz to set
	 */
	public void setXgr_bz(Integer xgr_bz) {
		this.xgr_bz = xgr_bz;
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

	/**
	 * @return the cjr
	 * @hibernate.property column="cjr"
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
	 * @return the mb
	 * @hibernate.property column="mb"
	 */
	public Integer getMb() {
		return mb;
	}

	/**
	 * @param mb
	 *            the mb to set
	 */
	public void setMb(Integer mb) {
		this.mb = mb;
	}

	/**
	 * @return the gcbh
	 * @hibernate.property column="gcbh"
	 */
	public String getGcbh() {
		return gcbh;
	}

	/**
	 * @param gcbh
	 *            the gcbh to set
	 */
	public void setGcbh(String gcbh) {
		this.gcbh = gcbh;
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

}
