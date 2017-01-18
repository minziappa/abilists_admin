<#import "/spring.ftl" as spring/>
	<ul class="nav nav-tabs" role="tablist">
		<li <#if model??><#if model.menu??><#if model.menu == "index">class="active"</#if></#if></#if>><a href="/abilists">Index</a></li>
	</ul>