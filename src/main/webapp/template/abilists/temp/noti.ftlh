
		      <#if model??>
		      <#if model.notificationList?has_content>
		      <div class="list-group">
		      	<#list model.notificationList as notification>
		        <a href="#" onclick="viewNoti('${notification.notiNo?if_exists}'); return false;" class="list-group-item">
		        	<i class="glyphicon glyphicon-menu-hamburger" style="color: #f2f2f2;"></i> ${notification.notiTitle?if_exists}
	            	<span class="pull-right">${notification.updateTime?string('yyyy/MM/dd')?if_exists}</span>
	            </a>
				</#list>
			  </div>
		      </#if>
		      </#if>
