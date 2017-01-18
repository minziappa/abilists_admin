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
	console.log("window.onload");
}

function overChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function outChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function removeProject() {
	// Call the modal for deleting
	$(window).ready(function(){
		$('#submitFormDeleteMdataId').modal('show')
	});
}

function validateForm(tableName) {

	var blnPopover = true;
	var isError = true;

	var table = document.getElementById(tableName);

	// Validate input tag
	var inputTag = table.getElementsByTagName("input");
	if(!validateField(inputTag)) {
		isError = false;
	}

	// Validate select tag
	selectTag = table.getElementsByTagName("select");
	if(!validateField(selectTag)) {
		isError = false;
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
		$('#submitFormUserProjects').modal('show')
	});

	var table1 = document.getElementById(tableName);
	// Create a table on Motal 
	var table3 = document.getElementById("t03");

	var row1, row3;
	var cell31, cell32, cell33, cell34

	var row11 = table1.rows[0];
	var row12 = table1.rows[1];
	var row13 = table1.rows[2];
	var row14 = table1.rows[3];
	var row15 = table1.rows[4];
	var row16 = table1.rows[5];
	var row17 = table1.rows[6];

	var row31 = table3.rows[0];
	var row32 = table3.rows[1];
	var row33 = table3.rows[2];
	var row34 = table3.rows[3];
	var row35 = table3.rows[4];
	var row36 = table3.rows[5];
	var row37 = table3.rows[6];

	var inputMrNameHtml;
	var selectMlCodeHtml;
	var textareaMrExplainHtml;
	var textareaMrResponsibilitiesHtml;
	var textareaMrWorksHtml;
	var textareaMrSkillsHtml;
	var textareaMrPrefersHtml;

	inputMrNameHtml = row11.cells[1].getElementsByTagName("input")[0].value;
	row31.cells[1].innerHTML = inputMrNameHtml;
	inputMrCodeHtml = row12.cells[1].getElementsByTagName("input")[0].value;
	row32.cells[1].innerHTML = inputMrCodeHtml;
	selectMlCodeHtml = row12.cells[3].getElementsByTagName("select")[0].value;
	row32.cells[3].innerHTML = selectMlCodeHtml;
	textareaMrExplainHtml = row13.cells[1].getElementsByTagName("textarea")[0].value;
	row33.cells[1].innerHTML = textareaMrExplainHtml;
	textareaMrResponsibilitiesHtml = row14.cells[1].getElementsByTagName("textarea")[0].value;
	row34.cells[1].innerHTML = textareaMrResponsibilitiesHtml;
	textareaMrWorksHtml = row15.cells[1].getElementsByTagName("textarea")[0].value;
	row35.cells[1].innerHTML = textareaMrWorksHtml;
	textareaMrSkillsHtml = row16.cells[1].getElementsByTagName("textarea")[0].value;
	row36.cells[1].innerHTML = textareaMrSkillsHtml;
	textareaMrPrefersHtml = row17.cells[1].getElementsByTagName("textarea")[0].value;
	row37.cells[1].innerHTML = textareaMrPrefersHtml;

	if(tableName == "newFormId") {
		document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitNewMdata();" );		  
	} else {
		document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitUpdateMdata();" );
	}

}

</script>

<div class="item-box" style="margin-top: 15px;">
<div class="row">
	<div class="col-md-8">
	  <h3>
		<ol class="breadcrumb-std">
		  <li><a href="/admin"><@spring.message "dashboard.title.home"/></a></li>
		  <li class="active"><@spring.message "admin.menu.mrole"/></li>
		</ol>
	  </h3>
	</div>
	<div class="col-md-4">
		<form name="sltForm" action="sltMRoleList" method="post">
		<select class="horizon-align" name="mlCode" onchange="return sltDataList(this);">
			<option value="" <#if model.sltMRolePara.mlCode?has_content><#if model.sltMRolePara.mlCode == "all">selected</#if></#if>><@spring.message "admin.button.all"/></option>
			<option value="en" <#if model.sltMRolePara.mlCode?has_content><#if model.sltMRolePara.mlCode == "en">selected</#if></#if>><@spring.message "admin.button.english"/></option>
			<option value="ko" <#if model.sltMRolePara.mlCode?has_content><#if model.sltMRolePara.mlCode == "ko">selected</#if></#if>><@spring.message "admin.button.korea"/></option>
			<option value="ja" <#if model.sltMRolePara.mlCode?has_content><#if model.sltMRolePara.mlCode == "ja">selected</#if></#if>><@spring.message "admin.button.japan"/></option>
		</select>
		</form>
		<span id="newToggleId" class="glyphicon glyphicon-chevron-down add-symbol" style="color:#337ab7;" aria-hidden="true" onClick="newFormToggle();"></span>
	</div>
