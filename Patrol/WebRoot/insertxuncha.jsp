<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>录入巡查信息</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<link rel="stylesheet" type="text/css" href="assets/css/Hui.css" />
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

<link rel="stylesheet" type="text/css"
	href="media/css/select2_metro.css" />
<link rel="stylesheet" href="media/css/DT_bootstrap.css" />
<!-- END PAGE LEVEL STYLES -->
<link rel="shortcut icon" href="media/image/favicon.ico" />
<!-- bootstrap table 额外添加 css -->
<link rel="stylesheet" href="media/css/bootstrap-table.min.css" />
<link rel="stylesheet" type="text/css" href="calen/DateTimePicker.css" />


<script src="media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<!-- Bootstrap Table 额外添加的js脚本 -->
<script src="media/js/bootstrap-table.js"></script>

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<!-- BEGIN CONTAINER -->

	<!-- BEGIN PAGE CONTAINER-->
	<div id="record_confirm" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel3" aria-hidden="true">

		<div class="modal-header">

			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true"></button>

			<h3 id="myModalLabel3">确认提示</h3>

		</div>

		<div class="modal-body">
			<center>
			<h4>您确定要提交录入信息吗？</h4>
			</center>
		</div>

		<div class="modal-footer">

			<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>

			<button data-dismiss="modal" class="btn blue" onclick="recordConfirm()">确认</button>

		</div>

	</div>
	<div id="error_class" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">

		<div class="modal-header">

			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true"></button>

			<h3 id="myModalLabel2">错误提示</h3>

		</div>

		<div class="modal-body">

			<center>
			<h4>数据库未查到您要录入班级!</h4>
			</center>

		</div>

		<div class="modal-footer">

			<button data-dismiss="modal" class="btn green">确认</button>

		</div>

	</div>
	<div id="error_teacher" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">

		<div class="modal-header">

			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true"></button>

			<h3 id="myModalLabel2">错误提示</h3>

		</div>

		<div class="modal-body">

			<center>
			<h4>数据库未查到此班级的课程!</h4>
			</center>

		</div>

		<div class="modal-footer">

			<button data-dismiss="modal" class="btn green">确认</button>

		</div>

	</div>
	<div id="error_alert" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">

		<div class="modal-header">

			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true"></button>

			<h3 id="myModalLabel2">错误提示</h3>

		</div>

		<div class="modal-body">

			<center>
			<h4>请求服务器失败，录入的信息可能存在空值！</h4>
			</center>

		</div>

		<div class="modal-footer">

			<button data-dismiss="modal" class="btn green">确认</button>

		</div>

	</div>
	<div class="container-fluid" style="margin-top:40px;margin-right:80px;">

		<!-- BEGIN PAGE CONTENT-->

		<div class="row-fluid">

			<div class="span12">

				<!-- BEGIN EXAMPLE TABLE PORTLET-->

				<div class="portlet box blue">

					<div class="portlet-title">

						<div class="caption">
							<i class="icon-globe"></i> <span id="nametext">巡查信息添加</span>
						</div>
					</div>
					<!-- update form -->

					<div class="portlet-body form">

						<div class="tabbable portlet-tabs">

							<br> <br> <br>

							<div class="tab-content">

								<div class="tab-pane active" id="portlet_tab1">

									<!-- BEGIN FORM-->

									<form action="#" class="form-horizontal">
										<table>
											<tr>
												<td>
													<div class="control-group">
														<label class="control-label">巡查班级</label>

														<div class="controls">
															<select id="deptId" class="small m-wrap" tabindex="1">
																<option value="5">高一年级组</option>
															</select>
														</div>
														<div class="controls">
															<select id="classId" class="small m-wrap" tabindex="1">
																<option value="5">1班</option>
															</select>
														</div>

													</div>
													<div class="control-group">
														<label class="control-label">巡查时间</label>
														<div class="controls">
															<input type="text" class="form-control" data-field="date"
																data-format="yyyy-MM-dd" placeholder="巡查时间"
																id="dateTime"><span class="help-inline"
																id="name1"><font color="#FF0000">*</font></span>
															<div id="dtBox"></div>

														</div>
													</div>


													<div class="control-group">
														<label class="control-label">迟到人数</label>
														<div class="controls">
															<input class="form-control" id="lateGuys" type="text"
																placeholder="迟到人数" /><span class="help-inline"
																id="name1"><font color="#FF0000">*</font></span>
														</div>

													</div>
													<div class="control-group">
														<label class="control-label">教师准时上课</label>
														<div class="controls">
															<select id="onTime" class="small m-wrap" tabindex="1">
																<option value="0">是</option>
																<option value="1">否</option>
															</select>
														</div>
													</div>
													<div class="control-group">
														<label class="control-label">教师上课表现</label>
														<div class="controls">
															<select id="onAction" class="small m-wrap" tabindex="1">
																<option value="1">非常好</option>
																<option value="2">还不错</option>
																<option value="3">一般般</option>
																<option value="4">略不好</option>
																<option value="5">非常差</option>
															</select>
														</div>
													</div>
												</td>
												<td>
													<div class="control-group">
														<label class="control-label">本节上课课程</label>
														<div class="controls">
															<select id="courseId" class="small m-wrap" tabindex="1">
																<option value="5">语文</option>
															</select>
														</div>
													</div>

													<div class="control-group">
														<label class="control-label">学生趴桌数量</label>
														<div class="controls">
															<input type="text" id="lazyNumber" placeholder="学生趴桌数量"
																class="form-control" /> <span class="help-inline"
																id="name1"><font color="#FF0000">*</font></span>
														</div>
													</div>
													<div class="control-group">
														<label class="control-label">玩手机数量</label>
														<div class="controls">
															<input type="text" id="playNumber" placeholder="玩手机数量"
																class="form-control" /> <span class="help-inline"
																id="name1"><font color="#FF0000">*</font></span>
														</div>
													</div>
													<div class="control-group">
														<label class="control-label">看闲书数量</label>
														<div class="controls">
															<input type="text" id="readNumber" placeholder="看闲书数量"
																class="form-control" /> <span class="help-inline"
																id="name1"><font color="#FF0000">*</font></span>
														</div>
													</div>
													<div class="control-group">
														<label class="control-label">睡觉数量</label>
														<div class="controls">
															<input type="text" id="sleepNumber" placeholder="睡觉数量"
																class="form-control" /> <span class="help-inline"
																id="name1"><font color="#FF0000">*</font></span>
														</div>
													</div>
												</td>
											</tr>
										</table>

										<table>
											<tr>

												<div class="control-group">

													<label class="control-label">备注</label>

													<div class="controls">

														<textarea class="span6 form-control" rows="3" id="remarks"></textarea>

													</div>

												</div>



											</tr>

										</table>


										<div class="form-actions" style="width: 100%;">
											<input type="hidden" value="" id="ud" />	
											<button type="reset" id="but" class="btn yellow"
												onclick="resetText()">
												<i class=" icon-trash"></i> 重置
											</button>
											<button type="button" id="but" class="btn blue"
												onclick="showDialog()">
												<i class="icon-upload-alt"></i> 提交信息
											</button>
											<!-- <button type="button" class="btn">Cancel</button> -->

										</div>

									</form>

									<!-- END FORM-->

								</div>

							</div>

						</div>

					</div>
				</div>
				<!-- END EXAMPLE TABLE PORTLET-->
			</div>
		</div>
		<!-- END PAGE CONTENT-->
	</div>
	<!-- END PAGE CONTAINER-->

	<!-- END PAGE -->

	<!-- END CONTAINER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<!-- BEGIN CORE PLUGINS -->


	<script src="media/js/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>
	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
	<script src="media/js/jquery-ui-1.10.1.custom.min.js"
		type="text/javascript"></script>
	<script src="media/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="media/js/jquery.blockui.min.js" type="text/javascript"></script>
	<script src="media/js/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="media/js/jquery.uniform.min.js" type="text/javascript"></script>
	<!-- END CORE PLUGINS -->
	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="media/js/select2.min.js"></script>
	<script type="text/javascript" src="media/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="media/js/DT_bootstrap.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->
	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<!-- 从服务器获取年级与班级信息-->
	<script type="text/javascript">
		$(function() {
			$.ajax({
				url : 'getSelectDeptItem',
				type : 'post',
				cache : false,
				dataType : "json",
				success : function(result) {
					var optionstr = "";
					for (var i = 0; i < result.total; i++) {
						optionstr = optionstr
								+ "<option value='"+result.rows[i].id+"'>"
								+ result.rows[i].name + "</option>";
					}
					$("#deptId").html(optionstr);

				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert('请求服务器失败!');
				}
			});

			$.ajax({
				url : 'getSelectClassItem',
				type : 'post',
				cache : false,
				dataType : "json",
				success : function(result) {
					var optionstr = "";
					for (var i = 0; i < result.total; i++) {
						optionstr = optionstr
								+ "<option value='"+result.rows[i].id+"'>"
								+ result.rows[i].name + "</option>";
					}
					$("#classId").html(optionstr);

				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert('请求服务器失败!');

				}
			});
			$.ajax({
				url : 'getSelectCourseItem',
				type : 'post',
				cache : false,
				dataType : "json",
				success : function(result) {
					var optionstr = "";
					for (var i = 0; i < result.total; i++) {
						optionstr = optionstr
								+ "<option value='"+result.rows[i].id+"'>"
								+ result.rows[i].name + "</option>";
					}
					$("#courseId").html(optionstr);

				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert('请求服务器失败!');
					//"请求服务器失败!",

				}
			});
		});
	</script>
	<!-- 获取录入信息 -->
	<script type="text/javascript" src="assets/js/H.js"></script>
	<script>
		function showDialog() {
			$("#record_confirm").modal('show');
		}
		function recordConfirm() {
			$("#record_confirm").modal('hide');   
			recordMsg();
		}
		function recordMsg() {
			var deptId, classId, courseId;
			var deptVal, classVal, courseVal;
			var dateTime = $("#dateTime").val();
			var lateGuys = $("#lateGuys").val();
			var onTime;
			var onAction;
			/*获取学生表现*/
			var lazyNumber = parseInt($("#lazyNumber").val());
			var playNumber = parseInt($("#playNumber").val());
			var readNumber = parseInt($("#readNumber").val());
			var sleepNumber = parseInt($("#sleepNumber").val());
			var remarks = parseInt($("#remarks").val());

			/*获取老师表现*/
			onTime = parseInt($("#onTime").find("option:selected").val());
			onAction = parseInt($("#onAction").find("option:selected").val());
			/*获取value的ID编号*/
			deptId = $("#deptId").find("option:selected").val();
			classId = $("#classId").find("option:selected").val();
			courseId = $("#courseId").find("option:selected").val();
			/*获取选中的文本值*/
			deptVal = $("#deptId").find("option:selected").text();
			classVal = $("#classId").find("option:selected").text();
			courseVal = $("#courseId").find("option:selected").text();
			/*计算班级得分*/
			var person = lazyNumber + lazyNumber + playNumber + readNumber
					+ sleepNumber;
			var t_score = 0.5 * (onAction - 1 + onTime);
			var c_score = 0.5 * person;

			$.ajax({
				url : 'recordMsg',
				type : 'post',
				cache : false,
				data : {
					"dept" : deptId,
					"u_class" : classId,
					"course" : courseId,
					"late" : lateGuys,
					"table" : lazyNumber,
					"play" : playNumber,
					"book" : readNumber,
					"sleep" : sleepNumber,
					"ontime" : onTime,
					"onaction" : onAction,
					"remarks" : remarks,
					"score" : c_score,
					"t_score" : t_score,
					"date" : dateTime
				},
				success : function(result) {
					if (result == "recordSuccess") {
						H.toastSuccess();
					} else if (result == "noclass") {
						$("#error_class").modal('show'); 
					} else if (result == "noteacher") {
						$("#error_teacher").modal('show'); 
					} else {
						H.toastError();
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					$("#error_alert").modal('show'); 
					//"请求服务器失败!",

				}
			});

		}
	</script>


	<script src="media/js/app.js"></script>
	<script src="media/js/table-advanced.js"></script>

	<!-- 添加日历 -->
	<script type="text/javascript" src="calen/DateTimePicker.js"></script>
	<script type="text/javascript" src="calen/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#dtBox").DateTimePicker({
				dateFormat : "yyyy-MM-dd"

			});
		});
	</script>
	<script>
		jQuery(document).ready(function() {
			App.init();
			TableAdvanced.init();
		});
	</script>
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

</body>
<!-- END BODY -->
</html>