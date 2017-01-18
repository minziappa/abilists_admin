<#import "../layout/loginLayout.ftl" as layout>
<@layout.myLayout>

<br/><br/>
<!-- To validate password -->
<script src="/static/js/validatePassword.js"></script>

<style>
</style>

<form name="form" class="form-horizontal" action="/login/completeResetPwd" method="POST">

	<div class="form-group">
		<label for="userIdId" class="col-sm-4 control-label">User Id</label>
		<div class="col-sm-5">
			UserId
		</div>
		<p id="pwdId1" class="form-control-static"></p>
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
		<label class="col-sm-4 control-label">*</label>
		<div class="col-sm-5">
		 Please input new password 
	    </div>
	</div>

	<div class="form-group">
		<div class="col-sm-offset-4 col-sm-10">
			<button type="submit" class="btn btn-default" onclick="return validateConfirmePassword();">Update password</button>
		</div>
	</div>

	<input type="hidden" name="token" value="<#if model??>${model.token?if_exists}</#if>" />
	<input type="hidden" name="ntoken" value="${ntoken?if_exists}" />
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