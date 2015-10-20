package com.netsky.service.impl;

import java.io.Serializable;
import java.util.List;

import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.baseService.Dao;
import com.netsky.service.QueryService;

/**
 * 查询服务实现类
 * 
 * @author Chiang 2009-03-11
 */
public class QueryServiceImpl implements QueryService {

	private Dao dao;

	public Dao getDao() {
		return dao;
	}

	public void setDao(Dao dao) {
		this.dao = dao;
	}

	public ResultObject search(QueryBuilder queryBuilder) {
		return new ResultObject(dao.search(queryBuilder), queryBuilder.getClazz());
	}

	public ResultObject search(String HSql) {
		return new ResultObject(dao.search(HSql), HSql);
	}

	public List searchList(QueryBuilder queryBuilder) {
		return dao.search(queryBuilder);
	}

	public Object searchById(Class clazz, Serializable id) {
		return dao.getObject(clazz, id);
	}

	public ResultObject searchByPage(QueryBuilder queryBuilder, int page, int pageSize) {
		return dao.searchByPage(queryBuilder, page, pageSize);
	}

	public ResultObject searchByPage(String HSql, int page, int pageSize) {
		return dao.searchByPage(HSql, page, pageSize);
	}

}
