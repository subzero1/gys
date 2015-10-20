/*****************************************************************
/*����:�����������ڼ��������
******************************************************************/
function DateDiff(sDate1,sDate2){
	var aDate, oDate1, oDate2, iDays   
	 aDate = sDate1.split("-")   
	oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0])  //ת��Ϊ��-��-���ʽ
	aDate = sDate2.split("-")   
	oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]) 
	
	iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 /24)  //�����ĺ�����ת��Ϊ����   
	return iDays;
	
	} 
/*****************************************************************
/*����:��֤�����ַ����Ƿ����YYYY-MM-DD��ʽ
******************************************************************/
function isDate(dt){
	//�����ж�YYYY-MM-DD ��ʽ
//	var l1 = dt.indexOf("-");
//	var l2 = dt.lastIndexOf("-");

	var dtarray = dt.split("-");
	if(dtarray.length == 1){
		dtarray = dt.split("-");
	}
	if(dtarray.length < 3){
		return false;
	}
	
	var year = dtarray[0];
	var month = format89(dtarray[1]);
	var day = format89(dtarray[2]);

//	var year = parseInt(dt.substring(0,l1));
//	var month = parseInt(dt.substring(l1+1,l2));
//	var day = parseInt(dt.substring(l2+1,dt.length));
	
	if(isNaN(year) || isNaN(month) || isNaN(day)){
		return false;
	}
        if(year==0|month==0|day==0){
                return false;
        }
	if(year > 2100 || year < 1900){
		return false;
	}
	if(month < 1 || month > 12){
		return false;
	}
	if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12){
		if(day > 31){
			return false;
		}
	}
	if(month == 4 || month == 6 || month == 9 || month == 11){
		if(day > 30){
			return false;
		}
	}
	///�ж���û������
	if(month == 2){
		if(year % 100 == 0 && year % 400 == 0){
			if(day > 29){
				return false;
			}
		}else{
			if(year % 100 !=0 && year % 4 == 0){
				if(day > 29){
					return false;
				}
			}else{
				if(day > 28){
					return false;
				}
			}
		}

	}

	return true;
}

//////////////////////////////////////////////////////////////////////////////////////
//��ʽ��08,09��parseInt����0������
//////////////////////////////////////////////////////////////////////////////////////
function format89(arg){
	if(arg == "08"){
		return "8";
	}
	if(arg == "09"){
		return "9";
	}
	return arg;
}

/*****************************************************************
/*����:��֤�����ַ����Ƿ����YYYY-MM-DD HH:MM��ʽ
******************************************************************/


function isDateTime(dt){
	
	var kg = dt.indexOf(" ");
	var mh = dt.indexOf(":");
	var da = dt.substring(0,kg);
	if(da == ""){
		return false;
	}
	//�����ж�YYYY-MM-DD ��ʽ
	var l1 = da.indexOf("-");
	var l2 = da.lastIndexOf("-");

	var year = parseInt(da.substring(0,l1));
	var month = parseInt(da.substring(l1+1,l2));
	var day = parseInt(da.substring(l2+1,da.length));
	var hour = parseInt(dt.substring(kg+1,mh));
	var minute = parseInt(dt.substring(mh+1,dt.length));
	if(isNaN(year) || isNaN(month) || isNaN(day) || isNaN(hour) || isNaN(minute)){
		return false;
	}
	if(year > 2100 || year < 1900){
		return false;
	}
	if(month < 1 || month > 12){
		return false;
	}
	if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12){
		if(day > 31){
			return false;
		}
	}
	if(month == 4 || month == 6 || month == 9 || month == 11){
		if(day > 30){
			return false;
		}
	}
	///�ж���û������
	if(month == 2){
		if(year % 100 == 0 && year % 400 == 0){
			if(day > 29){
				return false;
			}
		}else{
			if(year % 100 !=0 && year % 4 == 0){
				if(day > 29){
					return false;
				}
			}else{
				if(day > 28){
					return false;
				}
			}
		}
	}
	if(hour >= 24){
		return false;
	}
	if(minute >= 60){
		return false;
	}
return true;
}

//***********************************
//����:�����ַ�����,�����ַ���2���ַ�
//***********************************
function strlen(inputStr){
	var len=0;
	var currentStr;
	currentStr = new String(inputStr);

	for(var i=0;i<currentStr.length;i++){
		
		if (currentStr.charCodeAt(i)>255 ||currentStr.charCodeAt(i)<0) 
			len=len+2;
		else 
			len=len+1;
	}
	return len;
} 

