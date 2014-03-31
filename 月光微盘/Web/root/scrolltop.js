// JavaScript Document
function goTopEx(){
        var obj=document.getElementById("goTopBtn");
        function getScrollTop(){
				var explorer = window.navigator.userAgent ;
				if(explorer.indexOf("Chrome") >= 0)
				{
					
					return document.body.scrollTop;//谷歌浏览器 不支持document.documentElement.scrollTop;  故改为document.body.scrollTop
				}
				else
				{
					return document.documentElement.scrollTop;//谷歌浏览器 不支持 document.documentElement.scrollTop; 故改为document.body.scrollTop
				}
                
            }
        function setScrollTop(value){
                
				var explorer = window.navigator.userAgent ;
				if(explorer.indexOf("Chrome") >= 0)
				{
					document.body.scrollTop=value;//谷歌浏览器 不支持document.documentElement.scrollTop;  故改为document.body.scrollTop
				}
				else
				{
					document.documentElement.scrollTop=value;//谷歌浏览器 不支持 document.documentElement.scrollTop; 故改为document.body.scrollTop
				}
            }    
        window.onscroll=function(){getScrollTop()>0?obj.style.display="":obj.style.display="none";}
        obj.onclick=function(){
            var goTop=setInterval(scrollMove,10);
            function scrollMove(){
                    setScrollTop(getScrollTop()/1.1);
                    if(getScrollTop()<1)clearInterval(goTop);
                }
        }
    }
	/*判断浏览器类型
	function getExplorer() {
	var explorer = window.navigator.userAgent ;
	//ie 
	if (explorer.indexOf("MSIE") >= 0) {
		alert("ie");
	}
	//firefox 
	else if (explorer.indexOf("Firefox") >= 0) {
		alert("Firefox");
	}
	//Chrome
	else if(explorer.indexOf("Chrome") >= 0){
		alert("Chrome");
	}
	//Opera
	else if(explorer.indexOf("Opera") >= 0){
		alert("Opera");
	}
	//Safari
	else if(explorer.indexOf("Safari") >= 0){
		alert("Safari");
	}
}*/