/**
 * ��������javascript����
 *
 * @author Chiang 2009-04-14
 */
 

/**
 * �������Ϣ,���ڶ������и���
 * @param obj
 *				��ģ��
 * @return obj �²�����ж���
 */
function cloneRow(obj) {
	var newObj = obj.cloneNode(true);
	for (var i = 0; i < newObj.children.length; i++) {
		if (newObj.children[i].children.length > 0) {
			/**
			 * �����ӽ�㳤�Ȳ�����0
			 */
			for (var j = 0; j < newObj.children[i].children.length; j++) {
				var tdChild = newObj.children[i].children[j];
				if (String(tdChild.tagName.toUpperCase()) == "INPUT") {
					/**
					 * ����������Ϊinput�Ķ���.
					 */
					if (String(tdChild.type).toUpperCase() == "TEXT" || String(tdChild.type).toUpperCase("HIDDEN") || String(tdChild.type).toUpperCase("TEXTAREA")) {
						/**
						 * ��ͨ�������������.
						 */
						tdChild.value = "";
					} else if (String(tdChild.type).toUpperCase() == "CHECKBOX" || String(tdChild.type).toUpperCase() == "RADIO") {
						/**
						 * ��ѡ���ѡ��.
						 */
						tdChild.checked == false;
					}
				} else if (String(tdChild.tagName.toUpperCase()) == "SELECT") {
					/**
					 * ��������ѡ���
					 */
					tdChild.value = "";
				}
			}
		} else {
			newObj.children[i].innerText = "";
		}
	}
	newObj.style.display = "block";
	obj.parentNode.insertAdjacentElement("beforeEnd", newObj);
	return newObj;
}

/**
 * ɾ������Ϣ��id�ֶ���Ϣ����
 * @param rowObj
 *				��Ҫɾ������
 */
function deleteRow(rowObj) {
	for (var i = 0; i < rowObj.children.length; i++) {
		if (rowObj.children[i].children.length > 0) {
			/**
			 * �����ӽ�㳤�Ȳ�����0
			 */
			for (var j = 0; j < rowObj.children[i].children.length; j++) {
				var tdChild = rowObj.children[i].children[j];
				if (String(tdChild.name).indexOf(".ID") == -1) {
					/**
					 * �������Ʒ�id,��ն���ֵ.
					 */
					if (String(tdChild.tagName.toUpperCase()) == "INPUT") {
						/**
						 * ����������Ϊinput�Ķ���.
						 */
						if (String(tdChild.type).toUpperCase() == "TEXT" || String(tdChild.type).toUpperCase("HIDDEN") || String(tdChild.type).toUpperCase("TEXTAREA")) {
							/**
							 * ��ͨ�������������.
							 */
							tdChild.value = "";
						} else if (String(tdChild.type).toUpperCase() == "CHECKBOX" || String(tdChild.type).toUpperCase() == "RADIO") {
							/**
							 * ��ѡ���ѡ��.
							 */
							tdChild.checked == false;
						}
					} else if (String(tdChild.tagName.toUpperCase()) == "SELECT") {
						/**
						 * ��������ѡ���
						 */
						tdChild.value = "";
					}
				}
			}
		} else {
			rowObj.children[i].innerText = "";
		}
	}
	rowObj.style.display = "none";
}

function clearRow(rowObj){
	for (var i = 0; i < rowObj.children.length; i++) {
		if (rowObj.children[i].children.length > 0) {
			/**
			 * �����ӽ�㳤�Ȳ�����0
			 */
			for (var j = 0; j < rowObj.children[i].children.length; j++) {
				var tdChild = rowObj.children[i].children[j];
				if (String(tdChild.name).indexOf(".ID") == -1) {
					/**
					 * �������Ʒ�id,��ն���ֵ.
					 */
					if (String(tdChild.tagName.toUpperCase()) == "INPUT") {
						/**
						 * ����������Ϊinput�Ķ���.
						 */
						if (String(tdChild.type).toUpperCase() == "TEXT" || String(tdChild.type).toUpperCase("HIDDEN") || String(tdChild.type).toUpperCase("TEXTAREA")) {
							/**
							 * ��ͨ�������������.
							 */
							tdChild.value = "";
						} else if (String(tdChild.type).toUpperCase() == "CHECKBOX" || String(tdChild.type).toUpperCase() == "RADIO") {
							/**
							 * ��ѡ���ѡ��.
							 */
							tdChild.checked == false;
						}
					} else if (String(tdChild.tagName.toUpperCase()) == "SELECT") {
						/**
						 * ��������ѡ���
						 */
						tdChild.value = "";
					}
				}
			}
		} else {
			rowObj.children[i].innerText = "";
		}
	}
}