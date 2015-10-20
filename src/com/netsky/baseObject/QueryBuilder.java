package com.netsky.baseObject;

import java.io.Serializable;
import java.util.Map;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;

/**
 * ͨ�ò�ѯ�ӿ�.
 * 
 * @author Chiang 2009-3-12
 */
public interface QueryBuilder extends Serializable {

	/**
	 * equals ���
	 * 
	 * @param propertyName
	 *            ����
	 * @param value
	 *            ֵ
	 */
	public void eq(String propertyName, Object value);

	/**
	 * ������
	 * 
	 * @param propertyName
	 *            ����
	 * @param value
	 *            ֵ
	 */
	public void notEq(String propertyName, Object value);

	/**
	 * like ����
	 * 
	 * @param propertyName
	 *            ����
	 * @param value
	 *            ֵ
	 */
	public void like(String propertyName, Object value);
	
	/**
	 * not like ������
	 * 
	 * @param propertyName
	 *            ����
	 * @param value
	 *            ֵ
	 */
	public void notlike(String propertyName, Object value);

	/**
	 * like ����MatchMode�ж�����
	 * 
	 * @param propertyName
	 *            ����
	 * @param value
	 *            ֵ
	 * @param matchMode
	 *            ƥ������
	 */
	public void like(String propertyName, String value, MatchMode matchMode);
	
	/**
	 * not like ����MatchMode�жϲ�����
	 * 
	 * @param propertyName
	 *            ����
	 * @param value
	 *            ֵ
	 * @param matchMode
	 *            ƥ������
	 */
	public void notlike(String propertyName, String value, MatchMode matchMode);

	/**
	 * allEq ʹ��Map��ʹ��key/value���ж���ȶ�
	 * 
	 * @param propertyNameValues
	 */
	public void allEq(Map propertyNameValues);

	/**
	 * ���ڵ���
	 * 
	 * @param propertyName
	 *            ����
	 * @param value
	 *            ֵ
	 */
	public void ge(String propertyName, Object value);

	/**
	 * ����
	 * 
	 * @param propertyName
	 *            ����
	 * @param value
	 *            ֵ
	 */
	public void gt(String propertyName, Object value);

	/**
	 * С�ڵ���
	 * 
	 * @param propertyName
	 *            ����
	 * @param value
	 *            ֵ
	 */
	public void le(String propertyName, Object value);

	/**
	 * С��
	 * 
	 * @param propertyName
	 *            ����
	 * @param value
	 *            ֵ
	 */
	public void lt(String propertyName, Object value);

	/**
	 * �ж��Ƿ��ڸ�����������
	 * 
	 * @param propertyName
	 *            ����
	 * @param lowValue
	 *            ����
	 * @param highValue
	 *            ����
	 */
	public void between(String propertyName, Object lowValue, Object highValue);

	/**
	 * �ж��Ƿ��ڸ�����������
	 * 
	 * @param propertyName
	 *            ����
	 * @param values
	 *            ֵ
	 */
	public void in(String propertyName, Object[] values);

	/**
	 * �ж��Ƿ�Ϊ��
	 * 
	 * @param propertyName
	 *            ����
	 */
	public void isNull(String propertyName);

	/**
	 * �ж��Ƿ񲻵��ڿ�
	 * 
	 * @param propertyName
	 *            ����
	 */
	public void isNotNull(String propertyName);

	/**
	 * ����
	 * 
	 * @param orderBy
	 *            �������
	 * @see org.hibernate.criterion.Order
	 */
	public void addOrderBy(Order orderBy);

	/**
	 * ֱ����Ӳ�ѯ����
	 * 
	 * @param criterion
	 *            ��ѯ��������
	 * @see org.hibernate.criterion.Criterion
	 */
	public void addCriterion(Criterion criterion);

	/**
	 * ��ȡhibernate��ѯ����
	 * 
	 * @return org.hibernate.criterion.DetachedCriteria
	 */
	public DetachedCriteria getDetachedCriteria();

	/**
	 * ��ȡhibernate�־û�������
	 * 
	 * @return Class
	 */
	public Class getClazz();

}
