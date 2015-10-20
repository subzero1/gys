package com.netsky.baseFormatUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * ���ڸ�ʽ������
 * 
 * @author Chiang
 */
public class DateFormatUtil {

	/**
	 * ��ʽ������Ϊyyyy-MM-dd.
	 * 
	 * @param date
	 * @return String
	 */
	public static String FormatDate(java.util.Date date) {
		if (date != null)
			return new SimpleDateFormat("yyyy-MM-dd").format(date);
		else
			return "";
	}

	/**
	 * ��ʽ������Ϊyyyy-MM-dd HH:mm:ss.
	 * 
	 * @param date
	 * @return String
	 */
	public static String FormatTime(java.util.Date date) {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
	}

	/**
	 * ��ʽ������Ϊָ����ʽ.
	 * 
	 * @param date
	 * @param String
	 * @throws Exception
	 * @return String
	 */
	public static String Format(java.util.Date date, String simple) throws Exception {
		if (date != null) {
			try {
				return new SimpleDateFormat(simple).format(date);
			} catch (Exception ex) {
				throw new Exception("Exception at Format " + simple + "��ʽ����ȷ" + ex);
			}
		} else {
			return "";
		}
	}

	/**
	 * ��ʽ������Ϊyyyy-MM-dd.
	 * 
	 * @param date
	 * @return String
	 */
	public static String FormatDate(java.sql.Date date) {
		java.util.Date javaDate = new java.util.Date(date.getTime());
		return new SimpleDateFormat("yyyy-MM-dd").format(javaDate);
	}

	/**
	 * ��ʽ������Ϊyyyy-MM-dd HH:mm:ss.
	 * 
	 * @param date
	 * @return String
	 */
	public static String FormatTime(java.sql.Date date) {
		java.util.Date javaDate = new java.util.Date(date.getTime());
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(javaDate);
	}

	/**
	 * yyyy-MM-dd�ַ��ʽ��Ϊjava.util.Date
	 * 
	 * @param source
	 * @throws Exception
	 * @return java.util.Date
	 */
	public static java.util.Date FormatDateString(String source) throws Exception {
		try {
			return new SimpleDateFormat("yyyy-MM-dd").parse(source);
		} catch (ParseException ex) {
			throw new Exception("Exception at ForamteDateString ���������ʽ���Ƿ�� yyyy-MM-dd" + ex.toString());
		}
	}

	/**
	 * yyyy-MM-dd HH:mm:ss�ַ��ʽ��Ϊjava.util.Date
	 * 
	 * @param source
	 * @throws Exception
	 * @return java.util.Date
	 */
	public static java.util.Date FormatTimeString(String source) throws Exception {
		try {
			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(source);
		} catch (ParseException ex) {
			throw new Exception("Exception at ForamteTimeString ���������ʽ���Ƿ�� yyyy-MM-dd HH:mm:ss" + ex.toString());
		}
	}

	/**
	 * �ַ��ʽ��Ϊjava.util.Date
	 * 
	 * @param source
	 *            �ַ�����
	 * @param simple
	 *            ��ʽ
	 * @throws Exception
	 * @return java.util.Date
	 */
	public static java.util.Date ForamteString(String source, String simple) throws Exception {
		try {
			return new SimpleDateFormat(simple).parse(source);
		} catch (ParseException ex) {
			throw new Exception("Exception at ForamteTimeString ���������ʽ���Ƿ�� " + simple + ex.toString());
		}
	}
}