</div>
</div>

<div class="row">
  <div class="col-md-12">

	<#include "../../common/errorMessage.ftl"/>
	<div align="center" id="completeId" class="list-group-item list-group-item-danger">complete</div>

	<div class="caption mittle-size-title"><h4><@spring.message "admin.menu.mrole"/></h4></div>
	<div class="item-box" id="newUserProjectForm">
	<form name="newForm" class="form-horizontal" action="istMRole" method="post" id="contact_form" onkeypress="return captureReturnKey(event);">
		<table id="newFormId">
			<tr>
				<td width="15%"><@spring.message "role.title.name"/></td>
				<td colspan="3">
					<input class="form-control input-sm" style="width:100%" type="text" name="mrName"/>
				</td>
			</tr>
			<tr>
				<td width="15%"><@spring.message "role.title.code"/></td>
				<td>
					<input class="form-control input-sm" style="width:100%" type="text" name="mrCode"/>
				</td>
				<td width="15%"><@spring.message "mindustry.title.country.code"/></td>
				<td>
					<select name="mlCode" style="width:100%">
						<option value="">Choose Language</option>
					<#if commonBean??>
					<#if commonBean.mLanguageList?has_content>
						<#list commonBean.mLanguageList as mLanguage>
						<option value="${mLanguage.mlCode?if_exists}">${mLanguage.mlName?if_exists}</option>
						</#list>
					</#if>
					</#if>
					</select>
				</td>
			</tr>
			<tr>
				<td><@spring.message "role.title.explain"/></td>
				<td colspan="3">
					<textarea class="taForm" name="mrExplain" placeholder="Explian" ></textarea>
				</td>
			</tr>
			<tr>
				<td><@spring.message "role.title.responsibilities"/></td>
				<td colspan="3">
					<textarea class="taForm" name="mrResponsibilities" placeholder="Responsibilities"></textarea>
				</td>
			</tr>
			<tr>
				<td><@spring.message "role.title.works"/></td>
				<td colspan="3">
					<textarea class="taForm" name="mrWorks" placeholder="Works"></textarea>
				</td>
			</tr>
			<tr>
				<td><@spring.message "role.title.skills"/></td>
				<td colspan="3">
					<textarea class="taForm" name="mrSkills" placeholder="Skills"></textarea>
				</td>
			</tr>
			<tr>
				<td><@spring.message "role.title.prefer"/></td>
				<td colspan="3">
					<textarea class="taForm" name="mrPrefers" placeholder="Prefers"></textarea>
				</td>
			</tr>
		</table>
		<br/>
		<p align="center">
			<button type="button" onclick="return confirmData('newFormId');" class="btn btn-primary" data-toggle="modal"><@spring.message "role.button.confirm"/></button>
			<button class="btn btn-primary" type="button" onClick="newFormCancel();"><@spring.message "role.button.cancel"/></button>
		</p>
	</form>
	</div>

	<div class="item-box" id="updateUserProjectForm">
	<form name="updateForm" class="form-horizontal" action="udtMRole" method="post" id="contact_form" onkeypress="return captureReturnKey(event);">
		<table id="updateForm">
			<tr>
				<td width="15%"><@spring.message "role.title.name"/></td>
				<td>
					<input id="mrNameId" class="form-control input-sm" style="width:100%" type="text" name="mrName"/>
				</td>
				<td>Remove</td>
				<td width="15%"><button type="button" class="btn btn-danger" onclick="javascript: removeProject();"><@spring.message "modal.button.delete"/></button></td>
			</tr>
			<tr>
				<td><@spring.message "role.title.code"/></td>
				<td>
					<input id="mrCodeId" class="form-control input-sm" style="width:100%" type="text" name="mrCode"/>
				</td>
				<td width="15%"><@spring.message "mindustry.title.country.code"/></td>
				<td width="10%">
					<select id="mlCodeId" name="mlCode" style="width:100%">
						<option value="">Choose Language</option>
					<#if commonBean??>
					<#if commonBean.mLanguageList?has_content>
						<#list commonBean.mLanguageList as mLanguage>
						<option value="${mLanguage.mlCode?if_exists}">${mLanguage.mlName?if_exists}</option>
						</#list>
					</#if>
					</#if>
					</select>
				</td>
			</tr>
			<tr>
				<td><@spring.message "role.title.explain"/></td>
				<td colspan="4">
					<textarea id="mrExplainId" class="taForm" name="mrExplain" placeholder="Explian" ></textarea>
				</td>
			</tr>
			<tr>
				<td><@spring.message "role.title.responsibilities"/></td>
				<td colspan="4">
					<textarea id="mrResponsibilitiesId" class="taForm" name="mrResponsibilities" placeholder="Responsibilities"></textarea>
				</td>
			</tr>
			<tr>
				<td><@spring.message "role.title.works"/></td>
				<td colspan="4">
					<textarea id="mrWorksId" class="taForm" name="mrWorks" placeholder="Works"></textarea>
				</td>
			</tr>
			<tr>
				<td><@spring.message "role.title.skills"/></td>
				<td colspan="4">
					<textarea id="mrSkillsId" class="taForm" name="mrSkills" placeholder="Skills"></textarea>
				</td>
			</tr>
			<tr>
				<td><@spring.message "role.title.prefer"/></td>
				<td colspan="4">
					<textarea id="mrPrefersId" class="taForm" name="mrPrefers" placeholder="Prefers"></textarea>
				</td>
			</tr>
		</table>
		<input type="hidden" id="mrNoId" name="mrNo" />
		<br/>
		<p align="center">
			<button type="button" onclick="return confirmData('updateForm');" class="btn btn-primary" data-toggle="modal"><@spring.message "role.button.confirm"/></button>
			<button class="btn btn-primary" type="button" onClick="updateFormCancel();"><@spring.message "role.button.cancel"/></button>
		</p>
	</form>
	</div>

	<div class="item-box">
	  <table id="userProjectsId" class="table table-striped">
	      <thead>
	        <tr>
	          <th>#</th>
	          <th><@spring.message "role.title.name"/></th>
	          <th><@spring.message "role.title.code"/></th>
	          <th><@spring.message "role.title.explain"/></th>
	          <th><@spring.message "role.title.responsibilities"/></th>
	          <th><@spring.message "role.title.works"/></th>
	          <th><@spring.message "role.title.skills"/></th>
	          <th><@spring.message "role.title.prefer"/></th>
	          <th><@spring.message "role.title.country.code"/></th>
	          <th><@spring.message "role.title.status"/></th>
	          <th><@spring.message "role.title.update"/>+</th>
	        </tr>
	      </thead>
	      <tbody>
	
	      <#if model??>
	      <#if model.mRoleList?has_content>
	      <#list model.mRoleList as mRole>
	      <tr onmouseover="overChangeColor(this);"  onmouseout="outChangeColor(this);" onclick="selectMRole(this, '${mRole.mrNo?if_exists}');">
	      	<td>${mRole.mrNo?if_exists}</td>
	      	<td>${mRole.mrName?if_exists}</td>
	      	<td>${mRole.mrCode?if_exists}</td>
	      	<td>${mRole.mrExplain?if_exists}</td>
	      	<td>${mRole.mrResponsibilities?if_exists}</td>
	      	<td>${mRole.mrWorks?if_exists}</td>
	      	<td>${mRole.mrSkills?if_exists}</td>
	      	<td>${mRole.mrPrefers?if_exists}</td>
	      	<td>${mRole.mlCode?if_exists}</td>
	      	<td>${mRole.mrStatus?if_exists}</td>
	      	<td>${mRole.updateTime?string('yyyy/MM/dd')?if_exists}</td>
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
			<li><a href="sltMRoleList?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="sltMRoleList?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="sltMRoleList?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
			</#if>
		</#if>
	  </#if>
      </ul>
    </nav><!-- end #nav -->

  </div><!-- #col-md-12 -->