/************************************************
** ����:�ж�NUMBER(12,2)��ֵ����
*************************************************
** inputNum			�ַ���			¼�����ֵ
** precision		����			����
** decimalDigits	����			С��λ��
*************************************************/
function isStandNum(inputNum,precision,decimalDigits) {
	var strdot = /\./i;
	var dot = inputNum.search(strdot); 
	
	if(dot==-1){	//û��С����
		if(inputNum.length>precision) {
			return false;
		}
	}else{			//��С����
		var leftStr;
		var rightStr;
		var currentNum;
		currentNum = inputNum.split(".");
		leftStr = currentNum[0];
		rightStr = currentNum[1]
		if(leftStr.length>precision || rightStr.length>decimalDigits) {
			return false;
		}
	}
	return true;
}

/*****************************************************************
/*����:����Сд�Զ�ת��д
******************************************************************/
function toUpperCase(obj){

	if(obj == null){
			return;
	}
	var bb = obj.value.toUpperCase();
	obj.value = bb;
}


/*****************************************************************
/*����:���´���
******************************************************************/
function winOpen(URL,winW,winH,winScroll) {
	var temp_pop = window.open(URL,"","width="+winW+" height="+winH+" scrollbars="+winScroll + " status=yes");
	temp_pop.moveTo((screen.width-winW)/2,(screen.height-winH)/2);
	temp_pop.focus();
}

function newOpen(URL, name,winW,winH,winScroll) {
	var temp_pop1 = window.open(URL,name,"width="+winW+" height="+winH+" scrollbars="+winScroll);
	temp_pop1.moveTo((screen.width-winW)/2,(screen.height-winH)/2);
	temp_pop1.focus();
}

/*****************************************************************
/*����:����������
******************************************************************/
function allwinOpen(URL) {
	var arg = "width=" + new String(screen.width - 10) + ",height=" + new String(screen.height - 80) + ",scrollbars=1,menubar=0,status=yes,resize=1";
	var allpop = window.open(URL,"_blank",arg);
	allpop.moveTo(0,0);
	allpop.focus();
}
/*****************************************************************
/*����:iframe����Ӧ����ص���ҳ
******************************************************************/
function iframeAutoFit()
{
 if(window!=parent)
 {
  var a = parent.document.getElementsByTagName("IFRAME");
    for(var i=0; i<a.length; i++)
    {
       if(a[i].contentWindow==window)
       {
           var h = document.body.scrollHeight;
           var sh = a[i].height;
           if(h>sh){
	           if(document.all) {h += 4;}
	           if(window.opera) {h += 1;}
	           a[i].style.height = h;
           }
       }
    }
 }
}
/*****************************************************************
/*����:����ʾ�رմ���
******************************************************************/
function closeWin() {
	var ua=navigator.userAgent
	var ie=navigator.appName=="Microsoft Internet Explorer"?true:false
	if(ie){
	    var IEversion=parseFloat(ua.substring(ua.indexOf("MSIE ")+5,ua.indexOf(";",ua.indexOf("MSIE "))))
	 if(IEversion< 5.5){
	    var str  = '<object id=noTipClose classid="clsid:ADB880A6-D8FF-11CF-9377-00AA003B7A11">'
	    str += '<param name="Command" value="Close"></object>';
	    document.body.insertAdjacentHTML("beforeEnd", str);
	    document.all.noTipClose.Click();
	    }
	    else{
	    window.opener =null;
	    window.close();
	    }
	}
	else{
		window.close()
	}
}


