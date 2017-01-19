<#import "../../layout/loginLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<style>

div.transbox {
	// position: relative;
	padding: 1%;
	// z-index: 1;
	width: 80%;
	height: 40%;
	margin: auto;
}

div.transbox p {
	position: relative;
	width: 70%;
	margin: 1%;
	color: #000000;
	padding: 10px; 
}

h2 span { 
	   color: #ff6600; 
	   font: bold 24px/45px Helvetica, Sans-Serif; 
	   letter-spacing: -1px;  
	   background: rgb(0, 0, 0); /* fallback color */
	   background: rgba(0, 0, 0, 0.7);
	   padding: 10px; 
	}

.bgIndex {
	// position: relative;
    background: url('/static/img/bgIndex.jpg') no-repeat center center fixed;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    background-size: cover;
	background-color: #ff6600;
    -o-background-size: cover;
	padding-top: 50px;
	padding-bottom: 50px;
}
</style>
<div class="bgIndex">
	<div class="transbox">
		<div class="row">
			<div class="col-sm-6">
				<form class="form-signin" role="form" action="/admin/login/login" name="sform" id="sform" method="POST">
					<h2 class="form-signin-heading"><@spring.message "login.sign.in"/></h2>
					<#include "../../common/errorMessage.ftl"/>
			        <input  type="text" name="userId" class="form-control" placeholder="user id" required autofocus>
			        <input type="password" name="userPwd" class="form-control" placeholder="password" required>
			        
			  	    <div class="checkbox"><a href="/login/introResetPwd"><@spring.message "login.forgot.password"/></a></div>
			        <button class="btn btn-primary btn-block" type="submit"><@spring.message "login.sign.in"/></button>
		        </form>
			</div>
			<div class="col-sm-6">
			    <form class="form-signin" role="form" action="/login/introSingup" method="POST">
			  	    <h2 class="form-signin-heading"><@spring.message "login.sign.up"/></h2>
			  	    <input  type="text" name="userEmail" class="form-control" placeholder="Email address" required>
			  	    <div class="checkbox"></div>
			  	    <button class="btn btn-primary btn-block" type="submit"><@spring.message "login.sign.up"/></button>
		  	    </form>
			</div>
		</div>
	</div>
</div>
</@layout.myLayout>