</div><!-- end #content -->

<!-- Modal -->
<div class="modal fade" id="submitFormUserProjects" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel"><@spring.message "role.modal.title"/></h4>
      </div>

      <div id="confirmMessage" class="modal-body">
	      <table  id="t03" style="width:100%">
	      	<tr>
				<td width="15%"><@spring.message "role.title.name"/></td>
				<td colspan="3"></td>
			</tr>
	      	<tr>
				<td width="15%"><@spring.message "role.title.code"/></td>
				<td></td>
				<td width="10%"><@spring.message "mindustry.title.country.code"/></td>
				<td width="10%"></td>
			</tr>
			<tr>
				<td><@spring.message "role.title.explain"/></td>
				<td colspan="3"></td>
			</tr>
			<tr>
				<td><@spring.message "role.title.responsibilities"/></td>
				<td colspan="3"></td>
			</tr>
			<tr>
				<td><@spring.message "role.title.works"/></td>
				<td colspan="3"></td>
			</tr>
			<tr>
				<td><@spring.message "role.title.skills"/></td>
				<td colspan="3"></td>
			</tr>
			<tr>
				<td><@spring.message "role.title.prefer"/></td>
				<td colspan="3"></td>
			</tr>
		  </table>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">
        	<@spring.message "modal.button.close"/>
        </button>
        <button id="submitForm" type="button" class="btn btn-primary">
        	<@spring.message "modal.button.save"/>
        </button>
      </div>
    </div>
  </div>
