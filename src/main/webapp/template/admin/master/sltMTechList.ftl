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
	
	if(!validateId(inputTag[0])) {
		isError = false;
	}
	if(!validateId(inputTag[1])) {
		isError = false;
	}
	if(!validateId(inputTag[3])) {
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
		$('#submitFormMTech').modal('show')
	});

	// the source table
	var table1 = document.getElementById(tableName);
	// Create a table on modal 
	var table3 = document.getElementById("t03");

	var row11, row12, row13, row31, row32, row33;

	row11 = table1.rows[0];
	row12 = table1.rows[1];
	row13 = table1.rows[2];
	row31 = table3.rows[0];
	row32 = table3.rows[1];
	row33 = table3.rows[2];

	var inputMtSkillHtml;
	var inputMtKindHtml;
	var inputMtVersionHtml;
	var inputMtNameHtml;
	var inputMtTrendHtml;
	var inputMtExplainHtml;

	inputMtSkillHtml = row11.cells[1].getElementsByTagName("input")[0].value;
	row31.cells[1].innerHTML = inputMtSkillHtml;
	inputMtKindHtml = row11.cells[3].getElementsByTagName("input")[0].value;
	row31.cells[3].innerHTML = inputMtKindHtml;
	inputMtVersionHtml = row11.cells[5].getElementsByTagName("input")[0].value;
	row31.cells[5].innerHTML = inputMtVersionHtml;

	inputMtVersionHtml = row12.cells[1].getElementsByTagName("input")[0].value;
	row32.cells[1].innerHTML = inputMtVersionHtml;
	inputMtTrendHtml = row12.cells[3].getElementsByTagName("input")[0].value;
	row32.cells[3].innerHTML = inputMtTrendHtml;

	inputMtExplainHtml = row13.cells[1].getElementsByTagName("input")[0].value;
	row33.cells[1].innerHTML = inputMtExplainHtml;

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
		  <li class="active"><@spring.message "admin.menu.mtech"/></li>
		</ol>
	</h3>
	</div>
	<div class="col-md-4">
	<form name="sltForm" action="sltMTechList" method="post">
		<select class="horizon-align" name="mtSkill" onchange="return sltDataList(this);">
			<option value="" <#if model.sltMTechPara.mtSkill?has_content><#if model.sltMTechPara.mtSkill == "all">selected</#if></#if>><@spring.message "tech.button.all"/></option>
			<option value="skills" <#if model.sltMTechPara.mtSkill?has_content><#if model.sltMTechPara.mtSkill == "skills">selected</#if></#if>><@spring.message "tech.button.skills"/></option>
			<option value="lang" <#if model.sltMTechPara.mtSkill?has_content><#if model.sltMTechPara.mtSkill == "lang">selected</#if></#if>><@spring.message "tech.button.lang"/></option>
			<option value="certi" <#if model.sltMTechPara.mtSkill?has_content><#if model.sltMTechPara.mtSkill == "certi">selected</#if></#if>><@spring.message "tech.button.certi"/></option>
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

	<div class="caption mittle-size-title"><h4><@spring.message "admin.menu.mtech"/></h4></div>
	<div class="item-box" id="newMdataFormId">
	<form name="newForm" class="form-horizontal" action="istMTech" method="post" id="contact_form" onkeypress="return captureReturnKey(event);">
		<table id="newFormId">
		<tr>
			<td width="10%"><@spring.message "tech.title.skills"/></td>
			<td>
				<input class="form-control input-sm" style="width: 100%;" type="text" name="mtSkill"/>
			</td>
			<td width="10%"><@spring.message "tech.title.kind"/></td>
			<td>
				<input class="form-control input-sm" style="width: 100%;" type="text" name="mtKind"/>
			</td>
			<td width="10%"><@spring.message "tech.title.version"/></td>
			<td>
				<input class="form-control input-sm" style="width: 100%;" type="text" name="mtVersion"/>
			</td>
		</tr>
		<tr>
			<td><@spring.message "tech.title.name"/></td>
			<td colspan="3">
				<input class="form-control input-sm" style="width: 100%;" type="text" name="mtName"/>
			</td>
			<td><@spring.message "tech.title.trend"/></td>
			<td>
				<input class="form-control input-sm" style="width: 100%;" type="text" name="mtTrend"/>
			</td>
		</tr>
		<tr>
			<td><@spring.message "tech.title.explain"/></td>
			<td colspan="5">
				<input class="form-control input-sm" style="width: 100%;" name="mtExplain" type="text" placeholder="explian"/>
			</td>
		</tr>
		</table>
		<br/>
		<p align="center">
			<button type="button" onclick="return confirmData('newFormId');" class="btn btn-primary" data-toggle="modal"><@spring.message "tech.button.confirm"/></button>
			<button class="btn btn-primary" type="button" onClick="newFormCancel();"><@spring.message "tech.button.cancel"/></button>
		</p>
	</form>
	</div>

	<div class="item-box" id="updateMdataFormId">
	<form name="updateForm" class="form-horizontal" action="udtMTech" method="post" id="contact_form" onkeypress="return captureReturnKey(event);">
		<table id="updateForm">
		<tr>
			<td width="10%"><@spring.message "tech.title.skills"/></td>
			<td>
				<input class="form-control input-sm" style="width: 100%;" id="mtSkillId" type="text" name="mtSkill"/>
			</td>
			<td width="10%"><@spring.message "tech.title.kind"/></td>
			<td>
				<input class="form-control input-sm" style="width: 100%;" id="mtKindId" type="text" name="mtKind"/>
			</td>
			<td><@spring.message "tech.title.version"/></td>
			<td width="20%">
				<input class="form-control input-sm" style="width: 100%;" id="mtVersionId" type="text" name="mtVersion"/>
			</td>	
		</tr>
		<tr>
			<td><@spring.message "tech.title.name"/></td>
			<td colspan="3">
				<input class="form-control input-sm" style="width: 100%;" id="mtNameId" type="text" name="mtName"/>
			</td>	
			<td><@spring.message "tech.title.trend"/></td>
			<td>
				<input class="form-control input-sm" id="mtTrendId" style="width: 100%;" type="text" name="mtTrend"/>
			</td>
		</tr>
		<tr>
			<td><@spring.message "tech.title.explain"/></td>
			<td colspan="5">
				<input id="mtExplainId" class="form-control input-sm" style="width: 100%;" name="mtExplain" type="text" placeholder="explian"/>
			</td>
		</tr>
		</table>
		<input type="hidden" id="mtNoId" name="mtNo" />
		<br/>
		<p align="center">
			<button type="button" onclick="return confirmData('updateForm');" class="btn btn-primary" data-toggle="modal"><@spring.message "tech.button.confirm"/></button>
			<button class="btn btn-primary" type="button" onClick="updateFormCancel();"><@spring.message "tech.button.cancel"/></button>
			<a id="mTechDetailId" href="#" class="btn btn-success" style="width: 95px;" role="button" ><@spring.message "tech.button.input.detail"/></a>
			<button type="button" class="btn btn-danger" style="width: 80px;" onclick="javascript: removeProject();"><@spring.message "tech.button.detail.delete"/></button>
		</p>
	</form>
	</div>

	<div class="item-box">
	<table id="mTechId" class="table table-striped">
      <thead>
        <tr>
          <th>#</th>
          <th><@spring.message "tech.title.skills"/></th>
          <th><@spring.message "tech.title.kind"/></th>
          <th><@spring.message "tech.title.name"/></th>
          <th><@spring.message "tech.title.version"/></th>
          <th><@spring.message "tech.title.explain"/></th>
          <th><@spring.message "tech.title.relation"/></th>
          <th><@spring.message "tech.title.trend"/></th>
          <th><@spring.message "tech.title.status"/></th>
          <th><@spring.message "tech.title.update"/></th>
        </tr>
      </thead>
      <tbody>

      <#if model??>
      <#if model.mTechList?has_content>
      <#list model.mTechList as mTech>
      <tr onmouseover="overChangeColor(this);"  onmouseout="outChangeColor(this);" onclick="selectMTech(this, '${mTech.mtNo?if_exists?c}');">
      	<td>${mTech.mtNo?if_exists}</td>
      	<td>${mTech.mtSkill?if_exists}</td>
      	<td>${mTech.mtKind?if_exists}</td>
      	<td>${mTech.mtName?if_exists}</td>
      	<td>${mTech.mtVersion?if_exists}</td>
      	<td>${mTech.mtExplain?if_exists}</td>
      	<td>${mTech.mtRelation?if_exists}</td>
      	<td>${mTech.mtTrend?if_exists}</td>
      	<td>${mTech.mtStatus?if_exists}</td>
      	<td>${mTech.updateTime?string('yyyy/MM/dd')?if_exists}</td>
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
			<li><a href="sltMTechList?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}<#if model.sltMTechPara.mtSkill??>&mtSkill=${model.sltMTechPara.mtSkill?if_exists}</#if>" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="sltMTechList?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}<#if model.sltMTechPara.mtSkill??>&mtSkill=${model.sltMTechPara.mtSkill?if_exists}</#if>">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="sltMTechList?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}<#if model.sltMTechPara.mtSkill??>&mtSkill=${model.sltMTechPara.mtSkill?if_exists}</#if>" accesskey="#" title="Next">Next</a></li>
			</#if>
		</#if>
	  </#if>
      </ul>
    </nav><!-- end #nav -->

  </div><!-- #col-md-12 -->
