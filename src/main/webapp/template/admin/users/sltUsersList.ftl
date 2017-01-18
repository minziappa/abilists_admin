<#import "../../layout/abilistsAdminLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<!-- These are needed for Autocompliete to input a input form. -->
<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">

<script type="text/javascript">

window.onload = function() {
	$("#updateUserProjectForm").hide();
}

/*
 * Make the table on the Modal for confirming the data.
 */
function confirmData(tableName) {

	// Call the modal
	$(window).ready(function(){
		$('#submitFormUsers').modal('show')
	});

	var table1 = document.getElementById(tableName);
	// Create a table on Motal 
	var table3 = document.getElementById("t03");

	var row11, row12, row31, row32;

	row11 = table1.rows[0];
	row12 = table1.rows[1];
	row31 = table3.rows[0];
	row32 = table3.rows[1];

	var selectUserAuth;
	var selectUserStatus;

	selectUserAuth = row11.cells[5].getElementsByTagName("select")[0];
	var userAuthHtml = selectUserAuth.options[selectUserAuth.selectedIndex].text;
	row31.cells[1].innerHTML = userAuthHtml;

	selectUserStatus = row12.cells[5].getElementsByTagName("select")[0];
	var userStatusHtml = selectUserStatus.options[selectUserStatus.selectedIndex].text;
	row32.cells[1].innerHTML = userStatusHtml;

}

</script>


<script src="/static/js/search.js"></script>
<link href="/static/css/search.css" rel="stylesheet">


<div class="item-box" style="margin-top: 15px;">
<div class="row">
	<div class="col-md-6">
	  <h3>
		<ol class="breadcrumb-std">
		  <li><a href="/admin"><@spring.message "dashboard.title.home"/></a></li>
		  <li class="active"><@spring.message "admin.menu.users"/></li>
		</ol>
	  </h3>
	</div>
	<div class="col-md-6">
	<form id="searchForm" action="/admin/users/searchForUsers" method="post" onkeydown="return captureReturnKey(event)">
	    <div id="search0" class="input-group">
		    <input name="userId" type="text" class="form-control" 
		    	value="" autocomplete="off" autocorrect="off" autocapitilize="off"
		    		data-toggle="popover" data-trigger="manual" data-placement="top" 
		    			title="Popover title" data-content="Default popover"
		    				placeholder="Search for..." onkeydown="interverKeystroke(event, 0);">
		    <span class="input-group-btn">
		      <button class="btn btn-default" style="height: 34px;" type="submit"><i class="glyphicon glyphicon-search"></i></button>
		    </span>
	    </div><!-- /input-group -->
	</form>
	</div>
</div>
</div>

