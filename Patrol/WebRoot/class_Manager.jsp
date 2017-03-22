<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>班级信息管理</title>
<link rel="stylesheet" href="easyui/themes/bootstrap/easyui.css" />
<link rel="stylesheet" href="easyui/themes/icon.css">
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">

	function refreshDataGrid() {
		$("#datagrid").datagrid("reload");
	}
	function options(id, index) {

		return "<a href='javascript:updateClassInfoById()'>修改信息</a>	&nbsp;<a href='javascript:deleteClassInfoById()'>删除</a>"

	}

	function findUserInfoByNameOrTime() {
		$("#datagrid").datagrid("reload", {
			"mainteacher" : $("#cuname").val(),
			/* "d_date" : $("#birthday").datebox("getValue") */
		});
	}

	function editUserInfoById() {

		$("#datagrid").datagrid("beginEdit");

	}

	function updateClassInfoById() {

		var mainteacher, phone, dept, d_class, score;

		var row = $("#datagrid").datagrid("getSelected");
		var rindex = $("#datagrid").datagrid('getRowIndex', row);

		var ed = $("#datagrid").datagrid('getEditor', {
			index : rindex,
			field : 'mainteacher'
		});

		var ed2 = $("#datagrid").datagrid('getEditor', {
			index : rindex,
			field : 'phone'
		});

		var ed4 = $("#datagrid").datagrid('getEditor', {
			index : rindex,
			field : 'dept'
		});

		var ed5 = $("#datagrid").datagrid('getEditor', {
			index : rindex,
			field : 'd_class'
		});


		var ed6= $("#datagrid").datagrid('getEditor', {
			index : rindex,
			field : 'score'
		});

		if (ed == null)
			mainteacher = row.mainteacher;
		else
			mainteacher = $(ed.target).val();
		if (ed2 == null)
			phone = row.phone;
		else
			phone = $(ed2.target).val();
		if (ed4 == null)
			dept = row.dept;
		else
			dept = $(ed4.target).combobox('getValue');
		if (ed5 == null)
			d_class = row.d_class;
		else
			d_class = $(ed5.target).val();
		if (ed6 == null)
			score = row.score;
		else
			score = $(ed6.target).val();

		$.ajax({
			url : 'updateClassInfoById',
			contentType : "text/html;charset=utf-8",
			data : {
				"id" : row.id,
				"mainteacher" : mainteacher,
				"phone" : phone,
				"dept" : dept,
				"d_class" : d_class,
				"score" : score
			},
			success : function(result) {

				if (result == "updataSuccess") {
					alert('成功');

				} else {
					alert('shibai');
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert('请求服务器失败!');

			}
		});

		//结束编辑
		$("#datagrid").datagrid('endEdit', rindex);

	}

	function deleteClassInfoById() {
		var row = $("#datagrid").datagrid("getSelected");
		if (row != null) {
			$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
				if (r) {
					$.ajax({
						url : 'deleteClassInfoByID',
						data : {
							"id" : row.id
						},
						success : function(result) {
							if (result == "deleteSuccess") {
								$("#datagrid").datagrid("reload");
								$("#datagrid").datagrid("clearSelections");
							} else {
								$.messager.show({
									title : "消息提示",
									msg : "删除数据失败!",
									showType : "show"
								});
							}
						}
					});
				}
			});
		} else {
			$.messager.show({
				title : "消息提示",
				msg : "请选择一行要删除的数据!",
				showType : "show"
			});
		}

	}

	function formatPrice(val, row) {
		if (val < 60) {
			return '<span style="color:red;">' + val + '</span>';
		} else {
			return val;
		}
	}
