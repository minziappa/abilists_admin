<#import "../layout/abilistsLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<!-- Morris.js-0.5.1 -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.2/raphael-min.js"></script>
<script src="/static/lib/morris.js-0.5.1/morris.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/prettify/r224/prettify.min.js"></script>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/prettify/r224/prettify.min.css">
<link href="/static/lib/morris.js-0.5.1/morris.css" rel="stylesheet">

<!-- Time Line -->
<link href="/static/css/timeline.css" rel="stylesheet">

<style>
.title-box-line {
	border-top: 1px solid #ccc;
	border-left: 1px solid #ccc;
	border-right: 1px solid #ccc;
	box-shadow-left: 1px 1px 2px #eee;
	border-radius: 2px;
	padding: 10px;
    position: relative;
	background: #f2f2f2;
}

.default-box-line {
    border: 1px solid #ccc;
    box-shadow: 1px 1px 2px #eee;
    margin: 15px 0;
    padding: 15px;
	border-radius: 1px;
    position: relative;
}

.changeBgcolor:hover {
	border-top: 1px solid #FFFFFF;
	border-left: 1px solid #FFFFFF;
	border-right: 1px solid #9395C7;
	border-bottom: 1px solid #9395C7;
    background-color: #E3E4FF;
}

.navbar {
	margin-bottom: 5px;
}

.graph-box {
    border: 1px solid #ccc;
    box-shadow: 1px 1px 2px #eee;
    margin: 10px 0;
    padding: 30px;
    position: relative;
}

.summary {
	display: table-cell;
	vertical-align: top;
}

.thumbnail-hover img {
    position: relative;
    transition: all 0.8s ease-in-out 0s;
}

.thumbnail-hover:hover img {
    transform: scale(1.2) rotate(2deg);
}

ul.top_profiles {
    width: 100%;
}

ul.top_profiles li:nth-child(2n+1) {
    background-color: #f7f7f7;
}

.profile-div-right {
	padding-top: 15px !important;
	border-width: 0px 0px 0px 0px !important;
}
body.modal-open {
    overflow: visible;
    position: absolute;
    width: 100%;
    height:100%;
}

div.sm-margin-right {
	margin-right: 10px;
}

li.margin5-top {
	margin-top: 5px;
}

</style>

<script>
function viewTask(day) {
	// Call the modal
	$(window).ready(function(){
		// Only ones
		//$('div.modal').modal({remote : 'abilists/viewProjects/' + num});
		// Not only one
		$("#popupView").load("abilists/viewTask/" + day, function() {
			$('div.modal').modal('show');
		});
	});
}

function viewNoti(num) {
	// Call the modal
	$(window).ready(function(){
		// Only ones
		//$('div.modal').modal({remote : 'abilists/viewProjects/' + num});
		$("#popupView").load("abilists/viewNoti/" + num, function() {
			$('div.modal').modal('show');
		});
	});
}

function viewProject(num) {
	// Call the modal
	$(window).ready(function(){
		$("#popupView").load("abilists/viewProjects/" + num, function() {
			$('div.modal').modal('show');
		});
	});
}

$( function() {
  $( "#utkWorkDayId" ).datepicker({
      showButtonPanel: true, 
      currentText: '<@spring.message "calendar.day.today"/>', 
      closeText: '<@spring.message "calendar.day.close"/>',
      dateFormat: "yy-mm-dd",
      nextText: '<@spring.message "calendar.day.next.month"/>',
      prevText: '<@spring.message "calendar.day.previous.month"/>',
      dayNames: [<@spring.message "calendar.day.name"/>],
      dayNamesMin: [<@spring.message "calendar.day.name.min"/>]
  });

});


function addProjectName(x) {
	var utkTaskId = document.getElementById("utkTaskId");
	var project = "[" + x.options[x.selectedIndex].text + "] \r\r" +utkTaskId.value;
	utkTaskId.value = project;
}

function clearTask() {
	var utkTaskId = document.getElementById("utkTaskId");
	utkTaskId.value = "";
}


