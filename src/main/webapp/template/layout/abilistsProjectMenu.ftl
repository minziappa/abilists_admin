<#import "/spring.ftl" as spring/>
	<ul class="nav nav-tabs" role="tablist">
		<li <#if model??><#if model.menu??><#if model.menu == "sltProjectsList">class="active"</#if></#if></#if>><a href="/project/sltProjectsList"><@spring.message "navi.title.projects"/></a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "sltProjectTechList">class="active"</#if></#if></#if>><a href="/project/sltProjectTechList"><@spring.message "navi.title.project.tech"/></a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "sltTaskList">class="active"</#if></#if></#if>><a href="/task/sltTaskList"><@spring.message "navi.title.project.task"/></a></li>
	</ul>