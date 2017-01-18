<#import "../../layout/abilistsAdminLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<style>

</style>


<div class="item-box" style="margin-top: 15px;">
<div class="row">
	<div class="col-md-8">
	<h3>
		<ol class="breadcrumb-std">
		  <li><a href="/admin"><@spring.message "dashboard.title.home"/></a></li>
		  <li class="active">Reload Master</li>
		</ol>
	</h3>
	</div>
	<div class="col-md-4">
		<span id="newToggleId" class="glyphicon glyphicon-refresh add-symbol" style="color:#337ab7;" aria-hidden="true"></span>
	</div>
</div>
</div>

<div class="row">
  <div class="col-md-12">

	<#include "../../common/errorMessage.ftl"/>
	<div align="center" id="completeId" class="list-group-item list-group-item-danger">complete</div>
	<div class="caption mittle-size-title"><h4>Reload Master</h4></div>
	<div class="item-box">
		Completed the reload.
    </div><!-- item-box -->

  </div><!-- #col-md-12 -->
</div><!-- #row -->

</script>

<#include "../../common/abilistsFooder.ftl"/>

</@layout.myLayout>