package com.netsky.listener;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * 统计在线人数
 * 
 * @author CT
 * @create 2009-09-21
 */
public class SessionListener implements HttpSessionListener {

	public void sessionCreated(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		ServletContext application = session.getServletContext();
		Integer totalSessions = (Integer) application.getAttribute("totalSessions");
		if(totalSessions == null){
			totalSessions = new Integer(1);
			application.setAttribute("totalSessions", totalSessions);
		}else{
			totalSessions = new Integer(totalSessions.intValue() + 1);
			application.setAttribute("totalSessions", totalSessions);
		}
	}

	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		ServletContext application = session.getServletContext();
		Integer totalSessions = (Integer) application.getAttribute("totalSessions");
		if(totalSessions != null){
			totalSessions = new Integer(totalSessions.intValue() - 1);
			application.setAttribute("totalSessions", totalSessions);
		}
	}

}
