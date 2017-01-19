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

<script type="text/javascript">
/* Load select data from the server.*/
var mtechList = {};
<#if commonBean??>
<#if commonBean.getMtechMap("skills")?has_content>
	<#list commonBean.getMtechMap("skills")?keys as key>
	<#if key != "">
	mtechList['${key?if_exists}'] = [       
	    <#list commonBean.getMtechMap("skills")[key] as tech>
	    	{mtNo : "${tech.mtNo?if_exists}",mtName: "${tech.mtName?if_exists}"}<#if tech?has_next>,</#if>
	    </#list>
	];
	</#if>
	</#list>
</#if>
</#if>


/*
 * Remove a tech information of a project.
 */
function removeProjectTech() {
	// Call the modal for deleting
	$(window).ready(function(){
		$('#submitFormDeleteProjectTech').modal('show')
	});
}

</script>

<script type="text/javascript" src="/static/js/userProjectTech.js"></script>
<div class="item-box" style="margin-top: 15px;">
<div class="row">
	<div class="col-md-8">
		<h3>
			<ol class="breadcrumb-std">
			  <li><a href="/admin"><@spring.message "dashboard.title.home"/></a></li>
			  <li><a href="/admin/project/sltProjectsList"><@spring.message "admin.menu.projects"/></a></li>
			  <li class="active"><@spring.message "admin.menu.projects.tech.list"/></li>
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
		<div align="center" id="completeId" class="list-group-item list-group-item-danger">complete</div>

		<#if model.userProjects??>
		<div class="caption mittle-size-title"><h4><@spring.message "admin.menu.projects"/></h4></div>
		<div class="item-box">
			<table id="t01">
			<tr>
			  <th><@spring.message "projects.title.name"/></th>
			  <th><@spring.message "projects.title.industy"/></th>
			  <th><@spring.message "projects.title.role"/></th>
			  <th><@spring.message "projects.title.explain"/></th>
			</tr>
			<tr id="1">
				<td>${model.userProjects.upName?if_exists}</td>
				<td>
				<#if commonBean??>
				<#if commonBean.mIndustryMap?has_content>
					<#if commonBean.mIndustryMap["${lang?if_exists}"]??>
					<#list commonBean.mIndustryMap["${lang?if_exists}"] as mIndustry>
					<#if model.userProjects.upIndustrial??>
						<#if model.userProjects.upIndustrial == "${mIndustry.miCode?if_exists}">
						${mIndustry.miLargeCategory?if_exists}
						</#if>
					</#if>
					</#list>
					</#if>
				</#if>
				</#if>
				</td>
				<td>
			    <#if commonBean??>
			    <#if commonBean.mRoleList?has_content>
			    <#list commonBean.mRoleList as mRole>
			    	<#if model.userProjects.upRole == "${mRole.mrNo?if_exists}">
			    		${mRole.mrName?if_exists}
			    	</#if>
			    </#list>
			    </#if>
			    </#if>
				</td>
				<td>${model.userProjects.upExplain?if_exists}</td>
			</tr>
			</table>
		</div>
		</#if>

		<div class="caption mittle-size-title">

			<div class="row">
				<div class="col-md-6">
					<h4><@spring.message "admin.menu.projects.tech.list"/></h4>
				</div>
				<div class="col-md-6">
					<#if model.userProjects??>
					<span id="newToggleId" class="glyphicon glyphicon-chevron-down add-symbol" style="color:#337ab7;" aria-hidden="true" onClick="newFormToggle();"></span>
					</#if>
				</div>
			</div>

		</div>
		
		<#if model.userProjects??>
		<div class="item-box" id="newUserProjectTechForm">
		<form name="newForm" action="/admin/project/istProjectTech" method="post" onkeypress="return captureReturnKey(event);">
			<table id="newFormId">
			<tr>
				<td>
					<select id="newUptKindId" name="uptKind" class="taForm" onchange="changeSelect(document.newForm)">
						<option value="0"><@spring.message "tech.select.default.tech"/></option>
					<#if commonBean??>
					<#if commonBean.getMtechMap("skills")?has_content>
						<#list commonBean.getMtechMap("skills")?keys as key>
						<option value="${key?if_exists}">${key?if_exists}</option>
						</#list>
					</#if>
					</#if>
					</select>
				</td>
				<td>
					<select id="newMtNoId" name="mtNo" class="taForm" onchange="changeUtLevelSelect(0)">
						<option value="0"><@spring.message "tech.select.default.tech"/></option>
					</select>
				</td>
				<td>
					<select name="uptLevel" class="taForm">
						<option value="0"><@spring.message "tech.select.default.detail"/></option>
					</select>
				</td>
				<td>
					<textarea style="height: 50px;" class="taForm" name="uptDetail" placeholder="Detail"></textarea>
				</td>
			</tr>
			<input type="hidden" name="cnt" value="0" id="cnt01" autocomplete="off" />
			<input type="hidden" name="upNo" value="<#if model??><#if model.userProjects??>${model.userProjects.upNo?if_exists}</#if></#if>"/>
			<input type="hidden" name="uptNo" />
			</table>
			<br/>
			<p align="center">
				<button type="button" onclick="return confirmData('newFormId');" class="btn btn-primary" data-toggle="modal">
					<@spring.message "tech.button.confirm"/>
				</button>
				<button class="btn btn-primary" type="button" onClick="newFormCancel();">
					<@spring.message "tech.button.cancel"/>
				</button>
			</p>
		</form>
		</div>
		</#if>

		
		<div class="item-box" id="updateUserProjectTechForm">
		<form name="updateForm" action="/admin/project/udtProjectTech" method="post" onkeypress="return captureReturnKey(event);">
			<table id="updateFormId">
				<tr>
				<td>
					<select id="uptKindId" name="uptKind" class="taForm" onchange="changeSelect(document.updateForm)">
						<option value="0"><@spring.message "tech.select.default.tech"/></option>
						<#if commonBean??>
						<#if commonBean.getMtechMap("skills")?has_content>
							<#list commonBean.getMtechMap("skills")?keys as key>
							<option value="${key?if_exists}">${key?if_exists}</option>
							</#list>
						</#if>
						</#if>
					</select>
				</td>
				<td>
					<select id="mtNoId" name="mtNo" class="taForm" onchange="changeUtLevelSelect(0)">
						<option value="0"><@spring.message "tech.select.default.tech"/></option>
						<#if commonBean??>
						<#if commonBean.getMtechMap("skills")?has_content>
							<#list commonBean.getMtechMap("skills")?keys as key>
								<#if commonBean.getMtechMap("skills")[key]??>
								<#list commonBean.getMtechMap("skills")[key] as tech>
									<option value="${tech.mtNo}">${tech.mtName?if_exists}</option>
								</#list>
								</#if>
							</#list>
						</#if>
						</#if>
					</select>
				</td>
				<td>
					<select id="uptLevelId" name="uptLevel" class="taForm">
						<option value="0"><@spring.message "tech.select.default.detail"/></option>
						<#if commonBean??>
						<#if commonBean.mTechDetailMap?has_content>
							<#list commonBean.mTechDetailMap?keys as key>
								<#if commonBean.mTechDetailMap[key]??>
									<#list commonBean.mTechDetailMap[key] as techDetail>
									<#if techDetail.mlCode == "${lang?if_exists}">
									<option value="${techDetail.mtdLevel?string?if_exists}">${techDetail.mtdLevelExplain?if_exists}</option>
									</#if>
									</#list>
								</#if>
							</#list>
						</#if>
						</#if>
					</select>
				</td>
				<td>
					<textarea class="taForm" style="height: 45px;" id="uptDetailId" name="uptDetail" placeholder="Detail"></textarea>
				</td>
			</tr>
			<input type="hidden" name="cnt" value="0" id="cnt01" autocomplete="off" />
			<input type="hidden" name="upNo" value="<#if model.userProjects??>${model.userProjects.upNo?if_exists}</#if>"/>
			<input type="hidden" id="uptNoId" name="uptNo" />
			</table>
			<br/>
			<p align="center">
				<button type="button" onclick="return confirmData('updateFormId');" class="btn btn-primary" data-toggle="modal">
					<@spring.message "tech.button.confirm"/>
				</button>
				<button class="btn btn-primary" type="button" onClick="updateFormCancel();">
					<@spring.message "tech.button.cancel"/>
				</button>
				<button type="button" class="btn btn-danger" style="width: 80px;" onclick="javascript: removeProjectTech();">
					<@spring.message "projects.button.delete"/>
				</button>
			</p>
		</form>
		</div>

		<div class="item-box">
		<table id="userProjectTechId" class="table table-striped">
	      <thead>
	        <tr>
	          <th><@spring.message "tech.title.number"/></th>
	          <th><@spring.message "tech.title.kind"/></th>
	          <th><@spring.message "tech.title.tech"/></th>
	          <th><@spring.message "tech.title.level"/></th>
	          <th><@spring.message "tech.title.detail"/></th>
	          <th><@spring.message "tech.title.update"/></th>
	        </tr>
	      </thead>
	      <tbody>

	      <#if model??>
	      <#if model.userProjectTechList?has_content>
	      <#list model.userProjectTechList as userProjectTech>
	      <tr onmouseover="overChangeColor(this);"  onmouseout="outChangeColor(this);" 
	    	  onclick="selectUserProjectTech(this, '${userProjectTech.uptNo?if_exists}', '${userProjectTech.mtNo?if_exists}');">
	      	<td>${userProjectTech.uptNo?if_exists}</td>
	      	<td>${userProjectTech.uptKind?if_exists}</td>
	      	<td>
				<#if commonBean??>
				<#if commonBean.getMtechMap("skills")?has_content>
					<#list commonBean.getMtechMap("skills")[userProjectTech.uptKind] as tech>
						<#if tech.mtNo == userProjectTech.mtNo>
							${tech.mtName?if_exists}
						</#if>
					</#list>
				</#if>
				</#if>
	      	</td>
	      	<td>
				<#if commonBean??>
				<#if commonBean.mTechDetailMap[userProjectTech.mtNo?string]??>
					<#list commonBean.mTechDetailMap[userProjectTech.mtNo?string] as techDetail>
						<#if techDetail.mtdLevel?string == userProjectTech.uptLevel>
						<#if techDetail.mlCode == lang?if_exists>
							${techDetail.mtdLevelExplain?if_exists}
						</#if>
						</#if>
					</#list>
				</#if>
				</#if>
	      	</td>
	      	<td>${userProjectTech.uptDetail?if_exists}</td>
	      	<td>${userProjectTech.updateTime?string('yyyy/MM/dd')?if_exists}</td>
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
			<li><a href="/admin/project/sltProjectTechList?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="/admin/project/sltProjectTechList?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="/admin/project/sltProjectTechList?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
			</#if>
		</#if>
	  </#if>
    	</ul>
    </nav><!-- end #nav -->

  </div><!-- col-md-12 -->
