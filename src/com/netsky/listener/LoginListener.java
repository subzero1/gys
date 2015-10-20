package com.netsky.listener;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import com.netsky.dataObject.Gb01_yhb;

/**
 * @author Chiang 2009-09-24
 */
public class LoginListener implements HttpSessionBindingListener {

	private Gb01_yhb gb01;

	public LoginListener(Gb01_yhb gb01) {
		this.gb01 = gb01;
	}

	public void valueBound(HttpSessionBindingEvent event) {
		HttpSession session = event.getSession();
		ServletContext application = session.getServletContext();

		// 把用户名放入在线列表
		Map onlineUserList = (Map) application.getAttribute("onlineUserList");
		if (onlineUserList == null) {
			onlineUserList = new HashMap();
			application.setAttribute("onlineUserList", onlineUserList);
		}
		if (!onlineUserList.containsKey(this.gb01.getId()))
			onlineUserList.put(this.gb01.getId(), this.gb01);
	}

	public void valueUnbound(HttpSessionBindingEvent event) {
		HttpSession session = event.getSession();
		ServletContext application = session.getServletContext();
		// 从在线列表中删除用户名
		Map onlineUserList = (Map) application.getAttribute("onlineUserList");
		if (onlineUserList != null)
			onlineUserList.remove(this.gb01.getId());

	}

}
