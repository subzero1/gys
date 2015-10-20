package com.netsky.viewObject;

import java.io.Serializable;
import java.util.ArrayList;

public class BakVo implements Serializable {

	private static final long serialVersionUID = 1L;

	private Object basicInfo = null;
	
	private ArrayList list = new ArrayList();

	public Object getBasicInfo() {
		return basicInfo;
	}

	public void setBasicInfo(Object basicInfo) {
		this.basicInfo = basicInfo;
	}

	public ArrayList getList() {
		return list;
	}

}