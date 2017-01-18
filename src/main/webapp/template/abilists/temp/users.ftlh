		<#if model??>
		<#if model.usersList?has_content>
		<ul style="padding: 0;" class="list-unstyled top_profiles">
			<#list model.usersList as user>

	            <li class="media" style="margin-top: 5px;">
	                <div class="pull-left thumbnail-hover">
	                    <div class="overflow-hidden">
	                        <img width="50" alt="image" src="/static/img/15/ec97c2330e36c9dcadeadec6715570.png">
	                    </div>
	                </div>
	                <div style="float: left">
		                <a href="/profile/${user.userId?if_exists}" class="title">${user.userId?if_exists}</a>
		                <p>${user.userName?if_exists} ${user.updateTime?string('yyyy/MM/dd')?if_exists}</p>
	                </div>
	                <a href="/profile/${user.userId?if_exists}" class="div-right profile-div-right">
	                	<span class="glyphicon glyphicon-option-horizontal"></span>
                    </a>
	            </li>

	        </#list>
	    </ul>
		</#if>
		</#if>