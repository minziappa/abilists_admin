<#import "../../layout/abilistsAdminLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<style>

/*
 * Change the modal size.
 */
@media screen and (min-width: 768px) {
	#myModal .modal-dialog  {width:900px;}
}

</style>

<script type="text/javascript" src="/static/js/mTechDetail.js"></script>

<script>

function removeMTechDetail() {
	// Call the modal for deleting
	$(window).ready(function(){
		$('#submitFormDeleteMdataId').modal('show')
	});
}

</script>

<div class="item-box" style="margin-top: 15px;">
<div class="row">
	<div class="col-md-8">
		<h3>
		<ol class="breadcrumb-std">
		  <li><a href="/admin"><@spring.message "dashboard.title.home"/></a></li>
		  <li><a href="/admin/master/sltMTechList"><@spring.message "admin.menu.mtech"/></a></li>
		  <li class="active"><@spring.message "admin.menu.mtech.detail"/></li>
		</ol>
		</h3>
	</div>
	<div class="col-md-4">
		<form name="sltForm" action="/admin/master/sltMTechDetailList/<#if model.mTech??>${model.mTech.mtNo?if_exists}</#if>" method="post">
		<select class="horizon-align" name="mlCode" onchange="return sltDataList(this);">
			<option value="" <#if model.sltMTechDetailPara.mlCode?has_content><#if model.sltMTechDetailPara.mlCode == "all">selected</#if></#if>><@spring.message "admin.button.all"/></option>
			<option value="en" <#if model.sltMTechDetailPara.mlCode?has_content><#if model.sltMTechDetailPara.mlCode == "en">selected</#if></#if>><@spring.message "admin.button.english"/></option>
			<option value="ko" <#if model.sltMTechDetailPara.mlCode?has_content><#if model.sltMTechDetailPara.mlCode == "ko">selected</#if></#if>><@spring.message "admin.button.korea"/></option>
			<option value="ja" <#if model.sltMTechDetailPara.mlCode?has_content><#if model.sltMTechDetailPara.mlCode == "ja">selected</#if></#if>><@spring.message "admin.button.japan"/></option>
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

		<#if model.mTech??>
		<div class="caption" style="padding: 1px; padding-left: 10px;"><h4><@spring.message "admin.menu.mtech"/></h4></div>
		<div class="item-box">
			<table id="t01">
				<tr>
					<td><@spring.message "tech.title.skills"/></td>
					<td width="20%">
						${model.mTech.mtSkill?if_exists}
					</td>
					<td><@spring.message "tech.title.kind"/></td>
					<td width="20%">
						${model.mTech.mtKind?if_exists}
					</td>	
					<td><@spring.message "tech.title.version"/></td>
					<td width="20%">
						${model.mTech.mtVersion?if_exists}
					</td>
				</tr>
				<tr>
					<td><@spring.message "tech.title.name"/></td>
					<td colspan="3">
						${model.mTech.mtName?if_exists}
					</td>
					<td><@spring.message "tech.title.trend"/></td>
					<td>
						${model.mTech.mtTrend?if_exists}
					</td>
				</tr>
				<tr>
					<td><@spring.message "tech.title.explain"/></td>
					<td colspan="5">
						${model.mTech.mtExplain?if_exists}
					</td>
				</tr>
			</table>
		</div>
		</#if>

		<div class="caption" style="padding: 1px; padding-left: 10px;"><h4><@spring.message "admin.menu.mtech.detail"/></h4></div>
		<div class="item-box" id="newMTechDetailFormId">
		<form name="newForm" action="/admin/master/istMTechDetail" method="post" onkeypress="return captureReturnKey(event);">
		  	<table id="newFormId">
			  	<tr>
					<td><@spring.message "tech.detail.title.level"/></td>
					<td width="10%">
						<select name="mtdLevel">
							<option value="0"><@spring.message "tech.detail.title.value"/></option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
						</select>
					</td>
					<td><@spring.message "tech.detail.title.explain"/></td>
					<td>
						<input type="text" name="mtdLevelExplain" style="width:100%" placeholder="mtdLevelExplain" class="form-control" />
					</td>
					<td width="15%"><@spring.message "mindustry.title.country.code"/></td>
					<td width="20%">
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
				<button type="button" onclick="return confirmData('newFormId');" class="btn btn-primary" data-toggle="modal">Confirm</button>
				<input class="btn btn-primary" type="button" onClick="newFormCancel();" value="취소">
			</p>
			<input type="hidden" name="mtNo" value="<#if model.mTech??>${model.mTech.mtNo?if_exists}</#if>"/>
			<input type="hidden" name="mtKind" value="<#if model.mTech??>${model.mTech.mtKind?if_exists}</#if>"/>
		</form>
		</div>

		<div class="item-box" id="updateMTechDetailFormId">
		<form name="updateForm" action="/admin/master/udtMTechDetail" method="post" onkeypress="return captureReturnKey(event);">
			<table id="updateFormId">
			  	<tr>
					<td><@spring.message "tech.detail.title.level"/></td>
					<td width="10%">
						<select id="mtdLevelId" name="mtdLevel">
							<option value="0"><@spring.message "tech.detail.title.value"/></option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
						</select>
					</td>
					<td><@spring.message "tech.detail.title.explain"/></td>
					<td>
						<input type="text" id="mtdLevelExplainId" name="mtdLevelExplain" style="width:100%" placeholder="mtdLevelExplain" class="form-control"/>
					</td>
					<td width="10%"><@spring.message "mindustry.title.country.code"/></td>
					<td width="20%">
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
				<input type="hidden" name="mtNo" value="<#if model.mTech??>${model.mTech.mtNo?if_exists}</#if>"/>
				<input type="hidden" name="mtKind" value="<#if model.mTech??>${model.mTech.mtKind?if_exists}</#if>"/>
				<input type="hidden" id="mtdNoId" name="mtdNo" />
			</table>
			<br/>
			<p align="center">
				<button type="button" onclick="return confirmData('updateFormId');" class="btn btn-primary" data-toggle="modal">
					<@spring.message "tech.button.confirm"/>
				</button>
				<button class="btn btn-primary" type="button" onClick="updateFormCancel();">
					<@spring.message "tech.button.cancel"/>
				</button>
				<button type="button" class="btn btn-danger" style="width: 80px;" onclick="javascript: removeMTechDetail();">
					<@spring.message "tech.button.detail.delete"/>
				</button>
			</p>
		</form>
		</div>

		<div class="item-box">
		<table id="userProjectTechId" class="table table-striped">
	      <thead>

	        <tr>
	          <th>#</th>
	          <th><@spring.message "tech.detail.title.level"/></th>
	          <th><@spring.message "tech.detail.title.explain"/></th>
	          <th><@spring.message "tech.detail.title.country.code"/></th>
	          <th><@spring.message "tech.detail.title.update"/></th>
	        </tr>
	      </thead>
	      <tbody>

	      <#if model??>
	      <#if model.mTechDetailList?has_content>
	      <#list model.mTechDetailList as mTechDetail>
	      <tr onmouseover="overChangeColor(this);"  onmouseout="outChangeColor(this);" onclick="selectMTechDetail(this, '${mTechDetail.mtdNo?if_exists}');">
	      	<td>${mTechDetail.mtdNo?if_exists}</td>
	      	<td>${mTechDetail.mtdLevel?if_exists}</td>
	      	<td>${mTechDetail.mtdLevelExplain?if_exists}</td>
	      	<td>${mTechDetail.mlCode?if_exists}</td>
	      	<td>${mTechDetail.updateTime?string('yyyy/MM/dd')?if_exists}</td>
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
				<li><a href="/admin/master/sltMTechDetailList?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
				</#if>
				<#if model.paging.pagingInfoList?has_content>
					<#list model.paging.pagingInfoList as pageList>
						<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
						<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
						<#else>
						<li><a href="/admin/master/sltMTechDetailList?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
						</#if>
					</#list>
				</#if>
				<#if model.paging.nextPage?exists>
				<li><a href="/admin/master/sltMTechDetailList?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
				</#if>
			</#if>
			</#if>
	    	</ul>
    	</nav><!-- end #nav -->

  </div><!-- #col-md-12 -->