</div><!-- #row -->

<!-- Update Modal -->
<div class="modal fade" id="submitFormMTech" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel"><@spring.message "tech.modal.title"/></h4>
      </div>

      <div id="confirmMessage" class="modal-body">
		<table id="t03" style="width:100%">
		<tr>
			<td width="10%"><@spring.message "tech.title.skills"/></td>
			<td></td>
			<td width="10%"><@spring.message "tech.title.kind"/></td>
			<td></td>
			<td width="10%"><@spring.message "tech.title.version"/></td>
			<td></td>
		</tr>
		<tr>
			<td><@spring.message "tech.title.name"/></td>
			<td colspan="3"></td>
			<td><@spring.message "tech.title.trend"/></td>
			<td></td>
		</tr>
		<tr>
			<td><@spring.message "tech.title.explain"/></td>
			<td colspan="5"></td>
		</tr>
		</table>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">
        	<@spring.message "projects.button.close"/>
        </button>
        <button id="submitForm" type="button" class="btn btn-primary">
        	<@spring.message "tech.button.save"/>
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

var table = document.getElementById("mTechId");
var tr = table.getElementsByTagName("tr");

function clearBackGroundColor() {
	for(var j=0; j< tr.length; j++) {
		tr[j].style.backgroundColor = "";
	}
}

