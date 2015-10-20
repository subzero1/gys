//定义全局变量
var fromTr;
var sourceTable;
var keyField;
//设置全局变量默认值,明细页面载入时执行
function setDefaultGv(str,stb,key) {
	if(str != null || str != "")fromTr = str;
	else fromTr = 1;
	sourceTable = opener.document.getElementById(stb);
	keyField = key;
}
/******************************************************
** 字符后缀自动加1**
*******************************************************
** str：		字符型		要拆分字符串
** separatStr：	字符型		分隔符
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
** 对象克隆，用于多表保存明细增加**
*******************************************************
** obj：		对象		要克隆的对象
** separatStr：	字符型		分隔符（用于标记id属性拆分）
******************************************************/
function cloneObject(obj,separatStr,tblHead) {
	var newRowlength=obj.parentNode.rows.length-(tblHead-1);
	var newObj = obj.cloneNode(true);
	if(newObj.id != null && newObj.id != ""){
		newObj.id = postfixCounter(newObj.id,separatStr);
	}
	newObj.style.display = "block";
	
	//插入当前克隆对象
	obj.parentNode.insertAdjacentElement("beforeEnd",newObj);
	
	//判断当前对象标记
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
** 从明细选项窗口置选择项到主窗口对应行**
*******************************************************
** trObj:			对象		事件发生行对象
** curTr：			整型		当前事件发生所在行位置
** parentId			字符型		输入域明细所属父标记的ID属性值
** vartr：			整型		时间发生所在行位置，用于返回
** separatStr：		字符型		分隔符
** ifControlSelect	布尔型		是否控制选择
** limitValue		字符型		控制选择的值
*******************************************************
**要求说明：所有选项值存放在指定对象下包含的隐藏域中
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
		//循环设置父窗口选中行的单元格内容
		
		//------------------------------------------------------
		//方法一:
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
		//方法二:
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
** 回车打开明细选项窗口**
*******************************************************
** obj：			对象		事件发生的td
** itemUrl：		字符型	打开明细选项的url地址
** w：			整型		打开的窗口宽度
** h：			整型		打开的窗口高度
** s：			整型		是否有滚动条
*******************************************************
** 要求说明，给每个需要设置明细数据的标记都设置name属性,
			 用于<td>设置innerText,<input>设置value
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
**隐藏有明细的当前行,清除没有明细的各域值，执行明细删除
*******************************************************
** rowObj：			对象		事件发生行对象
******************************************************/
function clearCurItem(rowObj,cellIndex,elementIndex) {
	var cellObj = rowObj.cells;
	if(document.form1.limitInput){
		var ttt = document.form1.limitInput.value;
		var keyValue = cellObj[cellIndex].children[elementIndex].value;
		if(ttt.indexOf(keyValue)!=-1){
			if(ttt.split('|').length==1){
				document.form1.limitInput.value = ttt.replace(keyValue,'');
				//alert('仅剩一个直接替换空['+document.form1.limitInput.value+']');
			}else{
				if(ttt.indexOf(keyValue)==0){
					document.form1.limitInput.value = ttt.replace(keyValue+'|','');
					//alert('在开头位置['+document.form1.limitInput.value+']');
				}else{
					document.form1.limitInput.value = ttt.replace('|'+keyValue,'');
					//alert('在其它位置['+document.form1.limitInput.value+']');
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
** 设置对象值置空**
*******************************************************
** obj：		对象		要克隆的对象
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
** 增加明细列表**
*******************************************************
** tableId：		字符型		明细表<table>标记的id属性值
*******************************************************
**要求说明：
******************************************************/
function addList(tableId,tblHead) {
	var cloneObj = document.getElementById(tableId).rows;
	if(cloneObj)
	cloneObject(cloneObj[cloneObj.length-1],'|',tblHead);
}
/******************************************************
** 初始化页面，对明细中不能重复录入隐藏域初始化**
*******************************************************
** fieldName: 		字符型		明细字段名称
*******************************************************
**要求说明：
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
** 限制已经存在的明细录入**
*******************************************************
** obj：			对象		一般指opener
** fieldValue: 		字符型		明细字段值
*******************************************************
**要求说明：每个页面包含隐藏域limitInput
******************************************************/
function setLimitInput(obj,fieldValue) {
	//判断是否已经录入
	var ifExit = false;
	var tempValue = obj.form1.limitInput.value.split("|");
	for(var k=0;k<tempValue.length;k++) {
		if(tempValue[k] == fieldValue){
			alert("已经选过此项不能重复选择！");
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
** 更新limitValue的值保持最新 **
*******************************************************
** obj：				对象		一般指opener
** fieldValue: 		字符型	明细字段值
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