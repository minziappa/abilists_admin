<#import "../../layout/abilistsAdminLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<script>

window.onload = function() {
	$("#newUserProjectForm").hide();
	$("#updateUserProjectForm").hide();

	//var task = document.getElementsByName("userTask");
	//selectUserTask(task[5], '8')

	console.log("window.onload");
}

function removeProject() {
	// Call the modal for deleting
	$(window).ready(function(){
		$('#submitFormDeleteProjectId').modal('show')
	});
}

function validateForm(tableName) {

	var blnPopover = true;
	var isError = true;

	var table = document.getElementById(tableName);

	var inputTag = table.getElementsByTagName("input")[0];
	if(!validateId(inputTag)) {
		return false;
	}

	var selectTag = table.getElementsByTagName("select");
	if(!validateField(selectTag)) {
		return false;
	}

	return true;
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
		$('#submitFormUserProjects').modal('show');
	});

	var table1 = document.getElementById(tableName);
	// Create a table on Motal 
	var table3 = document.getElementById("t03");

	var row1, row3;
	var cell11, cell12, cell3, cell31, cell32, cell33;

	row11 = table1.rows[0];
	row12 = table1.rows[1];
	row13 = table1.rows[2];
	row31 = table3.rows[0];
	row32 = table3.rows[1];
	row33 = table3.rows[2];

	var inputUpNameHtml;
	var inputUpMembersHtml;
	var textareaUpExplainHtml;
	var selectUpRoleHtml;
	var selectUpIndustrialHtml;

	inputUpNameHtml = row11.cells[1].getElementsByTagName("input")[0].value;
	row31.cells[1].innerHTML = inputUpNameHtml;
	inputUpMembersHtml = row11.cells[3].getElementsByTagName("select")[0].value;
	row31.cells[3].innerHTML = inputUpMembersHtml;

	textareaUpExplainHtml = row12.cells[1].getElementsByTagName("textarea")[0].value;
	row32.cells[1].innerHTML = textareaUpExplainHtml;
	selectUpRoleHtml = row12.cells[3].getElementsByTagName("select")[0].value;
    <#if commonBean??>
    <#if commonBean.mRoleMap?has_content>
	    <#if commonBean.mRoleMap["${lang?if_exists}"]??>
	    <#list commonBean.mRoleMap["${lang?if_exists}"] as mRole>
			var mrCode = "${mRole.mrCode?if_exists}";
			if(mrCode == selectUpRoleHtml) {
				selectUpRoleHtml = "${mRole.mrName?if_exists}";
			}
	    </#list>
	    </#if>
    </#if>
    </#if>
	row32.cells[3].innerHTML = selectUpRoleHtml;

	selectUpIndustrialHtml = row13.cells[1].getElementsByTagName("select")[0].value;
	<#if commonBean??>
	<#if commonBean.mIndustryMap?has_content>
		<#if commonBean.mIndustryMap["${lang?if_exists}"]??>
		<#list commonBean.mIndustryMap["${lang?if_exists}"] as mIndustry>
			var miCode = "${mIndustry.miCode?if_exists}";
			if(miCode == selectUpIndustrialHtml) {
				selectUpIndustrialHtml = "${mIndustry.miLargeCategory?if_exists}";
			}
		</#list>
		</#if>
	</#if>
	</#if>
	row33.cells[1].innerHTML = selectUpIndustrialHtml;

	document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitNewFormProjects();" );

}

/*
 * Make the table on the Modal for confirming the data to update it.
 */
