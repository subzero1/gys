package com.netsky.servlet;

import java.io.FileOutputStream;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseFormatUtils.DateFormatUtil;
import com.netsky.baseObject.PropertyInject;
import com.netsky.dataObject.BlobObject;
import com.netsky.dataObject.SlaveObject;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

/**
 * 附件保存servlet
 * 
 * 配置方法
 * 
 * 无父表 <input type="hidden" name="tableInfomation" value="noFatherTable:表名">
 * 
 * 有父表 <input type="hidden" name="tableInfomation"
 * value="父表1,本表关联父表1列,对应本表列/父表2,本表关联父表2列,对应本表列:表名 ">
 * 
 * ！主表信息应出现在其从表前！
 * 
 * 每条记录必须有id，格式 <input type="text" name="持久化对象名称.ID" value="">
 * 
 * 各表中有相同列名： <input type="text" name="持久化对象名称.属性名" value="">
 * 
 * 属性名称一律大写，持久化对象名称则保持原大小写
 * 
 * 返回路径 <input type="hidden" name="dispatchStr" value="">
 * 
 * 返回参数 <input type="hidden" name="perproty"
 * value="参数名1,表名1,字段名1/参数名2,表名2,字段名2/request中参数名称3">
 * 
 * 保存后调用service <input type="hidden" name="ServiceName" value="服务名称">
 * 
 * <input type="hidden" name="ServiceFunction" value="方法名称">
 * 
 * <input type="hidden" name="ServicePerproty"
 * value="表名1,字段名1/表名2,字段名2/request中参数名称3">
 * 
 * 附件表信息
 * 
 * <input type="hidden" name="slaveTable" value="表名">
 * 
 * <input type="hidden" name="slaveType" value="db或disk">
 * 
 * 附件表主表信息,主表信息应存在于非附件表且为单条记录
 * 
 * <input type="hidden" name="slaveFatherTables"
 * value="父表1,本表关联父表1列,对应本表列/父表2,本表关联父表2列,对应本表列">
 * 
 * @author Chiang 2009-08-18
 */
public class SlaveController implements Controller {

	/**
	 * 默认持久化对象包路径
	 */
	private static String packgePath = "com.netsky.dataObject";

	/**
	 * 默认附件保存路径
	 */
	private static String slavePatch = "slave";

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

	public ModelAndView handleRequest(HttpServletRequest HttpRequest, HttpServletResponse response) throws Exception {

		MultipartHttpServletRequest request = (MultipartHttpServletRequest) HttpRequest;
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
		} catch (Exception e) {
			throw new Exception("不能获取session" + e);
		}
		/**
		 * 存放主表保存结果map
		 */
		Map map = new HashMap();
		try {
			/**
			 * 获取所有表信息
			 */
			String tableInformations[] = request.getParameterValues("tableInfomation");
			if (tableInformations != null) {
				for (int i = 0; i < tableInformations.length; i++) {
					/**
					 * 父表信息及本表信息数组
					 */
					String tableInfo[] = tableInformations[i].split(":");
					for (int j = 0; j < request.getParameterValues(tableInfo[tableInfo.length - 1] + ".ID").length; j++) {
						Object o = Class.forName(packgePath + "." + tableInfo[tableInfo.length - 1]).newInstance();
						if (request.getParameterValues(tableInfo[tableInfo.length - 1] + ".ID")[j] != null
								&& request.getParameterValues(tableInfo[tableInfo.length - 1] + ".ID")[j].length() > 0) {
							/**
							 * 更新时获取数据库中最新信息
							 */
							o = queryService.searchById(o.getClass(), Integer.valueOf(request.getParameterValues(tableInfo[tableInfo.length - 1]
									+ ".ID")[j]));
						}
						if (PropertyInject.injectTransCode(request, o, j, "iso-8859-1", "GBK")) {
							/**
							 * 更新或插入
							 */
							if (tableInfo[0].equals("noFatherTable")) {
								/**
								 * 主表
								 */
								session.saveOrUpdate(o);
								map.put(tableInfo[tableInfo.length - 1], o);
							} else {
								/**
								 * 从表
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
							 * 删除
							 */
							session.delete(o);
						}
					}

				}
			}

			/**
			 * 处理附件信息
			 */
			if (request.getParameter("slaveTable") != null && request.getParameter("slaveTable").length() > 0) {
				Object o[] = new Object[request.getParameterValues(request.getParameter("slaveTable") + ".ID").length];
				for (int i = 0; i < o.length; i++) {
					o[i] = Class.forName(packgePath + "." + request.getParameter("slaveTable")).newInstance();
					PropertyInject.injectTransCode(request, o[i], i, "iso-8859-1", "GBK");
					/**
					 * 处理主从表信息
					 */
					if (request.getParameter("slaveFatherTables") != null && request.getParameter("slaveFatherTables").length() > 0) {
						String slaveFatherTables[] = request.getParameter("slaveFatherTables").split("/");
						for (int k = 0; k < slaveFatherTables.length; k++) {
							String fatherInfo[] = slaveFatherTables[k].split(",");
							PropertyInject.injectNexus(map.get(fatherInfo[0]), fatherInfo[1], o[i], fatherInfo[2]);
						}
					}
				}
				if (request.getParameter("slaveType") != null && "db".equals(request.getParameter("slaveType"))) {
					/**
					 * 保存到数据库
					 */
					saveService.saveBlobs((BlobObject[]) o, request);

				} else {
					/**
					 * 保存到磁盘
					 */
					Iterator it = request.getFileNames();
					int i = 0;
					while (it.hasNext() && i < o.length) {
						String fileDispath = (String) it.next();
						MultipartFile file = request.getFile(fileDispath);
						if (file.getName() != null && !file.getName().equals("") && file.getInputStream().available() > 0) {
							session.saveOrUpdate(o[i]);
							SlaveObject so = (SlaveObject) o[i];
							String fileName = so.getId() + so.getSlaveIdentifier();
							if (file.getOriginalFilename().indexOf(".") != -1) {
								String extends_name = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
								if (extends_name.length() == extends_name.getBytes().length)
									fileName += extends_name;
							}
							FileOutputStream fo = new FileOutputStream(request.getRealPath(slavePatch) + "/" + fileName);
							fo.write(file.getBytes());
							fo.flush();
							fo.close();
							so.setFileName(file.getOriginalFilename());
							so.setFilePatch(slavePatch + "/" + fileName);
							session.saveOrUpdate(so);
						}
					}
				}
			}

			/**
			 * 处理保存后调用
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
							 * 处理方法参数
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
			throw new Exception(e + " 保存出错! ");
		} finally {
			session.close();
		}

		/**
		 * 处理返回路径
		 */
		String dispatchStr = request.getParameter("dispatchStr");
		try {
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
		} catch (Exception e) {
			throw new Exception("处理返回地址出错" + e);
		}
		return new ModelAndView("redirect:" + dispatchStr);
	}
}
