<#import "../layout/abilistsNotiLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<script type="text/javascript">

$(document).ready(function(){
    $("#flip").click(function(){
        // $("#sampleForm").slideUp("slow");
    });
});

function notiCanel() {
	$("#notiDivId").slideUp("slow");
	clearBackGroundColor();
}

function formSlideDown() {
	$("#notiDivId").slideDown("slow");
}

window.onload = function() {
	$("#notiDivId").hide();
}

</script>

<div class="item-box" style="margin-top: 15px;">
	<div class="row">
		<div class="col-md-6">
			<nav class="breadcrumbs">
			<ul>
			<li class="active"><a href="#">Notification</a></li>
			</ul>
			</nav>
		</div>
		<div class="col-md-6">
		</div>
	</div>
</div>

<div class="row">
  <div class="col-md-12">

	<div id="notiDivId" class="item-box">
		<table id="updateForm" style="width:100%">
			<tr>
				<td width="15%"><@spring.message "noti.view.title.tile"/></td>
				<td><span id="notiTitleId"></span></td>
				<td width="15%"><@spring.message "noti.view.title.kind"/></td>
			</tr>
			<tr>
				<td><@spring.message "noti.view.title.contents"/></td>
				<td><span id="notiContentsId"></span></td>
				<td><span id="notiKindId"></span></td>
			</tr>
		</table>
		<input type="hidden" id="notiNoId" name="notiNo" />
		<br/>
		<p align="center">
			<button type="button" onClick="notiCanel();" class="btn btn-primary">Close</button>
		</p>
	</div>

	<div class="item-box">
		<table id="notiListId" class="table table-striped">
	      <thead>
	        <tr>
	          <th>#</th>
	          <th><@spring.message "noti.view.title.tile"/></th>
	          <th><@spring.message "noti.view.title.contents"/></th>
	          <th><@spring.message "noti.view.title.kind"/></th>
	          <th><@spring.message "noti.view.title.udate"/></th>
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
				<li><a href="sltNotiForUserList?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
				</#if>
				<#if model.paging.pagingInfoList?has_content>
					<#list model.paging.pagingInfoList as pageList>
						<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
						<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
						<#else>
						<li><a href="sltNotiForUserList?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
						</#if>
					</#list>
				</#if>
				<#if model.paging.nextPage?exists>
				<li><a href="sltNotiForUserList?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
				</#if>
			</#if>
		  </#if>
      	</ul>
	</nav><!-- end #nav -->

	</div><!-- end #col-md-12 -->
</div><!-- end #row -->

<script type="text/javascript"> 

var ajaxLastNum = 0;

var table = document.getElementById("notiListId");
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
// var notiStartInput = document.getElementById("notiStartId");
// var notiEndInput = document.getElementById("notiEndId");

function selectMTech(x, num) {

	clearBackGroundColor();
	var paraJson = '{"notiNo" : "' + num + '"}';

	$(document).ready(function() {

		var availableKeys;
		var currentAjaxNum = ajaxLastNum;

        $.ajax({
            type: 'POST',
            url: '/noti/sltNotiAjax',
            contentType: "application/json",
            dataType: "json",
            data: paraJson,
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {

            	if(!isBlank(data)) {
            		notiNoInput.innerHTML = data.notiNo;
            		notiTitleInput.innerHTML = data.notiTitle;
            		notiContentsInput.innerHTML = data.notiContents;
            		notiKindInput.innerHTML = data.notiKind;

//            		var startDate = new Date(data.notiStart);
//            		notiStartInput.innerHTML = startDate.toISOString().substr(0,10);
//            		var endDate = new Date(data.notiEnd);
//            		notiEndInput.innerHTML = endDate.toISOString().substr(0,10);
            		//notiEndInput.value = endDate.toISOString().substr(0,10).replace(/-/g, '/');
            	}
            },
            complete: function(xhr, textStatus) {
            	console.log("complete");
            	formSlideDown();

            	x.style.backgroundColor = "#9999CC";
            },
            error: function(xhr, status) {
            	console.log("error >> " + xhr.responseText);
            }
        });
	});
}

</script>
</@layout.myLayout>