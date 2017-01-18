function addLoadEvent(func){
	var oldonload = window.onload;
	if(typeof window.onload != 'function'){
		window.onload = func;
	}else{
		window.onload = function(){
			oldonload();
			func();
		};
	}
}

function fadeOut(element) {
    var op = 1;  // initial opacity
    var timer = setInterval(function () {
        if (op <= 0.1){
            clearInterval(timer);
            element.style.display = 'none';
        }
        element.style.opacity = op;
        element.style.filter = 'alpha(opacity=' + op * 100 + ")";
        op -= op * 0.1;
    }, 150);
}

function captureReturnKey(evt) {
	
	var type;

    // Get type
    if (document.all) {
        type = evt.srcElement.type;
    } else {
    	type = evt.target.type;
    }

    if(evt.keyCode==13 && type != 'textarea') {
    	console.log("Entered in input tag.");
        return false;
    }

} 

function exceptionKey(e) {
    if(e.keyCode==37 || e.keyCode==38 || e.keyCode==39 || e.keyCode==40) {
        return false;    	
    }
    return true;
}

function isEmpty(str) {
    return (!str || 0 === str.length);
}
function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}

/* release popover */
function releasPopover(event) {
	$jevent = $(event);
	$jevent.popover('destroy');
}

/* Ajax with jquery */
function requestbyAjax(curl, cdata) {
	var result;
    $.ajax({
        type: 'POST',
        url: curl,
        contentType: "application/json",
        dataType: "json",
        data: cdata,
        cache: false,
        async: false,
        beforeSend: function(xhr, settings) {
        	xhr.setRequestHeader("Accept", "application/json");
        	xhr.setRequestHeader("Cache-Control","no-cache, must-revalidate");
        	xhr.setRequestHeader("Pragma","no-cache");

        },
        success: function(data, textStatus, request) {
        	// Set data to out side.
        	result = data;
        },
        complete: function(xhr, textStatus) {
        	console.log("complete");
        },
        error: function(xhr, status) {
        	console.log("error >> " + xhr.responseText);
        }
    });

    return result;
}

/*
 * Validate tags for 
 */
function validateField(inputTag) {

	var isError = true;

	if(inputTag.length < 1) {
		alert("At least you have to add your skills");
		return false;
	}

	for (i=0; i < inputTag.length; i++) {
	    var x = inputTag[i].value;
	    if (x==null || x=="" || x=="0") {
	    	if(isError) {
	    		inputTag[i].focus();
	    		inputTag[i].scrollIntoView();
	    	}
	    	inputTag[i].style.border = "1px solid red";
	    	// inputTag[i].style.cssText = 'border:1px solid red !important';

	        isError = false;
	    } else {
	    	inputTag[i].style.border = "";
	    }
	}

	return isError;
}

/*
 * Validate a tag for single
 */
function validateTag(inputTag) {

	var isError = true;
    var x = inputTag[0].value;

    if (x==null || x=="" || x=="0") {
    	if(isError) {
    		inputTag[0].focus();
    		inputTag[0].scrollIntoView();
    	}
    	inputTag[0].style.border = "1px solid red";
        isError = false;
    } else {
    	inputTag[0].style.border = "";
    }

    return isError;
}

function validateId(inputId) {

	var isError = true;
    var x = inputId.value;

    if (x==null || x=="" || x=="0") {
    	if(isError) {
    		inputId.focus();
    		inputId.scrollIntoView();
    	}
    	inputId.style.border = "1px solid red";
        isError = false;
    } else {
    	inputId.style.border = "";
    }

    return isError;
}

/* 
 * tagNameId : a tag
 * x : this (select tag)
 * When a Select Tag is selected, It works  
 */

function sltDataList(x) {
	// var sltMtSkillId = document.getElementById(tagNameId);
	// sltMtSkillId.value = x.value;
	document.sltForm.submit();
}


function overChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function outChangeColor(obj) {
	obj.style.cursor = "pointer";
}

/*
 * Delete all rows of the modal table
 */
function deleteTr(tableNameId) {
	var table = document.getElementById(tableNameId);
	var tableRows = table.getElementsByTagName('tr');

	for(var i = 1; i < tableRows.length; i++){
		tableRows[i].parentNode.removeChild(tableRows[i]);
		i--;
	}
}

function clearBackGroundColorTr(tableId) {
	var table = document.getElementById(tableId);
	var tr = table.getElementsByTagName("tr");

	for(var j=0; j< tr.length; j++) {
		tr[j].style.backgroundColor = "";
	}
}