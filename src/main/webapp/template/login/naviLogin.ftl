			<li>
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">
					<span class="glyphicon glyphicon-envelope" aria-hidden="true"></span> <#if notiCnt??><span class="badge">${notiCnt?c}</span></#if>
				</a>
                <ul class="dropdown-menu dropdown-noti">

                <#if userNotiList??>
                <#if userNotiList?has_content>
                <#list userNotiList as userNoti>
	                <li>
	                    <a href="/noti/sltNotiForUser/${userNoti.notiNo?if_exists}">
	                        <div>
	                        	${userNoti.notiTitle?if_exists}
	                            <span class="pull-right text-muted small"> ${userNoti.updateTime?string('dd/MM/yyyy')?if_exists} </span>
	                        </div>
	                    </a>
	                </li>
	                <li class="divider"></li>
	            </#list>
                </#if>
                </#if>
	                <li>
	                    <a class="text-center" href="/noti/sltNotiForUserList">
	                        <strong>See All Notification</strong>
	                    </a>
	                </li>
                </ul>
            <!-- /.dropdown-alerts -->
			</li>

			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
					<img style="border-radius: 4px;" src="${myPicture?if_exists}" height="20" width="20" alt="my picture" /><span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
					<li><a href="/profile"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> ${user.userName?if_exists} <@spring.message "profile.menu.profile"/></a></li>
					<li><a href="/account"><span class=" glyphicon glyphicon-lock" aria-hidden="true"></span> <@spring.message "account.menu.settings"/></a></li>
					<li class="divider"></li>
					<li><a href="/login/logout"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span> <@spring.message "login.sign.out"/><span class="sr-only">(current)</span></a></li>
				</ul>
			</li>