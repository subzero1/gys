package com.netsky.service;

import java.io.Serializable;
import java.util.List;

import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;

/**
 * ��ѯ����ӿ�
 * 
 * @author Chiang 2009-3-11
 */
public interface QueryService {

	/**
	 * ͨ��queryBuilder��ѯ.
	 * 
	 * @param queryBuilder
	 * @return ResultObject
	 */
	public ResultObject search(QueryBuilder queryBuilder);

	/**
	 * ͨ��hsql��ѯ
	 * 
	 * @param HSql
	 * @return ResultObject
	 */
	public ResultObject search(String HSql);

	/**
	 * ͨ��queryBuilder��ѯ.
	 * 
	 * @param queryBuilder
	 * @return List
	 */
	public List searchList(QueryBuilder queryBuilder);

	/**
	 * ͨ��id��ѯ.
	 * 
	 * @param clazz
	 * @param id
	 * @return Object
	 */
	public Object searchById(Class clazz, Serializable id);

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
}
