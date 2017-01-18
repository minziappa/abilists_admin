<#import "../layout/loginLayout.ftl" as layout>
<@layout.myLayout>

<br/><br/>
<!-- To validate password -->
<script src="/static/js/validatePassword.js"></script>

<form name="form" class="form-horizontal" action="/login/introResetPwd" method="POST">
	<div class="form-group has-success has-feedback">
		<label for="inputSuccess" class="col-sm-4 control-label">Your Email</label>
		<div class="col-sm-5">
			<input id="userEmailId" name="userEmail" type="text" class="form-control" 
				data-toggle="popover" data-trigger="manual" data-placement="top" 
					title="Your Email" data-content="Please, input your email"
						placeholder="your email" onclick="releasPopover(this);">
			<span id="ok-icon" class="glyphicon form-control-feedback" aria-hidden="true"></span>
			<span id="inputSuccess" class="sr-only">(success)</span>
		</div>
	</div>

	<div class="form-group">
		<label class="col-sm-4 control-label">*</label>
		<div class="col-sm-5">
		 We will sned an email to your email address. Click the link in the email to reset your password. <br/>
		 If you don't see the email, check other places it might be, like your junk, spam, social, or other folders. 
	    </div>
	</div>

	<div class="form-group">
		<div class="col-sm-offset-4 col-sm-10">
			<button type="submit" class="btn btn-default" onclick="return validateEmail();">Send email</button>
		</div>
	</div>

	<input type="hidden" name="token" value="<#if model??>${model.token?if_exists}</#if>" />
</form>

<script>

var email = document.getElementById("userEmailId");
function validateEmail() {
	// how to convert javascript object to jquery object
	var $inputs = $(email);

	if(!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email.value)){
		console.log(email.value);

        $inputs.css("border", "1px solid red");
        $inputs.popover('show');
		return false;
	}

    return true;
}

</script>

</@layout.myLayout>