/***************************************************************
*������ύ��ʱ�ж��������Ƿ����Ҫ��
*��ʽ:   ��ʾ�������� :������:�ֶ�����:����:�Ƿ��Ϊ��
****************************************************************/
function validateChk(formName){
	var validate;
	var formObj = eval(formName);
	if(formObj) {
		if(formObj.VALIDATE)validate = formObj.VALIDATE.value;
		else	validate = formObj.validate.value;
	}else {
		formObj = eval("document[\'"+formName+"\']");
		if(formObj) {
			validate = formObj.validate.value;
		}else {
			alert("û�ҵ�������!");
			return false;	
		}
	}
	var fieldName , fieldType , fieldLen , fieldEmpty , fieldCname;	
	var fieldVar,fieldElements;
	var i=0;
	var theObj;
	var fieldNum;
	
	fieldVar = validate.split(";");
	if(fieldVar[fieldVar.length-1] == null || fieldVar[fieldVar.length-1] == "")
		fieldNum = fieldVar.length-1;
	else
		fieldNum = fieldVar.length;
	
	for(i=0;i<fieldNum;i++) {
		fieldElements = fieldVar[i].split(":");
		if(fieldElements.length==5) {
			//����ֶ���ϢԪ��
			fieldCname = fieldElements[0];
			fieldName= fieldElements[1];
			fieldType= fieldElements[2].toUpperCase();
			fieldLen= fieldElements[3];
			fieldEmpty = fieldElements[4];
			
			var theObj = document.getElementsByName(fieldName);
			if(theObj){
				for(var j=0;j<theObj.length;j++) {
					if(((theObj[j].type == "text" || theObj[j].type == "textarea") && theObj[j].readOnly == false) || ((theObj[j].type == "select-one" || theObj[j].type == "radio" || theObj[j].type == "checkbox") && theObj[j].disabled == false)){
						if(theObj[j].type != "textarea" && fieldType != "DATETIME")
						theObj[j].value = theObj[j].value.replace(/\s/g,"");
						
						//�ж��Ƿ�Ϊ��
						if((theObj[j].value == "" || theObj[j].value == null ) && (fieldEmpty == "N" || fieldEmpty == "0")) {
							if(theObj[j].type == "text" || theObj[j].type == "textarea")
								alert(fieldCname + "  ������Ϊ��!");
							else 
								alert("��ѡ��" + fieldCname + "!");
							theObj[j].focus();
							return false;
						}				
						//�ж��ֶ����ͼ�����
						if(theObj[j].value != "" && (fieldType == "CHAR" || fieldType == "VARCHAR2")) {
							if(strlen(theObj[j].value) > fieldLen) {
								alert(fieldCname + "̫��!");
								theObj[j].focus();
								return false;
							}
						}else if(fieldType == "NUMBER") {
							if (theObj[j].value != "" && isNaN(parseFloat(theObj[j].value))) {
								alert(fieldCname + "  ������Ч����ֵ������!");
								theObj[j].focus();
								return false;
							}
							var number_str = fieldLen.split(".");
							var number_len = 12;
							var number_sp = 2;
							if(number_str.length == 2 && Number(number_str[1])>0){
								number_len = number_str[0];
								number_sp = number_str[1];
							}
							if(!isStandNum(theObj[j].value,number_len,number_sp)){
								alert(fieldCname + "  ������NUMBER(" + number_len + "," + number_sp + ")��ʽ������������!");
								theObj[j].focus();
								return false;
							}
						}else if(theObj[j].value != "" && fieldType == "DATE" && (!isDate(theObj[j].value))) {
							alert(fieldCname + "  ������Ч������(YYYY-MM-DD �� YYYY/MM/DD)��ʽ!");
							theObj[j].focus();
							return false;
						}else if(theObj[j].value != "" && fieldType == "DATETIME" && (!isDateTime(theObj[j].value))) {
							alert(fieldCname + "  ������Ч��ʱ��(YYYY-MM-DD HH:MM �� YYYY/MM/DD HH:MM)��ʽ!");
							theObj[j].focus();
							return false;
						}
					}
				}	
			}//end if(theObj)
		}else {
			if(validate!=""){
				alert("���ô���!");
				return false;
			}	
		}	
	}	//end for
	return true;	
}