function confirmUpdateData(tableName) {

	// Call the modal
	$(window).ready(function(){
		$('#submitFormUserProjects').modal('show');
	});

	var table1 = document.getElementById(tableName);
	// Create a table on Motal 
	var table3 = document.getElementById("t03");

	var row1, row3;
	var cell11, cell12, cell31, cell32;

	row11 = table1.rows[0];
	row12 = table1.rows[1];
	row31 = table3.rows[0];
	row32 = table3.rows[1];

	var inputUpNameHtml;
	var selectUpRoleHtml;
	var selectUpIndustrialHtml;

	inputUpNameHtml = row11.cells[1].getElementsByTagName("input")[0].value;
	row31.cells[1].innerHTML = inputUpNameHtml;

	selectUpIndustrialHtml = row12.cells[1].getElementsByTagName("select")[0].value;

	<#if commonBean??>
	<#if commonBean.mIndustryMap?has_content>
		<#if commonBean.mIndustryMap["${lang?if_exists}"]??>
		<#list commonBean.mIndustryMap["${lang?if_exists}"] as mIndustry>
			var miCode = "${mIndustry.miCode?if_exists}";
			if(miCode == selectUpIndustrialHtml) {
				selectUpIndustrialHtml = "${mIndustry.miLargeCategory?if_exists}";
			}
		</#list>
		</#if>
	</#if>
	</#if>
	row32.cells[1].innerHTML = selectUpIndustrialHtml;

	selectUpRoleHtml = row12.cells[3].getElementsByTagName("select")[0].value;
    <#if commonBean??>
    <#if commonBean.mRoleMap?has_content>
	    <#if commonBean.mRoleMap["${lang?if_exists}"]??>
	    <#list commonBean.mRoleMap["${lang?if_exists}"] as mRole>
			var mrCode = "${mRole.mrCode?if_exists}";
			if(mrCode == selectUpRoleHtml) {
				selectUpRoleHtml = "${mRole.mrName?if_exists}";
			}
	    </#list>
	    </#if>
    </#if>
    </#if>
	row32.cells[3].innerHTML = selectUpRoleHtml;

	document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitUpdateFormProjects();" );

}

function validateUpdateForm(tableName) {

	var blnPopover = true;
	var isError = true;

	var table = document.getElementById(tableName);

	var selectTag = table.getElementsByTagName("select");
	if(!validateField(selectTag)) {
		return false;
	}

	return true;
}

</script>

<div class="item-box" style="margin-top: 15px;">
<div class="row">
	<div class="col-md-6">
		<h3>
			<ol class="breadcrumb-std">
			  <li><a href="/admin"><@spring.message "dashboard.title.home"/></a></li>
			  <li class="active"><@spring.message "admin.menu.projects"/></li>
			</ol>
		</h3>
	</div>
	<div class="col-md-6">
		<span id="newToggleId" class="glyphicon glyphicon-chevron-down add-symbol" style="color:#337ab7;" aria-hidden="true" onClick="newFormToggle();"></span>
	</div>
</div>
</div>

