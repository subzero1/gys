package com.netsky.baseFormatUtils;

import java.math.BigDecimal;

import javax.xml.ws.Action;

/**
 * ��ȷ�������
 * 
 * @author Chiang 2009-3-16
 */
public class NumberFormatUtil {

	/**
	 * Ĭ�ϳ���С��λ��
	 */
	private static final int DEFULT_DIV_SCAL = 2;

	/**
	 * Ĭ���������뱣��С��λ�� 2
	 */
	private static final int DEFULT_ROUND_SCAL = 2;

	private NumberFormatUtil() {
	}

	/**
	 * �ӷ�����.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return double ��������ĺ�
	 */
	public static double addToDouble(double number1, double number2) {
		return addToDouble(Double.toString(number1), Double.toString(number2));
	}

	/**
	 * �ӷ�����.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return double ��������ĺ�
	 */
	public static double addToDouble(String number1, String number2) {
		return new BigDecimal(number1).add(new BigDecimal(number2)).doubleValue();
	}

	/**
	 * �ӷ�����.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return String ��������ĺ�
	 */
	public static String addToString(String number1, String number2) {
		return new BigDecimal(number1).add(new BigDecimal(number2)).toString();
	}

	/**
	 * �ӷ�����.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return String ��������ĺ�
	 */
	public static String addToString(double number1, double number2) {
		return addToString(Double.toString(number1), Double.toString(number2));
	}

	/**
	 * ��������.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return double ��������Ĳ�
	 */
	public static double subToDouble(String number1, String number2) {
		return new BigDecimal(number1).subtract(new BigDecimal(number2)).doubleValue();
	}

	/**
	 * ��������.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return double ��������Ĳ�
	 */
	public static double subToDouble(double number1, double number2) {
		return subToDouble(Double.toString(number1), Double.toString(number2));
	}

	/**
	 * ��������.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return String ��������Ĳ�
	 */
	public static String subToString(String number1, String number2) {
		return new BigDecimal(number1).subtract(new BigDecimal(number2)).toString();
	}

	/**
	 * ��������.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return String ��������Ĳ�
	 */
	public static String subToString(double number1, double number2) {
		return subToString(Double.toString(number1), Double.toString(number2));
	}

	/**
	 * �˷�����.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return double ��������Ļ�
	 */
	public static double mulToDouble(String number1, String number2) {
		return new BigDecimal(number1).multiply(new BigDecimal(number2)).doubleValue();
	}

	/**
	 * �˷�����.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return double ��������Ļ�
	 */
	public static double mulToDouble(double number1, double number2) {
		return mulToDouble(Double.toString(number1), Double.toString(number2));
	}

	/**
	 * �˷�����.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return String ��������Ļ�
	 */
	public static String mulToString(String number1, String number2) {
		return new BigDecimal(number1).multiply(new BigDecimal(number2)).toString();
	}

	/**
	 * �˷�����.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return String ��������Ļ�
	 */
	public static String mulToString(double number1, double number2) {
		return mulToString(Double.toString(number1), Double.toString(number2));
	}

	/**
	 * �����㣬Ĭ�ϱ���С����2λ DEFULT_DIV_SCAL = 2.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return String
	 */
	public static String divToString(String number1, String number2) {
		return new BigDecimal(number1).divide(new BigDecimal(number2), DEFULT_DIV_SCAL, BigDecimal.ROUND_HALF_UP).toString();
	}

	/**
	 * �����㣬Ĭ�ϱ���С����2λ DEFULT_DIV_SCAL = 2.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return String
	 */
	public static String divToString(double number1, double number2) {
		return divToString(Double.toString(number1), Double.toString(number2));
	}

	/**
	 * �����㣬Ĭ�ϱ���С����2λ DEFULT_DIV_SCAL = 2.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return double
	 */
	public static double divToDouble(String number1, String number2) {
		return new BigDecimal(number1).divide(new BigDecimal(number2), DEFULT_DIV_SCAL, BigDecimal.ROUND_HALF_UP).doubleValue();
	}

	/**
	 * �����㣬Ĭ�ϱ���С����2λ DEFULT_DIV_SCAL = 2.
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @return double
	 */
	public static double divToDouble(double number1, double number2) {
		return divToDouble(Double.toString(number1), Double.toString(number2));
	}

	/**
	 * �����㣬����scalλС���
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @param scal
	 *            ����С���λ��
	 * @return double
	 */
	public static double divToDouble(String number1, String number2, int scal) {
		return new BigDecimal(number1).divide(new BigDecimal(number2), scal, BigDecimal.ROUND_HALF_UP).doubleValue();
	}

	/**
	 * �����㣬����scalλС���
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @param scal
	 *            ����С���λ��
	 * @return double
	 */
	public static double divToDouble(double number1, double number2, int scal) {
		return divToDouble(Double.toString(number1), Double.toString(number2), scal);
	}

	/**
	 * �����㣬����scalλС���
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @param scal
	 *            ����С���λ��
	 * @return String
	 */
	public static String divToString(String number1, String number2, int scal) {
		return new BigDecimal(number1).divide(new BigDecimal(number2), scal, BigDecimal.ROUND_HALF_UP).toString();
	}