/***************************************************************
*������ύ����ϸʱ�ж��������Ƿ����Ҫ��
*��ʽ:   ��ʾ�������� :������:�ֶ�����:����:�Ƿ��Ϊ��
****************************************************************/
function listValidateChk(formName,keyFieldName){
	var validate;
	var formObj = eval(formName);
	if(formObj) {
		if(formObj.LIST_VALIDATE)validate = formObj.LIST_VALIDATE.value;
		else	validate = formObj.list_validate.value;
	}else {
		formObj = eval("document[\'"+formName+"\']");
		if(formObj) {
		alert("99"+formObj);
			validate = formObj.list_validate.value;
		}else {
			alert("û�ҵ�������!");
			return false;	
		}
	}
	var keyField = document.getElementsByName(keyFieldName);
	
	var fieldName , fieldType , fieldLen , fieldEmpty , fieldCname;	
	var fieldVar,fieldElements;
	var i=0;
	var theObj;
	var fieldNum;
	
	fieldVar = validate.split(";");
	if(fieldVar[fieldVar.length-1] == null || fieldVar[fieldVar.length-1] == "")
		fieldNum = fieldVar.length-1;
	else
		fieldNum = fieldVar.length;
	
	for(i=0;i<fieldNum;i++) {
		fieldElements = fieldVar[i].split(":");
		if(fieldElements.length==5) {
			//����ֶ���ϢԪ��
			fieldCname = fieldElements[0];
			fieldName= fieldElements[1];
			fieldType= fieldElements[2].toUpperCase();
			fieldLen= fieldElements[3];
			fieldEmpty = fieldElements[4];
			
			var theObj = document.getElementsByName(fieldName);
			if(theObj){
				for(var j=0;j<theObj.length;j++) {
					if(keyField[j].value != ""){
						if(((theObj[j].type == "text" || theObj[j].type == "password" || theObj[j].type == "textarea") && theObj[j].readOnly == false) || ((theObj[j].type == "select-one" || theObj[j].type == "radio" || theObj[j].type == "checkbox") && theObj[j].disabled == false)){
							if(theObj[j].type != "textarea" && fieldType != "DATETIME")
							theObj[j].value = theObj[j].value.replace(/\s/g,"");
							
							//�ж��Ƿ�Ϊ��
							if((theObj[j].value == "" || theObj[j].value == null ) && (fieldEmpty == "N" || fieldEmpty == "0")) {
								if(theObj[j].type == "text" || theObj[j].type == "textarea"|| theObj[j].type == "password")
									alert(fieldCname + "  ������Ϊ��!");
								else 
									alert("��ѡ��" + fieldCname + "!");
								theObj[j].focus();
								return false;
							}				
							//�ж��ֶ����ͼ�����
							if(theObj[j].value != "" && (fieldType == "CHAR" || fieldType == "VARCHAR" || fieldType == "VARCHAR2")) {
								if(strlen(theObj[j].value) > fieldLen) {
									alert(fieldCname + "̫��!");
									theObj[j].focus();
									return false;
								}
							}else if(fieldType == "NUMBER") {
								if (theObj[j].value != "" && isNaN(parseFloat(theObj[j].value))) {
									alert(fieldCname + "  ������Ч����ֵ������!");
									theObj[j].focus();
									return false;
								}
								var number_str = fieldLen.split(".");
								var number_len = 12;
								var number_sp = 2;
								if(number_str.length == 2 && Number(number_str[1])>0){
									number_len = number_str[0];
									number_sp = number_str[1];
								}
								if(!isStandNum(theObj[j].value,number_len,number_sp)){
									alert(fieldCname + "  ������NUMBER(" + number_len + "," + number_sp + ")��ʽ������������!");
									theObj[j].focus();
									return false;
								}
							}else if(theObj[j].value != "" && fieldType == "DATE" && (!isDate(theObj[j].value))) {
								alert(fieldCname + "  ������Ч������(YYYY-MM-DD �� YYYY/MM/DD)��ʽ!");
								theObj[j].focus();
								return false;
							}else if(theObj[j].value != "" && fieldType == "DATETIME" && (!isDateTime(theObj[j].value))) {
								alert(fieldCname + "  ������Ч��ʱ��(YYYY-MM-DD HH:MM �� YYYY/MM/DD HH:MM)��ʽ!");
								theObj[j].focus();
								return false;
							}
						}
					}
				}	
			}//end if(theObj)
		}else {
			if(validate!=""){
				alert("���ô���!");
				return false;
			}	
		}	
	}	//end for
	return true;	
}

/***************************************************************
*                           ��ҳ����
****************************************************************/
/*
 * ��һҳ
 */
function pageDown(obj){
  if(Number(obj.document.all.CurrentPage.value) < Number(obj.document.all.TotalOfPages.value))
  	obj.document.all.CurrentPage.value = Number(obj.document.all.CurrentPage.value) + 1;
  obj.submit();
}
/*
 * ��һҳ
 */
function pageUp(obj){
  if(Number(obj.document.all.CurrentPage.value) > 1)
  	obj.document.all.CurrentPage.value = Number(obj.document.all.CurrentPage.value) - 1;
  obj.submit();
}
function setPage() {
	var allPage = new Number(document.all.form1.TotalOfPages.value);
	var select_page = new Number(document.all.form1.selectPage.value);
	if( select_page < 1 || select_page > allPage ){
		alert("û��ָ����ҳ�����磨1-" + allPage + "��");	
	}else {
		document.all.form1.CurrentPage.value = select_page;
		document.all.form1.submit();
	}
}
/*
 * ��ҳ������ӵ�ַ�����ص�ַ�ַ���
 */
function checkLink(cstr) {
	var locStr="";
	var dot = "";
	if(cstr.indexOf("?") != -1){
		 str1 = cstr.indexOf("PageAction=PageDown");
	  	 str2 = cstr.indexOf("PageAction=PageUp");
	  	 if(str1 != -1) {
	  	 	locStr = cstr.substring(0,str1-1);
	  	 	dot = cstr.substring(str1-1,str1);
	  	 	if(dot == "&") 	return locStr + "&";
	  		else 			return locStr + "?";
	  	 }else if(str2 != -1) {
	  	 	locStr = cstr.substring(0,str2-1);
	  	 	dot = cstr.substring(str2-1,str2);
	  	 	if(dot == "&") 	return locStr + "&";
	  		else 			return locStr + "?";
	  	 }else {
	  	 	return cstr + "&";
	  	 }	
  	}else {
  		return cstr + "?";
    }
}
/**
 *������
 */
