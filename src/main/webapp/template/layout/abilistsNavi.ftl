<#import "/spring.ftl" as spring/>
	<!-- Static navbar -->
    <nav class="navbar navbar-default navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/abilists"><img src="/static/img/bi02.png" class="img-responsive" width="70" alt="abilists" /></a>
        </div>

        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <#if user??>
            	<li <#if model??><#if model.navi??><#if model.navi == "profile">class="active"</#if></#if></#if>><a href="/profile"><@spring.message "navi.title.profile"/></a></li>
            	<li <#if model??><#if model.navi??><#if model.navi == "project">class="active"</#if></#if></#if>><a href="/project/sltProjectsList"><@spring.message "navi.title.abilists"/></a></li>
            	<li <#if model??><#if model.navi??><#if model.navi == "account">class="active"</#if></#if></#if>><a href="/account"><@spring.message "navi.title.account"/></a></li>
            	<li <#if model??><#if model.navi??><#if model.navi == "admin">class="active"</#if></#if></#if>><a href="/admin"><@spring.message "navi.title.admin"/></a></li>
            </#if>
          </ul>

      	  <ul class="nav navbar-nav navbar-right">
      	  	<#if user??>
      		  <#include "/login/naviLogin.ftl">
			<#else>
      		  <#include "/login/naviLogout.ftl">
	     	</#if>

<#include "abilistsLang.ftl"/>

      	  </ul>
        </div><!--/.nav-collapse -->
      </div><!--/container -->
    </nav><!--/navbar -->