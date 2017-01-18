        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/admin">Admin</a>
                <a class="navbar-brand" href="/abilists"><img src="/static/img/bi02.png" class="img-responsive" width="70" alt="abilists" /></a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">

				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
					<img style="border-radius: 4px;" src="${myPicture?if_exists}" height="20" width="20" alt="my picture" /><span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="/profile"><i class="fa fa-user fa-fw"></i> ${user.userName?if_exists} <@spring.message "profile.menu.profile"/></a></li>
						<li><a href="/account"><i class="fa fa-gear fa-fw"></i> <@spring.message "account.menu.settings"/></a></li>
						<li class="divider"></li>
						<li><a href="/login/logout"><i class="fa fa-sign-out fa-fw"></i> <@spring.message "login.sign.out"/><span class="sr-only">(current)</span></a></li>
					</ul>
				</li>

				<#include "abilistsLang.ftl"/>

            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                            <a href="/admin"><i class="fa fa-dashboard fa-fw"></i> <@spring.message "menu.side.dashboard"/></a>
                        </li>
                        <li>
	                        <a href="#"><i class="fa fa-files-o fa-fw"></i> <@spring.message "admin.menu.projects"/><span class="fa arrow"></span></a>
	                        <ul class="nav nav-second-level">
	                          <li><a href="/admin/project/sltProjectsList"><@spring.message "menu.side.projects.list"/></a></li>
	                          <li><a href="/admin/project/sltProjectTechList"><@spring.message "menu.side.tech.list"/></a></li>
	                          <li><a href="/admin/project/sltTaskList"><@spring.message "menu.side.task.list"/></a></li>
	                        </ul>
                        </li>
                        <li>
	                        <a href="#"><i class="fa fa-files-o fa-fw"></i> <@spring.message "menu.side.users"/> <span class="fa arrow"></span></a>
	                        <ul class="nav nav-second-level">
	                          <li><a href="/admin/users/sltUsersList"><@spring.message "menu.side.users.list"/></a></li>
	                        </ul>
                        </li>
                        <li>
	                        <a href="#"><i class="fa fa-files-o fa-fw"></i> <@spring.message "admin.menu.mdata"/> <span class="fa arrow"></span></a>
	                        <ul class="nav nav-second-level">
	                          <li><a href="/admin/master/sltMTechList"><@spring.message "admin.menu.mtech"/></a></li>
	                          <li><a href="/admin/master/sltMRoleList"><@spring.message "admin.menu.mrole"/></a></li>
	                          <li><a href="/admin/master/sltMIndustryList"><@spring.message "admin.menu.mindustry"/></a></li>
	                        </ul>
                        </li>
                        <li>
            				<a href="/admin/noti/sltNotiList"><i class="fa fa-table fa-fw"></i> <@spring.message "admin.menu.notification"/></a>
            			</li>
                        <li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Charts<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="/charts/sltCharts1">Charts 1</a>
                                </li>
                                <li>
                                    <a href="/charts/sltCharts2">Charts 2</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                        	<a href="#"><i class="fa fa-refresh fa-fw"></i> <@spring.message "menu.side.reload"/><span class="fa arrow"></span></a>
	                        <ul class="nav nav-second-level">
	                          <li><a href="/admin/reloadMaster"><@spring.message "menu.side.master"/></a></li>
	                        </ul>
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->

            </div>
            <!-- /.navbar-static-side -->
        </nav>