</div><!-- #row -->


<!-- Modal - start-->
<div class="modal fade" id="submitFormMTechDetailId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel"><@spring.message "tech.modal.title"/></h4>
      </div>

      <div class="modal-body">
	  	<table id="t03">
	  		<tr>
			  <th><@spring.message "tech.detail.title.level"/></th>
			  <th><@spring.message "tech.detail.title.explain"/></th>
			</tr>
		</table>
      </div>

      <div class="modal-footer">
      	<button type="button" class="btn btn-default" data-dismiss="modal" onclick="deleteTr('t03');">Close</button>
        <button id="submitForm" type="button" class="btn btn-primary" onclick="javascript: submitform();">Save Data</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal - end-->

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


<script>

var ajaxLastNum = 0;

var table = document.getElementById("userProjectTechId");
var tr = table.getElementsByTagName("tr");

function clearBackGroundColor() {
	for(var j=0; j< tr.length; j++) {
		tr[j].style.backgroundColor = "";
	}
}

var mtdNoInput = document.getElementById("mtdNoId");
var mtdLevelInput = document.getElementById("mtdLevelId");
var mtdLevelExplainInput = document.getElementById("mtdLevelExplainId");
var mlCodeInput = document.getElementById("mlCodeId");

function selectMTechDetail(x, num) {

	clearBackGroundColor();

	$(document).ready(function() {

		var availableKeys;
		var currentAjaxNum = ajaxLastNum;

        $.ajax({
            type: 'POST',
            url: '/admin/master/sltMTechDetailAjax',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            data: 'body={ "mtdNo" : "' + num + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	if(!isBlank(data.result)) {
            		availableKeys = data.result;
            		console.log("mtdNo >> " + availableKeys.mtdNo);
            		mtdNoInput.value = availableKeys.mtdNo;
            		mtdLevelInput.value = availableKeys.mtdLevel;
            		mtdLevelExplainInput.value = availableKeys.mtdLevelExplain;
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

	$("#newMTechDetailFormId").slideToggle("slow");
	$("#newToggleId").toggleClass('glyphicon-chevron-down glyphicon-chevron-up');
	mtdNoInput.value = "";
	mtdLevelInput.value = "";
	mtdLevelExplainInput.value = "";
	mlCodeInput.value = "";

	clearBackGroundColor();
	updateFormCancel();
}

function formSlideDown() {
	$("#updateMTechDetailFormId").slideDown("slow");
}

function newFormCancel() {
	$("#newMTechDetailFormId").slideUp("slow");
	$("#newToggleId").addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-up');
	clearBackGroundColor();
}

function updateFormCancel() {
	$("#updateMTechDetailFormId").slideUp("slow");
	$("#newToggleId").addClass('add-symbol');
	clearBackGroundColor();
}

/* Change the next select list depending on the first select.*/
function changeSelect(form) {

	// This is the first select.
	var kindList = form.uptKind;
	// This is the second select.
	var mtNoList = form.mtNo;
	var userSelected = kindList.options[kindList.selectedIndex].value;

	// Delete the select's options
	while (mtNoList.options.length) {
		mtNoList.remove(0);
	}

	// Get a option of the first select.
	var mtechs = mtechList[userSelected];
	if (mtechs) {
		var i;
		for (i = 0; i < mtechs.length; i++) {
			var mtech = new Option(mtechs[i].mtName, mtechs[i].mtNo);
			mtNoList.options.add(mtech);
		}
	}

}

function submitNewFormMTechDetail() {
	document.newForm.submit();
}

function submitUpdateFormMTechDetail() {
	document.updateForm.submit();
}

//Delete mTech
function submitFormDeleteMdata() {
	document.updateForm.action = "/admin/master/dltMTechDetail";
	document.updateForm.submit();
}

</script>

<#include "../../common/abilistsFooder.ftl"/>

</@layout.myLayout>