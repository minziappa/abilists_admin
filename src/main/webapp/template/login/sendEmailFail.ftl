<#import "../layout/abilistsLayout.ftl" as layout>
<@layout.myLayout>

<div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title">Error</h3>
	</div>
	<div class="panel-body">
		<#include "../common/errorMessage.ftl"/>
	</div>
</div>

</@layout.myLayout>