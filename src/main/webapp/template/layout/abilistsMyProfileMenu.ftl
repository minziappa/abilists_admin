<#import "/spring.ftl" as spring/>
	<ul class="nav nav-tabs" role="tablist">
		<li <#if model??><#if model.menu??><#if model.menu == "profile">class="active"</#if></#if></#if>><a href="/profile"><@spring.message "profile.menu.overview"/></a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "skills">class="active"</#if></#if></#if>><a href="/profile/sltMyTechList/skills"><@spring.message "profile.menu.skills"/></a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "lang">class="active"</#if></#if></#if>><a href="/profile/sltMyTechList/lang"><@spring.message "profile.menu.lang"/></a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "certi">class="active"</#if></#if></#if>><a href="/profile/sltMyTechList/certi"><@spring.message "profile.menu.certi"/></a></li>
		<#-- <li <#if model??><#if model.menu??><#if model.menu == "resume">class="active"</#if></#if></#if>><a href="/profile/${user.userId?if_exists}/resume"><@spring.message "profile.menu.resume"/></a></li> -->
	</ul>