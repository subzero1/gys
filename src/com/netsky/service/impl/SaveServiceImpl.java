package com.netsky.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Session;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.netsky.baseService.Dao;
import com.netsky.dataObject.BlobObject;
import com.netsky.service.SaveService;

/**
 * 保存操作服务实现
 * 
 * @author Chiang
 */
public class SaveServiceImpl implements SaveService {

	private Dao dao;

	public Dao getDao() {
		return dao;
	}

	public void setDao(Dao dao) {
		this.dao = dao;
	}

	public Object saveBlob(BlobObject blobObject, MultipartHttpServletRequest multipartRequest) throws Exception {
		Iterator it = multipartRequest.getFileNames();
		while (it.hasNext()) {
			String fileDispath = (String) it.next();
			MultipartFile file = multipartRequest.getFile(fileDispath);
			blobObject.setFileName(file.getName());
			byte[] b = new byte[file.getInputStream().available()];
			file.getInputStream().read(b);
			blobObject.setBlob(b);
		}
		return dao.saveObject(blobObject);
	}

	public Object[] saveBlobs(BlobObject[] blobObject, MultipartHttpServletRequest multipartRequest) throws Exception {
		List list = new ArrayList();
		Iterator it = multipartRequest.getFileNames();
		int i = 0;
		while (it.hasNext() && i < blobObject.length) {
			String fileDispath = (String) it.next();
			MultipartFile file = multipartRequest.getFile(fileDispath);
			if (file != null) {
				byte[] b = new byte[file.getInputStream().available()];
				file.getInputStream().read(b);
				if (b.length != 0) {
					blobObject[i].setFileName(file.getOriginalFilename());
					blobObject[i].setBlob(b);
					list.add(blobObject[i]);
				}
			}
			i++;
		}
		return dao.saveObject(list.toArray(new Object[list.size()]));
	}

	public Object[] saveBlobs(BlobObject blobObject, MultipartHttpServletRequest multipartRequest) throws Exception {
		List list = new ArrayList();
		Iterator it = multipartRequest.getFileNames();
		while (it.hasNext()) {
			String fileDispath = (String) it.next();
			MultipartFile file = multipartRequest.getFile(fileDispath);
			if (file != null) {
				byte[] b = new byte[file.getInputStream().available()];
				file.getInputStream().read(b);
				if (b.length != 0) {
					BlobObject newObject = blobObject.cloneAttribute();
					newObject.setFileName(file.getOriginalFilename());
					newObject.setBlob(b);
					list.add(newObject);
				}
			}
		}
		return dao.saveObject(list.toArray(new Object[list.size()]));
	}

	public Object save(Object object) {
		return dao.saveObject(object);
	}

	public Object[] save(Object[] object) throws Exception {
		return dao.saveObject(object);
	}

	public void updateByHSql(String HSql) {
		dao.update(HSql);
	}

	public void removeObject(Class clazz, Serializable id) {
		dao.removeObject(clazz, id);
	}

	public void removeObject(Object o) {
		dao.removeObject(o);		
	}

	public Session getHiberbateSession() {
		return dao.getHiberbateSession();
	}

}