</script>
<script type="text/javascript">
	$.extend($.fn.datagrid.methods, {
		editCell : function(jq, param) {
			return jq.each(function() {
				var opts = $(this).datagrid('options');
				var fields = $(this).datagrid('getColumnFields', true).concat(
						$(this).datagrid('getColumnFields'));
				for (var i = 0; i < fields.length; i++) {
					var col = $(this).datagrid('getColumnOption', fields[i]);
					col.editor1 = col.editor;
					if (fields[i] != param.field) {
						col.editor = null;
					}
				}
				$(this).datagrid('beginEdit', param.index);
				for (var i = 0; i < fields.length; i++) {
					var col = $(this).datagrid('getColumnOption', fields[i]);
					col.editor = col.editor1;
				}
			});
		}
	});

	var editIndex = undefined;
	function endEditing() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#datagrid').datagrid('validateRow', editIndex)) {
			$('#datagrid').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onDblClickCell(index, field, value) {
		$(this).datagrid('beginEdit', index);
		var ed = $(this).datagrid('getEditor', {
			index : index,
			field : field
		});
		$(ed.target).focus();
	}
	function onClickCell(index, field) {
		if (endEditing()) {
			$('#datagrid').datagrid('selectRow', index).datagrid('editCell', {
				index : index,
				field : field
			});
			editIndex = index;
		}
	}
</script>
<script type="text/javascript">
	var editIndex = undefined;
	function endEditing() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#dg').datagrid('validateRow', editIndex)) {
			$('#dg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickCell2(index) {
		if (endEditing()) {
			$('#dg').datagrid('selectRow', index).datagrid('beginEdit', index);
			editIndex = index;
		} else {
			$('#dg').datagrid('selectRow', editIndex);
		}
	}
</script>
</head>
<body>


	<!-- 	<table id="dg" class="easyui-datagrid"></table> -->
	<div class="easyui-panel"
		data-options="title:'班级信息管理',width:'auto',height:'auto'">
		<table id="datagrid" class="easyui-datagrid"
			data-options="pageNumber:1,pageSize:10,pageList:[5,10,15,20],pagePosition:'bottom',nowrap:true,striped:true,url:escape('findClassInfo'),toolbar:'#btn'
				,rownumbers:true,idField:'id',fitColumns:true,method:'post',pagination:true,singleSelect:true,onDblClickCell: onDblClickCell">
			<thead>
				<tr>

					<th data-options="field:'mainteacher',width:'15%',editor:'text'">主管老师</th>
					<th data-options="field:'phone',width:'25%',editor:'text'">联系方式</th>
					<th data-options="field:'dept',width:'15%'"
						editor="{  
type:'combobox',  
options:{required:true,  
editable:true,  
data:  
[
{    
    'id':1,    
    'text':'高一组'   
},{    
    'id':2,    
    'text':'高二组' ,  
},{    
    'id':3,    
    'text':'高三组' ,  
},{    
    'id':4,    
    'text':'高四组' ,  
}

],
valueField:'id',  
textField:'text'}}">所属部门</th>

					<th data-options="field:'d_class',width:'15%'"
												editor="{  
type:'combobox',  
options:{required:true,  
editable:true,  
data:  
[
{    
    'id':1,    
    'text':'1班'   
},{    
    'id':2,    
    'text':'2班' ,  
},{    
    'id':3,    
    'text':'3班' ,  
},{    
    'id':4,    
    'text':'4班' ,  
},{    
    'id':5,    
    'text':'5班' ,  
},{    
    'id':6,    
    'text':'6班' ,  
},{    
    'id':7,    
    'text':'7班' ,  
},{    
    'id':8,    
    'text':'8班' ,  
}

],
valueField:'id',  
textField:'text'}}">所属班级</th>

					<th
						data-options="field:'score',width:'12%',formatter:formatPrice,editor:'text'">评分</th>
					<th data-options="field:'id',width:'18%',formatter:options">操作</th>
				</tr>
			</thead>
		</table>


		<div id="btn">
			<a href="#" class="easyui-linkbutton"
				data-options="iconCls:'icon-lock'">全选</a> <a href="#"
				class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a> <a
				href="#" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit'">修改</a> <a href="#"
				onclick="deleteUserInfoById()" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove'">删除</a> <a href="#"
				onclick="refreshDataGrid()" class="easyui-linkbutton"
				data-options="iconCls:'icon-reload'">刷新</a> <a
				href="javascript:saveUserInfo()" class="easyui-linkbutton"
				data-options="iconCls:'icon-save'">保存</a> <br /> <br />
			<fieldset>
				<legend>高级查询</legend>
				姓名<input type="text" id="cuname" name="uname" /> 
				<!-- 	<input
					class="easyui-datebox" type="text" id="birthday" name="birthday" /> -->
				<a href="javascript:findUserInfoByNameOrTime()"
					class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
			</fieldset>
		</div>
	</div>







</body>
</html>
