<#import "../layout/loginLayout.ftl" as layout>
<@layout.myLayout>

<br/><br/>

<!-- To validate password -->
<script src="/static/js/validatePassword.js"></script>

<script>

function validateForm(o) {

	var blnPopover = true;
	var isError = true;

    var x = o.value;
    if (x==null || x=="" || x=="0" || x.length < 1) {
    	o.style.border = "1px solid red";
        isError = false;
    } else {
    	o.style.border = "";
    }

	return isError;
}

var timeout;
function interverKeystroke(o) {
	if(!validateForm(o)) {
		return false;
	}
	clearTimeout(timeout);
	timeout = setTimeout(function() {
	  console.log("You stopped typing.");
	  autoSearch(o);
	}, 500);
}


function autoSearch(o) {

	var userIdPara = '{"userId":"' + o.value + '"}';

	$(document).ready(function() {

        $.ajax({
            url: 'checkUserIdAjax',
            type: 'POST',
            dataType: "json",
            contentType: "application/json",
            data: userIdPara,
            cache: false,
            beforeSend: function(xhr, settings) {
            	xhr.setRequestHeader("Accept", "application/json");
//            	xhr.setRequestHeader("Content-Type", "application/json");
            	xhr.setRequestHeader("Cache-Control","no-cache, must-revalidate");
            	xhr.setRequestHeader("Pragma","no-cache");

            	console.log("before send");
            },
            success: function(data) {

            	console.log(data);

            	if(!isBlank(data.result)) {
            		// o.value = data.result;
            		if(data.result == "true") {
            			$('#ok-icon').removeClass('glyphicon-remove');
            			$('#ok-icon').addClass('glyphicon-ok');          			
            		} else {
            			$('#ok-icon').removeClass('glyphicon-ok');
            			$('#ok-icon').addClass('glyphicon-remove');
            		}
            	}

            },
            complete: function(xhr, textStatus) {
            	console.log("complete");
            },
            error: function(xhr, status, error) {
            	console.log("Error >> " + xhr.responseText + "\n" + status + "\n" + error);
            }
        });
	});
}
</script>

<style>

</style>

<#include "../common/errorMessage.ftl"/>

<form class="form-horizontal" role="form" action="/login/completeSingup" method="POST">
	<div class="form-group has-success has-feedback">
		<label for="inputUserId" class="col-sm-4 control-label">User Id</label>
		<div class="col-sm-5">
			<input id="inputUserId" name="userId" type="text" class="form-control" placeholder="User Id" aria-describedby="inputSuccess" onclick="releasPopover(this);" onkeydown="interverKeystroke(this);">
			<span id="ok-icon" class="glyphicon form-control-feedback" aria-hidden="true"></span>
			<span id="inputSuccess" class="sr-only">(success)</span>
		</div>
	</div>

	<div class="form-group">
		<label for="passwordId" class="col-sm-4 control-label">Password</label>
		<div class="col-sm-5">
	    	<input id="passwordId" name="password" type="password" class="form-control" 
	    		placeholder="User Password" onkeyup="validatePassword(this, 'pwdId1');" >
	    </div>
	    <p id="pwdId1" class="form-control-static"></p>
	</div>
	<div class="form-group">
		<label for="password2Id" class="col-sm-4 control-label">Password for confirm</label>
		<div class="col-sm-5">
			<input  id="password2Id" name="password2" type="password" class="form-control" 
				data-toggle="popover" data-trigger="manual" data-placement="bottom" 
					title="Passwords Do Not Match!" data-content="Please, check new password" onclick="releasPopover(this);"
						placeholder="For confirmation" onkeyup="validatePassword(this, 'pwdId2');">
		</div>
		<p id="pwdId2" class="form-control-static"></p>
	</div>
	<div class="form-group">
		<div class="col-sm-offset-4 col-sm-10">
			<button type="submit" class="btn btn-default" onclick="return validateConfirmePassword();">Sign in</button>
		</div>
	</div>
	<input type="hidden" name="ntoken" value="<#if model.userTemp??>${model.userTemp.userTempToken?if_exists}</#if>" />
</form>

<script>
function validateConfirmePassword() {
	var passwordId = document.getElementById("passwordId");
	var password2Id = document.getElementById("password2Id");

	if(passwordId.value != password2Id.value){
		// how to convert javascript object to jquery object
		var $inputs = $(password2Id);

        $inputs.css("border", "1px solid red");
        $inputs.popover('show');
        return false;
	}
	return true;
}
</script>
</@layout.myLayout>