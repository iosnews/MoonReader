function deleteNode(elementId) {
	var label=document.getElementById(elementId);
	while(label.hasChildNodes())
	{
		label.removeChild(label.lastChild);
	}
}

function decode_utf8( s )
{
  return decodeURIComponent( escape( s ) );
}

function modalPopup(filename, option, fileID) {
	deleteNode("modal-title");
	deleteNode("modal-text");
	deleteNode("modal-field");
	// pop modal
	$('#modal-content').modal({closeHTML: "<input type=button name='cancelButton' id='cancelButton' value=''>"});
//	filename = unescape(filename);
	filename = decodeURIComponent(filename);
	if (option==0) {	// rename
		document.getElementById("modal-field").style.display="block";
		var titleObj = document.createElement("h3");
		titleObj.innerText = "Rename";
		titleObj.textContent = "Rename";
		document.getElementById("modal-title").appendChild(titleObj);

		var textObj = document.createElement("a");
		textObj.innerText = "Current File Name  "+"\""+filename+"\"";
		textObj.textContent = "Current File Name "+"\""+filename+"\"";
		document.getElementById("modal-text").appendChild(textObj);

		var fieldObj = document.createElement("input");
		fieldObj.setAttribute("type","hidden");
		fieldObj.setAttribute("name","originalItem");
		fieldObj.setAttribute("value", filename);
		document.getElementById("modal-field").appendChild(fieldObj);

        var targetObj = document.createElement("input");
        targetObj.setAttribute("type", "input");
        targetObj.setAttribute("name", "targetItem");
        targetObj.setAttribute("value", filename);
        targetObj.setAttribute("id","modal-field");
        document.getElementById("modal-field").appendChild(targetObj);

        var operationObj = document.createElement("input");
		operationObj.setAttribute("type","hidden");
		operationObj.setAttribute("name","operationType");
		operationObj.setAttribute("value","rename");
		document.getElementById("modal-field").appendChild(operationObj);

		// assign text field value
		document.getElementsByName('submitButton')[0].value = "";
		document.getElementsByName('ID')[0].value = filename;

		document.getElementById('submitButton').style.margin= "-4px 0 0 9px";
	}
	else if (option==1) { // create folder
		document.getElementById("modal-field").style.display="block";
		var titleObj = document.createElement("p");
		titleObj.innerText = "新建文件夹";
		titleObj.textContent = "新建文件夹";
		document.getElementById("modal-title").appendChild(titleObj);

		var textObj = document.createElement("a");
		textObj.innerText = "填写文件夹名";
		textObj.textContent = "填写文件夹名";
		document.getElementById("modal-text").appendChild(textObj);

		var fieldObj = document.createElement("input");
		fieldObj.setAttribute("type","input");
		fieldObj.setAttribute("name","targetItem");
		fieldObj.setAttribute("value","新建文件夹");
		fieldObj.setAttribute("id","modal-field");
		document.getElementById("modal-field").appendChild(fieldObj);
		
        var operationObj = document.createElement("input");
		operationObj.setAttribute("type","hidden");
		operationObj.setAttribute("name","operationType");
		operationObj.setAttribute("value","create");
		document.getElementById("modal-field").appendChild(operationObj);
		
		document.getElementById('cancelButton').style.margin= "128px -69px 0";
		// assign text field value
		document.getElementsByName('submitButton')[0].value = "";
		document.getElementsByName('ID')[0].value = fileID;
		document.getElementById('submitButton').style.margin= "-1px 0 0 9px";
	}
	else if (option==2) { // delete file
		var titleObj = document.createElement("h3");
		titleObj.innerText = "删除文件";
		titleObj.textContent = "删除文件";
		document.getElementById("modal-title").appendChild(titleObj);

		var textObj = document.createElement("a");
		textObj.innerText = "确定要删除文件?\n";
		textObj.textContent = "确定要删除文件?\n";
		document.getElementById("modal-text").appendChild(textObj);

		var fieldObj = document.createElement("input");
		fieldObj.setAttribute("type","hidden");
		fieldObj.setAttribute("name","operationType");
		fieldObj.setAttribute("value","delete");
		document.getElementById("modal-field").appendChild(fieldObj);

        var targetObj = document.createElement("input");
        targetObj.setAttribute("type", "hidden");
        targetObj.setAttribute("name", "originalItem");
        targetObj.setAttribute("value", filename);
        document.getElementById("modal-field").appendChild(targetObj);
        document.getElementById("modal-field").style.display="none";
		// assign text field value
		document.getElementsByName('submitButton')[0].value = "";
		document.getElementsByName('ID')[0].value = filename;
		document.getElementById('submitButton').style.margin= "44px 4px 5px 3px";
	}


}

function downloadFile(filename)
{
	window.location.replace(filename + '?dl=yes');
}

function deleteFile(url, params) {
	var answer = confirm("确定要删除文件?\n" + params['deleteFile'])

    if (answer) {
        history.go();


        var form = document.createElement('form');
        form.action = url;
        form.method = 'POST';

        for (var i in params) {
            if (params.hasOwnProperty(i)) {
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = i;
                input.value = params[i];
                form.appendChild(input);
            }
        }

        form.submit();
    }
}






