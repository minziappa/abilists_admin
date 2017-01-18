<#import "/spring.ftl" as spring/>
<!-- Navigation -->
<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/">Abilists</a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
    <ul class="nav navbar-nav">
      <li <#if model??><#if model.navi??><#if model.navi == "Products">class="active"</#if></#if></#if>><a href="/products"><@spring.message "navi.title.products"/></a></li>
      <li <#if model??><#if model.navi??><#if model.navi == "Solustions">class="active"</#if></#if></#if>><a href="/solustions"><@spring.message "navi.title.solustions"/></a></li>
      <li <#if model??><#if model.navi??><#if model.navi == "Customers">class="active"</#if></#if></#if>><a href="/customers"><@spring.message "navi.title.customers"/></a></li>
      <li <#if model??><#if model.navi??><#if model.navi == "Customers">class="active"</#if></#if></#if>><a href="/abilists/"><@spring.message "navi.title.demo"/></a></li>
      <#if user??>
      	<li <#if model??><#if model.navi??><#if model.navi == "Dashboard">class="active"</#if></#if></#if>><a href="/auth/">Dashboard</a></li>
      	<li <#if model??><#if model.navi??><#if model.navi == "Bills">class="active"</#if></#if></#if>><a href="/users/userList">Bills</a></li>
      </#if>
    </ul>
	  <ul class="nav navbar-nav navbar-right">
	  	<#if user??>
		  <#include "/login/naviLogin.ftl">
		<#else>
		  <#include "/login/naviLogout.ftl">
		</#if>


	    
		<li class="dropdown">
		<#if lang?? && lang == "ko">
			<a href="?lang=ko" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"><span class="glyphicon glyphicon-globe" aria-hidden="true"></span>한국어<span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li><a href="?lang=en">영어</a></li>
				<li><a href="?lang=ja">일본어</a></li>
			</ul>
		<#elseif lang?? && lang == "ja">
			<a href="?lang=ja" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"><span class="glyphicon glyphicon-globe" aria-hidden="true"></span>日本語<span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li><a href="?lang=ko">韓国語</a></li>
				<li><a href="?lang=en">英語</a></li>
			</ul>
		<#else>
			<a href="?lang=en" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"><span class="glyphicon glyphicon-globe" aria-hidden="true"></span>English<span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li><a href="?lang=ko">Korea</a></li>
				<li><a href="?lang=ja">Japan</a></li>
			</ul>
		</#if>
		</li>
	  </ul>
	</div><!--/.nav-collapse -->

    <div class="navbar-default sidebar" role="navigation">
        <div class="sidebar-nav navbar-collapse">
            <ul class="nav" id="side-menu">
                <li>
                    <a href="/abilists/"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a>
                </li>
                <li>
                    <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i>Charts<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a href="/abilists/charts?option=1">Charts 1</a>
                        </li>
                        <li>
                            <a href="/abilists/charts?option=2">Charts 2</a>
                        </li>
                    </ul>
                    <!-- /.nav-second-level -->
                </li>
                <li>
                    <a href="#"><i class="fa fa-sitemap fa-fw"></i>Admin<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a href="/admin/users/usersList">User list</a>
                        </li>
                        <li>
                        	<a href="/admin/users/userProjectsList">Project list</a>
                        </li>
                        <li>
                            <a href="#">Third Level <span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level">
                                <li>
                                    <a href="#">Third Level Item</a>
                                </li>
                                <li>
                                    <a href="#">Third Level Item</a>
                                </li>
                            </ul>
                            <!-- /.nav-third-level -->
                        </li>
                    </ul>
                    <!-- /.nav-second-level -->
                </li>
            </ul>
        </div>
        <!-- /.sidebar-collapse -->
    </div>
    <!-- /.navbar-static-side -->
</nav>
