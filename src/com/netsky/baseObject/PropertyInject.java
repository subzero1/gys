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
 * �Զ�ע���������ͨ����
 * 
 * @author Chiang
 */
public class PropertyInject {

	/**
	 * �Զ�ע��request�����ݵ��������.
	 * Ҫ��request��keyֵΪ�����������ƵĴ�д,����request���в�ͬ������ͬ��������ʱ,��Ҫ��keyֵǰ���Ӷ�������
	 * 
	 * @param request
	 * @param o
	 *            ע�����
	 * @param index
	 *            ע������¼��request�����е�λ��
	 * @return boolean set �Ƿ��ѶԴ���������ע��,��������ΪID����Ϊ��ע��.
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
	 * �Զ�ע��request�����ݵ��������.��ת��string�����Ա���
	 * Ҫ��request��keyֵΪ�����������ƵĴ�д,����request���в�ͬ������ͬ��������ʱ,��Ҫ��keyֵǰ���Ӷ�������
	 * 
	 * @param request
	 * @param o
	 *            ע�����
	 * @param index
	 *            ע������¼��request�����е�λ��
	 * @param fromCode
	 *            request ��ȡ�����ʽ
	 * @param targetCode
	 *            ���±����ʽ
	 * @return boolean set �Ƿ��ѶԴ���������ע��,��������ΪID����Ϊ��ע��.
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
	 * ������һĳ����ֵд������ĳ������,ͨ��get,set����ʵ��
	 * 
	 * @param fatherObject
	 *            ����һ
	 * @param fatherPerproty
	 *            ����һ�������� ��д
	 * @param o
	 *            �����
	 * @param perproty
	 *            ������������� ��д
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
	 * ͨ��������get����,��ȡ�����е�����ֵ
	 * 
	 * @param o
	 * @param perprotyName
	 *            ��д��������
	 * @return Object ���
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
	 * �Դ�����󴴽��µ�ʵ���������ƶ���ӵ��getter��setter���������Ե���ʵ��
	 * 
	 * @param o
	 *            Դ����
	 * @return Object �´�����ʵ��
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
	 * ��excel��Ϣд�����������
	 * 
	 * @param o
	 *            ��Ҫע��Ķ���
	 * @param columnIndex
	 *            ����ֶ���������Ϣ��key���ֶ����ƣ���o����������һ�¡�value��������
	 * @param sheet
	 *            excel������
	 * @param row
	 *            ��ǰ������
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
	 * ͨ��������set����,��ȡ��������
	 * 
	 * @param clazz
	 *            ��
	 * @param propertyName������,�����ִ�Сд
	 * 
	 * @return Class ��������
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
	 * ���Ʋ�ͬ��������ͬ����,��ͬ���͵�����,ͨ��get,set����
	 * 
	 * @param fatherObject
	 *            ������
	 * @param o
	 *            ����������
	 * @param notCopy[]
	 *            �����Ƶ���������
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
