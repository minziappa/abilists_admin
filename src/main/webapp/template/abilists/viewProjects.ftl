<#import "/spring.ftl" as spring/>

<style>
	.dl-horizontal dd {
	    margin-left: 110px;
	}

	.dl-horizontal dt {
	    width: 100px;
	}
</style>

  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">
    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
    <h4 class="modal-title" id="myModalLabel"><@spring.message "navi.title.projects"/></h4>
  </div>

  <div id="confirmMessage" class="modal-body">

	<#if model.userProjects??>
	<dl class="dl-horizontal">
	
		<dt><@spring.message "projects.title.name"/></dt>
		<dd>${model.userProjects.upName?if_exists}</dd>
		<dt><@spring.message "projects.title.team.number"/></dt>
		<dd>${model.userProjects.upMembers?if_exists}</dd>
		<dt><@spring.message "projects.title.industy"/></dt>
		<dd>
			<#if commonBean??>
			<#if commonBean.mIndustryMap?has_content>
				<#if commonBean.mIndustryMap["${lang?if_exists}"]??>
				<#list commonBean.mIndustryMap["${lang?if_exists}"] as mIndustry>
					<#if model.userProjects.upIndustrial == "${mIndustry.miCode?if_exists}">
					${mIndustry.miLargeCategory?if_exists}
					</#if>
				</#list>
				</#if>
			</#if>
			</#if>
		</dd>
		<dt><@spring.message "projects.title.explain"/></dt>
		<dd>${model.userProjects.upExplain?if_exists}</dd>
		<dt><@spring.message "projects.title.role"/></dt>
		<dd>
			<#if commonBean??>
				<#if commonBean.mRoleList?has_content>
				<#list commonBean.mRoleList as mRole>
					<#if model.userProjects.upRole == "${mRole.mrNo?if_exists}">
						${mRole.mrName?if_exists}
			    	</#if>
			    </#list>
			    </#if>
			</#if>
		</dd>
	</dl>
	</#if>
  </div>

  <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
  </div>
