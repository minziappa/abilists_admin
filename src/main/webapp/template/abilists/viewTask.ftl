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
    <h4 class="modal-title" id="myModalLabel"><@spring.message "home.title.task"/></h4>
  </div>

  <div id="confirmMessage" class="modal-body">

	<#if model.userTask??>
	<dl class="dl-horizontal">
		<dt><@spring.message "task.title.workday"/></dt>
		<dd>${model.userTask.utkWorkDay?string('yyyy-MM-dd')?if_exists}</dd>
		<dt><@spring.message "task.title.task"/></dt>
		<dd>
			<#if model.userTask.utkTask??>
			${model.userTask.utkTask?string?if_exists}
			</#if>
		</dd>
		<dt><@spring.message "task.title.update"/></dt>
		<dd>${model.userTask.updateTime?string('yyyy-MM-dd')?if_exists}</dd>
	</dl>
	</#if>

  </div>

  <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
  </div>