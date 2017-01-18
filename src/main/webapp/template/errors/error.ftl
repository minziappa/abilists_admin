<#import "../layout/abilistsErrorsLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>
<div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title"><@spring.message "index.heading.title3"/></h3>
	</div>
	<div class="panel-body">
		<#include "../common/errorMessage.ftl"/>
	</div><!-- /panel panel-primary -->
</div>
</@layout.myLayout>