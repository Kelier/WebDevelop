<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>班级分析</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/normalize.css" />
<link rel="stylesheet" type="text/css" href="css/demo.css" />
<link rel="stylesheet" type="text/css" href="css/cs-select.css" />
<link rel="stylesheet" type="text/css" href="css/cs-skin-slide.css" />
<link rel="stylesheet" type="text/css" href="css/cs-skin-overlay.css" />
<link rel="stylesheet" href="css/button.min.css" />

<script type="text/javascript" src="js/echarts.js"></script>
<script type="text/javascript" src="easyui/jquery.min.js"></script>

<style type="text/css">
.Global-layout {
	display: -webkit-box; /*使用flexbox 布局*/
	-webkit-box-pack: center; /*实现容器内容垂直居中*/
	-webkit-box-align: center; /* 实现容器内的内容水平居中*/
	-webkit-box-orient: vertical; /*容器内的元素垂直排列*/
}

.analyze {
	margin-top: 70px;
	display: -webkit-box; /*使用flexbox 布局*/
	-webkit-box-pack: center; /*实现容器内容垂直居中*/
	-webkit-box-align: center; /* 实现容器内的内容水平居中*/
	-webkit-box-orient: horizontal; /*容器内的元素垂直排列*/
}

.analyze1 {
	margin-top: -320px;
	margin-left: 45.8%;
	z-index: 0;
	position: absolute;
	width: 80px;
	height: 40px;
	display: -webkit-box; /*使用flexbox 布局*/
	-webkit-box-pack: center; /*实现容器内容垂直居中*/
	-webkit-box-align: center; /* 实现容器内的内容水平居中*/
	-webkit-box-orient: horizontal; /*容器内的元素垂直排列*/
}

.class_compare {
	display: -webkit-box; /*使用flexbox 布局*/
	-webkit-box-pack: center; /*实现容器内容垂直居中*/
	-webkit-box-align: center; /* 实现容器内的内容水平居中*/
}
</style>
</head>

