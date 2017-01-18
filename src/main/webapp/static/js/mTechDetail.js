
$(document).ready(function(){
    $("#flip").click(function(){
        $("#newMTechDetailFormId").slideUp("slow");
    });
});

window.onload = function() {
	$("#newMTechDetailFormId").hide();
	$("#updateMTechDetailFormId").hide();
	console.log("window.onload");
}

function overChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function outChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function removeMTechDetail(obj) {
	document.updateForm.action = "deletedMTechDetail";
	document.updateForm.submit();
}

/*
 * Check the validity of the data inputed.
 */
function validateForm(tableName) {

	var blnPopover = true;
	var isError = true;

	var table = document.getElementById(tableName);
	var selectTag = table.getElementsByTagName("select");

	if(!validateField(selectTag)) {
		return false;
	}
	var inputTag = table.getElementsByTagName("input");
	if(!validateField(inputTag)) {
		return false;
	}

	return true;
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
		$('#submitFormMTechDetailId').modal('show')
	});

	var table1 = document.getElementById(tableName);
	// Create a table on Motal 
	var table3 = document.getElementById("t03");

	var mtdLevelHtml;
	var mtdLevelExplainHtml;

	var row1, row3;
	var cell31, cell32;

	row1 = table1.rows[0];
	row3 = table3.insertRow(1);

	// Create cells
	cell31 = row3.insertCell(0);
	cell32 = row3.insertCell(1);

	mtdLevelHtml = row1.cells[1].getElementsByTagName("select")[0].value;

	console.log("mtdLevelHtml >>> " + mtdLevelHtml);

	mtdLevelExplainHtml = row1.cells[3].getElementsByTagName("input")[0].value;

	cell31.innerHTML = mtdLevelHtml;
	cell32.innerHTML = mtdLevelExplainHtml;

	if(tableName == "newFormId") {
		document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitNewFormMTechDetail();" );		  
	} else {
		document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitUpdateFormMTechDetail();" );
	}

}

/*
 * Remove a tech information of a project.
 */
function removeProjectTech(obj) {
	document.updateForm.action = "/project/deletedUserProjectTech";
	document.updateForm.submit();
}
