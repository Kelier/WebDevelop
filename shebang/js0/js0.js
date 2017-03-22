$(document).ready(function()
{
	$("#btnOK").click(function() {
		if($("#1").val()>=10||$("#1").val()<=0){
			window.alert("请输入正确的宿舍楼号")
		}
		else if($("#2").val()>=1100||$("#2").val()<=100){
			window.alert("请输入正确的宿舍号")
		}
		
		else window.alert("提交成功！")
    
	
	
	})
});

//$(document).ready(function()
//{
//	$(".btn-inline").click(function() {
//			if ($(".number0").val() == "0")
//			{
//				window.alert("请输入数量")
//			}
//			else window.alert("加入购物车成功")
//			
//	});
//});