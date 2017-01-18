<#import "../../layout/abilistsAdminLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<style>

</style>

<script>

$(document).ready(function(){
    $("#flip").click(function(){
        $("#newUserProjectForm").slideUp("slow");
    });
});

window.onload = function() {
	$("#newUserProjectForm").hide();
	$("#updateUserProjectForm").hide();

	//var task = document.getElementsByName("userTask");
	//selectUserTask(task[5], '8')

	console.log("window.onload");
}

function overChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function outChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function removeTask() {
	// Call the modal for deleting
	$(window).ready(function(){
		$('#submitFormDeleteTask').modal('show')
	});
}

</script>

<div class="item-box" style="margin-top: 15px;">
<div class="row">
	<div class="col-md-8">
		<h3>
			<ol class="breadcrumb-std">
			  <li><a href="/admin"><@spring.message "dashboard.title.home"/></a></li>
			  <li class="active"><@spring.message "menu.side.task.list"/></li>
			</ol>
		</h3>
	</div>
	<div class="col-md-4">
	</div>
</div>
</div>

<div class="row">
  	<div class="col-md-12">

	<#include "../../common/errorMessage.ftl"/>
	<div align="center" id="completeId" class="list-group-item list-group-item-danger">success</div>

	  <div class="caption mittle-size-title"><h4><@spring.message "menu.side.task.list"/></h4></div>
	  <form id="updateUserProjectForm" name="updateForm" class="form-horizontal" action="udtTask" method="post" id="updateFormId">
		<div class="row">
			<div class="col-xs-3 col-md-3 right-col-cus">
				<div class="item-box">
					<div>
						<img style="border-radius: 4px;" src="" id="userImgDataId" height="200px" width="190px;" alt="your picture" />
					</div>
		        </div>
			</div>
			<div class="col-xs-9 col-md-9 left-col-cus">
				<div class="item-box">

		  		  <div>
		  		  	<label class="control-label">Calander</label>
		  		  	<div class="input-group" style="width: 30%;">
		  		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>
		  		  		<span class="form-control" id="updateUtkWorkDayId" style="background-color: #ededed;"></span>
		  		  	</div>
			  	  </div>
			  	  <div>
		  			<label class="control-label">Today your task</label>
		  			<div class="input-group" style="width: 100%;">
		  				<span id="updateUtkTaskId"></span>
		  			</div>
			  	  </div>
				</div>
			</div>
		</div>
		<input type="hidden" id="utkNoId" name="utkNo" />

		<p align="center">
			<button class="btn btn-primary" type="button" onClick="updateFormCancel();"><@spring.message "project.button.close"/></button>
			<button class="btn btn-danger" type="button" onclick="removeTask()"><@spring.message "task.title.delete"/></button>
		</p>
	  </form>

	  <div class="item-box">
		<table id="userTaskId" class="table table-striped">
	      <thead>
	        <tr>
	          <th><@spring.message "task.title.no"/></th>
	          <th><@spring.message "task.title.workday"/></th>
	          <th><@spring.message "task.title.task"/></th>
	          <th><@spring.message "task.title.status"/></th>
	          <th><@spring.message "task.title.update"/></th>
	        </tr>
	      </thead>
	      <tbody>

	      <#if model??>
	      <#if model.userTaskList?has_content>
	      <#list model.userTaskList as userTask>
	      <tr name="userTask" onmouseover="overChangeColor(this);" onmouseout="outChangeColor(this);" onclick="selectUserTask(this, '${userTask.utkWorkDay?string('yyyy-MM-dd')?if_exists}', '${userTask.userId?if_exists}');">
	      	<td>${userTask.utkNo?if_exists}</td>
	      	<td>${userTask.utkWorkDay?string('yyyy-MM-dd')?if_exists}</td>
	      	<td class="text-left">${userTask.utkTask?if_exists}.....</td>
	      	<td>${userTask.status?if_exists}</td>
	      	<td>${userTask.updateTime?string('yyyy-MM-dd')?if_exists}</td>
	      </tr>
	      </#list>
	      </#if>
	      </#if>
	      </tbody>
	      </table>
      </div><!-- item-box -->

      <nav class="text-center">
	    <ul class="pagination">
	    <#if model?exists>
      	<#if model.paging?exists>
			<#if model.paging.prevPage?exists>
			<li><a href="sltTaskList?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="sltTaskList?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="sltTaskList?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
			</#if>
		</#if>
		</#if>
      	</ul>
      </nav><!-- end #nav -->

	</div><!-- col-md-12 -->