</div>

<!-- Delete Modal -->
<div class="modal fade" id="submitFormDeleteMdataId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
      	  <@spring.message "modal.button.close"/>
      </button>
      <button id="submitForm" type="button" class="btn btn-danger" onclick="javascript: submitFormDeleteMdata();">
      	  <@spring.message "modal.button.delete"/>
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

var mrNoInput = document.getElementById("mrNoId");
var mrNameInput = document.getElementById("mrNameId");
var mrCodeInput = document.getElementById("mrCodeId");
var mrExplainInput = document.getElementById("mrExplainId");
var mrResponsibilitiesInput = document.getElementById("mrResponsibilitiesId");
var mrWorksInput = document.getElementById("mrWorksId");
var mrSkillsInput = document.getElementById("mrSkillsId");
var mrPrefersInput = document.getElementById("mrPrefersId");
var mlCodeInput = document.getElementById("mlCodeId");


function selectMRole(x, num) {

	clearBackGroundColor();

	$(document).ready(function() {

		var availableKeys;
		var currentAjaxNum = ajaxLastNum;

        $.ajax({
            type: 'POST',
            url: 'sltMRoleAjax',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            data: 'body={ "mrNo" : "' + num + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	if(!isBlank(data.result)) {
            		availableKeys = data.result;

            		mrNoInput.value = availableKeys.mrNo;
            		mrNameInput.value = availableKeys.mrName;
            		mrCodeInput.value = availableKeys.mrCode;
            		mrExplainInput.value = availableKeys.mrExplain;
            		mrResponsibilitiesInput.value = availableKeys.mrResponsibilities;
            		mrWorksInput.value = availableKeys.mrWorks;
            		mrSkillsInput.value = availableKeys.mrSkills;
            		mrPrefersInput.value = availableKeys.mrPrefers;
            		mlCodeInput.value = availableKeys.mlCode;
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
	mrNoInput.value = "";
	mrNameInput.value = "";
	mrCodeInput.value = "";
	mrExplainInput.value = "";
	mrResponsibilitiesInput.value = "";
	mrWorksInput.value = "";
	mrSkillsInput.value = "";
	mlCodeInput.value = "";

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

function submitNewMdata() {
	document.newForm.submit();
}

function submitUpdateMdata() {
	document.updateForm.submit();
}

//Delete mTech
function submitFormDeleteMdata() {
	document.updateForm.action = "dltMRole";
	document.updateForm.submit();
}

</script>

<#include "../../common/abilistsFooder.ftl"/>

</@layout.myLayout>