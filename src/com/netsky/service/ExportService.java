package com.netsky.service;

import java.util.ArrayList;

import com.netsky.viewObject.BakVo;

import jxl.write.WritableSheet;

/**
 * ���ݵ�������
 * 
 * @author Chiang 2009-06-22
 */
public interface ExportService {

	/**
	 * ������ܱ���Ϣ��ָ��WritableSheet
	 * 
	 * @param ws
	 *            ��дSheet
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_ids
	 *            �����ids,��Ҫ����ĵ����id�ַ���,���ŷָ�
	 * @param startPage
	 *            ��ʼҳ
	 * @param bgbh
	 *            ��ӡ�����
	 * @throws Exception
	 */
	public void exportHzbtoExcel(WritableSheet ws, Integer gcxm_id, String dxgc_ids, int startPage, String bgbh) throws Exception;

	/**
	 * �����2��Ϣ��ָ��WritableSheet
	 * 
	 * @param ws
	 *            ��дSheet
	 * @param dxgc_id
	 *            �����id
	 * @param startPage
	 *            ��ʼҳ
	 * @param bgbh
	 *            ��ӡ�����
	 * @throws Exception
	 */
	public void exportB2toExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

	public BakVo expBak(String pID, String[] spIDs) throws Exception;

	public void impBak(String pSign, String[] spSigns, ArrayList data, String gcfl, String operate, String cjr_id, String cjr) throws Exception;

	public boolean impValid(String pSign, String[] spSigns, ArrayList data, String cjr_id) throws Exception;

	/**
	 * �����3����Ϣ��ָWritableSheet
	 * 
	 * @param ws
	 *            ��дSheet
	 * @param dxgc_id
	 *            �����Id
	 * @throws Exception
	 */

	public void exportB3JtoExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

	/**
	 * �����3����Ϣ��ָ����WritableSheet
	 * 
	 * @param ws
	 *            ��дSheet
	 * @param dxgc_id
	 *            �����ID
	 * @throws Exception
	 */
	public void exportB3ytoExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

	/**
	 * �����3����ϢExcel
	 * 
	 * @param ws
	 * @param dxgc_id
	 * @throws Exception
	 */
	public void exportB3btoExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

	/**
	 * ��1Excel���
	 * 
	 * @param ws
	 * @param dxgc_id
	 * @throws Exception
	 */
	public void exportB1toExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

	/**
	 * �����4��Ϣ��ָ��WritableSheet
	 * 
	 * @param ws
	 *            ��дSheet
	 * @param dxgc_id
	 *            �����id
	 * @param bgbh
	 *            �����
	 * @param startPage
	 *            ��ʼҳ
	 * @param printBgbh
	 *            ��ӡ�����
	 * @throws Exception
	 */
	public void exportB4toExcel(WritableSheet ws, Integer dxgc_id, String bgbh, int startPage, String printBgbh) throws Exception;

	/**
	 * �����5��Ϣ��ָ��WritableSheet
	 * 
	 * @param ws
	 *            ��дSheet
	 * @param dxgc_id
	 *            �����id
	 * @param startPage
	 *            ��ʼҳ
	 * @param totalPage
	 *            ��ҳ��
	 * @throws Exception
	 */
	public void exportB5toExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

}