<div class="row">
  <div class="col-md-12">

	<#include "../../common/errorMessage.ftl"/>
	<div align="center" id="completeId" class="list-group-item list-group-item-danger">complete</div>

	<div class="caption mittle-size-title"><h4><@spring.message "admin.menu.users"/></h4></div>
	<form id="updateUserProjectForm" name="updateForm" class="form-horizontal" action="udtUsers" method="post" id="contact_form" onkeypress="return captureReturnKey(event);">
	<div class="row">
		<div class="col-xs-3 col-md-3 right-col-cus">
			<div class="item-box">
				<div>
					<img style="border-radius: 4px;" src="" id="userImgDataId" height="200px" width="190px;" alt="your picture" />
				</div>
				<table style="width:100%; margin-top: 5px;">
				<tr>
					<td width="10%"><@spring.message "user.title.id"/></td>
					<td><span id="userIdId"></span></td>
				</tr>
				<tr>
					<td><@spring.message "user.title.name"/></td>
					<td><span id="userNameId"></span></td>
				</tr>
				</table>
	        </div>
		</div>

		<div class="col-xs-9 col-md-9 left-col-cus">
			<div class="item-box">
				<table id="updateTable" style="width:100%">
				<tr>
					<td width="10%"><@spring.message "user.title.sex"/></td>
					<td><span id="userSexId"></span></td>
					<td width="10%"><@spring.message "user.title.email"/></td>
					<td><span id="userEmailId"></span></td>
					<td width="10%"><@spring.message "user.title.auth"/></td>
					<td width="25%">
			            <select class="form-control" id="userAuthId" name="userAuth" style="width: 100%;">
				            <option value="1"><@spring.message "auth.select.user"/></option>
				            <option value="2"><@spring.message "auth.select.semi.admin"/></option>
				            <option value="3"><@spring.message "auth.select.super.admin"/></option>
			            </select>
					</td>
				</tr>
				<tr>
					<td>insertTime</td>
					<td><span id="insertTimeId"></span></td>
					<td width="10%"><@spring.message "user.title.ages"/></td>
					<td><span id="userAgesId"></span></td>
					<td width="10%"><@spring.message "user.title.status"/></td>
					<td width="15%">
			            <select class="form-control" id="userStatusId" name="userStatus" style="width: 100%;">
			            	<option value="0"><@spring.message "user.status.use"/></option>
				            <option value="1"><@spring.message "user.status.sleep"/></option>
				            <option value="2"><@spring.message "user.status.stop"/></option>
			            </select>
		            </td>
				</tr>
				<tr>
					<td>Profile</td>
					<td colspan="5"><span id="userProfileId"></span></td>
				</tr>
				<input type="hidden" id="inputUserId" name="userId" />
				</table>
				<br/>
				<p align="center">
					<button type="button" onclick="return confirmData('updateTable');" class="btn btn-primary" data-toggle="modal">
						<@spring.message "noti.button.confirm"/>
					</button>
					<button class="btn btn-primary" type="button" onClick="updateFormCancel();">
						<@spring.message "noti.button.cancel"/>
					</button>
				</p>
			</div><!--item-box-->
		</div><!--col-sm-9 left-col-cus-->
	</div><!--row-->
	</form>

	  <div class="item-box">
		<table id="userProjectsId" class="table table-striped">
	      <thead>
	        <tr>
	          <th>#</th>
	          <th><@spring.message "user.title.id"/></th>
	          <th><@spring.message "user.title.name"/></th>
	          <th><@spring.message "user.title.auth"/></th>
	          <th><@spring.message "user.title.sex"/></th>
	          <th><@spring.message "user.title.email"/></th>
	          <th><@spring.message "user.title.ages"/></th>
	          <th><@spring.message "user.title.status"/></th>
	        </tr>
	      </thead>
	      <tbody>

	      <#if model??>
	      <#if model.usersList?has_content>
	      <#list model.usersList as user>
	        <tr onmouseover="overChangeColor(this);"  onmouseout="outChangeColor(this);" onclick="sltUsers(this, '${user.userId?if_exists}');">
	        	<td>${user.userNo?if_exists}</td>
	        	<td><a href="/profile/${user.userId?if_exists}">${user.userId?if_exists}</a></td>
	        	<td>${user.userName?if_exists}</td>
	        	<td>
	        	<#if user.userAuth??>
	        		<#if user.userAuth == "2">
	        		<@spring.message "auth.select.semi.admin"/>
	        		<#elseif user.userAuth == "3">
	        		<@spring.message "auth.select.super.admin"/>
	        		<#else>
	        		<@spring.message "auth.select.user"/>
	        		</#if>
	        	</#if>
	        	</td>
	        	<td>
	            <#if user.userSex??>
	              <#if user.userSex == "1">
	              	<@spring.message "user.sex.man"/>
	              <#elseif user.userSex == "2">
	              	<@spring.message "user.sex.woman"/>
	              <#else>
	              </#if>
	            </#if>
	        	</td>
	        	<td>${user.userEmail?if_exists}</td>
	        	<td>${user.userAges?if_exists}</td>
	        	<td>
	        	  <#if user.userStatus??>
	        		<#if user.userStatus == "1">
	        		<@spring.message "user.status.sleep"/>
	        		<#elseif user.userStatus == "2">
	        		<@spring.message "user.status.stop"/>
	        		<#else>
	        		<@spring.message "user.status.use"/>
	        		</#if>
	        	  </#if>
	        	</td>
	        </tr>
	        </#list>
	        </#if>
	        </#if>

	      </tbody>
	    </table>
	  </div>

	  <nav class="text-center">
	    <ul class="pagination">
	  <#if model?exists>
	  	<#if model.paging?exists>
			<#if model.paging.prevPage?exists>
			<li><a href="/admin/users/sltUsersList?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="/admin/users/sltUsersList?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="/admin/users/sltUsersList?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
			</#if>
		</#if>
	  </#if>
	  	</ul>
	  </nav><!-- end #nav -->

  </div><!-- #col-md-12 -->