function save(formName,saveType){
	var validate;
	var formObj = eval(formName);
	var tempAction="/gypms/data_writer";
	
	if(saveType != null && saveType == 2) tempAction = "/gypms/data_writer2";
	
	if(formObj) {
		if(validateChk(formName)) { 
			formObj.action = tempAction;
		    formObj.submit();
	    }
	}else {
		formObj = eval("document.all."+formName);
		if(formObj) {
			if(validateChk(formName)) {  	
			    formObj.action = tempAction;
			    formObj.submit();
		    }
		}else {
			alert("û���ҵ�Ҫ����ı�����!");	
		}
	}
}

/*
 * ɾ��
 */
function del(obj){
	if(obj) {
	  var tempObj = document.getElementsByName("ID");
	  var validateDel = 0;
	  for(i=0;i<tempObj.length;i++) {
	  	if(tempObj[i].tagName == "checkbox"){
	  		if(tempObj[i].checked) {
		  		validateDel = 1;
		  		break;
		  	}
	  	}else{
	  		validateDel = 1;
		  	break;
	  	}	  	
	  }
	  if (validateDel == 1) {
		  var cf = confirm("ȷ��ɾ����?");
		  if(cf) {
			  obj.action = "/gypms/data_deleter";
			  obj.submit();
			}
		}else {
			alert("û���ҵ�ɾ������!");
			return;	
		}
	}else {
		alert("û���ҵ�ɾ������!");	
		return;
	}
}
/***************************************************************/

/*
 *��ģ̬�Ի���
 */
function openDialog(WINurl,WINwidth,WINheight,xyPosition)
{
 if(xyPosition==0)//��Ļ����
   {
    showx = (window.screen.availWidth  - WINwidth)/2;
    showy = (window.screen.availHeight - WINheight)/2;
   }
 else//�¼�����
   {
     showx = event.screenX; // + deltaX;
     showy = event.screenY - event.offsetY + 18; // + deltaY;
    }
  newWINwidth = WINwidth + 4 + 18;
  var features =
    'dialogWidth:'  + newWINwidth  + 'px;' +
    'dialogHeight:' + WINheight + 'px;' +
    'dialogLeft:'   + showx     + 'px;' +
    'dialogTop:'    + showy     + 'px;' +
    'directories:no; localtion:no; menubar=no; status=no; toolbar:no;scrollbars=yes;Resizeable=no'+
    '';
  var vDialog = window.showModalDialog(WINurl, " ", features);
  return vDialog;
}

/**
 * ѡ������
 * @param obj ��Ҫ�õ����ڵĶ���
 * @param sChar  ���ڼ����
 */
function datePick(obj, sChar)
{
  if(sChar==null) sChar='';
	  var sDate =openDialog("/gys/js/datePicker.jsp",185,230);
	  if(sDate != null)
	     obj.value=sDate.substr(0,4)+sChar+sDate.substr(4,2)+sChar+sDate.substr(6,2);
	  else
	     obj.value="";
	  if(obj.type == 'text'){
	  	 obj.onChange;
	  }
	  obj.blur();
}

//��ȡ�ַ������Ӵ�
function cutChar(parentChar,subChar) {
	var tempChar;
	var rChar = "";
	if(parentChar.indexOf(subChar)!=-1) {
		tempChar = parentChar.split(subChar);
		for(i=0;i<tempChar.length;i++) {
			rChar = rChar + tempChar[i];	
		}
		parentChar = rChar;
	}
	return parentChar;
}

//ת�����ڸ�ʽ�ַ���Ϊ��������
function dateCharToNumber(sourceChar,schar) {
	var tempChar = sourceChar.split(schar);
	var targetValue;
	if(tempChar.length == 3) {
		targetValue = parseInt(tempChar[0])*10000 + parseInt(tempChar[1])*100 + parseInt(tempChar[2]);
	}else {
		targetValue = 0;
	}
	return targetValue;
}

/********************************���ñ������������ɫ*****************************/