<body>

	<div class="analyze">
		<div id="grade_star" style="width:1000px;height:400px;"></div>

	</div>
	<div style="margin-top:80px;">
		<div class="analyze">
			<div id="class_analyze"
				style="width:1000px;height:400px;position:relative;"></div>
		</div>
		<div class="analyze">
			<div style="margin-left:50px;margin-top:50px;">
				<hr>
				<span
					style="color:#000;font-size:20px;font-weight:bold;font-family: 微软雅黑;">谁</span>
				<span
					style="color:#000;font-size:20px;font-weight:bold;font-family: 微软雅黑;">与</span>
				<span
					style="color:#000;font-size:20px;font-weight:bold;font-family: 微软雅黑;">争</span>
				<span
					style="color:#000;font-size:20px;font-weight: bold;font-family: 微软雅黑;">锋</span>
				<hr>
			</div>
		</div>


		<div style="margin-top:50px;margin-left:20%;float:left;">
			<select class="cs-select cs-skin-slide" id="classone">
				<option value="class" disabled selected>请选择班级</option>
				<option value="1">1班</option>
				<option value="2">2班</option>
				<option value="3">3班</option>
				<option value="4">4班</option>
				<option value="5">5班</option>
				<option value="6">6班</option>
				<option value="7">7班</option>
				<option value="8">8班</option>
			</select>
		</div>
		<div style="margin-top:50px;margin-left:340px;float:left;">
			<select class="cs-select cs-skin-slide" id="classtwo">
				<option value="class" disabled selected>请选择班级</option>

				<option value="1">1班</option>
				<option value="2">2班</option>
				<option value="3">3班</option>
				<option value="4">4班</option>
				<option value="5">5班</option>
				<option value="6">6班</option>
				<option value="7">7班</option>
				<option value="8">8班</option>

			</select>
		</div>

		<div style="margin-top:230px;margin-bottom:80px;margin-left:45%;">
			<select class="cs-select cs-skin-slide" id="grade">
				<option value="grade" disabled selected>请选择年级</option>
				<option value="1">高一组</option>
				<option value="2">高二组</option>
				<option value="3">高三组</option>
				<option value="4">高四组</option>
			</select>
		</div>
		<div class="analyze1">
			<div class="svg-wrapper">
				<svg height="30" width="80" xmlns="http://www.w3.org/2000/svg">
				<rect id="shape" height="30" width="80" />
				<div id="text">
					<a href="javascript:clickTest()"><span class="spot"></span>VS</a>
				</div>
				</svg>
			</div>
		</div>
		<div class="Global-layout">
			<div id="class_compare"
				style="width:1200px;height:800px;margint-top:200px;"></div>
		</div>

		<!--start button, nothing above this is necessary -->


		<script type="text/javascript">
			//这里是年级
			var data_x_grade = [];
			var data_y_grade1 = [], data_y_grade2 = [], data_y_grade3 = [], data_y_grade4 = [];

			//这里是班级
			var data_x_class = [];
			var data_y_late = [], data_y_lazy = [], data_y_play = [], data_y_book = [], data_y_sleep = [];

			//这里是比拼
			var data_x_main = [];
			var data_y_score1 = [], data_y_score2 = [], data_y_dValue = [];

			// 基于准备好的dom，初始化echarts图表
			var score2 = [];
			/*班级之星*/

			var grade_star = echarts
					.init(document.getElementById('grade_star'));
			grade_star.showLoading();
			getGradedata1();
			getGradedata2();
			getGradedata3();
			getGradedata4();
			var option = {
				title : {
					text : '班级之星',
					subtext : '成绩'
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					data : [ '高一年级', '高二年级', '高三年级', '高四年级' ]
				},
				toolbox : {
					feature : {
						saveAsImage : {}
					}
				},
				grid : {
					left : '3%',
					right : '4%',
					bottom : '3%',
					containLabel : true
				},
				xAxis : [ {
					type : 'category',
					boundaryGap : false,
					data : data_x_grade
				} ],
				yAxis : [ {
					type : 'value'
				} ],
				series : [ {
					name : '高一年级',
					type : 'line',
					stack : '陋习总量',
					areaStyle : {
						normal : {}
					},
					data : data_y_grade1
				}, {
					name : '高二年级',
					type : 'line',
					stack : '陋习总量',
					areaStyle : {
						normal : {}
					},
					data : data_y_grade2
				}, {
					name : '高三年级',
					type : 'line',
					stack : '陋习总量',
					areaStyle : {
						normal : {}
					},
					data : data_y_grade3
				}, {
					name : '高四年级',
					type : 'line',
					stack : '陋习总量',
					areaStyle : {
						normal : {}
					},
					data : data_y_grade4
				} ]
			}
			// 为echarts对象加载数据 

			grade_star.hideLoading();
			grade_star.setOption(option);
			function getGradedata1() {
				$
						.ajax({
							type : "post",
							async : false, //同步执行
							url : "tabGradestar1",
							data : {
								"page" : 1,
								"rows" : 10
							},
							dataType : "json", //返回数据形式为json
							success : function(result) {
								if (result) {
									for (var i = 0; i < result.total; i++) {
										data_x_grade
												.push(result.rows[i].u_class
														+ "班");
										data_y_grade1
												.push(result.rows[i].score);
									}
								}
							},
							error : function(errorMsg) {
								alert("不好意思，大爷，图表请求数据失败啦!");
								grade_star.hideLoading();
							}
						});
			}
			function getGradedata2() {
				$.ajax({
					type : "post",
					async : false, //同步执行
					url : "tabGradestar2",
					data : {
						"page" : 1,
						"rows" : 10
					},
					dataType : "json", //返回数据形式为json
					success : function(result) {
						if (result) {
							for (var i = 0; i < result.total; i++) {
								/* 	data_x_grade.push(result.rows[i].date); */
								data_y_grade2.push(result.rows[i].score);
							}
						}
					},
					error : function(errorMsg) {
						alert("不好意思，大爷，图表请求数据失败啦!");
						grade_star.hideLoading();
					}
				});
			}
			function getGradedata3() {
				$.ajax({
					type : "post",
					async : false, //同步执行
					url : "tabGradestar3",
					data : {
						"page" : 1,
						"rows" : 10
					},
					dataType : "json", //返回数据形式为json
					success : function(result) {
						if (result) {
							for (var i = 0; i < result.total; i++) {
								/* 	data_x_grade.push(result.rows[i].date); */
								data_y_grade3.push(result.rows[i].score);
							}
						}
					},
					error : function(errorMsg) {
						alert("不好意思，大爷，图表请求数据失败啦!");
						grade_star.hideLoading();
					}
				});
			}
			function getGradedata4() {
				$.ajax({
					type : "post",
					async : false, //同步执行
					url : "tabGradestar4",
					data : {
						"page" : 1,
						"rows" : 10
					},
					dataType : "json", //返回数据形式为json
					success : function(result) {
						if (result) {
							for (var i = 0; i < result.total; i++) {
								/* 				data_x_grade.push(result.rows[i].date); */
								data_y_grade4.push(result.rows[i].score);
							}
						}
					},
					error : function(errorMsg) {
						alert("不好意思，大爷，图表请求数据失败啦!");
						grade_star.hideLoading();
					}
				});
			}

			/*班级巡查情况*/
			var class_analyze = echarts.init(document
					.getElementById('class_analyze'));
			class_analyze.showLoading();
			getClassdata();
			var option = {
				title : {
					text : '班级巡查情况',
					subtext : '2016-7-9'
				},
				tooltip : {
					trigger : 'axis',
					axisPointer : { // 坐标轴指示器，坐标轴触发有效
						type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
					}
				},
				legend : {
					data : [ '迟到人数', '趴桌人数', '玩手机人数', '看闲书人数', '睡觉人数' ]
				},
				grid : {
					left : '3%',
					right : '4%',
					bottom : '3%',
					containLabel : true
				},
				xAxis : {
					type : 'value',

				},
				yAxis : {
					type : 'category',
					data : data_x_class
				},
				series : [ {
					name : '迟到人数',
					type : 'bar',
					stack : '总量',
					label : {
						normal : {
							show : true,
							position : 'insideRight'
						}
					},
					data : data_y_late
				}, {
					name : '趴桌人数',
					type : 'bar',
					stack : '总量',
					label : {
						normal : {
							show : true,
							position : 'insideRight'
						}
					},
					data : data_y_lazy
				}, {
					name : '玩手机人数',
					type : 'bar',
					stack : '总量',
					label : {
						normal : {
							show : true,
							position : 'insideRight'
						}
					},
					data : data_y_play
				}, {
					name : '读闲书人数',
					type : 'bar',
					stack : '总量',
					label : {
						normal : {
							show : true,
							position : 'insideRight'
						}
					},
					data : data_y_book
				}, {
					name : '睡觉人数',
					type : 'bar',
					stack : '总量',
					label : {
						normal : {
							show : true,
							position : 'insideRight'
						}
					},
					data : data_y_sleep
				} ]
			};
			// 为echarts对象加载数据 
			class_analyze.hideLoading();
			class_analyze.setOption(option);
			function getClassdata() {
				$.ajax({
					type : "post",
					async : false, //同步执行
					url : "tabClassstar",
					data : {
						"page" : 1,
						"rows" : 10
					},
					dataType : "json", //返回数据形式为json
					success : function(result) {
						if (result) {
							for (var i = 0; i < result.total / 6; i++) {
								data_x_class.push(result.rows[i].dept + "年级"
										+ result.rows[i].u_class + "班");
								data_y_late.push(result.rows[i].late);
								data_y_lazy.push(result.rows[i].lazy);
								data_y_play.push(result.rows[i].play);
								data_y_book.push(result.rows[i].book);
								data_y_sleep.push(result.rows[i].sleep);
							}
						}
					},
					error : function(errorMsg) {
						alert("不好意思，大爷，图表请求数据失败啦!");
						class_analyze.hideLoading();
					}
				});
			}

			/*班级对比*/
			var class_compare = echarts.init(document
					.getElementById('class_compare'));

			function clickTest() {
				getScoredata1();

				showEcharts();
			}
			function showEcharts() {
				var option = {
					tooltip : {
						trigger : 'axis',
						axisPointer : { // 坐标轴指示器，坐标轴触发有效
							type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
						}
					},
					legend : {
						data : [ '分数差值', '左绩点', '右绩点' ]
					},
					grid : {
						left : '3%',
						right : '4%',
						bottom : '3%',
						containLabel : true
					},
					xAxis : [ {
						type : 'value'
					} ],
					yAxis : [ {
						type : 'category',
						axisTick : {
							show : false
						},
						data : data_x_main
					} ],
					series : [ {
						name : '分数差值',
						type : 'bar',
						label : {
							normal : {
								show : true,
								position : 'inside'
							}
						},
						data : data_y_dValue
					}, {
						name : '左绩点',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true
							}
						},
						data : data_y_score1
					}, {
						name : '右绩点',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'left'
							}
						},
						data : data_y_score2
					} ]
				};
				// 为echarts对象加载数据 
				class_compare.hideLoading();
				class_compare.setOption(option);
			}
			function getScoredata1() {
				var classone = $("#classone").find("option:selected").val();
				var grade = $("#grade").find("option:selected").val();
				var scoreone = [];
				$.ajax({
					type : "post",
					async : false, //同步执行
					url : "tabScorestar1",
					data : {
						"classone" : classone,
						"dept" : grade
					},
					dataType : "json", //返回数据形式为json
					success : function(result) {
						if (result) {

							for (var i = 0; i < result.total; i++) {
								data_y_score1.push(result.rows[i].score);
								var score1 = result.rows[i].score;
								getScoredata2();
							}
							data_y_dValue.push(score1 - score2);

						}
					},
					error : function(errorMsg) {
						alert("不好意思，大爷，图表请求数据失败啦!");
						class_compare.hideLoading();
					}
				});
			}
			function getScoredata2() {
				var grade = $("#grade").find("option:selected").val();
				var classtwo = $("#classtwo").find("option:selected").val();

				$.ajax({
					type : "post",
					async : false, //同步执行
					url : "tabScorestar2",
					data : {
						"classtwo" : classtwo,
						"dept" : grade
					},
					dataType : "json", //返回数据形式为json
					success : function(result) {
						if (result) {
							for (var i = 0; i < result.total; i++) {

								data_y_score2.push(result.rows[i].score);
								score2 = result.rows[i].score;

							}
						}
					},
					error : function(errorMsg) {
						alert("不好意思，大爷，图表请求数据失败啦!");
						class_compare.hideLoading();
					}
				});
			}
		</script>
		<script src="js/classie.js"></script>
		<script src="js/selectFx.js"></script>
		<script>
			(function() {
				[].slice.call(document.querySelectorAll('select.cs-select'))
						.forEach(function(el) {
							new SelectFx(el);
						});
			})();
		</script>
</body>

</html>
