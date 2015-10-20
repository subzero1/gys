package com.netsky.servlet;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseFormatUtils.DateFormatUtil;
import com.netsky.baseObject.PropertyInject;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

/**
 * �����servlet
 * 
 * ���÷���
 * 
 * �޸��� <input type="hidden" name="tableInfomation" value="noFatherTable:����">
 * 
 * �и��� <input type="hidden" name="tableInfomation"
 * value="����1,�����������1��,��Ӧ������/����2,�����������2��,��Ӧ������:���� ">
 * 
 * ��������ϢӦ��������ӱ�ǰ��
 * 
 * ÿ����¼������id����ʽ <input type="text" name="�־û���������.ID" value="">
 * 
 * ����������ͬ������ <input type="text" name="�־û���������.������" value="">
 * 
 * ��������һ�ɴ�д���־û����������򱣳�ԭ��Сд
 * 
 * ����·�� <input type="hidden" name="dispatchStr" value="">
 * 
 * ���ز��� <input type="hidden" name="perproty"
 * value="������1,����1,�ֶ���1/������2,����2,�ֶ���2/request�в�������3">
 * 
 * ��������service <input type="hidden" name="ServiceName" value="��������">
 * 
 * <input type="hidden" name="ServiceFunction" value="��������">
 * 
 * <input type="hidden" name="ServicePerproty"
 * value="����1,�ֶ���1/����2,�ֶ���2/request�в�������3">
 * 
 * @author Chiang 2009-04-03
 */
public class DataController implements Controller {

	/**
	 * Ĭ�ϳ־û������·��
	 */
	private static String packgePath = "com.netsky.dataObject";

	private SaveService saveService;

	private QueryService queryService;

	/**
	 * @return the saveService
	 */
	public SaveService getSaveService() {
		return saveService;
	}

	/**
	 * @param saveService
	 *            the saveService to set
	 */
	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	/**
	 * @return the queryService
	 */
	public QueryService getQueryService() {
		return queryService;
	}

	/**
	 * @param queryService
	 *            the queryService to set
	 */
	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("GBK");
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
		} catch (Exception e) {
			throw new Exception("���ܻ�ȡsession" + e);
		}
		/**
		 * �����������map
		 */
		Map map = new HashMap();
		try {
			/**
			 * ��ȡ���б���Ϣ
			 */
			String tableInformations[] = request.getParameterValues("tableInfomation");
			for (int i = 0; i < tableInformations.length; i++) {
				/**
				 * ������Ϣ��������Ϣ����
				 */
				String tableInfo[] = tableInformations[i].split(":");
				for (int j = 0; j < request.getParameterValues(tableInfo[tableInfo.length - 1] + ".ID").length; j++) {
					Object o = Class.forName(packgePath + "." + tableInfo[tableInfo.length - 1]).newInstance();
					if (request.getParameterValues(tableInfo[tableInfo.length - 1] + ".ID")[j] != null
							&& request.getParameterValues(tableInfo[tableInfo.length - 1] + ".ID")[j].length() > 0) {
						/**
						 * ����ʱ��ȡ���ݿ���������Ϣ
						 */
						o = queryService.searchById(o.getClass(), Integer
								.valueOf(request.getParameterValues(tableInfo[tableInfo.length - 1] + ".ID")[j]));
					}
					if (PropertyInject.inject(request, o, j)) {
						/**
						 * ���»����
						 */
						if (tableInfo[0].equals("noFatherTable")) {
							/**
							 * ����
							 */
							session.saveOrUpdate(o);
							map.put(tableInfo[tableInfo.length - 1], o);
						} else {
							/**
							 * �ӱ�
							 */
							String fatherTables[] = tableInfo[0].split("/");
							for (int k = 0; k < fatherTables.length; k++) {
								String fatherInfo[] = fatherTables[k].split(",");
								PropertyInject.injectNexus(map.get(fatherInfo[0]), fatherInfo[1], o, fatherInfo[2]);
								session.saveOrUpdate(o);
							}
						}

					} else if (request.getParameterValues(tableInfo[tableInfo.length - 1] + ".ID")[j] != null
							&& request.getParameterValues(tableInfo[tableInfo.length - 1] + ".ID")[j].length() > 0) {
						/**
						 * ɾ��
						 */
						session.delete(o);
					}
				}

			}
			/**
			 * ����������
			 */
			if (request.getParameter("ServiceName") != null && request.getParameter("ServiceName").length() > 0) {
				ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				Object service = ctx.getBean(request.getParameter("ServiceName"));
				if (service != null && request.getParameter("ServiceFunction") != null && request.getParameter("ServiceFunction").length() > 0) {
					Method method[] = service.getClass().getDeclaredMethods();
					for (int i = 0; i < method.length; i++) {
						if (method[i].getName().equals(request.getParameter("ServiceFunction"))) {
							Object object[] = null;
							/**
							 * ����������
							 */
							if (request.getParameter("ServicePerproty") != null && request.getParameter("ServicePerproty").length() > 0) {
								String perprotys[] = request.getParameter("ServicePerproty").split("/");
								object = new Object[perprotys.length];
								for (int j = 0; j < perprotys.length; j++) {
									if (perprotys[j].split(",").length > 1) {
										Object o = PropertyInject.getPerproty(map.get(perprotys[j].split(",")[0]), perprotys[j].split(",")[1]);
										object[j] = o;
									} else {
										Class clazz[] = method[i].getParameterTypes();
										if (clazz[j].getName().equals("java.lang.Integer")) {
											object[j] = Integer.valueOf(request.getParameter(perprotys[j]));
										} else if (clazz[j].getName().equals("java.lang.String")) {
											object[j] = request.getParameter(perprotys[j]);
										} else if (clazz[j].getName().equals("java.lang.Double")) {
											object[j] = Double.valueOf(request.getParameter(perprotys[j]));
										} else if (clazz[j].getName().equals("java.util.Date")) {
											object[j] = DateFormatUtil.FormatDateString(request.getParameter(perprotys[j]));
										}
									}
								}
							}
							method[i].invoke(service, object);
						}
					}
				}
			}
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " �������! ");
		} finally {
			session.close();
		}

		/**
		 * ������·��
		 */
		String dispatchStr = request.getParameter("dispatchStr");
		if (request.getParameter("perproty") != null && request.getParameter("perproty").length() > 0) {
			String perprotys[] = request.getParameter("perproty").split("/");
			for (int i = 0; i < perprotys.length; i++) {
				if (perprotys[i].split(",").length > 1) {
					Object o = PropertyInject.getPerproty(map.get(perprotys[i].split(",")[1]), perprotys[i].split(",")[2]);
					if (dispatchStr.indexOf("?") != -1 && o != null) {
						dispatchStr += "&" + perprotys[i].split(",")[0] + "=" + o.toString();
					} else if (o != null) {
						dispatchStr += "?" + perprotys[i].split(",")[0] + "=" + o.toString();
					}
				} else {
					if (dispatchStr.indexOf("?") != -1) {
						dispatchStr += "&" + perprotys[i] + "=" + request.getParameter(perprotys[i]);
					} else {
						dispatchStr += "?" + perprotys[i] + "=" + request.getParameter(perprotys[i]);
					}
				}
			}
		}
		return new ModelAndView("redirect:" + dispatchStr);
	}
}
