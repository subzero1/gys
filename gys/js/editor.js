
function write_html(cssurl, htmlbody){
	var html_header="";
	var html_footer;
	cssfile=cssurl;
	html_header='<html><head><META http-equiv=Content-Type content="text/html; charset=utf-8"><title></title><META http-equiv=pragma content=no-cache><META http-equiv=Cache-Control content="no-cache, must-revalidate"><META http-equiv=expires content="wed, 26 Feb 1997 08:21:57 GMT"><link rel="stylesheet" type="text/css" href="'+cssurl+'"></head>'+"\n"+'<body topmargin=0 leftmargin=0 rightmargin=0 bottommargin=0 class="editor_font">';
	html_footer='\n\n\n</body></html>';
	infoEditor.document.write(html_header+htmlbody+html_footer);
}

/****粘贴****/
function Doc_OnPaste(){
 paste();
 return false;
}
 

function fnKeypress(){
 var ev = infoEditor.event;
 if(ev.keyCode==13){
	var sel = infoEditor.document.selection.createRange();
	sel.pasteHTML("<BR>");
	ev.cancelBubble = true;
	ev.returnValue = false;
	sel.select();
	sel.moveEnd("character", 1);
	sel.moveStart("character", 1);
	sel.collapse(false);
  return false;
 }
}

/****初始化编辑器****/
function initEditor(){
  infoEditor.document.onkeypress=fnKeypress;
  infoEditor.document.body.onpaste= Doc_OnPaste ;

}

var sel;

/****添加链接、打开链接层****/
function addLink(){
	var linkdiv = document.getElementById("linkDiv");
	var curleft=event.clientX + document.body.scrollLeft - 200;
	var curtop=event.clientY + document.body.scrollTop + 120;
	linkdiv.style.left = curleft;
	linkdiv.style.top = curtop;
	linkdiv.style.display = "block";
	
	sel= infoEditor.document.selection.createRange();
} 