//���ñ����������ڵ�Ԫ���ɫ
function setFormInputColor(formName,appointedBgcolor,ifSetParent,ifSetWindow) {
	if(ifSetWindow != false){
		window.name="autoformwindow";
		window.moveTo(0,0);
		window.resizeTo(screen.width , screen.height - 26);	
	}
	var formObj = eval(formName);
	if(!formObj) {
		formObj = eval("document.all."+formName);
		if(!formObj) {
			alert("û�ҵ�������!");
		}
	}
	var tempChar;
	var tempObj;
	
	for(i=0;i<formObj.elements.length;i++) {
		
		if(formObj.elements[i].type == "text" || formObj.elements[i].type == "textarea") {
			if(formObj.elements[i].readOnly == false) {
				formObj.elements[i].style.background = appointedBgcolor;
				if(ifSetParent)
				formObj.elements[i].parentElement.style.background = appointedBgcolor;
			}else {
				if(formObj.elements[i].ondblclick != null) {
					formObj.elements[i].style.background = appointedBgcolor;
					if(ifSetParent)
					formObj.elements[i].parentElement.style.background = appointedBgcolor;
				}	
			}
		}
		if(formObj.elements[i].type == "radio") {
			if(formObj.elements[i].disabled == false) {
				formObj.elements[i].style.background = appointedBgcolor;
				if(ifSetParent)
				formObj.elements[i].parentElement.style.background = appointedBgcolor;
			}
		}
		if(formObj.elements[i].type == "select-one") {
			if(formObj.elements[i].name.indexOf("SELECT_") != -1) {
				tempChar = formObj.elements[i].name.split("SELECT_")
				if(tempChar.length == 2)
				tempObj = eval("document.all."+tempChar[1]+"_SHOW");
				if(tempObj) {
					tempObj.style.background = appointedBgcolor;
					if(ifSetParent)
					tempObj.parentElement.style.background = appointedBgcolor;
				}
			}else {
				if(formObj.elements[i].disabled == false) {
					formObj.elements[i].style.background = appointedBgcolor;
					if(ifSetParent)
					formObj.elements[i].parentElement.style.background = appointedBgcolor;
				}
			}
		}
		
		if(formObj.elements[i].type == "button") {
			tempChar = document.form1.elements[i].name;
			tempObj = tempChar + "_iframe";
			
			if(document.getElementsByName(tempObj).length != 0) {
				tempObj = eval(tempObj);
				if(tempObj) {
					tempObj.document.body.style.background = appointedBgcolor;
				}
			}
			if(ifSetParent) {
				tempObj = eval("document.all." + tempChar + "_td");
				if(tempObj) {
					tempObj.style.background = appointedBgcolor;
				}
			}
		}
	}
}
//�����ض�����ı���ɫ
function setObjBgcolor(obj,appointedBgcolor) {
	var tempObj = eval(obj);
	if(!tempObj) {
		tempObj = eval("document.all."+obj);
	}
	if(tempObj) {
		tempObj.style.background = appointedBgcolor;
	}
}
function setIframeBgcolor(cotl_buttonName,iframeName,appointedBgcolor) {
	var buttonObj = eval("document.all." + cotl_buttonName);
	var iframeObj = eval("document.all." + iframeName);
	var iframeWinObj = eval(iframeName);
	if(buttonObj && buttonObj.style.display != "none") {
		Setobjbgcolor(iframeObj.parentElement,appointedBgcolor);
		setObjBgcolor(iframeWinObj.document.body,appointedBgcolor);
	}
}
//�����������
function releaseInputDate(obj,appointedBgcolor,ifrelease) {
	var tempObj = eval(obj);
	if(!tempObj) {
		tempObj = eval("document.all."+obj);
	}
	if(tempObj) {
		if(ifrelease == true) {
			tempObj.ondblclick = new Function("setRqField(this)");
			tempObj.style.background = appointedBgcolor;
			tempObj.parentElement.style.background = appointedBgcolor;
		}else {
			tempObj.ondblclick = null;
			tempObj.style.background = "";
			tempObj.parentElement.style.background = "";
		}
	}
}

/********************************         ����         *****************************/

/**
 *����������
 */
function createInput(obj,m_type,m_name,m_value,ifReadOnly,m_size) {
	
	var temp_input = obj.createElement("input");
	temp_input.type = m_type;
	temp_input.name = m_name;
	temp_input.value = m_value;
	if(m_size != null && m_size != "")
	temp_input.size = m_size;
	if(ifReadOnly != null && ifReadOnly != "")
	temp_input.readOnly = ifReadOnly;
	
	if(temp_input.type == 'checkbox') {
		temp_input.defaultChecked = true;
	}
	
	return temp_input;
}
/**
 *�����������¼�����
 */
 function setInputFun(obj,ev,str) {
 	
 }