<div class="row">
  <div class="col-md-12">

	<#include "../../common/errorMessage.ftl"/>
	<div align="center" id="completeId" class="list-group-item list-group-item-danger">success</div>

	<div class="caption mittle-size-title"><h4><@spring.message "admin.menu.projects"/></h4></div>
	<div class="item-box" id="newUserProjectForm">
	<form name="newForm" class="form-horizontal" action="istProjects" method="post" id="contact_form" onkeypress="return captureReturnKey(event);">
		<table id="newFormId" style="width:100%">
		<tr>
			<td width="12%"><@spring.message "projects.title.name"/></td>
			<td>
				<input type="text" style="width:100%" name="upName" />
			</td>
			<td width="12%"><@spring.message "projects.title.team.number"/></td>
			<td width="15%">
				<select class="taForm" name="upMembers">
					<option value="0"><@spring.message "projects.title.team.number"/></option>
					<option value="1">1</option>
					<option value="3">2-3</option>
					<option value="7">4-7</option>
					<option value="12">8-12</option>
					<option value="18">13-18</option>
					<option value="25">19-25</option>
					<option value="30">26-30</option>
					<option value="40">31-40</option>
					<option value="50">more than 41</option>
				</select>
			</td>
		</tr>
		<tr>
			<td rowspan="2"><@spring.message "projects.title.explain"/></td>
			<td rowspan="2">
				<textarea class="taForm" name="upExplain" placeholder="explian" rows="1"></textarea>
			</td>
			<td><@spring.message "projects.title.role"/></td>
			<td>
				<select class="taForm" name="upRole">
				<option value="0"><@spring.message "projects.title.role"/></option>
			    <#if commonBean??>
			    <#if commonBean.mRoleMap?has_content>
				    <#if commonBean.mRoleMap["${lang?if_exists}"]??>
				    <#list commonBean.mRoleMap["${lang?if_exists}"] as mRole>
				    	<option value="${mRole.mrCode?if_exists}">${mRole.mrName?if_exists}</option>
				    </#list>
				    </#if>
			    </#if>
			    </#if>
			    </select>
			</td>
		</tr>
		<tr>
			<td><@spring.message "projects.title.industy"/></td>
			<td>
				<select class="taForm" name="upIndustrial">
					<option value="0"><@spring.message "projects.title.industy"/></option>
					<#if commonBean??>
					<#if commonBean.mIndustryMap?has_content>
						<#if commonBean.mIndustryMap["${lang?if_exists}"]??>
						<#list commonBean.mIndustryMap["${lang?if_exists}"] as mIndustry>
							<option value="${mIndustry.miCode?if_exists}">${mIndustry.miLargeCategory?if_exists}</option>
						</#list>
						</#if>
					</#if>
					</#if>
			    </select>
			</td>
		</tr>
		</table>
		<br/>
		<p align="center">
			<button type="button" onclick="return confirmData('newFormId');" class="btn btn-primary" data-toggle="modal">
				<@spring.message "projects.button.confirm"/>
			</button>
			<button class="btn btn-primary" type="button" onClick="newFormCancel();">
				<@spring.message "projects.button.cancel"/>
			</button>
		</p>
	  </form>
	  </div>

	  <form id="updateUserProjectForm" name="updateForm" class="form-horizontal" action="udtProjects" method="post" id="updateFormId" onkeypress="return captureReturnKey(event);">
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

				<table id="updateForm" style="width:100%">
				<tr>
					<td><@spring.message "projects.title.name"/></td>
					<td><input id="upNameId" style="width:100%" type="text" name="upName"/></td>
					<td><@spring.message "projects.title.team.number"/></td>
					<td><span id="upMembersId"></span></td>
				</tr>
				<tr>
					<td><@spring.message "projects.title.industy"/></td>
					<td>
						<select id="upIndustrialId" class="taForm" name="upIndustrial">
							<option value="0"><@spring.message "projects.title.industy"/></option>
							<#if commonBean??>
							<#if commonBean.mIndustryMap?has_content>
								<#if commonBean.mIndustryMap["${lang?if_exists}"]??>
								<#list commonBean.mIndustryMap["${lang?if_exists}"] as mIndustry>
									<option value="${mIndustry.miCode?if_exists}">${mIndustry.miLargeCategory?if_exists}</option>
								</#list>
								</#if>
							</#if>
							</#if>
					    </select>
					</td>
					<td><@spring.message "projects.title.role"/></td>
					<td>
						<select id="upRoleId" class="taForm" name="upRole">
							<option value="0"><@spring.message "projects.title.role"/></option>
						    <#if commonBean??>
						    <#if commonBean.mRoleMap?has_content>
							    <#if commonBean.mRoleMap["${lang?if_exists}"]??>
							    <#list commonBean.mRoleMap["${lang?if_exists}"] as mRole>
							    	<option value="${mRole.mrCode?if_exists}">${mRole.mrName?if_exists}</option>
							    </#list>
							    </#if>
						    </#if>
						    </#if>
						</select>
					</td>
				</tr>
				<tr>
					<td><@spring.message "projects.title.explain"/></td>
					<td colspan="3">
						<span id="upExplainId"></span>
					</td>
				</tr>
				</table>
				</div>
			</div>
		</div>
		<input type="hidden" id="upNoId" name="upNo" />

		<p align="center">
			<button type="button" onclick="return confirmUpdateData('updateForm');" class="btn btn-primary" data-toggle="modal">
				<@spring.message "projects.button.confirm"/>
			</button>
			<button class="btn btn-primary" type="button" onClick="updateFormCancel();">
				<@spring.message "project.button.close"/>
			</button>
			<a id="projectTechId" href="#" class="btn btn-success" style="width: 90px;" role="button" >
				<@spring.message "projects.button.tech.input"/>
			</a>
			<button type="button" class="btn btn-danger" style="width: 90px;" onclick="javascript: removeProject();">
				<@spring.message "projects.button.delete"/>
			</button>
		</p>
	  </form>

	  <div class="item-box">
		<table id="tableListId" class="table table-striped">
	      <thead>
	        <tr>
	          <th><@spring.message "projects.title.no"/></th>
	          <th><@spring.message "projects.title.name"/></th>
	          <th><@spring.message "projects.title.industy"/></th>
	          <th><@spring.message "projects.title.explain"/></th>
	          <th><@spring.message "projects.title.team.number"/></th>
	          <th><@spring.message "projects.title.role"/></th>
	          <th><@spring.message "projects.title.update"/></th>
	        </tr>
	      </thead>
	      <tbody>

	      <#if model??>
	      <#if model.userProjectsList?has_content>
	      <#list model.userProjectsList as userProjects>
	      <tr onmouseover="overChangeColor(this);" onmouseout="outChangeColor(this);"
	      		onclick="selectUserProjects(this, '${userProjects.upNo?if_exists}');">
	      	<td>${userProjects.upNo?if_exists}</td>
	      	<td>${userProjects.upName?if_exists}</td>
	      	<td>
				<#if commonBean??>
				<#if commonBean.mIndustryMap?has_content>
					<#if commonBean.mIndustryMap["${lang?if_exists}"]??>
					<#list commonBean.mIndustryMap["${lang?if_exists}"] as mIndustry>
					<#if userProjects.upIndustrial??>
						<#if userProjects.upIndustrial == "${mIndustry.miCode?if_exists}">
						${mIndustry.miLargeCategory?if_exists}
						</#if>
					</#if>
					</#list>
					</#if>
				</#if>
				</#if>
	      	</td>
	      	<td>${userProjects.upExplain?if_exists}</td>
	      	<td>${userProjects.upMembers?if_exists}</td>
	      	<td>
			    <#if commonBean??>
			    <#if commonBean.mRoleMap?has_content>
				    <#if commonBean.mRoleMap["${lang?if_exists}"]??>
				    <#list commonBean.mRoleMap["${lang?if_exists}"] as mRole>
				    	<#if userProjects.upRole??>
			    		<#if userProjects.upRole == "${mRole.mrCode?if_exists}">
			    			${mRole.mrName?if_exists}
			    		</#if>
			    		</#if>
				    </#list>
				    </#if>
			    </#if>
			    </#if>
		    </td>
      		<td>${userProjects.updateTime?string('yyyy/MM/dd')?if_exists}</td>
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
			<li><a href="/admin/projects/sltProjectsList?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="/admin/projects/sltProjectsList?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="/admin/projects/sltProjectsList?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
			</#if>
		</#if>
		</#if>
      	</ul>
      </nav><!-- end #nav -->

	</div><!-- col-md-12 -->
