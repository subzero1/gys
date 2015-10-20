package com.netsky.baseObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ��ѯ�����.
 * 
 * @author Chiang 2009-3-12
 */
public class ResultObject {

	/**
	 * ���ݿ��¼�ܳ��� ʹ�÷�ҳ��ѯʱ��Ϊ0
	 */
	private int totalRows = 0;

	/**
	 * ��ҳ�����ҳ��,ʹ�÷�ҳ��ѯʱ��Ϊ0
	 */
	private int totalPages = 0;

	/**
	 * ���������
	 */
	private int length = 0;

	/**
	 * �����Ŀǰλ��,Ĭ��-1
	 */
	private int placeIndex = -1;

	/**
	 * �����map
	 */
	private Map[] map;

	/**
	 * ������ؼ�������
	 */
	private String ResultArray[];

	/**
	 * ������Ƿ��þ�.
	 */
	private boolean bottom = false;

	/**
	 * ��ȡ������ؼ�������
	 * 
	 * @return String[]
	 */
	public String[] getResultArray() {
		return ResultArray;
	}

	/**
	 * @return the totalPages
	 */
	public int getTotalPages() {
		return totalPages;
	}

	/**
	 * @param totalPages
	 *            the totalPages to set
	 */
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	/**
	 * @return the totalRows
	 */
	public int getTotalRows() {
		return totalRows;
	}

	/**
	 * @param totalRows
	 *            the totalRows to set
	 */
	public void setTotalRows(int totalRows, int pageRowSize) {
		this.totalRows = totalRows;
		if (totalRows % pageRowSize == 0) {
			this.totalPages = totalRows / pageRowSize;
		} else {
			this.totalPages = totalRows / pageRowSize + 1;
		}
	}

	/**
	 * ��ȡ���������
	 * 
	 * @return int
	 */
	public int getLength() {
		return length;
	}

	/**
	 * ���ý��������,˽�з���
	 */
	private void setLength(int length) {
		this.length = length;
	}

	/**
	 * ��ȡ�����λ��
	 */
	public int getPlaceIndex() {
		return placeIndex;
	}

	/**
	 * ���ý����λ��
	 * 
	 * @param int
	 *            placeIndex �����λ��
	 */
	public void setPlaceIndex(int placeIndex) {
		this.placeIndex = placeIndex;
	}

	/**
	 * ���ý����λ��
	 */
	public void reSetPlaceIndex() {
		setPlaceIndex(-1);
	}

	/**
	 * HibernateQueryBuilder��ѯ��ʽ��Ӧ���췽��
	 * 
	 * @param list
	 *            hibernate��ѯ���ؽ��
	 * @param clazz
	 *            �־û�����Class
	 */
	public ResultObject(List list, Class clazz) {
		setLength(list.size());
		map = new HashMap[list.size()];
		for (int i = 0; i < list.size(); i++) {
			map[i] = new HashMap();
			map[i].put(clazz.getName(), list.get(i));
		}
	}

	/**
	 * hsql��ѯ��Ӧ���췽��
	 * 
	 * @param list
	 *            hibernate��ѯ���ؽ��
	 * @param HSql
	 */
	public ResultObject(List list, String HSql) {
		/**
		 * ��ʽ��hsql,����keys
		 */
		if (HSql.toUpperCase().indexOf("SELECT") != -1) {
			HSql = HSql.substring(HSql.toUpperCase().indexOf("SELECT") + 6, HSql.toUpperCase().indexOf("FROM")).trim();
			ResultArray = HSql.split(",");
		} else if (HSql.toUpperCase().indexOf("WHERE") != -1) {
			HSql = HSql.substring(HSql.toUpperCase().indexOf("FROM") + 4, HSql.toUpperCase().indexOf("WHERE")).trim();
			ResultArray = HSql.split(",");
		} else {
			HSql = HSql.substring(HSql.toUpperCase().indexOf("FROM") + 4).trim();
			ResultArray = HSql.split(",");
		}
		for (int i = 0; i < ResultArray.length; i++) {
			if (ResultArray[i].indexOf(" ") != -1) {
				ResultArray[i] = ResultArray[i].split(" ")[ResultArray[i].split(" ").length - 1];
			}
		}
		/**
		 * ���ɽ����
		 */
		map = new HashMap[list.size()];
		setLength(list.size());
		for (int i = 0; i < list.size(); i++) {
			map[i] = new HashMap();
			if (ResultArray.length > 1) {
				for (int j = 0; j < ResultArray.length; j++) {
					map[i].put(ResultArray[j], ((Object[]) list.get(i))[j]);
				}
			} else {
				map[i].put(ResultArray[0], list.get(i));
			}
		}
	}

	/**
	 * ָ����һ��¼
	 */
	public boolean next() {
		placeIndex++;
		if (placeIndex < length) {
			bottom = true;
			return true;
		} else {
			bottom = false;
			return false;
		}
	}

	/**
	 * ����key��ý��
	 * 
	 * @param key
	 *            �����������
	 */
	public Object get(String key) {
		if (placeIndex < length && bottom) {
			return map[placeIndex].get(key);
		} else {
			return null;
		}
	}

	/**
	 * ���ý����.
	 */
	public void reSet() {
		placeIndex = -1;
		bottom = false;
	}

	/**
	 * @return the bottom
	 */
	public boolean isBottom() {
		return bottom;
	}

	/**
	 * @param bottom
	 *            the bottom to set
	 */
	public void setBottom(boolean bottom) {
		this.bottom = bottom;
	}

}
