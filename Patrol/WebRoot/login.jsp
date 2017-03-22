<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isErrorPage="true" errorPage="404.html"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="google-site-verification"
	content="KdndASF57-BebrsFc5Jhd0-Cwf7Dn7G7gDp_GGNhG0I">
<title>Login</title>
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css"
	media="all">
<link rel="stylesheet" href="css/font-awesome.min.css" type="text/css"
	media="all">
<link rel="stylesheet" href="css/font-lineicons.css" type="text/css"
	media="all">
<link rel="stylesheet" href="css/animate.css" type="text/css"
	media="all">
<link rel="stylesheet" href="css/style.css" type="text/css" media="all">
<link rel="stylesheet" href="css/login.css" type="text/css" media="all">
<link href="img/owl.png" rel="shortcut icon"/>
</head>

<body id="landing-page"
	style="overflow:scroll;overflow-y:hidden;overflow-x:hidden">
	<!--注册弹窗验证 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">&nbsp;完成注册</h4>
				</div>
				<div class="modal-body">
					<div style="align:center">
						<input type="text" id="vcode" placeholder="&nbsp;&nbsp;请输入验证码"
							style="width:200px;height:40px" /> <a
							href="javascript:changeCode()"><img id="imagecode"
							src="vcode.jsp" width="100" height="40" align="center"
							style="margin-left: 50px;margin-top: -6px;"></a>
					</div>

				</div>
				<div class="modal-footer">
					<span id="ajax_msg"
						style="font-size:20px;color:#CD4F39;margin-right:41%;display:none;"></span>
					<label class="tip_label3" id="tip_label3">验证码不能为空</label>
					<button type="button" class="btn btn-primary"
						onclick="submitCode()">提交信息</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

	<!--登录弹窗验证 -->
	<div class="modal fade" id="myModal0" style="margin-top: 200px;"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">提示</h4>
				</div>
				<div class="modal-body" id="login_msg"
					style="text-align:center;font-size: 20px"></div>
				<div class="modal-footer">
					<button type="button" class="btn " data-dismiss="modal">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

	<!--找回密码 -->
	<div class="modal fade" id="myModal1" style="margin-top: 200px;"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">找回密码</h4>
				</div>
				<div class="modal-body" style="text-align:center;font-size: 20px">
					<form>
						<div style="padding-bottom: 10px;width:600px;margin-left:20px;">
							手机号&nbsp;&nbsp;<input type="tel" style="width:200px">
						</div>
						<div style="padding-bottom: 10px;width:600px;">
							填入动态码&nbsp;&nbsp;<input type="text" style="width:100px">
							<button
								style="width:90px;height:30px;color:#fff;margin-left: 10px;background: rgba(26, 198, 255, 0.901961);font-size:15px;border:none;border-radius:5px;padding-top:3px;">获取动态码</button>
						</div>
						<div style="padding-bottom: 10px;width:600px;">
							填写新密码&nbsp;&nbsp;<input type="password" style="width:200px">
						</div>
						<div style="padding-bottom: 10px;width:600px;">
							确认新密码&nbsp;&nbsp;<input type="password" style="width:200px">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn " value="获取动态码">确认提交</button>

				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

	<!--顶部覆盖导航部分 -->
	<nav class="navigation navigation-header fixmenu-clone" hidden="hidden">
		<div class="container">
			<div class="navigation-brand">
				<div class="brand-logo">
					<a href="login.jsp" class="logo"></a> <span class="sr-only">Patrol</span>
				</div>

			</div>
			<div class="navigation-navbar">
				<ul class="navigation-bar navigation-bar-left">
					<li class="active"><a href="#hero">高校教学教务巡查系统</a></li>

				</ul>
				<ul class="navigation-bar navigation-bar-right">
					<li><a
						href="https://graph.qq.com/oauth/show?which=Login&display=pc&response_type=code&client_id=101135281&redirect_uri=http://www.jq22.com/QQReturn.aspx?tjurl=http://www.jq22.com/"><img
							src="icon/qq_black.png" width="24px" height="24px" /></a></li>
					<li><a href="https://wx.qq.com/"><img
							src="icon/weixin_logo _black.png" width="24px" height="24px" /></a>
					</li>
					<li><a
						href="http://service.weibo.com/share/share.php?url=file%3A%2F%2F%2FF%3A%2F%E5%AE%9E%E4%B9%A0%2F%E8%BD%AF%E9%80%9A%E5%8A%A8%E5%8A%9B%E5%B7%A5%E4%BD%9C%E6%97%A5%E5%BF%97%2F%E6%BA%90%E7%A0%81%2Fshebang2%2Flogin%2520index.html%230-tsina-1-9824-397232819ff9a47a7b7e80a40613cfe1&title=she%20login&appkey=1343713053&searchPic=true"><img
							src="icon/weibo_black.png" width="24px" height="24px" /></a></li>

				</ul>
			</div>
		</div>
	</nav>
	<!--顶部底边导航部分 -->
	<header>
		<nav class="navigation navigation-header">
			<div class="container">
				<div class="navigation-brand">
					<div class="brand-logo">
						<a href="login.jsp" class="logo"></a> <span class="sr-only">Patrol</span>
					</div>

				</div>
				<div class="navigation-navbar">
					<ul class="navigation-bar navigation-bar-left">
						<li class="active"><a href="#hero">高校教学教务巡查系统</a></li>

					</ul>
					<ul class="navigation-bar navigation-bar-right">

						<li><a
							href="https://graph.qq.com/oauth/show?which=Login&display=pc&response_type=code&client_id=101135281&redirect_uri=http://www.jq22.com/QQReturn.aspx?tjurl=http://www.jq22.com/"><img
								src="icon/qq_white.png" width="24px" height="24px" /></a></li>
						<li><a href="https://wx.qq.com/"><img
								src="icon/weixin_logo_white.png" width="24px" height="24px" /></a>
						</li>
						<li><a
							href="http://service.weibo.com/share/share.php?url=file%3A%2F%2F%2FF%3A%2F%E5%AE%9E%E4%B9%A0%2F%E8%BD%AF%E9%80%9A%E5%8A%A8%E5%8A%9B%E5%B7%A5%E4%BD%9C%E6%97%A5%E5%BF%97%2F%E6%BA%90%E7%A0%81%2Fshebang2%2Flogin%2520index.html%230-tsina-1-9824-397232819ff9a47a7b7e80a40613cfe1&title=she%20login&appkey=1343713053&searchPic=true"><img
								src="icon/weibo_white.png" width="24px" height="24px" /></a></li>
						<!-- <li class="featured"><a href="register.html">Sign up</a></li>-->
					</ul>
				</div>
			</div>
		</nav>
	</header>
	<!--框体注册部分 -->
	<div id="hero" class="static-header register-version light clearfix">

		<div class="text-heading">
			<h1 class="animated bounceInDown visible"
				data-animation="bounceInDown" data-delay="0">
				开始你的 <span class="highlight">巡查</span> 之旅
			</h1>
			<p class="animated fadeInDown visible" data-animation="fadeInDown"
				data-delay="500">高效处理教学管理信息&nbsp;&nbsp;使记录不再糙乱</p>
		</div>

		<button value="" class="btn_change1" id="btn_change1" alt="注册" title="注册页面"
			onclick="changeDiv2()"></button>
		<br />
		<button value="" class="btn_change2" id="btn_change2" alt="登录" title="登录页面"
			onclick="changeDiv1()"></button>
		<br /> <a href="#" rel="modal" class="box_sides"><img
			src="icon/aws_logo_white.png"></a>

		<div class="layer1" id="layer1">
			<div class="container">
				<div class="signup-wrapper animated bounceInUp visible"
					data-animation="bounceInUp" data-delay="0">

					<div class="row">
						<!--黑边框-->
						<div class="form-inline form-register-small" id="form-getstarted">

							<div class="form-group">
								<input size="22" type="text" class="form-control required name"
									name="name" id="user_name" placeholder="Name"
									autocomplete="off" aria-required="true"> <label
									class="tip_label1" id="tip_label1">不能少于3个字符</label>
							</div>
							<div class="form-group">
								<input size="20" type="password" class="form-control required"
									name="password" id="user_pwd" placeholder="Password"
									style="display:block;" autocomplete="off" aria-required="true">
								<label class="tip_label2" id="tip_label2">不能为空</label>
								<!--<input type="number" class="form-control required" name="phone" id="signup_user_phone" placeholder="Phone Number" style="display:block;" autocomplete="off" aria-required="true">-->
							</div>
							<div class="form-group submit-wrap">
								<input type="hidden" name="small-form">
								<button class="btn btn-primary btn-md" data-toggle="modal"
									data-target="#" onclick="Ind_register()" id="btn-register">注&nbsp;&nbsp;册</button>

							</div>

						</div>
					</div>

				</div>
			</div>
		</div>
		<!--登录部分 -->
		<div class="layer2 hidden" id="layer2">
			<div class="container">
				<div class="signup-wrapper animated bounceInUp visible"
					data-animation="bounceInUp" data-delay="0">
					<div class="row">
						<div class="form-inline form-register-small" id="form-getstarted"
							onsubmit="getStarted(); return true;" novalidate="novalidate">

							<div class="form-group">
								<input size="22" type="text" class="form-control required name"
									name="name" id="user_name1" placeholder="Name"
									autocomplete="off" aria-required="true"> <label
									class="tip_label1" id="tip_label4">不能少于3个字符</label>
							</div>
							<div class="form-group">
								<input size="20" type="password" class="form-control required"
									name="password" id="user_pwd1" placeholder="Password"
									style="display:block;" autocomplete="off" aria-required="true">
								<label class="tip_label2" id="tip_label5">不能为空</label>
							</div>
							<div class="form-group submit-wrap">
								<input type="hidden" name="small-form">
								<button type="submit" class="btn btn-primary btn-md"
									onclick="Ind_login()" id="btn_login">登&nbsp;&nbsp;录</button>
								<a href="javascript:findPass()"><label class="findpass">找回密码</label></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!--[if lt IE 9]>
        <script type="text/javascript" src="assets/js/jquery-1.11.0.min.js?ver=1"></script>
    <![endif]-->
	<!--[if (gte IE 9) | (!IE)]><!-->
	<script type="text/javascript" src="js/jquery-2.1.0.min.js"></script>
	<!--<![endif]-->

	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/headhesive.min.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	<script type="text/javascript" src="js/sha1.js"></script>
	<!-- 设置窗体适应宽高 -->
	<script>
		jQuery(document).ready(
				function() {
					//	if()    1366   1920   1024   
					if(localStorage.log_reg!=0){
						changeDiv1();
					}
					var height = $('body').width();
					if (height < 1366) {
						$('#hero').css("min-height", 667);
					} else if (height < 1920)
						$('#hero').css("min-height", 970);

					$("#myModal").modal('hide').css({
						width : 'auto',
						'margin-top' : function() {
							return ($(this).height() / 3);
						},
						'aria-hidden' : 'true'
					})
					document.onkeydown = function(event) {
						var e = event || window.event
								|| arguments.callee.caller.arguments[0];
						if (e && e.keyCode == 27) { // 按 Esc 
							//要做的事情
						}
						if (e && e.keyCode == 113) { // 按 F2 
							//要做的事情
						}
						if (e && e.keyCode == 13) { // enter 键
							Ind_login();
						}
					};

				});
	</script>
	<!--右部贴边切换按钮 -->
	<script>

		function changeDiv2() {
			$('.layer1').show();
			$('.layer2').hide();
			$('.navigation').show();
			$('.fixmenu-clone').hide();
			$("#btn_change2").css("background-color", "grey");
			$("#btn_change1").css("background-color", "#FFFFFF");
			

		};
		function changeDiv1() {
			$('.layer2').show();
			$('.layer1').hide();
			$('.navigation').hide();
			$('.fixmenu-clone').show();
			document.getElementById("layer2").className = "layer2";
			$("#btn_change1").css("background-color", "grey");
			$("#btn_change2").css("background-color", "#FFFFFF");
		};
		/* 右部扫码部分 */
		$(function() {
			$("[rel=modal]")
					.popover(
							{
								trigger : 'manual',
								placement : 'left', //placement of the popover. also can use top, bottom, left or right
								title : '<div style="text-align:center; font-size:16px;width:80px;float:left;color:black">Android</div><div style="text-align:center; font-size:16px;color:black">IOS</div></div>', //this is the top title bar of the popover. add some basic css
								html : 'true', //needed to show html of course
								content : '<div id="popOverBox" style="display:inline;"><div style="float:left;"><img src="icon/code.png" width="78" height="80" style="margin-bottom:10px;"/></div><div style="float:left;line-height:80px;">+</div><div style="float:left;"><img src="icon/code.png" width="80" height="80" /></div></div>', //this is the content of the html box. add the image here or anything you want really.
								animation : false
							}).on(
							"mouseenter",
							function() {
								var _this = this;
								$(this).popover("show");
								$(this).siblings(".popover").on("mouseleave",
										function() {
											$(_this).popover('hide');
										});
							}).on("mouseleave", function() {
						var _this = this;
						setTimeout(function() {
							if (!$(".popover:hover").length) {
								$(_this).popover("hide")
							}
						}, 100);
					});
		});
	</script>

	<!--登录/注册校验部分 -->
	<script type="text/javascript">
		var uname, upwd, flag;
		function log_reg(name_id, pwd_id, id, id2, modal) {
			uname = $(JSON.parse("\"#" + name_id + "\"")).val();
			upwd = $(JSON.parse("\"#" + pwd_id + "\"")).val();
			$(JSON.parse("\"#" + id + "\"")).css("display", "none");
			$(JSON.parse("\"#" + id2 + "\"")).css("display", "none");
			if (uname.length <= 3) {
				$(JSON.parse("\"#" + id + "\"")).css("display", "block");
				return false;
			}
			if (upwd.length == 0) {
				$(JSON.parse("\"#" + id2 + "\"")).css("display", "block");
				return false;
			}
			if (modal != null)
				$(JSON.parse("\"#" + modal + "\"")).modal('show');
			return true;
		}

		function Ind_login() {
			flag = log_reg("user_name1", "user_pwd1", "tip_label4",
					"tip_label5", null);
			if (flag)
				$.ajax({
					url : 'androidlogin',
					type : 'post',
					cache : false,
					data : {
						"uname" : uname,
						"upwd" : hex_sha1(upwd+"patrol")
					},
					success : function(result) {
						if (result == "adminLoginSuccess"||result == "plantLoginSuccess"||result == "teacherLoginSuccess") {
							localStorage.log_reg=1;
							window.location.href = "systema.jsp";
						} else {
							$("#login_msg").html('请检查你的用户名和密码是否正确');
							$("#myModal0").modal('show');
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						$("#login_msg").html('请求服务器失败!');
						$("#myModal0").modal('show');
					}
				});
		}
		function Ind_register() {
			log_reg("user_name", "user_pwd", "tip_label1", "tip_label2",
					"myModal");
			$("#ajax_msg").css("display", "none");
			$("#tip_label3").css("display", "none");
			changeCode();
			$("#vcode").val("");
		}
		function findPass() {
			$("#myModal1").modal('show');
		}
		function changeCode() {
			var path = "vcode.jsp?id=" + Math.random();
			$("#imagecode").attr('src', path);
		}
		function submitCode() {
			var vcode = $("#vcode").val();
			$("#ajax_msg").css("display", "none");
			$("#tip_label3").css("display", "none");
			if (vcode.length == 0) {
				$("#tip_label3").css("display", "block");
				return;
			}
			$.ajax({
				url : 'register',
				type : 'post',
				cache : false,
				data : {
					"uname" : uname,
					"upwd" : hex_sha1(upwd+"patrol"),
					"vcode" : vcode,
				},
				success : function(result) {
					if (result == "vcodeError") {
						$("#ajax_msg").html('验证码错误');
						$("#ajax_msg").css("display", "inline-block");
					} else if (result == "existuser") {
						$("#ajax_msg").html('用户名已存在!');
						$("#ajax_msg").css("display", "inline-block");
					} else {
						localStorage.log_reg=1;
						window.location.href = "systema.jsp";
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					$("#ajax_msg").html('请求服务器失败!');
					$("#ajax_msg").css("display", "inline-block");
				}
			});
		}
	</script>
</body>

</html>