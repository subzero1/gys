/******************************************************
** 明细中带有数量、单价字段的不为空验证 **
*******************************************************
** tableId: 			字符型	验证的表的ID
** rowIndex：			整型		开始验证的行索引
** keyCellIndex：		整型		验证时参考的关键值所在单元格索引
** keyElementIndex：		整型		关键值所在单元格中的位置
** amountCellIndex：		整型		数量列索引
** amountElementIndex：	整型		数量列中元素索引
*******************************************************
**要求说明：
******************************************************/
function AmountValidateInList(tableId,startRow,keyCell,keyElement,amountCell,amountElement,priceCell,priceElement) {
	var rowObj = document.getElementById(tableId).rows;
	var cellObj;
	for(var i=startRow;i<rowObj.length;i++) {
		cellObj = rowObj[i].cells;
		if(cellObj[keyCell].children[keyElement].value != ""){
			if(cellObj[amountCell].children[amountElement].value == "") {
				alert("数量不能为空！");
				cellObj[amountCell].children[amountElement].focus();
				return false;
			}
			if(cellObj[priceCell].children[priceElement].value == "") {
				//alert("价格不能为空！");
				//cellObj[priceCell].children[priceElement].focus();
				//return false;
				cellObj[priceCell].children[priceElement].value='0';
			}
		}
	}
	return true;	
}
/**
*	计算明细各行的合计值
*/
function calculateTotal(tableId,startRow,keyCell,keyElement,amountCell,amountElement,priceCell,priceElement,resultCell,resultElement){
	var obj_table = document.getElementById(tableId);
	var obj_rows = obj_table.rows;
	var temp_cells;
	var tempValue;
	for(var i=startRow; i<obj_rows.length; i++) {
		temp_cells = obj_rows[i].cells;
		if(temp_cells[keyCell].children[keyElement].value != "" && temp_cells[amountCell].children[amountElement].value != "" && temp_cells[priceCell].children[priceElement].value != ""){
			tempValue = new Number(temp_cells[amountCell].children[amountElement].value) * new Number(temp_cells[priceCell].children[priceElement].value);
			if(tempValue > 0) {
				temp_cells[resultCell].children[resultElement].value = setNumFormat(tempValue,2);
			}else{
				temp_cells[resultCell].children[resultElement].value='';
			}
		}else{
			temp_cells[resultCell].children[resultElement].value='';
		}
	}

}
/**
* 简单的数值有效性验证
*/
function NumValid(amountObj){
	if(amountObj.value!=""){
		if(isNaN(parseFloat(amountObj.value))) {
			alert("输入的不是有效的数值型数据！");
			amountObj.value = "";
			amountObj.focus();
			return false;
		}else{
			if(parseFloat(amountObj.value)<0){
				alert("输入的数值不能小于零！");
				amountObj.value = "";
				amountObj.focus();
				return false;
			}
		}	
	}
	return true;
}
/**
 *设置数值类型精确度
 */
function setNumFormat(numValue,numScale) {
	var tempValue = numValue.toString();
	var havedot = tempValue.indexOf("."); 
	var tempChar = tempValue;
	if(havedot !=-1 ){
		tempNum = tempValue.split(".");
		if(tempNum.length == 2) {
			if(tempNum[1].length > numScale) {
				if(numScale == 0){
					tempChar = tempNum[1].substring(0,1);
					if(new Number(tempChar) > 4) {
						tempChar = (new Number(tempNum[0]) + 1).toString();
					}else{
						tempChar = tempNum[0];
					}
				}else{
					tempChar = tempNum[1].substring(0,numScale+1);
					tempChar = tempChar.substring(tempChar.length-1,tempChar.length);
					if(new Number(tempChar) > 4) {
						var tmpSuff = new Number(tempNum[1].substring(0,numScale)) + 1;
						var tmpSuff2 = "";
						for(var k=0;k<numScale-tmpSuff.toString().length;k++){
							tmpSuff2+="0";
						}
						tmpSuff2+=tmpSuff.toString();
						tempChar = tmpSuff2;
					}else{
						tempChar = tempNum[1].substring(0,numScale);
					}
					//整数位进一
					if(tempChar.length > numScale){
						tempChar = (new Number(tempNum[0]) + 1) + "." + tempChar.substring(1,tempChar.length);
					}else{
						tempChar = tempNum[0] + "." + tempChar;
					}
				}				
			}else if(tempNum[1].length < numScale){
				tempChar = tempValue;
				for(var i=0;i<numScale-tempNum[1].length;i++)
					tempChar+="0";
			}
		}else {
			alert("数据格式错！");
			tempChar = "";
		}
	}else {
		tempChar = tempValue;
		if(numScale>0){
			tempChar+=".";
			for(var i=0;i<numScale;i++)
				tempChar+="0";
		}
	}
	
	return 	tempChar;
	
}