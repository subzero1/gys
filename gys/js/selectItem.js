//����ȫ�ֱ���
var fromTr;
var sourceTable;
var keyField;
//����ȫ�ֱ���Ĭ��ֵ,��ϸҳ������ʱִ��
function setDefaultGv(str,stb,key) {
	if(str != null || str != "")fromTr = str;
	else fromTr = 1;
	sourceTable = opener.document.getElementById(stb);
	keyField = key;
}
/******************************************************
** �ַ���׺�Զ���1**
*******************************************************
** str��		�ַ���		Ҫ����ַ���
** separatStr��	�ַ���		�ָ���
******************************************************/
function postfixCounter(str,separatStr) {
	var temp_str = str.split(separatStr);
	var postfix = "";
	var prefix = "";
	var targetStr;
	if(temp_str.length == 0) {
		targetStr = str;
	}else {
		for (var i=0;i<temp_str.length-1;i++) {
			prefix = prefix + temp_str[i];
		}
		postfix = String(new Number(temp_str[temp_str.length-1]) + 1);
		targetStr = prefix + separatStr + postfix;
	}
	return targetStr;
}
/******************************************************
** �����¡�����ڶ������ϸ����**
*******************************************************
** obj��		����		Ҫ��¡�Ķ���
** separatStr��	�ַ���		�ָ��������ڱ��id���Բ�֣�
******************************************************/
function cloneObject(obj,separatStr,tblHead) {
	var newRowlength=obj.parentNode.rows.length-(tblHead-1);
	var newObj = obj.cloneNode(true);
	if(newObj.id != null && newObj.id != ""){
		newObj.id = postfixCounter(newObj.id,separatStr);
	}
	newObj.style.display = "block";
	
	//���뵱ǰ��¡����
	obj.parentNode.insertAdjacentElement("beforeEnd",newObj);
	
	//�жϵ�ǰ������
	var obj_rows;
	var obj_cells;
	var obj_children;
	var obj_tagname = newObj.tagName.toUpperCase();
	switch (obj_tagname) {
		case "TABLE":
			obj_rows = newObj.rows;
			for(var i=0;i<obj_rows.length;i++) {
				
				if(obj_row[i].id != null && obj_row[i].id != "") {
					obj_row[i].id = postfixCounter(obj_row[i].id,separatStr);
				}
				 
				obj_cells = obj_rows[i].cells;
				for (var j=0;j<obj_cells.length;j++) {
					
					if(obj_cells[j].id != null && obj_cells[j].id != ""){
						obj_cells[j].id = postfixCounter(obj_cells[j].id,separatStr);
					}
					
					obj_children = obj_cells[j].children;
					if(obj_children.length == 0) {
						obj_cells[j].innerText = "";
					}else {
						for (var m=0;m<obj_children.length;m++) {
							obj_children[m].value = "";
						}
					}
				}
				if(obj_cells[0].children.length == 0)
					obj_cells[0].innerText = newRowlength;
				else
					obj_cells[0].children[0].value=newRowlength;
			}
			 break;
		case "TR":
			obj_cells = newObj.cells;
			for (var j=0;j<obj_cells.length;j++) {
				if(obj_cells[j].id != null && obj_cells[j].id != ""){
					obj_cells[j].id = postfixCounter(obj_cells[j].id,separatStr);
				}
				
				obj_children = obj_cells[j].children;
				if(obj_children.length == 0) {
					obj_cells[j].innerText = "";
				}else {
					for (var m=0;m<obj_children.length;m++) {
						obj_children[m].value = "";
					}
				}
			}
			if(obj_cells[0].children.length == 0)
				obj_cells[0].innerText = newRowlength;
			else
				obj_cells[0].children[0].value=newRowlength;
			break;
		default:
			obj_children = newObj.children;
			if(obj_children.length == 0) {
				newObj.innerText = "";
			}else {
				for (var m=0;m<obj_children.length;m++) {
					obj_children[m].value = "";
				}
			}
	}
}
/******************************************************
** ����ϸѡ�����ѡ��������ڶ�Ӧ��**
*******************************************************
** trObj:			����		�¼������ж���
** curTr��			����		��ǰ�¼�����������λ��
** parentId			�ַ���		��������ϸ��������ǵ�ID����ֵ
** vartr��			����		ʱ�䷢��������λ�ã����ڷ���
** separatStr��		�ַ���		�ָ���
** ifControlSelect	������		�Ƿ����ѡ��
** limitValue		�ַ���		����ѡ���ֵ
*******************************************************
**Ҫ��˵��������ѡ��ֵ�����ָ�������°�������������
******************************************************/
function selectItem(trObj,parentId,separatStr,ifControlSelect,limitValue,tblHead) {
	if(ifControlSelect) {
		if(setLimitInput(opener,limitValue) == false) {
			return;
		}
	}
	var j = fromTr;

	if(sourceTable.rows.length <= j) {
		opener.cloneObject(sourceTable.rows[sourceTable.rows.length - 1],separatStr,tblHead);
	}

	//sourceTable.rows[j-1].cells[0].style.backgroundColor = "";
	//sourceTable.rows[j].cells[0].style.backgroundColor = "red";
	
	var parentObj = document.getElementById(parentId);
	var openerRow = sourceTable.rows[j];
	var openerChild;
	var sname,tname,tObject;

	for(var k=0;k<parentObj.children.length;k++) {
		//ѭ�����ø�����ѡ���еĵ�Ԫ������
		
		//------------------------------------------------------
		//����һ:
		//------------------------------------------------------
		for(var m=0;m<openerRow.cells.length;m++) {
			sname = parentObj.children[k].name.toUpperCase()+ separatStr + String(j);
			tname = openerRow.cells[m].id.toUpperCase();
			if(sname == tname){
				openerRow.cells[m].innerText = parentObj.children[k].value;	
			}else {
				sname = parentObj.children[k].name.toUpperCase();
				openerChild = openerRow.cells[m].children;
				for(var n=0;n<openerChild.length;n++) {
					tname = openerChild[n].name.toUpperCase();
					if(sname == tname)
					openerChild[n].value = parentObj.children[k].value;	
				}
			}
		}
		/*
		
		//------------------------------------------------------
		//������:
		//------------------------------------------------------
		
		sname = parentObj.children[k].name.toUpperCase();
		tObject = opener.document.getElementById(sname + separatStr + String(j));
		if(tObject) {
			tObject.innerText = parentObj.children[k].value;
		}else {
			tObject = opener.document.getElementsByName(sname);
			//alert(sname + ":" + tObject.length);
			if(tObject[j-1]) {
				tObject[j-1].value = parentObj.children[k].value;
			}
		}*/
		//------------------------------------------------------
	}
	
	//initLimitValue(opener,keyField);
	fromTr++;
	document.getElementById("fromTr").value = fromTr;
	//trObj.style.display = "none";
}
/******************************************************
** �س�����ϸѡ���**
*******************************************************
** obj��			����		�¼�������td
** itemUrl��		�ַ���	����ϸѡ���url��ַ
** w��			����		�򿪵Ĵ��ڿ��
** h��			����		�򿪵Ĵ��ڸ߶�
** s��			����		�Ƿ��й�����
*******************************************************
** Ҫ��˵������ÿ����Ҫ������ϸ���ݵı�Ƕ�����name����,
			 ����<td>����innerText,<input>����value
******************************************************/
function openSelectWin(obj,tableId,url,w,h,s) {
		var tempUrl;
		var currRowIndex = obj.parentNode.rowIndex;
		var cur_table = document.getElementById(tableId);
		var temptrObj = obj.parentNode;
		if(cur_table.rows[currRowIndex] != temptrObj) {
			for(var tempi=currRowIndex;tempi<cur_table.rows.length;tempi++) {
				if(cur_table.rows[tempi] == temptrObj) {
					currRowIndex = tempi;
					break;
				}
			}
		}
		
		if(url.indexOf("?") == -1) tempUrl = url + "?stable=" + tableId + "&fromTr=" + currRowIndex+"&keyField="+keyField;
		else tempUrl = url + "&stable=" + tableId + "&fromTr=" + currRowIndex+"&keyField="+keyField;
	
		pop = window.open(tempUrl,"listWin","width=" + w + " height=" + h + " scrollbars="+ s + " status=yes");
		pop.moveTo((screen.width-w)/2,(screen.height-h)/2);
}
/*****************************************************
**��������ϸ�ĵ�ǰ��,���û����ϸ�ĸ���ֵ��ִ����ϸɾ��
*******************************************************
** rowObj��			����		�¼������ж���
******************************************************/
function clearCurItem(rowObj,cellIndex,elementIndex) {
	var cellObj = rowObj.cells;
	if(document.form1.limitInput){
		var ttt = document.form1.limitInput.value;
		var keyValue = cellObj[cellIndex].children[elementIndex].value;
		if(ttt.indexOf(keyValue)!=-1){
			if(ttt.split('|').length==1){
				document.form1.limitInput.value = ttt.replace(keyValue,'');
				//alert('��ʣһ��ֱ���滻��['+document.form1.limitInput.value+']');
			}else{
				if(ttt.indexOf(keyValue)==0){
					document.form1.limitInput.value = ttt.replace(keyValue+'|','');
					//alert('�ڿ�ͷλ��['+document.form1.limitInput.value+']');
				}else{
					document.form1.limitInput.value = ttt.replace('|'+keyValue,'');
					//alert('������λ��['+document.form1.limitInput.value+']');
				}
			}
		}
	}
	for(var i=0;i<cellObj.length;i++) {
		if(cellObj[i].children.length == 0) {
			cellObj[i].innerText = "";
		}else {
			for(var j=0;j<cellObj[i].children.length;j++) {
				var cl = cellObj[i].children[j];
				if(cl.name.indexOf(".ID")==-1)
					setObjNullValue(cellObj[i].children[j]);
			}
		}
	}
	rowObj.style.display = "none";
}
/******************************************************
** ���ö���ֵ�ÿ�**
*******************************************************
** obj��		����		Ҫ��¡�Ķ���
******************************************************/
function setObjNullValue(obj){
	if(obj.type == "text" || obj.type == "textarea" || obj.type == "hidden"){
		obj.value = "";
	}else if(obj.type == "select-one"){
		for(var m=0; m<obj.options.length; m++){
			if(obj.options[m].value == "")
				obj.options[m].selected = true;
		}
	}else if(obj.type == "radio"){
		if(obj.checked)obj.checked = false;
	}else if(obj.type == "checkbox"){
		if(obj.checked)obj.checked = false;
	}
}
/******************************************************
** ������ϸ�б�**
*******************************************************
** tableId��		�ַ���		��ϸ��<table>��ǵ�id����ֵ
*******************************************************
**Ҫ��˵����
******************************************************/
function addList(tableId,tblHead) {
	var cloneObj = document.getElementById(tableId).rows;
	if(cloneObj)
	cloneObject(cloneObj[cloneObj.length-1],'|',tblHead);
}
/******************************************************
** ��ʼ��ҳ�棬����ϸ�в����ظ�¼���������ʼ��**
*******************************************************
** fieldName: 		�ַ���		��ϸ�ֶ�����
*******************************************************
**Ҫ��˵����
******************************************************/
function initializeWeb(fieldName) {
	keyField = fieldName;
	var limitObjectNames = document.getElementsByName(fieldName);
	for(var i=0;i<limitObjectNames.length;i++) {
		if(limitObjectNames[i].value != null && limitObjectNames[i].value != "")
		var result = setLimitInput(document,limitObjectNames[i].value);
	}
}
/******************************************************
** �����Ѿ����ڵ���ϸ¼��**
*******************************************************
** obj��			����		һ��ָopener
** fieldValue: 		�ַ���		��ϸ�ֶ�ֵ
*******************************************************
**Ҫ��˵����ÿ��ҳ�����������limitInput
******************************************************/
function setLimitInput(obj,fieldValue) {
	//�ж��Ƿ��Ѿ�¼��
	var ifExit = false;
	var tempValue = obj.form1.limitInput.value.split("|");
	for(var k=0;k<tempValue.length;k++) {
		if(tempValue[k] == fieldValue){
			alert("�Ѿ�ѡ��������ظ�ѡ��");
			ifExit = true;
			break;
		}
	}
	if(ifExit)	return false;
	else{
		if(obj.form1.limitInput.value == null || obj.form1.limitInput.value == "")
			obj.form1.limitInput.value = fieldValue;
		else
			obj.form1.limitInput.value = obj.form1.limitInput.value + "|" + fieldValue;
		return true;
	}
}
/******************************************************
** ����limitValue��ֵ�������� **
*******************************************************
** obj��				����		һ��ָopener
** fieldValue: 		�ַ���	��ϸ�ֶ�ֵ
*******************************************************
******************************************************/
function initLimitValue(obj,keyFieldName){
	if(keyFieldName!=null||keyFieldName!=""){
		var temp = obj.form1.limitInput.value.split("|");
		var limitObjectNames = obj.document.getElementsByName(keyFieldName);
		for(var k=0;k<temp.length;k++) {
			var i=0;
			for(;i<limitObjectNames.length;i++) {
				if(temp[k]==limitObjectNames[i].value)
					break;
			}
			if(i==limitObjectNames.length){
				if(temp.length==1){
					obj.form1.limitInput.value = '';
				}else{
					if(obj.form1.limitInput.value.indexOf(temp[k])==0)
						obj.form1.limitInput.value = obj.form1.limitInput.value.replace(temp[k]+'|','');
					else
						obj.form1.limitInput.value = obj.form1.limitInput.value.replace('|'+temp[k],'');
				}
			}
		}
	}
}