function changlinktype(linktype){
	var linkurl = document.getElementById("linkurl");
	linkurl.value=linkurl.value.replace(/^[^ ]+:\/\//,linktype);
} 

/****处理链接****/
function linkOk(){
	var linkurl = document.getElementById("linkurl");
	var linkurlstr=linkurl.value;
	if(!CheckUrl(linkurlstr)){
		alert("输入的网址无效，请重新输入！");
		linkurl.focus();
		return false;
	}
	var openwintype='';
	var link_type= document.getElementById("linkwintype").value; 
	if(link_type=='2'){
	 openwintype=' target=_blank ';
	}
	
	var linkdiv = document.getElementById("linkDiv");
	linkdiv.style.display = "none";
	
	sel.select();
	var selstr=sel.htmlText;
	if(selstr.length<1){
	  selstr=linkurlstr;
	}
	infoEditor.focus();     
	resstr="<a href='"+linkurlstr+"' "+openwintype+">"+selstr+"</a>";
	pasteHTML(resstr);

}

/****检测url地址****/
function CheckUrl(url){
	var sTemp;
	var b=true;
	sTemp=url.substring(0,6);
	sTemp=sTemp.toUpperCase();
	if (((sTemp!="HTTP:/")&&(sTemp!="FTP://")&&(sTemp!="MAILTO")&&(sTemp!="HTTPS:"))||(url.length<11)){
		b=false;
	}
	return b;
}

/****取消关闭链接层****/
function linkCancel(){
  var linkdiv = document.getElementById("linkDiv");
  linkdiv.style.display = "none";

}

/****执行指定命令****/
function FormatText(command, option){
	infoEditor.document.execCommand(command, true, option);
	infoEditor.focus();
}

var emotion="";

function selectRange(){
	edit = infoEditor.document.selection.createRange();
	RangeType = infoEditor.document.selection.type;
}


/****粘贴****/
function paste(){
  var divElement=document.getElementById('divTemp');
  if(!divElement){
    divElement=document.createElement('<DIV id=divTemp style="VISIBILITY: hidden; OVERFLOW: hidden; WIDTH: 1px; POSITION: absolute; HEIGHT: 1px"></DIV>');
  }

 
  divElement.innerHTML = "" ;
  
  var oTextRange = document.body.createTextRange() ;
  oTextRange.moveToElementText(divElement) ;
  oTextRange.execCommand("Paste") ;
  
  var sData = divElement.innerHTML ;
  divElement.innerHTML = "" ; 
  pasteHTML(sData);
 
}


function add_file(filetype){
	window.open("uploadPic.asp?action=new&type=" + filetype,"","width=400 height=350");
	sel= infoEditor.document.selection.createRange();
}

/***重置***/
function ResetForm(){

	if (window.confirm('确认重新输入新闻内容吗？')){
	 	infoEditor.document.body.innerHTML = ''; 
	 	return true;
	 } 
	 return false;		
}

/***所有内容拷贝到剪贴板***/
function  CopyToClipBoard(){
      
	infoEditor.document.execCommand("selectAll");
	infoEditor.document.execCommand("Copy");
}

/***清除所有文字格式***/
function CleanStyle()
  {
    if (confirm("确认清楚所有文字格式吗？"))
    {
      // remove styles
      var els = infoEditor.document.body.all;
      for (i=0; i<els.length; i++)
      {
        // remove style and class attributes from all tags
        els[i].removeAttribute("className",0);
        els[i].removeAttribute("style",0);
      }

      var found = true;
      while (found)
      {
        found = false;
        var els = infoEditor.document.body.all;
        for (i=0; i<els.length; i++)
        {
          // remove tags with urns set
          if (els[i].tagUrn != null && els[i].tagUrn != '')
          {
            els[i].removeNode(false);
            found = true;
          }

          // remove font and span tags
          if (els[i].tagName== "P" || els[i].tagName== "FONT" || els[i].tagName == "SPAN" || els[i].tagName == "DIV" )
          {
            els[i].removeNode(false);
            found = true;
          }
        }      
      }
      
    }
  } 

/**选择颜色**/

var colorWhere='';

function ChooseColor(where)
{
	colorWhere=where;
	
	var colordiv = document.getElementById("colorDiv");
	
	var curleft = event.clientX + document.body.scrollLeft - 20;
	var curtop = event.clientY + document.body.scrollTop + 100;
	colordiv.style.left = curleft;
	colordiv.style.top = curtop;
	colordiv.style.display = "";
	
	sel= infoEditor.document.selection.createRange();
}

function ColorOK(color){
	var colordiv = document.getElementById("colorDiv");
	colordiv.style.display = "none";
	sel.select();
	infoEditor.document.execCommand(colorWhere, false, color);
	infoEditor.focus();
}

function pasteHTML(HTML)
{
	infoEditor.focus();
	selectRange();
	edit = infoEditor.document.selection.createRange();
	edit.pasteHTML(HTML);
}

/**文字移动**/
function move()
{
	edit = infoEditor.document.selection.createRange();
	var content='<marquee SCROLLAMOUNT = 2>'+edit.htmlText+'</marquee>';
	pasteHTML(content);
}

/**文字发光**/
function glow()
{

	edit = infoEditor.document.selection.createRange();
	var content = '<span style="filter: glow(color=#FF0000); height:6">'+edit.text+'</span>';
	pasteHTML(content);
}

/**文字阴影**/
function shadow()
{
	edit = infoEditor.document.selection.createRange();
	var content='<span style="filter: shadow(color=#CCCCCC); height:6">'+edit.text+'</span>';
	pasteHTML(content);
}

/**改变字体大小**/
function set_fontsize(fontsize){
	var font_style_size=12;
	switch(fontsize){
		case "7": font_style_size=36; break;
		case "6": font_style_size=28; break;
		case "5": font_style_size=22; break;
		case "4": font_style_size=18; break;
		case "3": font_style_size=14; break;
		case "2": font_style_size=12; break;
		case "1": font_style_size=10; break;
	}


		infoEditor.document.execCommand("FontSize", true, fontsize);
		var edit = infoEditor.document.selection.createRange();
		var el = edit.parentElement();
		if(el && (el.tagName=="FONT")){
			el.style.fontSize=font_style_size+"px";
		}
}

function submitInfo(){
	
  var sBody = infoEditor.document.body.innerHTML;
  sBody = sBody.replace(/: /gi,":");
  sBody = sBody.replace(/; /gi,";");
  sBody = sBody.replace(/"/gi,'\\"');
  
  //处理paseHtml之后绝对地址
 // var curFilePath = document.location.href;
 // var pathIndex = curFilePath.lastIndexOf("/");
  //var repStr = curFilePath.substring(0,pathIndex + 1);
 // var re = new RegExp(repStr,"gi")   
//  sBody = sBody.replace(re,'');
   
  document.editform.content.value=sBody;
  document.editform.submit();
}

