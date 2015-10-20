/******************************************************
** ��ϸ�д��������������ֶεĲ�Ϊ����֤ **
*******************************************************
** tableId: 			�ַ���	��֤�ı��ID
** rowIndex��			����		��ʼ��֤��������
** keyCellIndex��		����		��֤ʱ�ο��Ĺؼ�ֵ���ڵ�Ԫ������
** keyElementIndex��		����		�ؼ�ֵ���ڵ�Ԫ���е�λ��
** amountCellIndex��		����		����������
** amountElementIndex��	����		��������Ԫ������
*******************************************************
**Ҫ��˵����
******************************************************/
function AmountValidateInList(tableId,startRow,keyCell,keyElement,amountCell,amountElement,priceCell,priceElement) {
	var rowObj = document.getElementById(tableId).rows;
	var cellObj;
	for(var i=startRow;i<rowObj.length;i++) {
		cellObj = rowObj[i].cells;
		if(cellObj[keyCell].children[keyElement].value != ""){
			if(cellObj[amountCell].children[amountElement].value == "") {
				alert("��������Ϊ�գ�");
				cellObj[amountCell].children[amountElement].focus();
				return false;
			}
			if(cellObj[priceCell].children[priceElement].value == "") {
				//alert("�۸���Ϊ�գ�");
				//cellObj[priceCell].children[priceElement].focus();
				//return false;
				cellObj[priceCell].children[priceElement].value='0';
			}
		}
	}
	return true;	
}
/**
*	������ϸ���еĺϼ�ֵ
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
* �򵥵���ֵ��Ч����֤
*/
function NumValid(amountObj){
	if(amountObj.value!=""){
		if(isNaN(parseFloat(amountObj.value))) {
			alert("����Ĳ�����Ч����ֵ�����ݣ�");
			amountObj.value = "";
			amountObj.focus();
			return false;
		}else{
			if(parseFloat(amountObj.value)<0){
				alert("�������ֵ����С���㣡");
				amountObj.value = "";
				amountObj.focus();
				return false;
			}
		}	
	}
	return true;
}
/**
 *������ֵ���;�ȷ��
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
					//����λ��һ
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
			alert("���ݸ�ʽ��");
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