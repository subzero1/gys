package com.netsky.baseService;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Session;

import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;

/**
 * ����Dao�ӿ���
 * 
 * @author Chiang 2009-3-11
 */
public interface Dao {

	/**
	 * ����򱣴�־û�����
	 * 
	 * @param o
	 * @return Object ���½��.
	 */
	public Object saveObject(Object o);

	/**
	 * ����򱣴�־û�����
	 * 
	 * @param o
	 * @return Object ���½��.
	 */
	public Object[] saveObject(Object[] o) throws Exception;

	/**
	 * ����id��ȡ�־û�����
	 * 
	 * @param clazz
	 *            �־û�����Class
	 * @param id
	 *            ��������
	 * @return Object ���ز�ѯ�������.
	 */
	public Object getObject(Class clazz, Serializable id);

	/**
	 * ��ȡ���ж���
	 * 
	 * @param clazz
	 *            �־û�����Class
	 * @return List ���м�¼
	 */
	public List getObjects(Class clazz);

	/**
	 * ����idɾ���־û�����
	 * 
	 * @param clazz
	 *            �־û�����Class
	 * @param id
	 */
	public void removeObject(Class clazz, Serializable id);

	/**
	 * ɾ���־û�����
	 * 
	 * @param o
	 *            �־û�����Object
	 */
	public void removeObject(Object o);

	/**
	 * ͨ��querybuilder��ѯ����
	 * 
	 * @param queryBuilder
	 * @return List
	 */
	public List search(QueryBuilder queryBuilder);

	/**
	 * ͨ��hsql��ѯ
	 * 
	 * @param HSql
	 * @return ResultObject
	 */
	public List search(String HSql);

	/**
	 * ͨ��hsql��������
	 * 
	 * @param HSql
	 */
	public void update(String HSql);

	/**
	 * ��ҳ��ѯ.
	 * 
	 * @param queryBuilder
	 * @param page
	 *            ��ǰҳ,��1��ʼ
	 * @param pageSize
	 *            ÿҳ��¼����
	 * @return ResultObject
	 */
	public ResultObject searchByPage(QueryBuilder queryBuilder, int page, int pageSize);

	/**
	 * ��ҳ��ѯ.
	 * 
	 * @param HSql
	 * @param page
	 *            ��ǰҳ,��1��ʼ
	 * @param pageSize
	 *            ÿҳ��¼����
	 * @return ResultObject
	 */
	public ResultObject searchByPage(String HSql, int page, int pageSize);

	/**
	 * ���hibernate session
	 * 
	 * @return Session session
	 */
	public Session getHiberbateSession();

}
