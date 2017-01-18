
$(document).ready(function(){
    $("#flip").click(function(){
        $("#newUserProjectForm").slideUp("slow");
    });
});

window.onload = function() {
	$("#newUserProjectForm").hide();
	$("#updateUserProjectForm").hide();
	console.log("window.onload");
}

function overChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function outChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function removeProject() {
	// Call the modal for deleting
	$(window).ready(function(){
		$('#submitFormDeleteProjects').modal('show')
	});
}

function validateForm(tableName) {

	var blnPopover = true;
	var isError = true;

	var table = document.getElementById(tableName);

	var inputTag = table.getElementsByTagName("input");
	if(!validateField(inputTag)) {
		return false;
	}

	/**
	var selectTag = table.getElementsByTagName("select");
	if(!validateField(selectTag)) {
		return false;
	}
	*/

	return true;
}
