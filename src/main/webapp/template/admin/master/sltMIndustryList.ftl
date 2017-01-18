<#import "../../layout/abilistsAdminLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<style>

</style>

<script type="text/javascript">

$(document).ready(function(){
    $("#flip").click(function(){
        $("#newMdataFormId").slideUp("slow");
    });
});

window.onload = function() {
	$("#newMdataFormId").hide();
	$("#updateMdataFormId").hide();
	console.log("window.onload");
}

function overChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function outChangeColor(obj) {
	obj.style.cursor = "pointer";
}

function removeIndustry() {
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
	if(!validateId(inputTag[0])) {
		isError = false;
	}
	if(!validateId(inputTag[1])) {
		isError = false;
	}
	if(!validateId(inputTag[2])) {
		isError = false;
	}

	// Validate select tag
	selectTag = table.getElementsByTagName("select");
	if(!validateId(selectTag[0])) {
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

	if(tableName == "newFormId") {
		document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitNewFormUserProjects();" );		  
	} else {
		document.getElementById("submitForm").setAttribute( "onClick", "javascript: submitUpdateFormUserProjects();" );
	}

}

</script>

<div class="item-box" style="margin-top: 15px;">
<div class="row">
	<div class="col-md-8">
	  <h3>
		<ol class="breadcrumb-std">
		  <li><a href="/admin"><@spring.message "dashboard.title.home"/></a></li>
		  <li class="active"><@spring.message "admin.menu.mindustry"/></li>
		</ol>
	  </h3>
	</div>
	<div class="col-md-4">
		<form name="sltForm" action="sltMRoleList" method="post">
		<select class="horizon-align" name="mlCode" onchange="return sltDataList(this);">
			<option value="" <#if model.sltMIndustryPara.mlCode?has_content><#if model.sltMIndustryPara.mlCode == "all">selected</#if></#if>><@spring.message "admin.button.all"/></option>
			<option value="en" <#if model.sltMIndustryPara.mlCode?has_content><#if model.sltMIndustryPara.mlCode == "en">selected</#if></#if>><@spring.message "admin.button.english"/></option>
			<option value="ko" <#if model.sltMIndustryPara.mlCode?has_content><#if model.sltMIndustryPara.mlCode == "ko">selected</#if></#if>><@spring.message "admin.button.korea"/></option>
			<option value="ja" <#if model.sltMIndustryPara.mlCode?has_content><#if model.sltMIndustryPara.mlCode == "ja">selected</#if></#if>><@spring.message "admin.button.japan"/></option>
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

	<div class="caption mittle-size-title"><h4><@spring.message "admin.menu.mindustry"/></h4></div>
	<div class="item-box" id="newMdataFormId">
	<form name="newForm" class="form-horizontal" action="istMIndustry" method="post" id="contact_form" onkeypress="return captureReturnKey(event);">
		<table id="newFormId">
			<tr>
				<td><@spring.message "mindustry.title.large.name"/></td>
				<td width="20%">
					<input class="form-control input-sm" style="width:100%" type="text" name="miLargeCategory"  placeholder="miLargeCategory"/>
				</td>
				<td><@spring.message "mindustry.title.middle.name"/></td>
				<td width="20%">
					<input class="form-control input-sm" style="width:100%" type="text" name="miMiddleCategory"/>
				</td>
				<td><@spring.message "mindustry.title.code"/></td>
				<td>
					<input class="form-control input-sm" style="width:100%" type="text" name="miCode"/>
				</td>
			</tr>
			<tr>
				<td><@spring.message "mindustry.title.explain"/></td>
				<td colspan="3">
					<input class="form-control input-sm" name="miExplain" style="width:100%" type="text" placeholder="explian"/>
				</td>
				<td><@spring.message "mindustry.title.country.code"/></td>
				<td width="10%">
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
		</table>
		<br/>
		<p align="center">
			<button type="button" onclick="return confirmData('newFormId');" class="btn btn-primary" data-toggle="modal"><@spring.message "mindustry.button.confirm"/></button>
			<button class="btn btn-primary" type="button" onClick="newFormCancel();"><@spring.message "mindustry.button.cancel"/></button>
		</p>
	</form>
	</div>

	<div class="item-box" id="updateMdataFormId">
	<form name="updateForm" class="form-horizontal" action="udtMIndustry" method="post" id="contact_form" onkeypress="return captureReturnKey(event);">
		<table id="updateForm" style="width:100%">
			<tr>
				<td><@spring.message "mindustry.title.large.name"/></td>
				<td width="20%">
					<input class="form-control input-sm" id="miLargeCategoryId" style="width:100%" type="text" name="miLargeCategory"/>
				</td>
				<td><@spring.message "mindustry.title.middle.name"/></td>
				<td width="20%">
					<input class="form-control input-sm" id="miMiddleCategoryId" style="width:100%" type="text" name="miMiddleCategory"/>
				</td>
				<td><@spring.message "mindustry.title.code"/></td>
				<td>
					<input class="form-control input-sm" id="miCodeId" style="width:100%" type="text" name="miCode"/>
				</td>
			</tr>
			<tr>
				<td><@spring.message "mindustry.title.explain"/></td>
				<td colspan="3">
					<input id="miExplainId" class="form-control input-sm" style="width:100%" name="miExplain" type="text" placeholder="explian"/>
				</td>
				<td><@spring.message "mindustry.title.country.code"/></td>
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
		</table>
		<input type="hidden" id="miNoId" name="miNo" />
		<br/>
		<p align="center">
			<button type="button" onclick="return confirmData('updateForm');" class="btn btn-primary" data-toggle="modal"><@spring.message "mindustry.button.confirm"/></button>
			<button class="btn btn-primary" type="button" onClick="updateFormCancel();"><@spring.message "mindustry.button.cancel"/></button>
			<button type="button" class="btn btn-danger" style="width: 80px;" onclick="javascript: removeIndustry();">
				<@spring.message "tech.button.detail.delete"/>
			</button>
		</p>
	</form>
	</div>
	
	
	<div class="item-box">
	<table id="userProjectsId" class="table table-striped">
      <thead>
        <tr>
          <th>#</th>
          <th><@spring.message "mindustry.title.large.name"/></th>
          <th><@spring.message "mindustry.title.middle.name"/></th>
          <th><@spring.message "mindustry.title.code"/></th>
          <th><@spring.message "mindustry.title.explain"/></th>
          <th><@spring.message "mindustry.title.country.code"/></th>
          <th><@spring.message "mindustry.title.status"/></th>
          <th><@spring.message "mindustry.title.update"/></th>
        </tr>
      </thead>
      <tbody>

      <#if model??>
      <#if model.mIndustryList?has_content>
      <#list model.mIndustryList as mIndustry>
      <tr onmouseover="overChangeColor(this);"  onmouseout="outChangeColor(this);" onclick="selectMIndustry(this, '${mIndustry.miNo?if_exists}');">
      	<td>${mIndustry.miNo?if_exists}</td>
      	<td>${mIndustry.miLargeCategory?if_exists}</td>
      	<td>${mIndustry.miMiddleCategory?if_exists}</td>
      	<td>${mIndustry.miCode?if_exists}</td>
      	<td>${mIndustry.miExplain?if_exists}</td>
      	<td>${mIndustry.mlCode?if_exists}</td>
      	<td>${mIndustry.miStatus?if_exists}</td>
      	<td>${mIndustry.updateTime?string('yyyy/MM/dd')?if_exists}</td>
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
			<li><a href="sltMIndustryList?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="sltMIndustryList?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="sltMIndustryList?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
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
        <h4 class="modal-title" id="myModalLabel"><@spring.message "mindustry.modal.title"/></h4>
      </div>

      <div id="confirmMessage" class="modal-body">
      	<@spring.message "mindustry.modal.message"/>
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
      	  <@spring.message "projects.button.close"/>
      </button>
      <button id="submitForm" type="button" class="btn btn-danger" onclick="javascript: submitFormDeleteMdata();">
      	  <@spring.message "projects.button.delete"/>
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

var miNoInput = document.getElementById("miNoId");
var miLargeCategoryInput = document.getElementById("miLargeCategoryId");
var miMiddleCategoryInput = document.getElementById("miMiddleCategoryId");
var miCodeInput = document.getElementById("miCodeId");
var miExplainInput = document.getElementById("miExplainId");
var mlCodeInput = document.getElementById("mlCodeId");
var miStatusInput = document.getElementById("miStatusId");

function selectMIndustry(x, num) {

	clearBackGroundColor();

	$(document).ready(function() {

		var availableKeys;
		var currentAjaxNum = ajaxLastNum;

        $.ajax({
            type: 'POST',
            url: 'sltMIndustryAjax',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            data: 'body={ "miNo" : "' + num + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	if(!isBlank(data.result)) {
            		availableKeys = data.result;
            		miNoInput.value = availableKeys.miNo;
            		miLargeCategoryInput.value = availableKeys.miLargeCategory;
            		miMiddleCategoryInput.value = availableKeys.miMiddleCategory;
            		miCodeInput.value = availableKeys.miCode;
            		miExplainInput.value = availableKeys.miExplain;
            		mlCodeInput.value = availableKeys.mlCode;
            	}
            },
            complete: function(xhr, textStatus) {
            	console.log("complete");
            	
            	// Set a project title into Model
            	var dltMasterDataId = document.getElementById("dltMasterDataId");
            	dltMasterDataId.innerHTML = miLargeCategoryInput.value;

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

	$("#newMdataFormId").slideToggle("slow");
	$("#newToggleId").toggleClass('glyphicon-chevron-down glyphicon-chevron-up');
	miNoInput.value = "";
	miLargeCategoryInput.value = "";
	miMiddleCategoryInput.value = "";
	miCodeInput.value = "";
	miExplainInput.value = "";
	mlCodeInput.value = "";

	clearBackGroundColor();
	updateFormCancel();

}

function formSlideDown() {
	$("#updateMdataFormId").slideDown("slow");
}

function newFormCancel() {
	$("#newMdataFormId").slideUp("slow");
	$("#newToggleId").addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-up');
	clearBackGroundColor();
}

function updateFormCancel() {
	$("#updateMdataFormId").slideUp("slow");
	$("#newToggleId").addClass('add-symbol');
	clearBackGroundColor();
}


function submitNewFormUserProjects() {
	document.newForm.submit();
}

function submitUpdateFormUserProjects() {
	document.updateForm.submit();
}

//Delete mTech
function submitFormDeleteMdata() {
	document.updateForm.action = "dltMIndustry";
	document.updateForm.submit();
}


</script>

<#include "../../common/abilistsFooder.ftl"/>

</@layout.myLayout>