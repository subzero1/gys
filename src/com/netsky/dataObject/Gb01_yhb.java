package com.netsky.dataObject;

import java.util.Date;

/**
 * �û���.
 * 
 * @hibernate.class table="GB01_YHB"
 * @author wangflan
 * 
 */
public class Gb01_yhb {
	/**
	 * ��ʶ ����
	 */
	private Integer id;

	/**
	 * ����
	 */
	private String name;

	/**
	 * ��¼��
	 */
	private String login_id;

	/**
	 * ��¼����
	 */
	private String passwd;

	/**
	 * �û�Ȩ�� 0������Ա 1������Ա
	 */
	private Integer role;

	/**
	 * ����ԱȨ�� 0�����ɱ༭ 1���ɱ༭
	 */
	private Integer operate;
	
	/**
	 * �û�ʧЧ���� ��ֵ��������Ч
	 */
	private Date limit_date;

	/**
	 * ��ע
	 */
	private String remark;
	/**
	 * email
	 */
	private String email;
	/**
	 * �绰
	 */
	private String phone;
	/**
	 * ��˾����
	 */
	private String company_name;
	/**
	 * ������к�
	 */
	private String sofeware_num;
	/**
	 * ״̬1���ã�0������
	 */
	private String state;
	/**
	 * ע��ʱ��
	 */
	private Date login_date;
	
	/**
	 * ͷ��ͼƬ
	 */
	private String image;
	/**
	 * ʡ/ֱϽ��
	 */
	private String province;
	/**
	 * ��ϵ��
	 */
	private String lxr;
	/**
	 * QQ
	 */
	private String qq;
	/**
	 * MSN
	 */
	private String msn;
	/**
	 * @hibernate.property column="msn"
	 * @return msn
	 */
	public String getMsn() {
		return msn;
	}
	/**
	 * @param msn
	 */
	public void setMsn(String msn) {
		this.msn = msn;
	}
	/**
	 * @hibernate.property column="qq"
	 * @return qq
	 */
	public String getQq() {
		return qq;
	}
	/**
	 * @param qq
	 */
	public void setQq(String qq) {
		this.qq = qq;
	}
	/**
	 * @hibernate.property column="province"
	 * @return province
	 */
	public String getProvince() {
		return province;
	}
	/**
	 * @param province
	 */
	public void setProvince(String province) {
		this.province = province;
	}
	/**
	 * @hibernate.property column="image"
	 * @return image
	 */
	public String getImage() {
		return image;
	}
	/**
	 * @param image
	 */
	public void setImage(String image) {
		this.image = image;
	}
	/**
	 * @hibernate.property column="company_name"
	 * @return company_name
	 */
	public String getCompany_name() {
		return company_name;
	}
	/**
	 * @param company_name
	 */
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	/**
	 * @hibernate.property column="email"
	 * @return email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @hibernate.property column="login_date"
	 * @return login_date
	 */
	public Date getLogin_date() {
		return login_date;
	}
	/**
	 * @param login_date
	 */
	public void setLogin_date(Date login_date) {
		this.login_date = login_date;
	}
	/**
	 * @hibernate.property column="phone"
	 * @return phone
	 */
	public String getPhone() {
		return phone;
	}
	/**
	 * @param phone
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}
	/**
	 * @hibernate.property column="sofeware_num"
	 * @return sofeware_num
	 */
	public String getSofeware_num() {
		return sofeware_num;
	}
	/**
	 * @param sofeware_num
	 */
	public void setSofeware_num(String sofeware_num) {
		this.sofeware_num = sofeware_num;
	}
	/**
	 * @hibernate.property column="state"
	 * @return state
	 */
	public String getState() {
		return state;
	}
	/**
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
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
	 * @hibernate.property column="limit_date"
	 * @return the limit_date
	 */
	public Date getLimit_date() {
		return limit_date;
	}

	/**
	 * @param limit_date
	 *            the limit_date to set
	 */
	public void setLimit_date(Date limit_date) {
		this.limit_date = limit_date;
	}

	/**
	 * @hibernate.property column="login_id"
	 * @return the login_id
	 */
	public String getLogin_id() {
		return login_id;
	}

	/**
	 * @param login_id
	 *            the login_id to set
	 */
	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}

	/**
	 * @hibernate.property column="name"
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @hibernate.property column="passwd"
	 * @return the passwd
	 */
	public String getPasswd() {
		return passwd;
	}

	/**
	 * @param passwd
	 *            the passwd to set
	 */
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	/**
	 * @hibernate.property column="remark"
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @hibernate.property column="role"
	 * @return the role
	 */
	public Integer getRole() {
		return role;
	}

	/**
	 * @param role
	 *            the role to set
	 */
	public void setRole(Integer role) {
		this.role = role;
	}
	
	
	/**
	 * @hibernate.property column="operate"
	 * @return the operate
	 */
	public Integer getOperate() {
		return operate;
	}

	/**
	 * @param operate
	 *            the operate to set
	 */
	public void setOperate(Integer operate) {
		this.operate = operate;
	}
	
	/**
	 * @hibernate.property column="lxr"
	 * @return lxr
	 */
	public String getLxr() {
		return lxr;
	}
	/**
	 * @param lxr
	 */
	public void setLxr(String lxr) {
		this.lxr = lxr;
	}

}