</div><!-- row -->

<!-- Modal - start-->
<div class="modal fade" id="submitFormUserProjectTech" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
        	<span class="sr-only"><@spring.message "projects.button.close"/></span>
        </button>
        <h4 class="modal-title" id="udtProjectTechTileId"><@spring.message "tech.title.input"/></h4>
      </div>

      <div class="modal-body">
	  	<table id="t03">
	  		<tr>
			  <th><@spring.message "tech.title.skills"/></th>
			  <th><@spring.message "tech.title.skills"/></th>
			  <th><@spring.message "tech.title.level"/></th>
			  <th><@spring.message "tech.title.detail"/></th>
			</tr>
		</table>
      </div>

      <div class="modal-footer">
      	<button type="button" class="btn btn-default" data-dismiss="modal" onclick="deleteTr('t03');">
      		<@spring.message "tech.button.close"/>
      	</button>
        <button id="submitForm" type="button" class="btn btn-primary" onclick="javascript: submitUdtFormProjectTech();">
        	<@spring.message "tech.button.save"/>
        </button>
      </div>
    </div>
  </div>
</div>
<!-- Modal - end-->

<!-- Delete Modal -->
<div class="modal fade" id="submitFormDeleteProjectTech" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <h4 class="modal-title" id="dltProjectTechTileId"><@spring.message "projects.title.modal"/></h4>
    </div>

    <div id="confirmMessage" class="modal-body">
    	<@spring.message "projects.confirm.message.delete"/>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal"><@spring.message "projects.button.close"/></button>
      <button id="submitForm" type="button" class="btn btn-danger" onclick="javascript: submitDeleteFormProjectTech();">
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

