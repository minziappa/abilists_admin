<#import "../layout/abilistsNotiLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<div class="item-box" style="margin-top: 15px;">
	<div class="row">
		<div class="col-md-6">
			<nav class="breadcrumbs">
			<ul>
			<li><a href="/noti/sltNotiForUserList">Notification</a></li>
			<li class="active"><a href="#">${model.notification.notiTitle?if_exists}</a></li>
			</ul>
			</nav>
		</div>
		<div class="col-md-6">
		</div>
	</div>
</div>

<div class="row">
  <div class="col-md-12">

	<div class="item-box">
		<table id="updateForm" style="width:100%">
			<tr>
				<td width="15%"><@spring.message "noti.view.title.tile"/></td>
				<td>${model.notification.notiTitle?if_exists}</td>
				<td width="15%"><@spring.message "noti.view.title.start.day"/></td>
				<td width="15%"><@spring.message "noti.view.title.kind"/></td>
			</tr>
			<tr>
				<td><@spring.message "noti.view.title.contents"/></td>
				<td>${model.notification.notiContents?if_exists}</td>
				<td><@spring.message "noti.view.title.end.day"/></td>
				<td>${model.notification.notiKind?if_exists}</td>
			</tr>
		</table>
	</div>

  </div><!-- #col-md-12 -->
</div><!-- #row -->

</@layout.myLayout>