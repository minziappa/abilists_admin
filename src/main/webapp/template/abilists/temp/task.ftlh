
	      <#if model??>
	      <#if model.userTaskList?has_content>
	      <ul class="timeline">
	      	<#list model.userTaskList as userTask>

	      		<#if (userTask_index % 2) == 0 >
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
	                        <h5 class="timeline-title"><a href="#" onclick="viewTask('${userTask.utkNo?if_exists}'); return false;">${userTask.utkWorkDay?string('yyyy-MM-dd')?if_exists}</a></h5>
	                    </div>
	                    <div class="timeline-body">
	                        <p>
								<#if 7 < userTask.utkTask?length >
								${userTask.utkTask?if_exists[0..7]}...
								<#else>
								${userTask.utkTask?if_exists}
								</#if>
	                        </p>
	                    </div>
	                </div>
                </li>

			</#list>
	      </ul>
	      </#if>
	      </#if>