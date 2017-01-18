<#import "../../layout/abilistsAdminLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<style>

</style>

<script type="text/javascript">

$(document).ready(function(){
    $("#flip").click(function(){
        $("#newUserProjectForm").slideUp("slow");
    });
});

window.onload = function() {
	$("#newUserProjectForm").hide();
	$("#updateUserProjectForm").hide();
}

function removeNoti(obj) {
	document.updateForm.action = "dltNoti";
	document.updateForm.submit();
}


function validateForm(tableName) {

	var blnPopover = true;
	var isError = true;

	var table = document.getElementById(tableName);
	var inputTag = table.getElementsByTagName("input");

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

/*
 * Make the table on the Modal for confirming the data.
 */
function confirmData(tableName) {

	if(!validateForm(tableName)) {
		return;
	}

	// Call the modal
	$(window).ready(function(){
		$('#submitFormNoti').modal('show')
	});

	if(tableName == "newFormId") {
		document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitNewForm();" );		  
	} else {
		document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitUpdateForm();" );
	}

}

/*
 * For select tag
 */
$(document).ready(function(){

	var selectTarget = $('.selectbox select');

	selectTarget.on('blur', function(){
		$(this).parent().removeClass('focus');
	});

	selectTarget.change(function(){
		var select_name = $(this).children('option:selected').text();

		$(this).siblings('label').text(select_name);
		});
	});


function removeNoti() {
	// Call the modal for deleting
	$(window).ready(function(){
		$('#submitFormDeleteNotiId').modal('show')
	});
}

</script>

<div class="item-box" style="margin-top: 15px;">
<div class="row">
	<div class="col-md-8">
		<h3>
			<ol class="breadcrumb-std">
			  <li><a href="/admin"><@spring.message "dashboard.title.home"/></a></li>
			  <li class="active"><@spring.message "admin.menu.notification"/></li>
			</ol>
		</h3>
	</div>
	<div class="col-md-4">
		<span id="newToggleId" class="glyphicon glyphicon-chevron-down add-symbol" style="color:#337ab7;" aria-hidden="true" onClick="newFormToggle();"></span>
	</div>
</div>
</div>

<div class="row">
  <div class="col-md-12">

	<#include "../../common/errorMessage.ftl"/>
	<div align="center" id="completeId" class="list-group-item list-group-item-danger">complete</div>

	<div class="item-box" id="newUserProjectForm">
	<form name="newForm" class="form-horizontal" action="/admin/noti/istNoti" method="post" id="contact_form" onkeypress="return captureReturnKey(event);">
		<table id="newFormId" style="width:100%">
			<tr>
				<td width="10%"><@spring.message "noti.title.title"/></td>
				<td>
					<input class="form-control input-sm" style="width:100%" name="notiTitle" type="text" placeholder="title"/>
				</td>
				<td width="10%"><@spring.message "noti.title.kind"/></td>
			</tr>
			<tr>
				<td><@spring.message "noti.title.contents"/></td>
				<td>
					<textarea class="form-control" name="notiContents" placeholder="contents" rows="1"></textarea>
				</td>
				<td>
					<select name="notiKind">
						<option value='<@spring.message "noti.kind.all"/>'><@spring.message "noti.kind.all"/></option>
						<option value='<@spring.message "noti.kind.admin"/>'><@spring.message "noti.kind.admin"/></option>
						<option value='<@spring.message "noti.kind.info"/>'><@spring.message "noti.kind.info"/></option>
						<option value='<@spring.message "noti.kind.note"/>'><@spring.message "noti.kind.note"/></option>
					</select>
				</td>
			</tr>
		</table>
		<br/>
		<p align="center">
			<button type="button" onclick="return confirmData('newFormId');" class="btn btn-primary" data-toggle="modal"><@spring.message "noti.button.confirm"/></button>
			<button class="btn btn-primary" type="button" onClick="newFormCancel();"><@spring.message "noti.button.cancel"/></button>
		</p>
	</form>
	</div>

	<div class="item-box" id="updateUserProjectForm">
	<form name="updateForm" class="form-horizontal" action="/admin/noti/udtNoti" method="post" id="contact_form" onkeypress="return captureReturnKey(event);">

		<table id="updateForm" style="width:100%">
		<tr>
			<td width="10%"><@spring.message "noti.title.title"/></td>
			<td>
				<input class="form-control input-sm" id="notiTitleId" style="width:100%" name="notiTitle" type="text" placeholder="title"/>
			</td>
			<td width="10%"><@spring.message "noti.title.kind"/></td>
		</tr>
		<tr>
			<td><@spring.message "noti.title.contents"/></td>
			<td>
				<textarea class="form-control" id="notiContentsId" name="notiContents" placeholder="contents" rows="1"></textarea>
			</td>
			<td>
				<select id="notiKindId" name="notiKind">
					<option value="">Kind</option>
					<option value="admin">admin</option>
					<option value="info">info</option>
					<option value="ad">ad</option>
				</select>
			</td>
		</tr>
		</table>
		<input type="hidden" id="notiNoId" name="notiNo" />
		<br/>
		<p align="center">
			<button type="button" onclick="return confirmData('updateForm');" class="btn btn-primary" data-toggle="modal">
				<@spring.message "noti.button.confirm"/>
			</button>
			<button class="btn btn-primary" type="button" onClick="updateFormCancel();">
				<@spring.message "noti.button.cancel"/>
			</button>
			<button type="button" class="btn btn-danger" style="width: 80px;" onclick="javascript: removeNoti();">
				<@spring.message "noti.button.delete"/>
			</button>
		</p>
	</form>
	</div>

	<div class="item-box">
	<table id="userProjectsId" class="table table-striped">
      <thead>
        <tr>
          <th>#</th>
          <th><@spring.message "noti.title.title"/></th>
          <th><@spring.message "noti.title.contents"/></th>
          <th><@spring.message "noti.title.kind"/></th>
          <th><@spring.message "noti.title.udate"/></th>
        </tr>
      </thead>
      <tbody>

      <#if model??>
      <#if model.notificationList?has_content>
      <#list model.notificationList as noti>
      <tr onmouseover="overChangeColor(this);"  onmouseout="outChangeColor(this);" onclick="selectMTech(this, '${noti.notiNo?if_exists}');">
      	<td>${noti.notiNo?if_exists}</td>
      	<td>${noti.notiTitle?if_exists}</td>
      	<td>${noti.notiContents?if_exists}</td>
      	<td>${noti.notiKind?if_exists}</td>
      	<td>${noti.updateTime?string('dd/MM/yyyy')?if_exists}</td>
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
			<li><a href="sltNotiList?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="sltNotiList?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="sltNotiList?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
			</#if>
		</#if>
	  </#if>
      </ul>
      </nav><!-- end #nav -->

   </div><!-- #col-md-12 -->
</div><!-- end #content -->


<!-- Modal -->
<div class="modal fade" id="submitFormNoti" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel"><@spring.message "noti.modal.title"/></h4>
      </div>

      <div id="confirmMessage" class="modal-body">
      	<@spring.message "noti.modal.message"/>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><@spring.message "noti.button.close"/></button>
        <button id="submitForm" type="button" class="btn btn-primary"><@spring.message "noti.button.save"/></button>
      </div>
    </div>
  </div>
</div>

<!-- Delete Modal -->
<div class="modal fade" id="submitFormDeleteNotiId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <h4 class="modal-title" id="dltMasterDataId"><@spring.message "projects.title.modal"/></h4>
    </div>

    <div id="confirmMessage" class="modal-body">
    	<@spring.message "projects.confirm.message.delete"/>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">
      	  <@spring.message "noti.button.close"/>
      </button>
      <button id="submitForm" type="button" class="btn btn-danger" onclick="javascript: submitFormDeleteNoti();">
      	  <@spring.message "noti.button.delete"/>
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

var notiNoInput = document.getElementById("notiNoId");
var notiTitleInput = document.getElementById("notiTitleId");
var notiContentsInput = document.getElementById("notiContentsId");
var notiKindInput = document.getElementById("notiKindId");

function selectMTech(x, num) {

	clearBackGroundColor();
	var paraJson = '{"notiNo" : "' + num + '"}';

	$(document).ready(function() {

		var availableKeys;
		var currentAjaxNum = ajaxLastNum;

        $.ajax({
            type: 'POST',
            url: '/admin/noti/sltNotiAjax',
            contentType: "application/json",
            dataType: "json",
            data: paraJson,
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {

            	if(!isBlank(data)) {
            		notiNoInput.value = data.notiNo;
            		notiTitleInput.value = data.notiTitle;
            		notiContentsInput.value = data.notiContents;
            		notiKindInput.value = data.notiKind;
            	}
            },
            complete: function(xhr, textStatus) {
            	console.log("complete");
            	formSlideDown();
            	newFormCancel();

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

function newFormToggle() {

	$("#newUserProjectForm").slideToggle("slow");
	$("#newToggleId").toggleClass('glyphicon-chevron-down glyphicon-chevron-up');
	notiNoInput.value = "";
	notiTitleInput.value = "";
	notiContentsInput.value = "";
	notiKindInput.value = "";

	clearBackGroundColor();
	updateFormCancel();
}

function formSlideDown() {
	$("#updateUserProjectForm").slideDown("slow");
}

function newFormCancel() {
	$("#newUserProjectForm").slideUp("slow");
	$("#newToggleId").addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-up');
	clearBackGroundColor();
}

function updateFormCancel() {
	$("#updateUserProjectForm").slideUp("slow");
	$("#newToggleId").addClass('add-symbol');
	clearBackGroundColor();
}


function submitNewForm() {
	document.newForm.submit();
}

function submitUpdateForm() {
	document.updateForm.submit();
}

//Delete noti
function submitFormDeleteNoti() {
	document.updateForm.action = "/admin/noti/dltNoti";
	document.updateForm.submit();
}

</script>

<#include "../../common/abilistsFooder.ftl"/>

</@layout.myLayout>