function validateForm(formName) {

	var blnPopover = true;
	var isError = true;

	var table = document.getElementById(formName);
	var selectTag = table.getElementsByTagName("textarea");

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
function confirmData(formName) {

	if(!validateForm(formName)) {
		return false;
	}
	var taskForm = document.getElementById(formName);
	taskForm.submit();
}


</script>

<div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="popupView" >
    </div>
  </div>
</div>

<div class="row" style="margin-top: 15px;">
	<div class="col-md-6 right-col-cus">
		<div class="caption mittle-size-title"><h4><@spring.message "home.title.task"/></h4></div>
		<div class="item-box">

			<form id="taskFormId" class="form-horizontal" action="/task/udtTask" method="post">
			<ul style="padding: 0;" class="list-unstyled">
		        <li class="media margin5-top">
		        	<label><@spring.message "home.title.task.project"/></label>
		        </li>
		        <li class="media margin5-top">
		        	<div class="sm-margin-right" style="float:left; width: 270px;">
						<select class="form-control" onchange="return addProjectName(this);">

						<#if model.userProjectsList??>
							<#list model.userProjectsList as userProjects>
							<option value="${userProjects.upNo?if_exists}">${userProjects.upName?if_exists}</option>
							</#list>
						</#if>

						</select>
					</div>
					<div class="input-group" style="float:left; width: 160px;">
						<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>
						<input type="text" class="form-control" id="utkWorkDayId" name="utkWorkDay" value="<#if model.userTask??>${model.userTask.utkWorkDay?string('yyyy-MM-dd')?if_exists}</#if>">
					</div>
		        </li>
		        <li class="media margin5-top">
		        	<textarea class="taForm" style="height: 200px;" id="utkTaskId" name="utkTask" placeholder="Detail" rows="25"><#if model.userTask??>${model.userTask.utkTask?if_exists}</#if></textarea>
		        </li>
			</ul>
			<p align="center">
				<button type="button" class="btn btn-primary" onclick="return confirmData('taskFormId');" >Send</button>
				<button class="btn btn-primary" type="button" onClick="clearTask();">Clean</button>
			</p>
			</form>

		</div><!-- item-box -->
	</div><!-- col-md-6 right-col-cus -->

	<div class="col-md-6 left-col-cus">
		<div class="caption mittle-size-title"><h4><@spring.message "home.title.task.timeline"/></h4></div>
		<div class="item-box">
	      <#if model??>
	      <#if model.userTaskList?has_content>
	      <ul class="timeline">
	      	<#list model.userTaskList as userTask>

	      		<#if (userTask_index % 2) == 0 >
	      			<li>
		                <div class="timeline-badge" style="background-color: #4670b5;">
	                	<span class="glyphicon glyphicon-chevron-left" style="line-height: 2.5;" aria-hidden="true"></span>
	                	</div>
	      		<#else>
	      			<li class="timeline-inverted">
		                <div class="timeline-badge" style="background-color: #46b562;">
	                	<span class="glyphicon glyphicon-chevron-right" style="line-height: 2.5;" aria-hidden="true"></span>
	                	</div>
	      		</#if>
	                <div class="timeline-panel">
	                    <div class="timeline-heading">
	                        <h5 class="timeline-title"><a href="#" onclick="viewTask('${userTask.utkWorkDay?string('yyyy-MM-dd')?if_exists}'); return false;">${userTask.utkWorkDay?string('yyyy-MM-dd')?if_exists}</a></h5>
	                    </div>
	                    <div class="timeline-body">
	                        <p>
	                          <#if userTask.utkTask??>
								<#if 7 < userTask.utkTask?length >
								${userTask.utkTask?if_exists[0..7]}...
								<#else>
								${userTask.utkTask?if_exists}
								</#if>
							  </#if>
	                        </p>
	                    </div>
	                </div>
                </li>

			</#list>
	      </ul>
	      </#if>
	      </#if>
		</div>
	</div>
</div><!-- row -->

<!--
<div class="row">
<div class="col-md-8 right-col-cus">
	<div class="caption mittle-size-title"><h4><@spring.message "home.title.task.timeline"/></h4></div>
	<div class="item-box">
	</div>
</div>
<div class="col-md-4 left-col-cus">
<div class="caption mittle-size-title"><h4><@spring.message "home.title.notification"/></h4></div>
	<div class="item-box">
		<#include "temp/noti.ftlo"/>
	</div>
</div>
</div>
-->

<div class="row">
	<div class="col-md-6 right-col-cus">
		<div class="caption mittle-size-title"><h4><@spring.message "home.title.profile"/></h4></div>
		<div class="item-box">
		<#if model??>
		<#if model.usersList?has_content>
		<ul style="padding: 0;" class="list-unstyled top_profiles">
			<#list model.usersList as user>

	            <li class="media" style="margin-top: 5px;">
	                <div class="pull-left thumbnail-hover">
	                    <div class="overflow-hidden">
	                        <img width="50" alt="image" src="${user.userImgData?if_exists}">
	                    </div>
	                </div>
	                <div style="float: left">
		                <a href="/profile/${user.userId?if_exists}" class="title">${user.userId?if_exists}</a>
		                <p>${user.userName?if_exists} ${user.updateTime?string('yyyy/MM/dd')?if_exists}</p>
	                </div>
	                <a href="/profile/${user.userId?if_exists}" class="div-right profile-div-right">
	                	<span class="glyphicon glyphicon-option-horizontal"></span>
                    </a>
	            </li>

	        </#list>
	    </ul>
		</#if>
		</#if>
		</div>
	</div>
	<div class="col-md-6 left-col-cus">
		<div class="caption mittle-size-title"><h4><@spring.message "home.title.project"/></h4></div>
		<div class="item-box">
			<div id="graph1"></div>
		</div>
	</div>
</div>

<script>
	Morris.Bar({
		element: 'graph1',
		data: [

	 	  <#if model.userProjectsSumByYearList?has_content>
			<#list model.userProjectsSumByYearList as userProjectsSumByYear>
				{x: '${userProjectsSumByYear.year?if_exists}', y: '${userProjectsSumByYear.cnt?string?if_exists}' }<#if userProjectsSumByYear?has_next>,</#if>
			</#list>
		  <#else>
				{x: 'no data', y: '0' }
		  </#if>

		],
		xkey: 'x',
		ykeys: ['y'],
		labels: ['Projects']
	}).on('click', function(i, row){
		console.log(i, row);
	});

</script>

</@layout.myLayout>