</div><!-- row -->


<!-- Delete Modal -->
<div class="modal fade" id="submitFormDeleteTask" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <h4 class="modal-title" id="dltTaskTileId"><@spring.message "projects.title.modal"/></h4>
    </div>

    <div id="confirmMessage" class="modal-body">
    	<@spring.message "projects.confirm.message.delete"/>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal"><@spring.message "projects.button.close"/></button>
      <button id="submitForm" type="button" class="btn btn-danger" onclick="javascript: submitDeleteFormTask();"><@spring.message "projects.button.delete"/></button>
    </div>
  </div>
</div>
</div>


<script type="text/javascript"> 

var ajaxLastNum = 0;

var table = document.getElementById("userTaskId");
var tr = table.getElementsByTagName("tr");

function clearBackGroundColor() {
	for(var j=0; j< tr.length; j++) {
		tr[j].style.backgroundColor = "";
	}
}

var utkNoInput = document.getElementById("utkNoId");
var utkWorkDayInput = document.getElementById("updateUtkWorkDayId");
var utkTaskInput = document.getElementById("updateUtkTaskId");
var userImgDataInput = document.getElementById("userImgDataId");

function selectUserTask(x, day, userId) {

	clearBackGroundColor();

	$(document).ready(function() {

		var availableKeys;
		var currentAjaxNum = ajaxLastNum;

        $.ajax({
            type: 'POST',
            url: 'sltTaskAjax',
            contentType: "application/json",
            dataType: "json",
            data: '{ "utkWorkDay" : "' + day + '", "userId" : "' + userId + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	if(!isBlank(data)) {

            		// Sequence Number
            		utkNoInput.value = data.userTask.utkNo;

            		// Work Day
            		var workDay = new Date(data.userTask.utkWorkDay);
            		// utkWorkDayInput.value = workDay.toISOString().substr(0,10);
            		var dd = workDay.getDate();
            		// January is 0!
            		var mm = workDay.getMonth()+1;
            		var yyyy = workDay.getFullYear();
            		if(dd<10){
            		    dd='0'+dd
            		} 
            		if(mm<10){
            		    mm='0'+mm
            		} 
            		var today = yyyy + '-' + mm + '-' + dd;
            		utkWorkDayInput.innerHTML = today;

            		// Task for report
            		utkTaskInput.innerHTML = data.userTask.utkTask;
            		// Set your image
            		userImgDataInput.src = data.userImgData;
            	}
            },
            complete: function(xhr, textStatus) {
            	console.log("complete");

            	// Set a task title into Model
            	var dltTaskTileId = document.getElementById("dltTaskTileId");
            	dltTaskTileId.innerHTML = utkWorkDayInput.innerHTML;

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

	utkNoInput.value = "";
	utkWorkDayInput.value = "";
	utkTaskInput.value = "";

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

function submitNewFormUserTask() {
	document.newForm.submit();
}

function submitUpdateFormUserTask() {
	document.updateForm.submit();
}

/*
 * Remove a task
 */
function submitDeleteFormTask() {
	document.updateForm.action = "/admin/project/dltTask";
	document.updateForm.submit();
}

</script>

<#include "../../common/abilistsFooder.ftl"/>

</@layout.myLayout>