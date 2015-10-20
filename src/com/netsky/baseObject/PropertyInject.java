package com.netsky.baseObject;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import jxl.Cell;
import jxl.Sheet;

import com.netsky.baseFormatUtils.DateFormatUtil;

/**
 * 自动注入对象属性通用类
 * 
 * @author Chiang
 */
public class PropertyInject {

	/**
	 * 自动注入request中内容到类的属性.
	 * 要求request中key值为对象属性名称的大写,当有request中有不同对象相同名称属性时,需要在key值前增加对象名称
	 * 
	 * @param request
	 * @param o
	 *            注入对象
	 * @param index
	 *            注入对象记录在request数组中的位置
	 * @return boolean set 是否已对传入对象进行注入,属性名称为ID不记为已注入.
	 * @throws Exception
	 */
	public static boolean inject(HttpServletRequest request, Object o, int index) throws Exception {
		boolean set = false;
		Class clazz = o.getClass();
		Method method[] = clazz.getDeclaredMethods();
		for (int i = 0; i < method.length; i++) {
			Class clazz1[] = method[i].getParameterTypes();
			if (clazz1.length == 1) {
				if (method[i].getName().indexOf("set") != -1) {
					String property[] = null;
					if (request.getParameterValues(method[i].getName().replaceFirst("set", "").toUpperCase()) != null
							&& request.getParameterValues(method[i].getName().replaceFirst("set", "").toUpperCase()).length > 0) {
						property = new String[] { request.getParameterValues(method[i].getName().replaceFirst("set", "").toUpperCase())[index] };
					} else if (request.getParameterValues(clazz.getName().substring(clazz.getName().lastIndexOf(".") + 1, clazz.getName().length())
							+ "." + method[i].getName().replaceFirst("set", "").toUpperCase()) != null
							&& request.getParameterValues(clazz.getName().substring(clazz.getName().lastIndexOf(".") + 1, clazz.getName().length())
									+ "." + method[i].getName().replaceFirst("set", "").toUpperCase()).length > 0) {
						property = new String[] { request.getParameterValues(clazz.getName().substring(clazz.getName().lastIndexOf(".") + 1,
								clazz.getName().length())
								+ "." + method[i].getName().replaceFirst("set", "").toUpperCase())[index] };
					}
					if (property != null && property[0] != null) {
						if (clazz1[0].getName().equals("java.lang.Integer")) {
							if (property[0].length() > 0)
								method[i].invoke(o, new Integer[] { Integer.valueOf(property[0]) });
							else
								method[i].invoke(o, new Integer[] { null });
							if (!method[i].getName().equalsIgnoreCase("setId") && property[0].length() > 0) {
								set = true;
							}
						} else if (clazz1[0].getName().equals("java.lang.String")) {
							method[i].invoke(o, property);
							if (property[0].length() > 0)
								set = true;
						} else if (clazz1[0].getName().equals("java.lang.Double")) {
							if (property[0].length() > 0) {
								method[i].invoke(o, new Double[] { Double.valueOf(property[0]) });
								set = true;
							} else
								method[i].invoke(o, new Double[] { null });
						} else if (clazz1[0].getName().equals("java.util.Date")) {
							if (property[0].length() > 0) {
								if (property[0].indexOf(":") == -1) {
									property[0] = property[0] + " 00:00:00";
								}
								method[i].invoke(o, new Date[] { DateFormatUtil.FormatDateString(property[0]) });
								set = true;
							} else
								method[i].invoke(o, new Date[] { null });
						}
					}
				}
			}
		}
		return set;
	}