</div><!-- row -->


<!-- Insert And Update Modal -->
<div class="modal fade" id="submitFormUserProjects" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
        	<span class="sr-only"><@spring.message "projects.button.close"/></span>
        </button>
        <h4 class="modal-title" id="myModalLabel"><@spring.message "projects.title.modal"/></h4>
      </div>

      <div id="confirmMessage" class="modal-body">
		<table id="t03" style="width:100%">
		<tr>
			<td><@spring.message "projects.title.name"/></td>
			<td></td>
			<td><@spring.message "projects.title.team.number"/></td>
			<td><span id="uptUpMembersId"></span></td>
		</tr>
		<tr>
			<td><@spring.message "projects.title.industy"/></td>
			<td></td>
			<td><@spring.message "projects.title.role"/></td>
			<td></td>
		</tr>
		<tr>
			<td><@spring.message "projects.title.explain"/></td>
			<td colspan="3">
				<span id="uptUpExplainId"></span>
			</td>
		</tr>
		</table>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><@spring.message "projects.button.close"/></button>
        <button id="submitForm" type="button" class="btn btn-primary"><@spring.message "projects.button.save"/></button>
      </div>
    </div>
  </div>
</div>

<!-- Delete Modal -->
<div class="modal fade" id="submitFormDeleteProjectId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <h4 class="modal-title" id="dltProjectTileId"><@spring.message "projects.title.modal"/></h4>
    </div>

    <div id="confirmMessage" class="modal-body">
    	<@spring.message "projects.confirm.message.delete"/>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal"><@spring.message "projects.button.close"/></button>
      <button id="submitForm" type="button" class="btn btn-danger" onclick="javascript: submitFormDeleteProject();">
      	  <@spring.message "projects.button.delete"/>
      </button>
    </div>
  </div>
