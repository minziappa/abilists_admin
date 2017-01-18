<#import "../layout/abilistsAdminLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<!-- Morris.js-0.5.1 -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.2/raphael-min.js"></script>
<script src="/static/lib/morris.js-0.5.1/morris.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/prettify/r224/prettify.min.js"></script>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/prettify/r224/prettify.min.css">
<link href="/static/lib/morris.js-0.5.1/morris.css" rel="stylesheet">

<style>
.new-box {
    border: 1px solid #ccc;
    box-shadow: 1px 1px 2px #eee;
    margin: 10px 0;
    position: relative;
	overflow:hidden;
//	padding-top: 5px;
//	padding-left: 5px;
//	padding-right: 5px;
//	padding-bottom: 5px;
}

.margin-middle {
	margin-bottom: 10px;
	margin-left: 0px;
	margin-top: 10px;
}

.margin-small {
	margin-bottom: 5px;
	margin-left: 5px;
	margin-top: 5px;
}

div .test2 {
	width: 100%;
}
div .div-img {
	float:left;
	//background-color:blue;
	width:40px;
	height:40px;
//	padding-top: 5px;
//	padding-left: 5px;
//	padding-right: 5px;
//	padding-bottom: 5px;
	margin-bottom: 5px;
	margin-left: 5px;
	margin-right: 5px;
	margin-top: 5px;
}

</style>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header" style="margin: 15px 0 00px;"><@spring.message "dashboard.title.home"/></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>

            <div class="row">
	            <div class="col-md-6 right-col-cus">
	            	<div class="caption mittle-size-title"><h4><@spring.message "dashboard.title.user"/></h4></div>
	            	<div class="item-box">
	                <div id="user-month-graph" style="height: 250px;" class="graph"></div>
	            </div>
	            </div>
	            <div class="col-md-6 left-col-cus">
	            	<div class="caption mittle-size-title"><h4><@spring.message "dashboard.title.projects"/></h4></div>
	            	<div class="item-box">
	                	<div id="projects-month-graph" style="height: 250px;" class="graph"></div>
	            	</div>
	            </div>
            </div>

            <!-- /.row -->
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-cog fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">${model.techsSum?if_exists}</div>
                                    <div><@spring.message "admin.menu.mtech"/></div>
                                </div>
                            </div>
                        </div>
                        <a href="/admin/master/sltMTechList">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-green">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-industry fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">${model.industrySum?if_exists}</div>
                                    <div><@spring.message "admin.menu.mindustry"/></div>
                                </div>
                            </div>
                        </div>
                        <a href="/admin/master/sltMIndustryList">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-yellow">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-id-card-o fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">${model.rolesSum?if_exists}</div>
                                    <div><@spring.message "admin.menu.mrole"/></div>
                                </div>
                            </div>
                        </div>
                        <a href="/admin/master/sltMRoleList">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-red">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-envelope-open-o fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">${model.notiSum?if_exists}</div>
                                    <div><@spring.message "admin.menu.notification"/></div>
                                </div>
                            </div>
                        </div>
                        <a href="/noti/sltNotiList">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <!-- /.row -->

            <div class="row">
	            <div class="col-lg-12">
	    		<#if model??>
	    		<#if model.taskBeanList?has_content>
	    		<#list model.taskBeanList as taskBean>
					<div class="new-box" onmouseover="overChangeColor(this);"  onmouseout="outChangeColor(this);" onclick="goToDetail('${taskBean.userTask.userId?if_exists}', '${taskBean.userTask.utkNo?string?if_exists}');">
						<div class="div-img">
							<img width="40" id="showImg" alt="image" src="${taskBean.userImgData?if_exists}" />
						</div>
						<div class="div-left">
							${taskBean.userTask.utkWorkDay?string('yyyy-MM-dd')?if_exists}
						</div>
					     <div class="div-left">
					     <#if taskBean.userTask.utkTask??>
					     	<#if 20 < taskBean.userTask.utkTask?length >
							${taskBean.userTask.utkTask?if_exists[0..20]}...
							<#else>
							${taskBean.userTask.utkTask?if_exists}
							</#if>
						  </#if>
						 </div>
						<div id="detailId" class="div-right" style="background-color:#eee;">
					     	<span class="glyphicon glyphicon-option-horizontal"></span><br/>
					     	DETAIL
						</div>
					     <div class="div-right">
						    Project 30
						 </div>
				    </div>
				</#list>
				</#if>
				</#if>
	            </div><!-- /.col-lg-12 -->
            </div><!-- /.row -->

<script>

//Use Morris.Bar
Morris.Bar({
  element: 'user-month-graph',
  data: [
  <#if model.adminUsersSumByMonthList?has_content>
	<#list model.adminUsersSumByMonthList as adminUsersSumByMonth>
		{x: '${adminUsersSumByMonth.month?if_exists}', users: '${adminUsersSumByMonth.cnt?string?if_exists}' }<#if adminUsersSumByMonth?has_next>,</#if>
	</#list>
  <#else>
		{x: 'no data', users: '0' }
  </#if>
  ],
  xkey: 'x',
  ykeys: ['users'],
  labels: ['users'],
  barRatio: 0.4,
  xLabelAngle: 35,
  barColors: function () {return 'rgb(70,130,215)'},
  resize: true,
  hideHover: 'auto'
});

//Use Morris.Bar
Morris.Bar({
  element: 'projects-month-graph',
  data: [
  <#if model.adminProjectsSumByStatusList?has_content>
	<#list model.adminProjectsSumByStatusList as adminProjectsSumByStatus>
		{x: 'projects', projects: '${adminProjectsSumByStatus.cnt?string?if_exists}' }<#if adminProjectsSumByStatus?has_next>,</#if>
	</#list>
  <#else>
		{x: 'no data', projects: '0' }
  </#if>
  ],
  xkey: 'x',
  ykeys: ['projects'],
  labels: ['projects'],
  barRatio: 0.4,
  xLabelAngle: 35,
  barColors: function () {return 'rgb(70,130,215)'},
  resize: true,
  hideHover: 'auto'
});

function overChangeColor(obj) {
	obj.style.cursor = "pointer";
	obj.style.borderColor = "#e0e6f9";
	var deep1 = obj.childNodes;
	deep1[5].style.backgroundColor = "#e0e6f9";
}

function outChangeColor(obj) {
	obj.style.cursor = "pointer";
	obj.style.borderColor = "#ccc";
	var deep1 = obj.childNodes;
	deep1[5].style.backgroundColor = "#eee";
}

function goToDetail(userId, utkNo) {

	window.location.href="admin/project/sltTaskList";
	
}

</script>

</@layout.myLayout>