	/**
	 * 自动注入request中内容到类的属性.并转换string型属性编码
	 * 要求request中key值为对象属性名称的大写,当有request中有不同对象相同名称属性时,需要在key值前增加对象名称
	 * 
	 * @param request
	 * @param o
	 *            注入对象
	 * @param index
	 *            注入对象记录在request数组中的位置
	 * @param fromCode
	 *            request 获取编码格式
	 * @param targetCode
	 *            重新编码格式
	 * @return boolean set 是否已对传入对象进行注入,属性名称为ID不记为已注入.
	 * @throws Exception
	 */
	public static boolean injectTransCode(HttpServletRequest request, Object o, int index, String fromCode, String targetCode) throws Exception {
		boolean set = false;
		Class clazz = o.getClass();
		Method method[] = clazz.getDeclaredMethods();
		for (int i = 0; i < method.length; i++) {
			Class clazz1[] = method[i].getParameterTypes();
			if (clazz1.length == 1) {
				if (method[i].getName().indexOf("set") != -1) {
					String property[] = null;
					if (request.getParameterValues(method[i].getName().replaceFirst("set", "").toUpperCase()) != null
							&& request.getParameterValues(method[i].getName().replaceFirst("set", "").toUpperCase()).length > 0) {
						property = new String[] { request.getParameterValues(method[i].getName().replaceFirst("set", "").toUpperCase())[index] };
					} else if (request.getParameterValues(clazz.getName().substring(clazz.getName().lastIndexOf(".") + 1, clazz.getName().length())
							+ "." + method[i].getName().replaceFirst("set", "").toUpperCase()) != null
							&& request.getParameterValues(clazz.getName().substring(clazz.getName().lastIndexOf(".") + 1, clazz.getName().length())
									+ "." + method[i].getName().replaceFirst("set", "").toUpperCase()).length > 0) {
						property = new String[] { request.getParameterValues(clazz.getName().substring(clazz.getName().lastIndexOf(".") + 1,
								clazz.getName().length())
								+ "." + method[i].getName().replaceFirst("set", "").toUpperCase())[index] };
					}
					if (property != null && property[0] != null) {
						if (clazz1[0].getName().equals("java.lang.Integer")) {
							if (property[0].length() > 0)
								method[i].invoke(o, new Integer[] { Integer.valueOf(property[0]) });
							else
								method[i].invoke(o, new Integer[] { null });
							if (!method[i].getName().equalsIgnoreCase("setId") && property[0].length() > 0) {
								set = true;
							}
						} else if (clazz1[0].getName().equals("java.lang.String")) {
							property[0] = new String(property[0].getBytes(fromCode), targetCode);
							method[i].invoke(o, property);
							if (property[0].length() > 0)
								set = true;
						} else if (clazz1[0].getName().equals("java.lang.Double")) {
							if (property[0].length() > 0) {
								method[i].invoke(o, new Double[] { Double.valueOf(property[0]) });
								set = true;
							} else
								method[i].invoke(o, new Double[] { null });
						} else if (clazz1[0].getName().equals("java.util.Date")) {
							if (property[0].length() > 0) {
								if (property[0].indexOf(":") == -1) {
									property[0] = property[0] + " 00:00:00";
								}
								method[i].invoke(o, new Date[] { DateFormatUtil.FormatTimeString(property[0]) });
								set = true;
							} else
								method[i].invoke(o, new Date[] { null });
						}
					}
				}
			}
		}
		return set;
	}

	/**
	 * 将对象一某属性值写入对象二某属性中,通过get,set方法实现
	 * 
	 * @param fatherObject
	 *            对象一
	 * @param fatherPerproty
	 *            对象一属性名称 大写
	 * @param o
	 *            对象二
	 * @param perproty
	 *            对象二属性名称 大写
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 */
	public static void injectNexus(Object fatherObject, String fatherPerproty, Object o, String perproty) throws IllegalArgumentException,
			IllegalAccessException, InvocationTargetException {
		Method fatherMethod[] = fatherObject.getClass().getMethods();
		Method method[] = o.getClass().getMethods();
		for (int i = 0; i < fatherMethod.length; i++) {
			if (fatherMethod[i].getName().indexOf("get") != -1
					&& (fatherMethod[i].getName().replaceFirst("get", "").toUpperCase()).equals(fatherPerproty)) {
				for (int j = 0; j < method.length; j++) {
					if (method[j].getName().indexOf("set") != -1 && (method[j].getName().replaceFirst("set", "").toUpperCase()).equals(perproty)) {
						method[j].invoke(o, new Object[] { fatherMethod[i].invoke(fatherObject, null) });
					}
				}
			}
		}
	}

	/**
	 * 通过对象中get方法,获取对象中的属性值
	 * 
	 * @param o
	 * @param perprotyName
	 *            大写属性名称
	 * @return Object 结果
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 */
	public static Object getPerproty(Object o, String perprotyName) throws IllegalArgumentException, IllegalAccessException,
			InvocationTargetException {
		Method method[] = o.getClass().getMethods();
		for (int i = 0; i < method.length; i++) {
			if (method[i].getName().indexOf("get") != -1 && (method[i].getName().replaceFirst("get", "").toUpperCase()).equals(perprotyName)) {
				return method[i].invoke(o, null);
			}
		}
		return null;
	}

	/**
	 * 对传入对象创建新的实例，并复制对象拥有getter、setter方法的属性到新实例
	 * 
	 * @param o
	 *            源对象
	 * @return Object 新创建的实例
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 * @throws InvocationTargetException
	 * @throws IllegalArgumentException
	 */
	public static Object cloneObject(Object o) throws InstantiationException, IllegalAccessException, IllegalArgumentException,
			InvocationTargetException {
		Object newObject = o.getClass().newInstance();
		Field field[] = o.getClass().getDeclaredFields();
		for (int i = 0; i < field.length; i++) {
			injectNexus(o, field[i].getName().toUpperCase(), newObject, field[i].getName().toUpperCase());
		}
		return newObject;
	}