/**********************ʹSelect�е�Option�ƶ�N��**********************/
function move(src, index, offset){
	var tmp_text = "";
	var tmp_value = "";
	var tmp_selected = false;
	var options = src.options;
	if(index >= 0 && index < options.length){
		if(offset < 0){
			if(offset + index < 0)
				offset = 0 - index;
			for(var i = index; i < options.length; i++){
				if(options[i].selected){
					for(var j = i; j > i + offset; j--){
						tmp_text = options[j - 1].innerText;
						tmp_value = options[j - 1].value;
						tmp_selected = options[j - 1].selected;
						options[j - 1].innerText = options[j].innerText;
						options[j - 1].value = options[j].value;
						options[j - 1].selected = options[j].selected;
						options[j].innerText = tmp_text;
						options[j].value = tmp_value;
						options[j].selected = tmp_selected;
					}
				}
			}
		}else{
			var last = options.length - 1;
			for(var i = last; i >= index; i--){
				if(options[i].selected){
					last = i;
					break;
				}
			}
			if(last + offset > options.length - 1)
				offset = options.length - 1 - last;
			for(var i = last; i >= index; i--){
				if(options[i].selected){
					for(var j = i; j < i + offset; j++){
						tmp_text = options[j + 1].innerText;
						tmp_value = options[j + 1].value;
						tmp_selected = options[j + 1].selected;
						options[j + 1].innerText = options[j].innerText;
						options[j + 1].value = options[j].value;
						options[j + 1].selected = options[j].selected;
						options[j].innerText = tmp_text;
						options[j].value = tmp_value;
						options[j].selected = tmp_selected;
					}
				}
			}
		}
	}
}

/******************��src�б�ѡ�е�Option�ƶ���dest��ȥ********************/
function appendColumn(src, dest, total){
	if(src && dest && src.selectedIndex >= 0){
		var options = src.options;
		var counter = 0;
		for(var i = 0; i < options.length; i++){
			if(options[i].selected){
				var option = document.createElement("option");
				option.innerText = options[i].innerText;
				option.value = options[i].value;
				dest.appendChild(option);
				src.removeChild(options[i]);
				counter++;
				i--;
				if(counter == total){
					break;
				}
			}
		}
	}
}


/**
 *���¼�������Ԫ���ñ���ɫ��ǰ��ɫ
 */
var preEl ;
var orgBColor;
var orgTColor;
function HighLightSet(backColor,textColor){
if(typeof(preEl)!='undefined') {
preEl.bgColor=orgBColor;
try{ChangeTextColor(preEl,orgTColor);}catch(e){;}
 }
  var el = event.srcElement;
  el = el.parentElement;
  orgBColor = el.bgColor;
  orgTColor = el.style.color;
  el.bgColor=backColor;

  try{ChangeTextColor(el,textColor);}catch(e){;}
  preEl = el;
}
 function ChangeTextColor(a_obj,a_color){
   for (i=0;i<a_obj.cells.length;i++){
     //put condition before increase!!!!!
      a_obj.cells(i).style.color=a_color;
 }
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
						tempChar = (new Number(tempNum[1].substring(0,numScale)) + 1).toString();
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
			}else{
				tempChar = tempValue;
			}
			
		}else {
			alert("���ݸ�ʽ��");
			tempChar = "";
		}
	}else {
		tempChar = tempValue;	
	}
	
	return 	tempChar;
	
}
/**
*���ú�̨����
*/
function backSort(obj,preSortField){
	var temp_href = window.location.href;
	var location_href = "";
	preSortField = preSortField.replace(/\s/g,"");
	if(preSortField != null && preSortField != "")
		location_href = temp_href.replace(preSortField,obj.id);
	else{
		if(temp_href.indexOf("?") == -1) {
			location_href = temp_href + "?sortField=" + obj.id ;
		}else {
			location_href = temp_href + "&sortField=" + obj.id;
		}
	}
	var sortObj = document.getElementById("sortField");
	if(sortObj && sortObj.value == obj.id) {
		if(document.getElementById("sortType").value != "desc")
			location_href = location_href +	"&sortType=desc";
		else
			location_href = location_href.replace("&sortType=desc","");
	}
	window.location.href = location_href;
}
function backSortForSubmit(obj,formObj){
	
	var sortObj = document.getElementById("sortField");
	var sortTypeObj = document.getElementById("sortType");
	var preSortField = sortObj.value;
	sortObj.value = obj.id;
	if(preSortField == sortObj.value) {
		if(sortTypeObj.value != "desc")
			sortTypeObj.value = "desc";
		else
			sortTypeObj.value = "";
	}
	document.form1.submit();
}
/**
*��ѡ��ȫѡ
*/	
function checka(){
							
	var allobj = document.form1.all;
	for(var i = 0;i < allobj.length; i ++){
		if(allobj[i].type == "checkbox" && allobj[i].name != "checkall"){
			allobj[i].checked = document.form1.checkall.checked;
		}
	}
}
/**
 *���㺯��
 */
