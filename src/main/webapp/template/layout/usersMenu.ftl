	<ul role="tablist" class="nav nav-tabs">
		<li <#if model??><#if model.menu??><#if model.menu == "aIndex">class="active"</#if></#if></#if>><a href="/users/">Index</a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "inputUser">class="active"</#if></#if></#if>><a href="/users/inputUser">Input user</a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "userList">class="active"</#if></#if></#if>><a href="/users/userList">User list</a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "userDetail">class="active"</#if></#if></#if>><a href="#">User Detail</a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "options">class="active"</#if></#if></#if>><a href="/options/userList">Options</a></li>
	</ul>