	/**
	 * �����㣬����scalλС���
	 * 
	 * @param number1
	 *            ������
	 * @param number2
	 *            ����
	 * @param scal
	 *            ����С���λ��
	 * @return String
	 */
	public static String divToString(double number1, double number2, int scal) {
		return divToString(Double.toString(number1), Double.toString(number2), scal);
	}

	/**
	 * Ĭ�ϱ���С������λ DEFULT_DIV_SCAL = 2
	 * 
	 * @param number
	 * @return String
	 */
	public static String roundToString(String number) {
		return new BigDecimal(number).divide(new BigDecimal("1"), DEFULT_ROUND_SCAL, BigDecimal.ROUND_HALF_UP).toString();
	}

	/**
	 * Ĭ�ϱ���С������λ DEFULT_DIV_SCAL = 2
	 * 
	 * @param number
	 * @param str
	 *            numberΪ0ʱ�����ַ�
	 * @return String
	 */
	public static String roundToString(String number, String str) {
		if (number != null && Double.parseDouble(number) != 0.0)
			return new BigDecimal(number).divide(new BigDecimal("1"), DEFULT_ROUND_SCAL, BigDecimal.ROUND_HALF_UP).toString();
		else
			return str;
	}

	/**
	 * Ĭ�ϱ���С������λ DEFULT_DIV_SCAL = 2
	 * 
	 * @param number
	 * @return String
	 */
	public static String roundToString(double number) {
		return roundToString(Double.toString(number));
	}

	/**
	 * Ĭ�ϱ���С������λ DEFULT_DIV_SCAL = 2
	 * 
	 * @param number
	 * @param str
	 *            numberΪ0ʱ�����ַ�
	 * @return String
	 */
	public static String roundToString(double number, String str) {
		if (number != 0.0)
			return roundToString(Double.toString(number));
		else
			return str;
	}

	/**
	 * Ĭ�ϱ���С������λ DEFULT_DIV_SCAL = 2
	 * 
	 * @param number
	 * @return String
	 */
	public static String roundToString(Double number) {
		if (number != null)
			return roundToString(number.toString());
		else
			return roundToString("0");
	}

	/**
	 * Ĭ�ϱ���С������λ DEFULT_DIV_SCAL = 2
	 * 
	 * @param number
	 * @param str
	 *            ��numberΪ�ջ���Ϊ0ʱ�����ַ�
	 * @return String
	 */
	public static String roundToString(Double number, String str) {
		if (number != null && number.doubleValue() != 0.0)
			return roundToString(number.toString());
		else
			return str;
	}

	/**
	 * Ĭ�ϱ���С������λ DEFULT_DIV_SCAL = 2
	 * 
	 * @param number
	 * @return double
	 */
	public static double roundToDouble(String number) {
		return new BigDecimal(number).divide(new BigDecimal("1"), DEFULT_ROUND_SCAL, BigDecimal.ROUND_HALF_UP).doubleValue();
	}

	/**
	 * Ĭ�ϱ���С������λ DEFULT_DIV_SCAL = 2
	 * 
	 * @param number
	 * @return String
	 */
	public static double roundToDouble(double number) {
		return roundToDouble(Double.toString(number));
	}

	/**
	 * Ĭ�ϱ���С������λ DEFULT_DIV_SCAL = 2
	 * 
	 * @param number
	 * @return String
	 */
	public static double roundToDouble(Double number) {
		if (number != null)
			return roundToDouble(number.toString());
		else
			return 0;
	}

	/**
	 * ����С����scalλ
	 * 
	 * @param number
	 * @param scal
	 * @return String
	 */
	public static String roundToString(String number, int scal) {
		return new BigDecimal(number).divide(new BigDecimal("1"), scal, BigDecimal.ROUND_HALF_UP).toString();
	}

	/**
	 * ����С����scalλ
	 * 
	 * @param number
	 * @param scal
	 * @return String
	 */
	public static String roundToString(double number, int scal) {
		return roundToString(Double.toString(number), scal);
	}

	/**
	 * ����С����scalλ
	 * 
	 * @param number
	 * @param scal
	 * @return String
	 */
	public static String roundToString(Double number, int scal) {
		if (number != null)
			return roundToString(number.toString(), scal);
		else
			return roundToString("0", scal);
	}

	/**
	 * ����С����scalλ
	 * 
	 * @param number
	 * @param scal
	 * @return double
	 */
	public static double roundToDouble(String number, int scal) {
		return new BigDecimal(number).divide(new BigDecimal("1"), scal, BigDecimal.ROUND_HALF_UP).doubleValue();
	}

	/**
	 * ����С����scalλ
	 * 
	 * @param number
	 * @param scal
	 * @return String
	 */
	public static double roundToDouble(double number, int scal) {
		return roundToDouble(Double.toString(number), scal);
	}

	/**
	 * ����С����scalλ
	 * 
	 * @param number
	 * @param scal
	 * @return String
	 */
	public static double roundToDouble(Double number, int scal) {
		if (number != null)
			return roundToDouble(number.toString(), scal);
		else
			return 0;
	}

	/**
	 * ȡ��,��4��5��
	 * 
	 * @param number
	 * @return String
	 */
	public static String subScal(String number) {
		if (number != null) {
			return number = number.substring(0, number.indexOf("."));
		} else {
			return "";
		}
	}
}
