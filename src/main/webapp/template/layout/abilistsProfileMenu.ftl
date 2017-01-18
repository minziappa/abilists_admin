<#import "/spring.ftl" as spring/>
	<ul class="nav nav-tabs" role="tablist">
		<li <#if model.menu??><#if model.menu == "profile">class="active"</#if></#if>><a href="/profile/<#if model.users??>${model.users.userId?if_exists}</#if>"><@spring.message "profile.menu.overview"/></a></li>
		<li <#if model.menu??><#if model.menu == "techs">class="active"</#if></#if>><a href="/profile/<#if model.users??>${model.users.userId?if_exists}/techs</#if>"><@spring.message "profile.menu.techs"/></a></li>
	</ul>