</div>
</div>

<script type="text/javascript"> 

var upNoInput = document.getElementById("upNoId");
var upNameInput = document.getElementById("upNameId");
var upMembersInput = document.getElementById("upMembersId");
var upIndustrialInput = document.getElementById("upIndustrialId");
var upExplainInput = document.getElementById("upExplainId");
var upRoleInput = document.getElementById("upRoleId");
var projectTechInput = document.getElementById("projectTechId");

var uptUpMembersInput = document.getElementById("uptUpMembersId");
var uptUpExplainInput = document.getElementById("uptUpExplainId");

function selectUserProjects(x, num) {
	clearBackGroundColorTr("tableListId");
	$(document).ready(function() {

		var availableKeys;

        $.ajax({
            type: 'POST',
            url: 'sltProjectsAjax',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            data: 'body={ "upNo" : "' + num + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	if(!isBlank(data.result)) {
            		availableKeys = data.result;
            		upNoInput.value = availableKeys.upNo;
            		upNameInput.value = availableKeys.upName;
            		upMembersInput.innerHTML = availableKeys.upMembers;
            		uptUpMembersInput.innerHTML = availableKeys.upMembers;

            		upIndustrialInput.value = availableKeys.upIndustrial;
            		upExplainInput.innerHTML = availableKeys.upExplain;
            		uptUpExplainInput.innerHTML = availableKeys.upExplain;

            		upRoleInput.value = availableKeys.upRole;
            		projectTechInput.href = "sltProjectTechList/" + availableKeys.upNo
            	}
            },
            complete: function(xhr, textStatus) {
            	console.log("complete");

            	// Set a project title into Model
            	var dltProjectTileId = document.getElementById("dltProjectTileId");
            	dltProjectTileId.innerHTML = upNameInput.value;

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

	upNoInput.value = "";
	upNameInput.value = "";
	upMembersInput.value = "";
	upIndustrialInput.value = "";
	upExplainInput.value = "";
	upRoleInput.value = "";

	uptUpMembersInput = "";
	uptUpExplainInput = "";

	clearBackGroundColorTr("tableListId");
	updateFormCancel();
}

function formSlideDown() {
	$("#updateUserProjectForm").slideDown("slow");
}

function newFormCancel() {
	$("#newUserProjectForm").slideUp("slow");
	$("#newToggleId").addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-up');
	clearBackGroundColorTr("tableListId");
}

function updateFormCancel() {
	$("#updateUserProjectForm").slideUp("slow");
	$("#newToggleId").addClass('add-symbol');
	clearBackGroundColorTr("tableListId");
}

function submitNewFormProjects() {
	document.newForm.submit();
}

function submitUpdateFormProjects() {
	document.updateForm.submit();
}

function submitFormDeleteProject() {
	document.updateForm.action = "dltProjects";
	document.updateForm.submit();
}

</script>

<#include "../../common/abilistsFooder.ftl"/>

</@layout.myLayout>