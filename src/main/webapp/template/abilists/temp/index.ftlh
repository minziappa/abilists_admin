<#import "/spring.ftl" as spring/>

<div class="row">
	<div class="col-sm-6">

		<div class="default-box-line changeBgcolor">
		<h4>Engineer's profile list</h4>
		<#if model??>
		<#if model.usersList?has_content>
		<table class="table">
			<#list model.usersList as user>
				<tr>
					<td><a href="/profile/${user.userId?if_exists}">${user.userId?if_exists}</a></td>
					<td>${user.userName?if_exists}</td>
					<td>${user.updateTime?string('yyyy/MM/dd')?if_exists}</td>
				</tr>
	        </#list>
		</table>
		</#if>
		</#if>
		</div>

		<div class="default-box-line changeBgcolor">
			<h4>Project list.</h4>
		      <#if model??>
		      <#if model.userProjectsList?has_content>
		      <table class="table">
		      	<#list model.userProjectsList as userProjects>
					<tr>
						<td><a href="#" onclick="return viewProject('${userProjects.upNo?if_exists}');">${userProjects.upName?if_exists}</a></td>
						<td>
							<#if 5 < userProjects.upExplain?length >
								${userProjects.upExplain?if_exists[0..7]}...
							<#else>
								${userProjects.upExplain?if_exists}
							</#if>
						</td>
						<td>${userProjects.userName?if_exists}</td>
						<td>${userProjects.updateTime?string('yyyy/MM/dd')?if_exists}</td>
					</tr>
				</#list>
		      </table>
		      </#if>
		      </#if>
		</div>
	</div>
	<div class="col-sm-6">
		<div class="default-box-line changeBgcolor">
			<h4>Notification</h4>
		      <#if model??>
		      <#if model.notificationList?has_content>
		      <table class="table">
		      	<#list model.notificationList as notification>
					<tr>
						<td><a href="#" onclick="return viewNoti('${notification.notiNo?if_exists}');">${notification.notiTitle?if_exists}</a></td>
						<td>${notification.notiKind?if_exists}</td>
						<td>${notification.updateTime?string('yyyy/MM/dd')?if_exists}</td>
					</tr>
				</#list>
		      </table>
		      </#if>
		      </#if>
		</div>

		<div id="graph1" style="height: 250px;" class="graph-box"></div>

	</div>
</div>

<script>
Morris.Bar({
	  element: 'graph1',
	  data: [
	    {x: '2011 Q1', y: 3, z: 2, a: 3},
	    {x: '2011 Q2', y: 2, z: null, a: 1},
	    {x: '2011 Q3', y: 0, z: 2, a: 4},
	    {x: '2011 Q4', y: 2, z: 4, a: 3}
	  ],
	  xkey: 'x',
	  ykeys: ['y', 'z', 'a'],
	  labels: ['User count', 'Projects', 'Skills']
	}).on('click', function(i, row){
	  console.log(i, row);
	});
</script>