	/**
	 * 将excel信息写入给定对象中
	 * 
	 * @param o
	 *            需要注入的对象
	 * @param columnIndex
	 *            存放字段所在列信息，key：字段名称，与o中属性名称一致。value：所在列
	 * @param sheet
	 *            excel工作表
	 * @param row
	 *            当前所在行
	 * @throws Exception
	 */
	public static boolean injectFromExcel(Object o, Map columnIndex, Sheet sheet, int row) throws Exception {
		boolean set = false;
		Class clazz = o.getClass();
		Method method[] = clazz.getDeclaredMethods();
		for (int i = 0; i < method.length; i++) {
			Class clazz1[] = method[i].getParameterTypes();
			if (clazz1.length == 1) {
				if (method[i].getName().indexOf("set") != -1) {
					String property[] = null;
					String colName = method[i].getName().replaceFirst("set", "").toUpperCase();
					Map colMap = (Map) columnIndex.get(colName);
					if (colMap != null) {
						int index = Integer.parseInt((String) colMap.get("$index"));
						Cell cell = sheet.getCell(index, row);
						if (cell.getContents() != null && cell.getContents().length() > 0) {
							property = new String[] { cell.getContents() };
						}
					}
					if (property != null && property[0] != null) {
						if (clazz1[0].getName().equals("java.lang.Integer")) {
							if (property[0].length() > 0)
								method[i].invoke(o, new Integer[] { Integer.valueOf(property[0]) });
							else
								method[i].invoke(o, new Integer[] { null });
							if (!method[i].getName().equalsIgnoreCase("setId") && property[0].length() > 0) {
								set = true;
							}
						} else if (clazz1[0].getName().equals("java.lang.String")) {
							method[i].invoke(o, property);
							if (property[0].length() > 0)
								set = true;
						} else if (clazz1[0].getName().equals("java.lang.Double")) {
							if (property[0].length() > 0) {
								method[i].invoke(o, new Double[] { Double.valueOf(property[0]) });
								set = true;
							} else
								method[i].invoke(o, new Double[] { null });
						} else if (clazz1[0].getName().equals("java.util.Date")) {
							if (property[0].length() > 0) {
								if (property[0].indexOf(":") == -1) {
									property[0] = property[0] + " 00:00:00";
								}
								method[i].invoke(o, new Date[] { DateFormatUtil.FormatDateString(property[0]) });
								set = true;
							} else
								method[i].invoke(o, new Date[] { null });
						}
					}
				}
			}
		}
		return set;
	}

	/**
	 * 通过类属性set方法,获取属性类型
	 * 
	 * @param clazz
	 *            类
	 * @param propertyName属性名,不区分大小写
	 * 
	 * @return Class 属性类型
	 */
	public static Class getPropertyType(Class clazz, String propertyName) {
		Method method[] = clazz.getDeclaredMethods();
		for (int i = 0; i < method.length; i++) {
			Class clazz1[] = method[i].getParameterTypes();
			if (clazz1.length == 1) {
				if (method[i].getName().indexOf("set") != -1 && method[i].getName().replaceFirst("set", "").equalsIgnoreCase(propertyName)) {
					return clazz1[0];
				}
			}
		}
		return null;
	}

	/**
	 * 复制不同对象中相同名称,相同类型的属性,通过get,set方法
	 * 
	 * @param fatherObject
	 *            父对象
	 * @param o
	 *            被操作对象
	 * @param notCopy[]
	 *            不复制的属性名称
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 */
	public static void copyProperty(Object fatherObject, Object o, String notCopy[]) throws IllegalArgumentException, IllegalAccessException,
			InvocationTargetException {
		Field fatherField[] = fatherObject.getClass().getDeclaredFields();
		Field field[] = o.getClass().getDeclaredFields();
		for (int i = 0; i < fatherField.length; i++) {
			for (int j = 0; j < field.length; j++) {
				if (field[j].getName().equals(fatherField[i].getName())) {
					boolean copyflag = true;
					if (notCopy != null) {
						for (int k = 0; k < notCopy.length; k++) {
							if (notCopy[k].equals(field[j].getName())) {
								copyflag = false;
								break;
							}
						}
					}
					if (copyflag) {
						injectNexus(fatherObject, fatherField[i].getName().toUpperCase(), o, fatherField[i].getName().toUpperCase());
					}
				}
			}
		}
	}
}
