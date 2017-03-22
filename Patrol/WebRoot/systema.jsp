<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />

<title>高校教学教务巡查系统</title>
<!-- Bootstrap core CSS -->

<!--external css-->
<link href="locks/font-awesome.css" rel="stylesheet" />

<link href="img/owl.png" rel="shortcut icon"/>

<!-- 全局强制性风格-->
<!-- 引入提示框样式 -->
<link href="media/css/jquery.gritter.css" rel="stylesheet"
	type="text/css" />



<link href="media/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />

<link href="media/css/bootstrap-responsive.min.css" rel="stylesheet"
	type="text/css" />

<link href="media/css/font-awesome.min.css" rel="stylesheet"
	type="text/css" />

<link href="media/css/style-metro.css" rel="stylesheet" type="text/css" />

<link href="media/css/style.css" rel="stylesheet" type="text/css" />

<link href="media/css/style-responsive.css" rel="stylesheet"
	type="text/css" />

<link href="media/css/default.css" rel="stylesheet" type="text/css"
	id="style_color" />

<link href="media/css/uniform.default.css" rel="stylesheet"
	type="text/css" />

<!-- 全局强制性风格结束 -->

<!-- 页面级别样式 -->

<link rel="stylesheet" type="text/css"
	href="media/css/select2_metro.css" />

<!-- 页面级别样式结束 -->

<style type="text/css">
.fa-lock:before {
	content: "\f023";
}

#showtime {
	width: 100%;
	color: #fff;
	font-size: 90px;
	margin-bottom: 30px;
	display: inline-block;
	text-align: center;
	font-weight: 400;
}

.lock_div{
margin-top:18%;
display: -webkit-box;  /*使用flexbox 布局*/
  -webkit-box-pack: center;  /*实现容器内容垂直居中*/
  -webkit-box-align: center; /* 实现容器内的内容水平居中*/
     -webkit-box-orient: vertical; /*容器内的元素垂直排列*/
/* 
	display: -webkit-box;
	-webkit-box-orient: horizontal;
	-webkit-box-pack: center; */	
}

.fa {
	color: #fff;
	font-size: 70px;
	margin-top: 30px;
	display: inline-block;
	text-align: center;
}

.fa:hover {
	color: #48CFAD;
}

.modal {
	background-color: #f2f2f2;
	background-clip: padding-box;
	border: 1px solid #999;
	border: 1px solid rgba(0, 0, 0, .2);
	border-radius: 5px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .5);
	text-align: center;
}

#lock-check {
	display: -webkit-box;
	-webkit-box-orient: horizontal;
	-webkit-box-pack: center;
}

#confirm-theme:hover {
	background: rgb(55, 188, 155);
}

#cancel-theme:hover {
	background: rgb(218, 68, 83);
}


</style>

</head>





<!-- 头部结束 -->

<!-- 内容 -->