var mtNoInput = document.getElementById("mtNoId");
var mtSkillInput = document.getElementById("mtSkillId");
var mtKindInput = document.getElementById("mtKindId");
var mtNameInput = document.getElementById("mtNameId");
var mtVersionInput = document.getElementById("mtVersionId");
var mtExplainInput = document.getElementById("mtExplainId");
var mtTrendInput = document.getElementById("mtTrendId");
var mTechDetailInput = document.getElementById("mTechDetailId");

function selectMTech(x, num) {

	clearBackGroundColor();

	$(document).ready(function() {

		var availableKeys;
		var currentAjaxNum = ajaxLastNum;

        $.ajax({
            type: 'POST',
            url: 'sltMTechAjax',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            data: 'body={ "mtNo" : "' + num + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	if(!isBlank(data.result)) {
            		availableKeys = data.result;
            		mtNoInput.value = availableKeys.mtNo;
            		mtSkillInput.value = availableKeys.mtSkill;
            		mtKindInput.value = availableKeys.mtKind;
            		mtNameInput.value = availableKeys.mtName;
            		mtVersionInput.value = availableKeys.mtVersion;
            		mtExplainInput.value = availableKeys.mtExplain;
            		mtTrendInput.value = availableKeys.mtTrend;
            		mTechDetailInput.href = "sltMTechDetailList/" + availableKeys.mtNo
            	}
            },
            complete: function(xhr, textStatus) {
            	console.log("complete");
            			
            	// Set a project title into Model
            	var dltMasterDataId = document.getElementById("dltMasterDataId");
            	dltMasterDataId.innerHTML = mtNameInput.value;

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

function newFormToggle() {

	$("#newMdataFormId").slideToggle("slow");
	$("#newToggleId").toggleClass('glyphicon-chevron-down glyphicon-chevron-up');
	mtNoInput.value = "";
	mtSkillInput.value = "";
	mtKindInput.value = "";
	mtNameInput.value = "";
	mtVersionInput.value = "";
	mtExplainInput.value = "";
	mtTrendInput.value = "";

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

// Insert a new mTech
function submitNewMdata() {
	document.newForm.submit();
}

// Update mTech
function submitUpdateMdata() {
	document.updateForm.submit();
}

// Delete mTech
function submitFormDeleteMdata() {
	document.updateForm.action = "dltMTech";
	document.updateForm.submit();
}

</script>

<#include "../../common/abilistsFooder.ftl"/>

</@layout.myLayout>