<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>教师数据分析</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
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

.class_compare {
	display: -webkit-box; /*使用flexbox 布局*/
	-webkit-box-pack: center; /*实现容器内容垂直居中*/
	-webkit-box-align: center; /* 实现容器内的内容水平居中*/
}
</style>
</head>

<body>
	<div class="Global-layout">
		<div class="analyze">
			<div id="teaScore" style="width:1000px;height:400px;"></div>
		</div>
		<div class="analyze">
			<div id="teaAction"
				style="width:800px;height:400px;margin-left:80px"></div>
		</div>
		<div class="analyze">
			<div id="teaSex"
				style="margin-top:50px;width:400px;height:400px;"></div>
			<div id="teaJob"
				style="margin-top:50px;margin-left:200px;width:400px;height:400px;"></div>
		</div>
	
	</div>
	<script type="text/javascript">
		//记录老师所带班级表现
		var data_x_name= [], data_y_classnum = [], data_y_teascore = [];
	
		// 柱状图
		var myChart=echarts.init(document.getElementById('teaScore'));
		myChart.showLoading();
		getTeainfo();
		var option={
				title:{
					text:'',
					subtext:'巡查记录'
				},
				tooltip:{
					trigger:'axis'
				},
				legend:{
					data:['老师所带班级','老师综合评分']
				},
				toolbox:{
					show:true,
					feature:{
						dataView:{
							show:true,
							readOnly:false
						},
						magicType:{
							show:true,
							type:['line','bar']
						},
						restore:{
							show:true
						},
						saveAsImage:{
							show:true
						}
					}
				},
				calculable:true,
				xAxis:[{
					type:'category',
					data:data_x_name
				}],
				yAxis:[{
					type:'value'
				}],
				series:[{
					name:'老师所带班级',
					type:'bar',
					data:data_y_classnum
			
				},{
					name:'老师综合评分',
					type:'bar',
					data:data_y_teascore
				}]
		};
		myChart.hideLoading();
		myChart.setOption(option);
		
		function getTeainfo() {
			
			$.ajax({
				type : "post",
				async : false, //同步执行
				url : "getTeainfo",
				data : {},
				dataType : "json", //返回数据形式为json
				success : function(result) {
					if (result) {
						
						for (var i = 0; i < result.total/2; i++) {
						
						data_x_name.push(result.rows[i].mainteacher);
							data_y_classnum.push(result.rows[i].u_class);
							data_y_teascore.push(result.rows[i].score);
						}
					}
				},
				error : function(errorMsg) {
					alert("不好意思，大爷，图表请求数据失败啦!");
					myChart.hideLoading();
				}
			});
			} 
		
		// ######################## 老师上课表现
		var myChart2 = echarts.init(document.getElementById('teaAction'));
		var option2 = {
			title : {
				text : '',
				subtext : '老师上课总体表现',
				x : 'center'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : [ '非常好', '还不错', '一般般', '略不好', '非常差' ]
			},
			series : [ {
				name : '巡查结果',
				type : 'pie',
				radius : '55%',
				center : [ '50%', '60%' ],
				data : [ {
					value : 11,
					name : '非常好'
				}, {
					value : 7,
					name : '还不错'
				}, {
					value : 16,
					name : '一般般'
				}, {
					value : 4,
					name : '略不好'
				}, {
					value : 6,
					name : '非常差'
				} ],
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};

		myChart2.setOption(option2);
		
		//这里是性别分布
		var myChart3 = echarts.init(document.getElementById('teaSex'));
		var option3 = {
			title : {
				text : '',
				subtext : '老师性别比例',
				x : 'center'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : [ '男', '女' ]
			},
			series : [ {
				name : '分布结果',
				type : 'pie',
				radius : '55%',
				center : [ '50%', '60%' ],
				data : [ {
					value : 108,
					name : '男'
				}, {
					value : 61,
					name : '女'
				}],
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};

		myChart3.setOption(option3);
		
		//这里是老师职位分布
			var myChart4= echarts.init(document.getElementById('teaJob'));
		var option4 = {
			title : {
				text : '',
				subtext : '老师职位分布',
				x : 'center'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : [ '教师', '班主任', '年级组长', '学科组长', '系主任', '副校长','校长' ]
			},
			series : [ {
				name : '分布结果',
				type : 'pie',
				radius : '55%',
				center : [ '70%', '60%' ],
				data : [ {
					value : 117,
					name : '教师'
				}, {
					value : 8,
					name : '班主任'
				}, {
					value : 4,
					name : '年级组长'
				}, {
					value : 32,
					name : '学科组长'
				}, {
					value : 4,
					name : '系主任'
				}, {
					value : 3,
					name : '副校长'
				}, {
					value : 1,
					name : '校长'
				} ],
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};

		myChart4.setOption(option4);
	</script>
</body>
</html>