function addZero(strNum,len){
	var temp_strNum = strNum;
	var nCount = len - temp_strNum.length;
	for(var i=0;i<nCount;i++){
		temp_strNum = "0" + strNum;
	}
	return temp_strNum;
}   

function del_provider(tempObj)
{
	obj=tempObj.parentNode.parentNode.parentNode;
	for(var j=0;j<obj.rows[0].cells[0].children.length;j++)
	{
		if(obj.rows[0].cells[0].children[j].name!="ID$TF12_PRICE_LIST")
			obj.rows[0].cells[0].children[j].value="";
	}
	obj.style.display="none";
}

/**
 *�޸ı�����ƻ�������¼���
 */

function changeRead(i){
	if (i==0){ 
		document.all.UPDATE_DATE.readOnly =true; 
		document.all.UPDATE_DATE.value="";
		document.all.UPDATE_DATE_ReadOnly.name="UPDATE_DATE_ReadOnly";
	}
	else if(i==1){ 
		document.all.UPDATE_DATE.readOnly =false;
		document.all.UPDATE_DATE_ReadOnly.name="other";
		
	}
}
/**
 *����ָ������
 */
function blankit(obj,inputObj){
	obj.style.display="none";
	inputObj.focus();
}

//��������������޸���Żس��󣬱�õ�ǰ���ָ����,����:�¼������е�obj�����ID����ͷ����
function changerow(obj,tableId,tlen){
	//if(event.keyCode==13) {//���̰���Enter�� 
		var listtable= document.getElementById(tableId);
		var line1=obj.parentElement.rowIndex;//��ǰ�е��к�
		var xh = obj.children[0].value;//��ǰ�е����
		var a=parseInt(xh); 
		var line2;
		if(tlen==3){ //�����ͷ�����е�
			line2= a+2; //��ͷ���м�2 
		}else if(tlen==2){//�����ͷ�����е�
			line2= a+1;
		}else if(tlen==1){//�����ͷ��һ�е�
			line2= a;
		}
		var rowlength=listtable.rows.length-tlen;//��񳤶ȼ�ȥ��ͷ
		if(a>rowlength){
			alert("��ų����˽��ޣ�");
			return;
		}
		if(line2>line1){
			for(var i=line1;i<line2;i++){
				listtable.rows[i].swapNode(listtable.rows[i+1]);
			}
		}else{	
			for(var i=line1;i>line2;i--){
				listtable.rows[i].swapNode(listtable.rows[i-1]);
			}
		}		
		rowsSort(tableId,rowlength,tlen);//��������id�������Ч���ݳ��ȣ���ͷ��
	//}
}

//������� ���� table id����񳤶�,��ͷ���� 
function rowsSort(tableId,objlen,tlen){	
	var listtable= document.getElementById(tableId);
	var j=0;
	for(var i=0;i<objlen;i++){
		var ro=i+tlen;
		if(listtable.rows[ro].style.display != "none"){	
			j++;
			listtable.rows[ro].children[0].children[0].value=j;	
		}
	}	
}
//������� ,���ڱ���֮ǰ����,���� table id; ��񳤶�;��ͷ����
function rowsSortSave(tableId,objlen,tlen){
	var listtable= document.getElementById(tableId);
	var j=0;
	for(var i=0;i<objlen;i++){
		var ro=i+tlen;
		if(listtable.rows[ro].style.display != "none"){
			if(listtable.rows[ro].children[1].children[0].value!=""){
				j++;
				listtable.rows[ro].children[0].children[0].value=j;	
			}
		}
	}	
}

/*
  	1���������Ϊ�ı����ҿ���¼�룬�������ı���
  	   �򽫴��ı��������ѡ��(onclick)
  	2���������Ϊ����,��С��λ����3�����Զ�����3λ����4��5��(onblur)
  */
  function addNumSelect(){
  	var f_all = document.all;
  	for(var i = 0;i < f_all.length;i++){
  		var obj = f_all[i];
  		if(obj.type != null && obj.type == 'text' && obj.readOnly == false){
	  		obj.onclick = function(){   
    			 this.select();   
    		}   
    		if(obj.value != '' && !isNaN(obj.value)){
	    		obj.onblur = function(){  
	    			this.value = Math.round(this.value*1000)/1000;
	    		}   
    		}
  		}
  	}
  }