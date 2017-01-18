
$(document).ready(function(){
    $("#flip").click(function(){
    	console.log("test")
        $("#newUserProjectTechForm").slideUp("slow");
        
    });
});

window.onload = function() {
	$("#newUserProjectTechForm").hide();
	$("#updateUserProjectTechForm").hide();
	console.log("window.onload");
}

function overChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function outChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function removeProject(obj) {
	document.updateForm.action = "deletedUserProjects";
	document.updateForm.submit();
}

/*
 * Check the validity of the data inputed.
 */
function validateForm(tableName) {

	var blnPopover = true;
	var isError = true;

	var table = document.getElementById(tableName);
	var inputTag = table.getElementsByTagName("select");

	if(!validateId(inputTag[0])) {
		return false;
	}
	if(!validateId(inputTag[1])) {
		return false;
	}
	return isError;
}


/*
 * Make the table on the Modal for confirming the data.
 */
function confirmData(tableName) {

	if(!validateForm(tableName)) {
		return;
	}

	// Call the modal
	$(window).ready(function(){
		$('#submitFormUserProjectTech').modal('show')
	});

	var table1 = document.getElementById(tableName);
	// Create a table on Motal 
	var table3 = document.getElementById("t03");

	var selectSkillHtml;
	var selectKindHtml, mtechs;
	var selectedLevelTag, selectLevelHtml;
	var textareaTag, detailHtml;

	  
	var row1, row3;
	var cell31, cell32, cell33, cell34

	row1 = table1.rows[0];
	row3 = table3.insertRow(1);

	// Create cells
	cell31 = row3.insertCell(0);
	cell32 = row3.insertCell(1);
	cell33 = row3.insertCell(2);
	cell34 = row3.insertCell(3);

	// Set tech1
	selectSkillHtml = row1.cells[0].getElementsByTagName("select")[0].value;
	mtechs = mtechList[selectSkillHtml];

	// Set tech2
	selectKindHtml = row1.cells[1].getElementsByTagName("select")[0].value;
	var j;
	for (j = 0; j < mtechs.length; j++) {
		if(selectKindHtml == mtechs[j].mtNo) {
			selectKindHtml = mtechs[j].mtName;
			break;
		}
	}

	// Set data in detail
	selectedLevelTag = row1.cells[2].getElementsByTagName("select")[0];
	selectLevelHtml = selectedLevelTag.options[selectedLevelTag.selectedIndex].innerHTML;

	// ETC
	textareaTag = row1.cells[3].getElementsByTagName("textarea");
	detailHtml = textareaTag[0].value;

	cell31.innerHTML = selectSkillHtml;
	cell32.innerHTML = selectKindHtml;
	cell33.innerHTML = selectLevelHtml;
	cell34.innerHTML = detailHtml;

	if(tableName == "newFormId") {
		document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitNewFormUserProjectTech();" );		  
	} else {
		document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitUpdateFormUserProjectTech();" );
	}

}

/*
 * Remove a tech information of a project.
 */
function removeProjectTech() {
	// Call the modal for deleting
	$(window).ready(function(){
		$('#submitFormDeleteProjectTech').modal('show')
	});

}
