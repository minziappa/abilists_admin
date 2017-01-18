<#import "../layout/abilistsLayout.ftl" as layout>
<@layout.myLayout>

<br/><br/>

<#include "../common/errorMessage.ftl"/>

<form class="form-horizontal" role="form" action="/login/completeConfirm" method="POST">
	<div class="form-group">
		<label for="inputUserId" class="col-sm-3 control-label">User Id</label>
		<div class="col-sm-5">
			<input id="inputUserId" name="userId" type="text" class="form-control" placeholder="User Id">
		</div>
	</div>
	<div class="form-group">
		<label for="inputPassword1" class="col-sm-3 control-label">Password</label>
		<div class="col-sm-5">
	    	<input id="inputPassword1" name="password" type="password" class="form-control" placeholder="User Password">
	    </div>
	</div>
	<div class="form-group">
		<label for="inputPassword2" class="col-sm-3 control-label">Password for confirm</label>
		<div class="col-sm-5">
			<input  id="inputPassword2" name="password2" type="password" class="form-control"placeholder="For confirmation">
		</div>
	</div>
	<div class="form-group">
		<div class="col-sm-offset-3 col-sm-10">
		<button type="submit" class="btn btn-default">Sign in</button>
		</div>
	</div>
	<input type="hidden" name="userTempToken" value="<#if model.userTemp??>${model.userTemp.userTempToken?if_exists}</#if>" />
</form>

</@layout.myLayout>