<body class="page-header-fixed"
	style="display:none;overflow:scroll;overflow-x:hidden">

	<!-- 解锁框 -->
	<div id="myModallock" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
		style="background: white;margin-top:10%">


		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="background:#000">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true"></button>
					<h4 class="modal-title" style="color:#fff;font-size:28px;">欢迎回来</h4>
				</div>
				<div class="modal-body">
					<div class="centered"
						style="-webkit-border-radius: 1000px;border-radius: 1000px;">
						<img class="img-circle" src="locks/10.jpg"
							style="width:100px;height:100px;" id="personLock">
					</div>
				</div>
				<input type="password" id="password" placeholder="Password"
					autocomplete="off" class="form-control placeholder-no-fix">
				<div class="modal-footer centered" id="lock-check"
					style="background: #fff">
					<button data-dismiss="modal" class="btn" id="cancel-theme"
						type="button" style="background:#000;color:#fff">取消</button>
					<button type="button" class="btn" id="confirm-theme"
						onclick="checkPass()" style="background:#3c7faf;color:#fff">确认</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 解锁框 -->

	<!-- 修改密码的会话框 -->
	<div id="myModal3" class="modal hide fade" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel3" aria-hidden="true">

		<div class="modal-header">

			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true"></button>

			<h3 id="myModalLabel3">修改密码</h3>

		</div>

		<div class="modal-body">

			<div class="control-group">


				<div class="controls">

					<div class="input-icon left">

						<i class="icon-lock"></i> <input class="m-wrap placeholder-no-fix"
							type="password" placeholder="原密码" name="oldpwd" id="oldpwd" />

					</div>

				</div>

			</div>

			<div class="control-group">

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-lock"></i> <input class="m-wrap placeholder-no-fix"
							type="password" placeholder="新密码" name="newpwd" id="newpwd" />

					</div>

				</div>

			</div>

			<div class="control-group">

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-lock"></i> <input class="m-wrap placeholder-no-fix"
							type="password" placeholder="确认密码" name="rnewpwd" id="rnewpwd" />

					</div>

				</div>

			</div>
			<div id="pwd_msg"
				style="color:#FF0000;text-align: center;font-size: 20px"></div>

		</div>

		<div class="modal-footer">

			<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>

			<button class="btn blue" onclick="update_pwd()">确认修改</button>

		</div>

	</div>

	<!-- 提示登出 -->
	<div id="myModal5" class="modal hide " tabindex="-1" role="dialog"
		style="margin-top:10%" aria-labelledby="myModalLabel5"
		aria-hidden="true">

		<div class="modal-header">

			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true"></button>

			<h3 id="myModalLabel5">Tips</h3>

		</div>

		<div class="modal-body">


			<div style="color:#000;text-align: center;font-size: 20px">是否要离开系统？</div>

		</div>

		<div class="modal-footer">

			<button class="btn" data-dismiss="modal" aria-hidden="true">不了</button>

			<button class="btn blue"
				onclick="javascript:self.location='login.jsp'">没错</button>

		</div>

	</div>



	<!-- 完善信息 -->
	<div id="myModal4" class="modal hide fade" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel3" aria-hidden="true"
		style="width:auto;border-radius: 100px;-moz-border-radius: 10px;-webkit-border-radius: 100px;">

		<div class="modal-header">

			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true"></button>

			<h3 id="myModalLabel3">完善信息</h3>

		</div>

		<div class="modal-body"
			style="overflow:-Scroll;overflow-x:hidden;overflow-y:hidden;padding:40px 40px;">


			<div class="row-fluid">
				<!-- 左侧内容 -->
				<div class="control-group" style="display:inline;float:left">

					<div class="controls">

						<span
							style="font-size: 16px;text-align: center;height:30px;line-height: 30px">姓名</span>
						<input class="m-wrap placeholder-no-fix" type="text"
							placeholder="请输入姓名" id="rname" style="background:#fff"/>
					</div>

					<div class="controls">
						<span 
							style="font-size: 16px;text-align: center;height:30px;line-height: 30px;margin-right:30px">性别
						</span> <label class="radio"><input type="radio" id="man"
							name="testradio" value="男"   /> 男</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label class="radio" ><input
							type="radio" id="woman" name="testradio" value="女"  /> 女</label>

					</div>
					<br>

					<div class="controls">

						<span
							style="font-size: 16px;text-align: center;height:30px;line-height: 30px">手机号</span>
						<input class="m-wrap placeholder-no-fix" type="text"
							placeholder="请输入手机号" id="phone"  style="background:#fff"/>
					</div>

				</div>


				<!-- 右侧内容 -->
				<div class="control-group" style="display:inline;float:right">

					<div class="controls">
						<span
							style="font-size: 16px;text-align: center;height:30px;line-height: 30px">所属部门</span>

						<select id="dept" class="small m-wrap" tabindex="1">

							<option value="1">高一组</option>


						</select>

					</div>

					<div class="controls">
						<span
							style="font-size: 16px;text-align: center;height:30px;line-height: 30px">所教班级</span>

						<select id="u_class" class="small m-wrap" tabindex="1">

							<option value="1">1班</option>


						</select>

					</div>
					
					<div class="controls">
						<span
							style="font-size: 16px;text-align: center;height:30px;line-height: 30px">所授课程</span>

						<select id="course" class="small m-wrap" tabindex="1">

							<option value="1">语文</option>


						</select>

					</div>

					<div class="controls">
						<span
							style="font-size: 16px;text-align: center;height:30px;line-height: 30px">工作职位</span>

						<select id="position" class="small m-wrap" tabindex="1">

							<option value="1">班主任</option>

							<option value="2">系主任</option>

							<option value="3">系副主任</option>

							<option value="4">年级组长</option>
							<option value="5">副校长</option>
							<option value="6">校长</option>
						</select>

					</div>

				</div>

			</div>
			<br>
			<div class="portlet-body form" style="margin-top:-30px;">

				<!-- BEGIN FORM-->

				<h3 class="form-section">头像上传</h3>

				<div class="row-fluid">

					<div class="span6 ">

						<div class="control-group">

							<label class="control-label" for="firstName">预览：</label>

							<div class="controls">

								<img id="preview" border="1" alt="个人头像"
									src="img/person_photo.png" name="pic " width="140px"
									height="140px" />
							</div>

						</div>

					</div>

					<!--/span-->

					<div class="span6 ">

						<div class="control-group error">

							

							<div class="controls">

								<form id="uploadform" enctype="multipart/form-data" name="form1"
									method="post">

									<input id="photo" type="file" name="photo" onchange="change()" style="outline:none;" />

								</form>
								<hr>


								<a href="javascript:personPhoto()"
									data-options="iconCls:'icon-save'" class="easyui-linkbutton">上传吧！</a>


							</div>

						</div>

					</div>

					<!--/span-->

				</div>

				<!-- END FORM-->

			</div>





		</div>




		<div class="modal-footer">

			<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>

			<button class="btn blue" onclick="personMsg()">保存修改</button>

		</div>

	</div>




	<!-- 头部标题 -->

	<div class="header navbar navbar-inverse navbar-fixed-top">

		<!-- 头部导航 -->

		<div class="navbar-inner">

			<div class="container-fluid">

				<!-- LOGO -->

				<a class="brand" href="systema.jsp"> <img
					src="img/font_white.png" alt="logo"  /> 巡查系统
				</a>

				<!-- END LOGO -->

				<!-- 开始菜单显示开关响应 -->

				<a href="javascript:;" class="btn-navbar collapsed"
					data-toggle="collapse" data-target=".nav-collapse"> <img
					src="media/image/menu-toggler.png" alt="" />

				</a>

				<!-- 结束菜单显示开关响应 -->

				<!-- 开始顶部导航菜单 -->

				<ul class="nav pull-right">

					<!-- 开始通知下拉-->

					<li class="dropdown" id="header_notification_bar"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"> <i
							class="icon-warning-sign"></i> <span class="badge">6</span>

					</a>

						<ul class="dropdown-menu extended notification">

							<li><span>&nbsp;&nbsp;你有6条信息需要管理</span></li>

							<li><a href="#"> <span class="label label-success"><i
										class="icon-plus"></i></span> 新用户注册了. <span class="time">Just
										now</span>

							</a></li>

							<li><a href="#"> <span class="label label-important"><i
										class="icon-bolt"></i></span> 服务器超载了. <span
									class="time">15 mins</span>

							</a></li>

							<li><a href="#"> <span class="label label-warning"><i
										class="icon-bell"></i></span> 信息管理模块需要更新. <span
									class="time">22 mins</span>

							</a></li>

							<li><a href="#"> <span class="label label-info"><i
										class="icon-bullhorn"></i></span> 权限修改失败. <span
									class="time">40 mins</span>

							</a></li>

							<li><a href="#"> <span class="label label-important"><i
										class="icon-bolt"></i></span>数据库过载68%. <span
									class="time">2 hrs</span>

							</a></li>



						</ul></li>

					<!-- 结束通知下拉 -->

					<!-- 从收件箱下拉-->

					<li class="dropdown" id="header_inbox_bar"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"> <i
							class="icon-envelope"></i> <span class="badge">5</span>

					</a>

						<ul class="dropdown-menu extended inbox">

							<li><span>&nbsp;&nbsp;你有3条信息</span></li>

							<li><a href="#"> <span class="photo"><img
										src="media/image/avatar2.jpg" alt="" /></span> <span class="subject">

										<span class="from">Miss</span> <span class="time">Just
											Now</span>

								</span> <span class="message">皮城开车了 </span>

							</a></li>

							<li><a href="#"> <span class="photo"><img
										src="media/image/avatar3.jpg" alt="" /></span> <span class="subject">

										<span class="from">王思聪</span> <span class="time">16
											mins</span>

								</span> <span class="message"> 有点意思，随便挑 </span>

							</a></li>

							<li><a href="#"> <span class="photo"><img
										src="media/image/avatar1.jpg" alt="" /></span> <span class="subject">

										<span class="from">老张</span> <span
										class="time">2 hrs</span>

								</span> <span class="message"> 能不能给我换个帅点的头像 </span>

							</a></li>

							
							</a></li>

						</ul></li>

					<!-- 结束收件箱下拉 -->

					<!-- 开始做下拉 -->

					<li class="dropdown" id="header_task_bar"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"> <i
							class="icon-tasks"></i> <span class="badge">5</span>

					</a>

						<ul class="dropdown-menu extended tasks">

							<li><span>&nbsp;&nbsp;本周进度安排</span></li>

							<li><a href="#"> <span class="task"> <span
										class="desc">工程进度</span> <span class="percent">30%</span>

								</span> <span class="progress progress-success "> <span
										style="width: 30%;" class="bar"></span>

								</span>

							</a></li>

							<li><a href="#"> <span class="task"> <span
										class="desc">UI设计</span> <span
										class="percent">65%</span>

								</span> <span class="progress progress-danger progress-striped active">

										<span style="width: 65%;" class="bar"></span>

								</span>

							</a></li>

							<li><a href="#"> <span class="task"> <span
										class="desc">Web服务</span> <span class="percent">98%</span>

								</span> <span class="progress progress-success"> <span
										style="width: 98%;" class="bar"></span>

								</span>

							</a></li>

							<li><a href="#"> <span class="task"> <span
										class="desc">数据库设计</span> <span class="percent">10%</span>

								</span> <span class="progress progress-warning progress-striped">

										<span style="width: 10%;" class="bar"></span>

								</span>

							</a></li>

							<li><a href="#"> <span class="task"> <span
										class="desc">Android开发</span> <span class="percent">58%</span>

								</span> <span class="progress progress-info"> <span
										style="width: 58%;" class="bar"></span>

								</span>

							</a></li>

							<li><a href="#"> <span class="task"> <span
										class="desc">数据分析</span> <span class="percent">85%</span>

								</span> <span class="progress progress-success"> <span
										style="width: 85%;" class="bar"></span>

								</span>

							</a></li>

							

						</ul></li>

					<!-- 结束下拉-->

					<!-- 从用户登录下拉 -->

					<li class="dropdown user"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> <img id="personCenter" alt=""
							src="media/image/avatar1_small.jpg"
							style="width:40px;height:40px" /> <span class="username">${sessionScope.uname}</span>
							<i class="icon-angle-down"></i>

					</a>

						<ul class="dropdown-menu">

							<li><a href="#"><i class="icon-user"></i>
									 This</a></li>

							<li><a href="#"><i
									class="icon-calendar"></i> is</a></li>

							<li><a href="#"><i class="icon-envelope"></i>
									my</a></li>

							<li><a data-toggle="dropdown"><i class="icon-tasks"></i>&nbsp;place</a></li>

							<li class="divider"></li>

							<li><a href="#myModal3" role="button" class=" btn blue"
								data-toggle="modal" onclick="initpwd()"><i
									class="icon-asterisk"></i> 修改密码</a></li>

							<li><a href="#myModal4" role="button" class="btn purple"
								data-toggle="modal" onclick="findSingleUser();findTeach();"><i class="icon-credit-card"></i> 完善信息</a></li>
							<li><a class=" btn green" data-toggle="modal"
								onclick="lockScreenShow()"><i class="icon-lock"></i>
									锁&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;屏</a></li>
							<li><a class=" btn red" data-toggle="modal" href="#myModal5"><i
									class="icon-key"></i>
									登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;出</a></li>




						</ul></li>

					<!-- 结束用户登录下拉 -->

				</ul>

				<!-- 结束顶部导航菜单 -->

			</div>

		</div>

		<!-- 结束头导航栏 -->

	</div>

	<!-- 结束头部 -->

	<!-- 容器 -->

	<div class="page-container row-fluid">

		<!-- 开始样本portlet配置模式窗体-->

		<div id="portlet-config" class="modal hide">

			<div class="modal-header">

				<button data-dismiss="modal" class="close" type="button"></button>

				<h3>系统设置</h3>

			</div>

			<div class="modal-body">

				<span>这里将有一个配置表单</span>

			</div>

		</div>

		<!-- 结束样本portlet配置模式窗体-->

		<!-- BEGIN SIDEBAR1 -->

		<div class="page-sidebar nav-collapse collapse">

			<!-- 开始menu1边栏 -->

			<ul class="page-sidebar-menu">

				<li>
					<!-- 从侧边栏显示开关按钮 -->

					<div class="sidebar-toggler hidden-phone"></div>

				</li>

				<li>
					<!-- 开始响应快速搜索表单 -->

					<form class="sidebar-search">

						<div class="input-box">

							<a href="#" class="remove"></a> <input type="text"
								placeholder="Search..." /> <input type="button" class="submit" onclick="javascript:alert('就是没赶上写');" style="outline: none"
								value=" " />

						</div>

					</form> <!-- 结束响应快速搜索表单 -->

				</li>

				<li class="start"><a class="ajaxify2 start"
					href="javascript:openframe('notice.html')"> <i
						class="icon-home"></i> <span class="title">管理首页</span> <span
						class="selected"></span>

				</a></li>

				<li class=""><a href="javascript:;"> <i class="icon-magic"></i>

						<span class="title">信息管理</span> <span class="selected"></span> <span
						class="arrow open"></span>

				</a>

					<ul class="sub-menu">

						<li><a href="javascript:openframe('insertxuncha.jsp')">

								巡查信息录入 </a></li>


						<li><a href="javascript:;"> <span class="title">信息查询</span>
								<span class="selected"></span> <span class="arrow"></span>

						</a>

							<ul class="sub-menu">

								<li><a href="javascript:openframe('teacherQuery.html')"
									class="ajaxify2"> 教师信息 </a></li>

								<li><a href="javascript:openframe('classQuery.html')"
									class="ajaxify2"> 班级信息 </a></li>

								<li><a href="javascript:openframe('xunchaQuery.html')"
									class="ajaxify2"> 巡查列表 </a></li>


							</ul></li>



					</ul></li>

				<li class=""><a href="javascript:;"> <i class="icon-cogs"></i>

						<span class="title">部门信息</span> <span class="selected"></span> <span
						class="arrow"></span>

				</a>

					<ul class="sub-menu">

						<li><a href="javascript:openframe('seniorOne.html')"
							class="ajaxify2"> 高一年级 </a></li>

						<li><a href="javascript:openframe('seniorTwo.html')"
							class="ajaxify2"> 高二年级 </a></li>

						<li><a href="javascript:openframe('seniorThree.html')"
							class="ajaxify2"> 高三年级 </a></li>

						<li><a href="javascript:openframe('seniorFour.html')"
							class="ajaxify2"> 高四年级 </a></li>

					</ul></li>

				<li class="last"><a href="javascript:;"> <i
						class="icon-star"></i> <span class="title">综合管理</span> <span
						class="selected"></span> <span class="arrow"></span>

				</a>

					<ul class="sub-menu">

						<li><a href="javascript:openframe('teacher_Manager.html')">

								教师管理</a></li>

						<li><a href="javascript:openframe('class_Manager.jsp')">

								班级管理 </a></li>

					

						<li><a href="javascript:openframe('table_work.html')">

								工作安排 </a></li>

					</ul></li>
				<li class="last"><a href="javascript:;"> <i
						class="icon-signal"></i> <span class="title">数据分析</span> <span
						class="selected"></span> <span class="arrow"></span>

				</a>

					<ul class="sub-menu">

						<li><a href="javascript:openframe('class_dataAnalyze.jsp')">

								班级分析</a></li>

						<li><a href="javascript:openframe('teacher_dataAnalyze.jsp')">

								教师分析 </a></li>

						
					</ul></li>

			</ul>

			<!-- 结束侧边栏menu1-->

		</div>

		<!-- 结束sidebar1 -->

		<!-- 页面 -->

		<div class="page-content" id="insteadframe"
			style="background:#f7f7f7;height:900px;">

			<!-- 开始页面容器-->

			<div class="container-fluid">

				<!-- 开始的风格定制 -->

				<div class="color-panel hidden-phone">

					<div class="color-mode-icons icon-color"></div>

					<div class="color-mode-icons icon-color-close"></div>

					<div class="color-mode">

						<span>风格颜色</span>

						<ul class="inline">

							<li class="color-black current color-default"
								data-style="default"></li>

							<li class="color-blue" data-style="blue"></li>

							<li class="color-brown" data-style="brown"></li>

							<li class="color-purple" data-style="purple"></li>

							<li class="color-grey" data-style="grey"></li>

							<li class="color-white color-light" data-style="light"></li>

						</ul>

						<label> <span>Layout</span> <select
							class="layout-option m-wrap small">

								<option value="fluid" selected>Fluid</option>

								<option value="boxed">Boxed</option>

						</select>

						</label> <label> <span>Header</span> <select
							class="header-option m-wrap small">

								<option value="fixed" selected>Fixed</option>

								<option value="default">Default</option>

						</select>

						</label> <label> <span>Sidebar</span> <select
							class="sidebar-option m-wrap small">

								<option value="fixed">Fixed</option>

								<option value="default" selected>Default</option>

						</select>

						</label> <label> <span>Footer</span> <select
							class="footer-option m-wrap small">

								<option value="fixed">Fixed</option>

								<option value="default" selected>Default</option>

						</select>

						</label>

					</div>

				</div>

				<!-- 结束风格定制 -->

				<div class="page-content-body"></div>

			</div>

			<!-- 这里将被加载一个可替换页面的内容 -->
			<p></p>

		</div>

		<!-- 结束页面 -->

	</div>

	<!-- 结束容器 -->

	<!-- 开始底部 -->

	<div class="footer">

		<div class="footer-inner">2016 &copy;Quice 团队.</div>

		<div class="footer-tools">

			<span class="go-top" style="margin-top:1px"> <i class="icon-angle-up"></i>

			</span>

		</div>

	</div>

	<!-- **********************************************************************************************************************************************************
     		 锁屏  overflow:scroll;overflow-y:hidden;overflow-x:hidden;
      **************************************************************url(locks/1.png)no-repeat center center;************************** -->

	<div class="lock_container" id="lock_container" onload="getTime()"
		style="display:none;position:fixed;z-index:9996;width:100%;height:100%;top:0px;background:url(locks/1.png)no-repeat center center;">
		<div class="lock_div">
			<div id="showtime"></div>

			<div class="lock-screen">
				<a data-toggle="modal" href="#myModallock"><i class="fa fa-lock"></i></a>
			</div>
			<! --/lock-screen -->
		</div>

	</div>
	<!-- /container -->



	<!-- 结束底部 -->

	<!-- 开始Javascript（底部，加载javascript这将减少页面加载时间） -->

	<!-- 开始加载核心插件 -->

	<script src="easyui/jquery.min.js" type="text/javascript"></script>

	<script src="media/js/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>

	<!-- 重要！前负荷jquery-ui-1.10.1.custom.min.js bootstrap.min.js修复引导提示冲突与jQuery UI工具提示 -->

	<script src="media/js/jquery-ui-1.10.1.custom.min.js"
		type="text/javascript"></script>

	<script src="media/js/bootstrap.min.js" type="text/javascript"></script>

	<!--[if lt IE 9]>

	<script src="media/js/excanvas.min.js"></script>

	<script src="media/js/respond.min.js"></script>  

	<![endif]-->

	<script src="media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="media/js/jquery.blockui.min.js" type="text/javascript"></script>

	<script src="media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="media/js/jquery.uniform.min.js" type="text/javascript"></script>

	<!-- 结束核心插件 -->

	<script type="text/javascript" src="media/js/select2.min.js"></script>

	<script src="media/js/app.js"></script>

	<link rel="stylesheet" href="easyui/themes/black/easyui.css" />
	<link rel="stylesheet" href="easyui/themes/icon.css">
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="js/jquerysession.js"></script>
<script type="text/javascript" src="js/sha1.js"></script>

	<script>
		jQuery(document).ready(function() {
			var user=('<%=session.getAttribute("uname")%>');
			if(user=='null'){
				alert("您未登陆，请先登录！");
				window.location.href = "login.jsp";
				return;
			}
			if(sessionStorage.lock==1){
				$('.lock_container').css("display", "block");
			}
			
			$('body').css("display", "block");
			//获取用户数据
			$.ajax({
				url : 'findPhoto',
				type : 'post',
				cache : false,
				data : {
				//	"uname" : 服务器已有不需要传值
					//'<%=session.getAttribute("uname")%>',
				},
				success : function(result) {
					$("#personCenter").attr("src", result);
					$("#personLock").attr("src", result);
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					$("#pwd_msg").html('请求服务器失败!');
					//"请求服务器失败!",

				}
			});
			
			
			App.init();
			$("#myModal3").modal('hide').css({
				width : 'auto',
				'margin-top' : function() {
					return ($(this).height() / 2);
				},
				'margin-left' : function() {
					return -($(this).width() / 2);
				}
			})
			//$('.page-sidebar .ajaxify2 start').click(); 
			openframe('notice.html');

			getTime();
		});
	</script>
	<!-- 锁屏 -->
	<script type="text/javascript">
		function getTime() {
			var today = new Date();
			var h = today.getHours();
			var m = today.getMinutes();
			var s = today.getSeconds();
			// add a zero in front of numbers<10
			m = checkTime(m);
			s = checkTime(s);
			document.getElementById('showtime').innerHTML = h + ":" + m + ":"
					+ s;
			t = setTimeout(function() {
				getTime()
			}, 500);
		}

		function checkTime(i) {
			if (i < 10) {
				i = "0" + i;
			}
			return i;
		}
	</script>
	<!-- 个人信息 -->
	<script type="text/javascript">

		function personPhoto() {

			$('#uploadform').form('submit', {
				url : "photoUpload",
				success : function(result) {
					if (result != "photoerror") {
						//	alert('
	<%=session.getAttribute("photo")%>
		//');			
						alert(result);
						$("#personCenter").attr("src", result);
					} else {
						alert('失败');
					}

				},
				error : function() {
					alert("请求失败");

				}
			});
		}
		
		function findTeach() {
			$.ajax({
				url : 'findTeach',
				type : 'post',
				cache : false,
				dataType : "json",
				data : {
					"uname":'<%=session.getAttribute("uname")%>'
				},
				success : function(result) {
					var c_id,d_id,k_id;
					c_id=result.rows[0].c_id;
					d_id=result.rows[0].d_id;
					k_id=result.rows[0].k_id;
					//alert(c_id+d_id+k_id);
					//获取年级列表
					$.ajax({
						url : 'getSelectDeptItem',
						type : 'post',
						cache : false,
						dataType : "json",
						success : function(result) {
							var optionstr = "";
							for (var i = 0; i < result.total; i++) {
								if(d_id == result.rows[i].id){
									optionstr = optionstr
									+ "<option value='"+result.rows[i].id+"' selected>"
									+ result.rows[i].name + "</option>";
								}else{
									optionstr = optionstr
									+ "<option value='"+result.rows[i].id+"'>"
									+ result.rows[i].name + "</option>";
								}
							}
							$("#dept").html(optionstr);

						},
						error : function(XMLHttpRequest, textStatus, errorThrown) {
							alert('请求服务器失败!');
						}
					});
					//班级列表
					$.ajax({
						url : 'getSelectClassItem',
						type : 'post',
						cache : false,
						dataType : "json",
						success : function(result) {
							var optionstr = "";
							for (var i = 0; i < result.total; i++) {
								if(c_id == result.rows[i].id){
									optionstr = optionstr
									+ "<option value='"+result.rows[i].id+"' selected>"
									+ result.rows[i].name + "</option>";
								}else{
									optionstr = optionstr
									+ "<option value='"+result.rows[i].id+"'>"
									+ result.rows[i].name + "</option>";
								}
							}
							$("#u_class").html(optionstr);
						},
						error : function(XMLHttpRequest, textStatus, errorThrown) {
							alert('请求服务器失败!');

						}
					});
					//课程
					$.ajax({
						url : 'getSelectCourseItem',
						type : 'post',
						cache : false,
						dataType : "json",
						success : function(result) {
							var optionstr = "";
							for (var i = 0; i < result.total; i++) {
								if(k_id == result.rows[i].id){
									optionstr = optionstr
									+ "<option value='"+result.rows[i].id+"' selected>"
									+ result.rows[i].name + "</option>";
								}else{
									optionstr = optionstr
									+ "<option value='"+result.rows[i].id+"'>"
									+ result.rows[i].name + "</option>";
								}
							}
							$("#course").html(optionstr);
						},
						error : function(XMLHttpRequest, textStatus, errorThrown) {
							alert('请求服务器失败!');

						}
					});
					
					
					
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert('请求服务器失败!');
				}
			});
		}
		
		function findSingleUser(){
			$.ajax({
				url : 'findSingleUser',
				type : 'post',
				cache : false,
				dataType : "json",
				data : {
					"uname":'<%=session.getAttribute("uname")%>'
				},
				success : function(result) {
					$("#rname").val(result.rows[0].rname);
					$("#phone").val(result.rows[0].phone);
					if(result.rows[0].sex == "女"){	
					 //	document.getElementById('woman').checked=true;
						$("#woman").attr("checked",'checked');
						/*	$("input[name=testradio]:eq('女')").attr("checked",'checked');
						$("input[name='testradio']").eq('女').attr("checked",true);
						$("input[name='testradio']").eq(1).attr("checked",true);
						$("input[type='radio'][name='testradio'][value='女']").attr("checked", "checked"); */
					//	$("input[type='radio'][value='女']").attr("checked", "checked");
						//$("input[type='radio'][value='女']").attr("checked", "checked");
					//	alert(document.getElementById("woman").checked);
					//	$("input[id='woman']").attr("checked","checked");
			//document.getElementById("woman").checked="checked";
					
					}else{
						document.getElementById("man").checked=true;
					//	$("#man").attr("checked","checked");
					}
					
					
					if(result.rows[0].sex == "女"){	
						$("#woman").attr("checked","checked");
					}else{
						$("#man").attr("checked","checked");
					}
					var optionstr = "";
					var str=["教师","班主任","年级组长","学科组长","系主任","副校长","校长"];
					for(var i=0;i<str.length;i++){
					
						if(str[i]==result.rows[0].position) {
									optionstr = optionstr
									+ "<option value='"+result.rows[0].position+"' selected>"
									+ result.rows[0].position + "</option>";	
						}else{
							optionstr = optionstr
							+ "<option value='"+str[i]+"'>"
							+ str[i]+ "</option>";
						}
					}
			$("#position").html(optionstr);

					
					
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert('请求服务器失败!');

				}
			});
		}
		// 手机号验证
		function checkPhone(phone) {
			var res = !phone.match(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/);
			return res;
		}
		function personMsg() {

			var rname = $("#rname").val();
			var sex;
			var dept;
			var u_class;
			var course;
			var position;
			var phone = $("#phone").val();
			if(checkPhone(phone)){
				alert("手机号不正确！");
				return;
			}
			sex = $('input[name="testradio"]:checked ').val();
			dept = $("#dept").find("option:selected").val();
			u_class= $("#u_class").find("option:selected").val();
			course= $("#course").find("option:selected").val();
			position = $("#position").find("option:selected").text();

			$.ajax({
				url : 'update_PersonMsg',
				type : 'post',
				cache : false,
				data : {
					"uname":'<%=session.getAttribute("uname")%>',
					"rname" : rname,
					"sex" : sex,
					"dept" : dept,
					"u_class" : u_class,
					"course" : course,
					"position" : position,
					"phone" : phone
				},
				success : function(result) {
					if (result == "updateSuccess") {
						$('#myModal4').modal('hide');
						tip_trigger();
						//消息
					} else {
						alert("更新失败");
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					$("#pwd_msg").html('请求服务器失败!');
					//"请求服务器失败!",

				}
			});

		}
	</script>

	<!-- 检测图片格式并觉得谷歌浏览器问题 -->
	<script type="text/javascript">
		function change() {
			var pic = document.getElementById("preview"), file = document
					.getElementById("photo");

			var ext = file.value.substring(file.value.lastIndexOf(".") + 1)
					.toLowerCase();

			// gif在IE浏览器暂时无法显示
			if (ext != 'png' && ext != 'jpg' && ext != 'jpeg') {
				alert("图片的格式必须为png或者jpg或者jpeg格式！");
				return;
			}
			var isIE = navigator.userAgent.match(/MSIE/) != null, isIE6 = navigator.userAgent
					.match(/MSIE 6.0/) != null;

			if (isIE) {
				file.select();
				var reallocalpath = document.selection.createRange().text;

				// IE6浏览器设置img的src为本地路径可以直接显示图片
				if (isIE6) {
					pic.src = reallocalpath;
				} else {
					// 非IE6版本的IE由于安全问题直接设置img的src无法显示本地图片，但是可以通过滤镜来实现
					pic.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='image',src=\""
							+ reallocalpath + "\")";
					// 设置img的src为base64编码的透明图片 取消显示浏览器默认图片
					pic.src = 'data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==';
				}
			} else {
				html5Reader(file);
			}
		}

		function html5Reader(file) {
			var file = file.files[0];
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e) {
				var pic = document.getElementById("preview");
				pic.src = this.result;
			}
		}
	</script>

	<script type="text/javascript">
		function initpwd() {
			$("#oldpwd").val('');
			$("#newpwd").val('');
			$("#rnewpwd").val('');
			$("#pwd_msg").html('');
		}
		function update_pwd() {
			hex_sha1($("#oldpwd").val()+"patrol")
			var oldpwd = hex_sha1($("#oldpwd").val()+"patrol");
			var newpwd = hex_sha1($("#newpwd").val()+"patrol");
			var rnewpwd = hex_sha1($("#rnewpwd").val()+"patrol");
			if (newpwd != rnewpwd) {
				$("#pwd_msg").html('两次密码不一致!');
				return;
			}
			$.ajax({
				url : 'update',
				type : 'post',
				cache : false,
				data : {
					"oldpwd" : oldpwd,
					"newpwd" : newpwd,
				},
				success : function(result) {
					if (result == "updateSuccess") {
						$('#myModal3').modal('hide');
						tip_trigger();
						//消息
					} else {
						//消息
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					$("#pwd_msg").html('请求服务器失败!');
					//"请求服务器失败!",

				}
			});
		}
		

		function openframe(url) {
		
			if(url=="insertxuncha.jsp"){
				if('<%=session.getAttribute("role")%>'=="教师"){
					alert("你未获得此权限");
					return;
				}
			}
			if(url=="xunchaQuery.html"||url=="teacher_Manager.html"||url=="class_Manager.jsp"||url=="table_work.html"){
				if('<%=session.getAttribute("role")%>'=="教师"||'<%=session.getAttribute("role")%>'=="巡查员"){
					alert("你未获得此权限");
					return;
				}
			}

			//添加iframe
			var if_w = '102%';
			var if_h = $('#insteadframe').height();
			$("#WFrame").remove();
			//allowTransparency='true' 设置背景透明
			$(
					"<iframe width='" + if_w + "'marginleft='200' height='" + if_h + "' id='WFrame' name='WFrame'  frameborder='no' marginheight='30' marginwidth='30'  allowTransparency='true'></iframe>")
					.prependTo('p');
			var st = document.documentElement.scrollTop
					|| document.body.scrollTop;//滚动条距顶部的距离
			var sl = document.documentElement.scrollLeft
					|| document.body.scrollLeft;//滚动条距左边的距离
			var ch = document.documentElement.clientHeight;//屏幕的高度
			var cw = document.documentElement.clientWidth;//屏幕的宽度
			var objH = $("#WFrame").height();//浮动对象的高度
			var objW = $("#WFrame").width();//浮动对象的宽度
			var objT = Number(st) + (Number(ch) - Number(objH)) / 2;
			var objL = Number(sl) + (Number(cw) - Number(objW)) / 2;
			$("#WFrame").css('left', objL);
			$("#WFrame").css('top', objT);
			$("#WFrame").attr("src", url)
		}
		/*
		 function showDialog2(url) {
		 var if_w = '100%';
		 var if_h = '100%';
		 $(
		 "<iframe width='"
		 + if_w
		 + "' height='"
		 + if_h
		 + "' id='YuFrame1' name='YuFrame1' style='position: fixed;top: 30%;left: 50%;background-color: #000;width:50%;height: 30%;-webkit-transform:  translateY(-40%);'  frameborder='no' marginheight='0' marginwidth='0' allowTransparency='true'></iframe>")
		 .prependTo('body');
		 var st = document.documentElement.scrollTop
		 || document.body.scrollTop;
		 var sl = document.documentElement.scrollLeft
		 || document.body.scrollLeft;
		 var ch = document.documentElement.clientHeight;
		 var cw = document.documentElement.clientWidth;
		 var objH = $("#YuFrame1").height();
		 var objW = $("#YuFrame1").width();
		 var objT = Number(st) + (Number(ch) - Number(objH)) / 2;
		 var objL = Number(sl) + (Number(cw) - Number(objW)) / 2;
		 $("#YuFrame1").css('left', objL);
		 $("#YuFrame1").css('margin-top', 'auto');
		 $("#YuFrame1").css('margin-bottom', 'auto');
		 $("#YuFrame1").attr("src", url)	
		 }*/
		function showIframe(url) {
			//添加iframe

			//全屏
			//	var if_w = $("body").width();
			//	var if_h = $("body").height();
			var if_w = $("body").width() / 3;
			var if_h = $("body").height() / 3;
			//allowTransparency='true' 设置背景透明
			$(
					"<iframe width='" + if_w + "' height='" + if_h + "' id='YuFrame1' name='YuFrame1' style='position:absolute;z-index:4;'  frameborder='no' marginheight='0' marginwidth='0' allowTransparency='true'></iframe>")
					.prependTo('body');
			var st = document.documentElement.scrollTop
					|| document.body.scrollTop;//滚动条距顶部的距离
			var sl = document.documentElement.scrollLeft
					|| document.body.scrollLeft;//滚动条距左边的距离
			var ch = document.documentElement.clientHeight;//屏幕的高度
			var cw = document.documentElement.clientWidth;//屏幕的宽度
			var objH = $("#YuFrame1").height();//浮动对象的高度
			var objW = $("#YuFrame1").width();//浮动对象的宽度
			var objT = Number(st) + (Number(ch) - Number(objH)) / 2;
			var objL = Number(sl) + (Number(cw) - Number(objW)) / 2;
			$("#YuFrame1").css('left', objL);
			$("#YuFrame1").css('top', objT);
			$("#YuFrame1").attr("src", url);

			//添加背景遮罩
			$(
					"<div id='YuFrame1Bg' style='background-color: Gray;display:block;z-index:3;position:absolute;left:0px;top:0px;filter:Alpha(Opacity=30);/* IE */-moz-opacity:0.4;/* Moz + FF */opacity: 0.4; '/>")
					.prependTo('body');
			var bgWidth = Math.max($("body").width(), cw);
			var bgHeight = Math.max($("body").height(), ch);
			$("#YuFrame1Bg").css({
				width : bgWidth,
				height : bgHeight
			});

			//点击背景遮罩移除iframe和背景
			$("#YuFrame1Bg").click(function() {
				$("#YuFrame1").remove();
				$("#YuFrame1Bg").remove();
			});
		}
	</script>
	<!-- 结束 JAVASCRIPTS -->

	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push([ '_setAccount', 'UA-37564768-1' ]);
		_gaq.push([ '_setDomainName', 'keenthemes.com' ]);
		_gaq.push([ '_setAllowLinker', true ]);
		_gaq.push([ '_trackPageview' ]);
		(function() {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://'
					: 'http://')
					+ 'stats.g.doubleclick.net/dc.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();
	</script>
	<!-- 	引入提示框事件 -->
	<script type="text/javascript" src="media/js/jquery.gritter.js"></script>
	<script type="text/javascript">
		function tip_trigger() {

			$('#myModal4').modal('hide');
			setTimeout(function() {
				var unique_id = $.gritter.add({
					// (string | mandatory) the heading of the notification
					title : '小贴士',
					// (string | mandatory) the text inside the notification
					text : '你的信息已经修改',
					// (string | optional) the image to display on the left
					image : 'media/image/10.jpg',
					// (bool | optional) if you want it to fade out on its own or just sit there
					sticky : true,
					// (int | optional) the time you want it to be alive for before fading out
					time : '',
					// (string | optional) the class name you want to apply to that specific message
					class_name : 'my-sticky-class'
				});
				setTimeout(function() {
					$.gritter.remove(unique_id, {
						fade : true,
						speed : 'slow'
					});
				}, 3600);
			}, 1000);
		}
	</script>
	<!-- 锁屏JS -->
	<script>
		function lockScreenShow(){		
			$('.lock_container').fadeIn(850);
			location.reload();
			sessionStorage.lock=1;
		//	$('.lock_container').css("display", "block");
		}
		function checkPass() {
			$.ajax({
				url : 'androidlogin',
				type : 'post',
				cache : false,
				data : {
					"uname" : '<%=session.getAttribute("uname")%>',
					"upwd" : hex_sha1($("#password").val()+"patrol")
				},
				success : function(result) {
					if (result != "loginError") {
						
						$('#myModallock').modal('hide');
						$('.lock_container').fadeOut(850);
						sessionStorage.lock=0;
						document.getElementById("password").value="";
					}
					else  alert('密码错误！');
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert('请求服务器失败!');
				
				}
			});
		}
	</script>
</body>

<!-- 结束内容 -->

</html>