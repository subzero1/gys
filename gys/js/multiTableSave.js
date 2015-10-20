/**
 * 多表保存相关javascript函数
 *
 * @author Chiang 2009-04-14
 */
 

/**
 * 添加行信息,用于多表保存的行复制
 * @param obj
 *				行模板
 * @return obj 新插入的行对象
 */
function cloneRow(obj) {
	var newObj = obj.cloneNode(true);
	for (var i = 0; i < newObj.children.length; i++) {
		if (newObj.children[i].children.length > 0) {
			/**
			 * 列中子结点长度不等于0
			 */
			for (var j = 0; j < newObj.children[i].children.length; j++) {
				var tdChild = newObj.children[i].children[j];
				if (String(tdChild.tagName.toUpperCase()) == "INPUT") {
					/**
					 * 处理标记名称为input的对象.
					 */
					if (String(tdChild.type).toUpperCase() == "TEXT" || String(tdChild.type).toUpperCase("HIDDEN") || String(tdChild.type).toUpperCase("TEXTAREA")) {
						/**
						 * 普通输入域或隐藏域.
						 */
						tdChild.value = "";
					} else if (String(tdChild.type).toUpperCase() == "CHECKBOX" || String(tdChild.type).toUpperCase() == "RADIO") {
						/**
						 * 复选框或单选框.
						 */
						tdChild.checked == false;
					}
				} else if (String(tdChild.tagName.toUpperCase()) == "SELECT") {
					/**
					 * 处理下拉选择框
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
 * 删除行信息，id字段信息保留
 * @param rowObj
 *				需要删除的行
 */
function deleteRow(rowObj) {
	for (var i = 0; i < rowObj.children.length; i++) {
		if (rowObj.children[i].children.length > 0) {
			/**
			 * 列中子结点长度不等于0
			 */
			for (var j = 0; j < rowObj.children[i].children.length; j++) {
				var tdChild = rowObj.children[i].children[j];
				if (String(tdChild.name).indexOf(".ID") == -1) {
					/**
					 * 对象名称非id,清空对象值.
					 */
					if (String(tdChild.tagName.toUpperCase()) == "INPUT") {
						/**
						 * 处理标记名称为input的对象.
						 */
						if (String(tdChild.type).toUpperCase() == "TEXT" || String(tdChild.type).toUpperCase("HIDDEN") || String(tdChild.type).toUpperCase("TEXTAREA")) {
							/**
							 * 普通输入域或隐藏域.
							 */
							tdChild.value = "";
						} else if (String(tdChild.type).toUpperCase() == "CHECKBOX" || String(tdChild.type).toUpperCase() == "RADIO") {
							/**
							 * 复选框或单选框.
							 */
							tdChild.checked == false;
						}
					} else if (String(tdChild.tagName.toUpperCase()) == "SELECT") {
						/**
						 * 处理下拉选择框
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
			 * 列中子结点长度不等于0
			 */
			for (var j = 0; j < rowObj.children[i].children.length; j++) {
				var tdChild = rowObj.children[i].children[j];
				if (String(tdChild.name).indexOf(".ID") == -1) {
					/**
					 * 对象名称非id,清空对象值.
					 */
					if (String(tdChild.tagName.toUpperCase()) == "INPUT") {
						/**
						 * 处理标记名称为input的对象.
						 */
						if (String(tdChild.type).toUpperCase() == "TEXT" || String(tdChild.type).toUpperCase("HIDDEN") || String(tdChild.type).toUpperCase("TEXTAREA")) {
							/**
							 * 普通输入域或隐藏域.
							 */
							tdChild.value = "";
						} else if (String(tdChild.type).toUpperCase() == "CHECKBOX" || String(tdChild.type).toUpperCase() == "RADIO") {
							/**
							 * 复选框或单选框.
							 */
							tdChild.checked == false;
						}
					} else if (String(tdChild.tagName.toUpperCase()) == "SELECT") {
						/**
						 * 处理下拉选择框
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