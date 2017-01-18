	<ul role="tablist" class="nav nav-tabs">
		<li <#if model??><#if model.menu??><#if model.menu == "index">class="active"</#if></#if></#if>><a href="/auth/">Index</a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "inputAuth">class="active"</#if></#if></#if>><a href="/auth/inputAuth">Input auth</a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "authList">class="active"</#if></#if></#if>><a href="/auth/authList">Auth list</a></li>
		<li <#if model??><#if model.menu??><#if model.menu == "authDetail">class="active"</#if></#if></#if>><a href="#">Auth Detail</a></li>
	</ul>