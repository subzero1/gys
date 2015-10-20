package com.netsky.service;

import java.io.Serializable;

import org.hibernate.Session;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.netsky.dataObject.BlobObject;

/**
 * 保存服务接口
 * 
 * @author Chiang
 */
public interface SaveService {

	/**
	 * 存储blob字段
	 * 
	 * @param BlobObject
	 * @param InputStream
	 * @return Object 保存结果.
	 */
	public Object saveBlob(BlobObject blobObject, MultipartHttpServletRequest multipartRequest) throws Exception;

	/**
	 * 存储blob字段
	 * 
	 * @param BlobObject[]
	 * @param InputStream
	 * @return Object[] 保存结果.
	 */
	public Object[] saveBlobs(BlobObject[] blobObject, MultipartHttpServletRequest multipartRequest) throws Exception;

	/**
	 * 存储blob字段
	 * 
	 * @param BlobObject[]
	 * @param InputStream
	 * @return Object[] 保存结果.
	 */
	public Object[] saveBlobs(BlobObject blobObject, MultipartHttpServletRequest multipartRequest) throws Exception;

	/**
	 * 保存对象
	 * 
	 * @param Object
	 * @return Object
	 */
	public Object save(Object object);

	/**
	 * 保存对象
	 * 
	 * @param Object
	 * @return Object
	 */
	public Object[] save(Object[] object) throws Exception;

	/**
	 * 使用hsql更新
	 * 
	 * @param String
	 *            hsql
	 */
	public void updateByHSql(String HSql);

	/**
	 * 根据id删除持久化对象
	 * 
	 * @param Class
	 *            clazz 持久化对象Class
	 * @param Serializable
	 *            id
	 */
	public void removeObject(Class clazz, Serializable id);
	
	/**
	 * 删除持久化对象
	 * 
	 * @param Object
	 *            持久化对象Object
	 */
	public void removeObject(Object o);
	
	/**
	 * 获得hibernate session
	 * 
	 * @return Session session
	 */
	public Session getHiberbateSession();

}