</div><!-- #row -->

<!-- Modal -->
<div class="modal fade" id="submitFormUsers" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel"><@spring.message "task.title.modal"/></h4>
      </div>

      <div id="confirmMessage" class="modal-body">
		<table id="t03" style="width:100%">
		<tr>
			<td>Auth</td>
			<td></td>
		</tr>
		<tr>
			<td>Status</td>
			<td></td>
		</tr>
		</table>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">
        	<@spring.message "user.button.close"/>
        </button>
        <button id="submitForm" type="button" class="btn btn-primary" onClick="javascript: submitUpdateFormUser();">
        	<@spring.message "user.button.save"/>
        </button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript"> 

var ajaxLastNum = 0;

var table = document.getElementById("userProjectsId");
var tr = table.getElementsByTagName("tr");

function clearBackGroundColor() {
	for(var j=0; j< tr.length; j++) {
		tr[j].style.backgroundColor = "";
	}
}


var inputUserIdInput = document.getElementById("inputUserId");
var userIdInput = document.getElementById("userIdId");
var userAuthInput = document.getElementById("userAuthId");
var userNameInput = document.getElementById("userNameId");
var userSexInput = document.getElementById("userSexId");
var userEmailInput = document.getElementById("userEmailId");
var userAgesInput = document.getElementById("userAgesId");
var userProfileInput = document.getElementById("userProfileId");
var userImgDataInput = document.getElementById("userImgDataId");
var userStatusInput = document.getElementById("userStatusId");

function sltUsers(x, userId) {

	clearBackGroundColor();
	var paraJson = '{"userId" : "' + userId + '"}';

	$(document).ready(function() {

		var availableKeys;
		var currentAjaxNum = ajaxLastNum;

        $.ajax({
            type: 'POST',
            url: '/admin/users/sltUsersAjax',
            contentType: "application/json",
            dataType: "json",
            data: paraJson,
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	console.log(data);
            	if(!isBlank(data)) {
            		inputUserIdInput.value = data.userId;
            		userIdInput.innerHTML = data.userId;
            		userAuthInput.value = data.userAuth;
            		userNameInput.innerHTML = data.userName;
            		userSexInput.innerHTML = data.userSex;
            		userEmailInput.innerHTML = data.userEmail;
            		userAgesInput.innerHTML = data.userAges;
            		userProfileInput.innerHTML = data.userProfile;
            		userImgDataInput.src = data.userImgData;
            		userStatusInput.value = data.userStatus;
            	}
            },
            complete: function(xhr, textStatus) {
            	console.log("complete");
            	formSlideDown();

            	x.style.backgroundColor = "#9999CC";
            },
            error: function(xhr, status) {
            	console.log("error >> " + xhr.responseText);
                var contentType = xhr.getResponseHeader("Content-Type");
                if (xhr.status === 200 && contentType.toLowerCase().indexOf("text/html") >= 0) {
                    // Login has expired - reload our current page
                    window.location.reload();
                }
            }
        });
	});
}

function formSlideDown() {
	$("#updateUserProjectForm").slideDown("slow");
}

function updateFormCancel() {
	$("#updateUserProjectForm").slideUp("slow");
	clearBackGroundColor();
}

function submitUpdateFormUser() {
	document.updateForm.submit();
}

</script>

<#include "../../common/abilistsFooder.ftl"/>

</@layout.myLayout>