var uptNoInput = document.getElementById("uptNoId");
var uptKindInput = document.getElementById("uptKindId");
var mtNoInput = document.getElementById("mtNoId");
var uptLevelInput = document.getElementById("uptLevelId");
var uptDetailInput = document.getElementById("uptDetailId");

function selectUserProjectTech(x, uptNo, mtNo) {

	clearBackGroundColor();

	$(document).ready(function() {

		var userProjectTechKeys;
		var mTechDetailKeys;
		var currentAjaxNum = ajaxLastNum;

        $.ajax({
            type: 'POST',
            url: '/admin/project/sltProjectTechAjax',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            data: 'body={ "uptNo":"' + uptNo + '","mtNo" : "' + mtNo + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	if(!isBlank(data.result)) {
            		userProjectTechKeys = data.result.userProjectTech;
            		
            		mTechDetailKeys = data.result.mTechDetailList;

            		uptNoInput.value = userProjectTechKeys.uptNo;
            		uptKindInput.value = userProjectTechKeys.uptKind;
            		mtNoInput.value = userProjectTechKeys.mtNo;
            		uptLevelInput.value = userProjectTechKeys.uptLevel;
            		uptDetailInput.value = userProjectTechKeys.uptDetail;

                	// Set data from server in Select Tag
            		changeSelectInAjax(mTechDetailKeys);
            	}

            },
            complete: function(xhr, textStatus) {
            	console.log("complete");

            	// Set a project title into Model
            	var dltProjectTechTile = document.getElementById("dltProjectTechTileId");
            	dltProjectTechTile.innerHTML = uptKindInput.value;

            	var udtProjectTechTileId = document.getElementById("udtProjectTechTileId");
            	udtProjectTechTileId.innerHTML = uptKindInput.value;

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

	$("#newUserProjectTechForm").slideToggle("slow");
	$("#newToggleId").toggleClass('glyphicon-chevron-down glyphicon-chevron-up');

	uptNoInput.value = "";
	uptKindInput.value = "";
	mtNoInput.value = "";
	uptLevelInput.value = "";
	uptDetailInput.value = "";

	clearBackGroundColor();
	updateFormCancel();
}

function formSlideDown() {
	$("#updateUserProjectTechForm").slideDown("slow");
}

function newFormCancel() {
	$("#newUserProjectTechForm").slideUp("slow");
	$("#newToggleId").addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-up');
	clearBackGroundColor();
}

function updateFormCancel() {
	$("#updateUserProjectTechForm").slideUp("slow");
	$("#newToggleId").addClass('add-symbol');
	clearBackGroundColor();
}


// Set data from server when selecting the first select.//
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
		var mtech = new Option('<@spring.message "tech.select.default.tech"/>', '0');
		mtNoList.options.add(mtech);
		for (i = 0; i < mtechs.length; i++) {
			mtech = new Option(mtechs[i].mtName, mtechs[i].mtNo);
			mtNoList.options.add(mtech);
		}
	}
}

//
// -----     -------      -----------------
// |aaa|  -  | bbb |  ->  | result by Ajax|
// -----     -------      -----------------
//
// Set data from server when selecting the second select.
function changeUtLevelSelect(changedNum) {

	// This is the second select.
	var mtNoList = document.getElementsByName("mtNo")[changedNum];
	var mtNoListSelected = mtNoList.options[mtNoList.selectedIndex].value;

	var cdata = '{ "mtNo" : "' + mtNoListSelected + '"}';
	var curl = "/admin/master/sltMTechDetailListAjax";
	var cresult = requestbyAjax(curl,cdata);

	var uptLevelList = document.getElementsByName("uptLevel")[changedNum];

	// Delete the select's options
	while (uptLevelList.options.length) {
		uptLevelList.remove(0);
	}

	if(cresult) {
		var mTechDetail = new Option('<@spring.message "tech.select.default.detail"/>', '0');
		uptLevelList.options.add(mTechDetail);
		for (i = 0; i < cresult.mTechDetailList.length; i++) {
			mTechDetail = new Option(cresult.mTechDetailList[i].mtdLevelExplain, cresult.mTechDetailList[i].mtdLevel);
			uptLevelList.options.add(mTechDetail);
		}
	}
}

/* Set data from server when selecting a row in table.*/
function changeSelectInAjax(mTechDetailKeys) {

	var userSelected = uptKindInput.options[uptKindInput.selectedIndex].value;

	// Delete the select's options in Tech2
	while (mtNoInput.options.length) {
		mtNoInput.remove(0);
	}

	// Get a option of the first select.
	var mtechs = mtechList[userSelected];
	if (mtechs) {
		var i;
		var mtech = new Option('<@spring.message "tech.select.default.tech"/>', '0');
		mtNoInput.options.add(mtech);
		for (i = 0; i < mtechs.length; i++) {
			mtech = new Option(mtechs[i].mtName, mtechs[i].mtNo);
			mtNoInput.options.add(mtech);
		}
		
		// TODO
		// Set data as the selected option.
	}

	// Delete the select's options
	while (uptLevelInput.options.length) {
		uptLevelInput.remove(0);
	}

	// Set the explain to the tech
	var mTechDetail = new Option('<@spring.message "tech.select.default.tech"/>', '0');
	uptLevelInput.options.add(mTechDetail);
	if (mTechDetailKeys) {
		for (i = 0; i < mTechDetailKeys.length; i++) {
			if(mTechDetailKeys[i].mlCode == "${lang?if_exists}") {
				mTechDetail = new Option(mTechDetailKeys[i].mtdLevelExplain, mTechDetailKeys[i].mtdLevel);
				uptLevelInput.options.add(mTechDetail);
			}
		}
		// TODO
		// Set data as the selected option.
	}
}

function submitNewFormUserProjectTech() {
	document.newForm.submit();
}

function submitUpdateFormUserProjectTech() {
	document.updateForm.action = "/admin/project/udtProjectTech";
	document.updateForm.submit();
}

function submitDeleteFormProjectTech() {
	document.updateForm.action = "/admin/project/dltProjectTech";
	document.updateForm.submit();
}

</script>

<#include "../../common/abilistsFooder.ftl"/>

</@layout.myLayout>