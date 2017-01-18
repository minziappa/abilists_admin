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
    <h4 class="modal-title" id="myModalLabel"><@spring.message "home.title.notification"/></h4>
  </div>

  <div id="confirmMessage" class="modal-body">

	<#if model.notification??>
	<dl class="dl-horizontal">
		<dt><@spring.message "noti.view.title.tile"/></dt>
		<dd>${model.notification.notiTitle?if_exists}</dd>
		<dt><@spring.message "noti.view.title.kind"/></dt>
		<dd>${model.notification.notiKind?if_exists}</dd>
		<dt><@spring.message "noti.view.title.start.day"/></dt>
		<dd>${model.notification.notiStart?string('yyyy/MM/dd')?if_exists}</dd>
		<dt><@spring.message "noti.view.title.end.day"/></dt>
		<dd>${model.notification.notiEnd?string('yyyy/MM/dd')?if_exists}</dd>
		<dt><@spring.message "noti.view.title.contents"/></dt>
		<dd>${model.notification.notiContents?if_exists}</dd>
	</dl>
	</#if>

  </div>

  <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
  </div>