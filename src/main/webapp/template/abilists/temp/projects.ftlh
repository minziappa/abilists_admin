
	      <#if model??>
	      <#if model.userProjectsList?has_content>
	      <ul class="timeline">
	      	<#list model.userProjectsList as userProjects>

	      		<#if (userProjects_index % 2) == 0 >
	      			<li>
		                <div class="timeline-badge" style="background-color: #4670b5;">
	                	<span class="glyphicon glyphicon-chevron-left" style="line-height: 2.5;" aria-hidden="true"></span>
	                	</div>
	      		<#else>
	      			<li class="timeline-inverted">
		                <div class="timeline-badge" style="background-color: #46b562;">
	                	<span class="glyphicon glyphicon-chevron-right" style="line-height: 2.5;" aria-hidden="true"></span>
	                	</div>
	      		</#if>
	                <div class="timeline-panel">
	                    <div class="timeline-heading">
	                        <h5 class="timeline-title"><a href="#" onclick="viewProject('${userProjects.upNo?if_exists}'); return false;">${userProjects.upName?if_exists}</a></h5>
	                        <p><small class="text-muted">${userProjects.updateTime?string('yyyy/MM/dd')?if_exists}</small>
	                        </p>
	                    </div>
	                    <div class="timeline-body">
	                        <p>
								<#if 5 < userProjects.upExplain?length >
								${userProjects.upExplain?if_exists[0..7]}...
								<#else>
								${userProjects.upExplain?if_exists}
								</#if>
	                        </p>
	                    </div>
	                </div>
                </li>

			</#list>
	      </ul>
	      </#if>
	      </#if>