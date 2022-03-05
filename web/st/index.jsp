<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

<script>
	$(function(){
		//为创建按钮绑定一个事件,打开添加操作的模态窗口
		$("#addBtn").click(function (){
			time();
			$("#questionAddForm")[0].reset();
			/*
				操作模态窗口的方式：
					需要操作模态窗口的jquery对象，调用modal方法，该方法传递参数， show:打开模态窗口， hide：隐藏模态窗口
			 */
			// $("#createquestionModal").modal("show");
			//走后台，目的是获取用户信息列表，为所有者下拉框铺值
			$.ajax({
				url:"st/getUserList.do",
				type:"get",
				dataType:"json",
				success:function (data){
					/*
						List<User> uList
						data
							[{},{},{}...]
					 */
					var html = "<option></option>";
					$.each(data,function (i,n){
						html+="<option value='"+n.username+"'>"+n.username+"</option>";
					})

					$("#create-owner").html(html);

					//将当前登录的用户，设置为下拉框的默认选项
					//取得当前登录用户的id（利用el表达式取session中的值，注意要套用在字符串中，也就是加在“”中）
					var id = "${user.username}";
					$("#create-owner").val(id);
					ifType("create");
					//根据题类型选框发生变化
					$("#create-type").change(function () {
						ifType("create");

					});
					//当所有者下拉框处理完毕后，展现模态窗口
					$("#createQuestionModal").modal("show");
				}
			})
		})

		$("#saveBtn").click(function(){
			var $as =$("input[name='answer']:checked");
			var html="";
			for(var i = 0;i<$as.length;i++){
				html+=$($as[i]).val();
			}
			$.ajax({
				url: "st/save.do",
				data:{
					"owner":$.trim($("#create-owner").val()),
					"type":$.trim($("#create-type").val()),
					"startDate":$.trim($("#create-startDate").val()),
					"title":$.trim($("#create-title").val()),
					"optionA":$.trim($("#create-optionA").val()),
					"optionB":$.trim($("#create-optionB").val()),
					"optionC":$.trim($("#create-optionC").val()),
					"optionD":$.trim($("#create-optionD").val()),
					"answer": html
				},
				type: "post",
				dataType: "json",
				success:function (data){
					/*
						data
							{"success":true/false}
					 */
					if (data.success){
						//添加成功后
						//刷新市场活动信息列表（局部刷新）
						// pageList(1,2);
						//清空模态窗口中的数据
						/*
							注意：
								我们拿到了form表单的jquery对象，
								对于表单的jquery对象，提供了submit()方法让我们提交表单，
								但表单的jquery对象，没有为我们提供reset()方法让我们重置表单（坑：idea为我们提示了有reset方法，但实际是无效的）

								虽然jquery对象没有提供reset方法，但是原生的js对象有
								所以我们将jquery对象转成原生的dom对象即可使用

								jquery对象转换成dom对象：jquery对象[下标]
								dom对象转换成jquery对象:$(dom)
						 */
						$("#questionAddForm")[0].reset();
						//关闭添加操作的模态窗口
						$("#createQuestionModal").modal("hide");
						pageList(1,$("#questionPage").bs_pagination('getOption', 'rowsPerPage'));
					}else{
						alert("添加失败");
					}
				}
			})
		})
		//页面加载完毕后出发第一个方法
        //默认展开页表的第一页，每页展现两条记录
        pageList(1,5);

		//为查询按钮绑定事件，出发pageList方法
        $("#searchBtn").click(function (){
        	/*
        		点击查询按钮的时候，我们应该将搜索框中的信息保存起来，保存到隐藏域中
        	*/
			$("#hidden-title").val($.trim($("#search-title").val()));
			$("#hidden-owner").val($.trim($("#search-owner").val()));
			$("#hidden-startDate").val($.trim($("#search-startDate").val()));
			$("#hidden-type").val($.trim($("#search-type").val()));

			pageList(1,$("#questionPage").bs_pagination('getOption', 'rowsPerPage'));
        })

		$("#qx").on("click",function (){
			$("input[name=xz]").prop("checked",this.checked);
		})
		$("#questionBody").on("click",$("input[name=xz]"),function (){
			$("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);
		})
		//为删除按钮绑定事件，执行市场活动删除操作
		$("#deleteBtn").click(function (){
			//找到复选框中所有挑√的复选框的jquery对象
			var $xz = $("input[name=xz]:checked");
			if ($xz.length==0){
				alert("请选择要删除的记录")
			}else{
				if(confirm("确定要删除所选的记录吗？")){
					//拼接参数
					var param = "";

					//将$xz中的每一个dom对象遍历出来，取其value值相当于取得了需要删除记录的id
					for (var i=0;i<$xz.length;i++){
						param += "id="+ $($xz[i]).val();
						if (i<$xz.length-1){
							param += "&";
						}
					}
					$.ajax({
						url:"st/delete.do",
						data:param,
						type:"post",
						dataType:"json",
						success:function (data){
							if (data.success){
								pageList(1,$("#questionPage").bs_pagination('getOption', 'rowsPerPage'));
							}else {
								alert("删除试题失败")
							}
						}
					})
				}

			}
		})

		//为修改按钮绑定事件，打开修改操作的模态窗口
		$("#editBtn").click(function (){
			time();
			var $xz = $("input[name=xz]:checked");
			if ($xz.length==0){
				alert("请选择需要修改的记录")
			}else if ($xz.length>1){
				alert("对不起，一次只能同时修改一个记录，请重新选择")
			}else if ($xz.length==1){
				var id = $xz.val();
			$.ajax({
				url:"st/getUserListAndQuestion.do",
				data:{
					"id":id
				},
				type:"get",
				dataType:"json",
				success:function (data){
					$("#edit-type").change(function () {
						ifType("edit");
					});
					/*
						data
						    用户列表
						    试题对象
						    {"uList":[{用户1},{2},{3}],"a":试题对象}
					*/
                    //处理所有者下拉框
                    var html = "<option></option>"
                    $.each(data.uList,function (i,n){
                        html += "<option value='"+n.username+"'>"+n.username+"</option>"
                    })
                    $("#edit-owner").html(html);
                    //处理单条question
					$("#edit-id").val(data.q.id);
                    $("#edit-owner").val(data.q.owner);
                    $("#edit-startDate").val(data.q.startDate);
                    $("#edit-type").val(data.q.type);
                    $("#edit-title").val(data.q.title);
                    $("#edit-optionA").val(data.q.optionA);
                    $("#edit-optionB").val(data.q.optionB);
                    $("#edit-optionC").val(data.q.optionC);
                    $("#edit-optionD").val(data.q.optionD);
					ifType("edit");
					$("input[name='answer']").prop("checked",false);
					var str = data.q.answer;
					var arr = str.split("");
					for(var i = 0;i<arr.length;i++){
						$("input[value='"+arr[i]+"']").prop("checked",true);
					}


                    //所有的值都填写好之后，打开修改操作的模态窗口
                    $("#editquestionModal").modal("show");
				}
			})
			}
		})

		//给更新按钮添加点击事件
		$("#updateBtn").click(function (){
			$.ajax({
				url: "st/update.do",
				data:{
					"id":$("#edit-id").val(),
					"owner":$.trim($("#edit-owner").val()),
					"type":$.trim($("#edit-type").val()),
					"startDate":$.trim($("#edit-startDate").val()),
					"title":$.trim($("#edit-title").val()),
					"optionA":$.trim($("#edit-optionA").val()),
					"optionB":$.trim($("#edit-optionB").val()),
					"optionC":$.trim($("#edit-optionC").val()),
					"optionD":$.trim($("#edit-optionD").val()),
					"answer":$.trim($("input[name='answer']:checked").val())
				},
				type: "post",
				dataType: "json",
				success:function (data){
					/*

						data
							{"success":true/false}

					 */
					if (data.success){
						//修改成功后
						//刷新市场活动信息列表（局部刷新）
						// pageList(1,2);

						//关闭修改操作的模态窗口
						$("#editquestionModal").modal("hide");
						pageList($("#questionPage").bs_pagination('getOption', 'currentPage')
								,$("#questionPage").bs_pagination('getOption', 'rowsPerPage'));

					}else{
						alert("修改市场活动失败");
					}
				}
			})
		})

	});
	function time(){
		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "bottom-left"
		});
	}
	function ifType(str) {
		if ($("#"+str+"-type").val()=="单选题"){
			$("input[name='answer']").attr('type','radio');
			$("#"+str+"-optionC").show();
			$("#"+str+"-optionD").show();
			$("."+str+"-optionC").show();
			$("."+str+"-optionD").show();
		}else if($("#"+str+"-type").val()=="多选题"){
			$("input[name='answer']").attr('type','checkbox');
			$("#"+str+"-optionC").show();
			$("#"+str+"-optionD").show();
			$("."+str+"-optionC").show();
			$("."+str+"-optionD").show();
		}else if($("#"+str+"-type").val()=="判断题"){
			$("input[name='answer']").attr('type','radio');
			$("#"+str+"-optionC").hide();
			$("#"+str+"-optionD").hide();
			$("."+str+"-optionC").hide();
			$("."+str+"-optionD").hide();
		}
	}

	function pageList(pageNo,pageSize){
		//将全选复选框的√干掉
		$("#qx").prop("checked",false);
		//查询前，将隐藏域中保存的信息取出来，重新赋予到搜索框中
		$("#search-title").val($.trim($("#hidden-title").val()));
		$("#search-owner").val($.trim($("#hidden-owner").val()));
		$("#search-startDate").val($.trim($("#hidden-startDate").val()));
		$("#search-type").val($.trim($("#hidden-type").val()));
        $.ajax({
            url:"st/pageList.do",
            data:{
                "pageNo":pageNo,
                "pageSize":pageSize,
                "title":$.trim($("#search-title").val()),
                "owner":$.trim($("#search-owner").val()),
                "startDate":$.trim($("#search-startDate").val()),
                "type":$.trim($("#search-type").val()),
            },
            type:"get",
            dataType:"json",
            success:function (data){
                /*
                    data
                        我们需要的，信息列表
                        [{1},{2},{3},{4}] List<question> aList
                        一会儿分页插件需要的，查询出来的总记录数
                        {"total":100} int total

                        {"total":100,"dataList":[{1},{2},{3},{4}]

                 */
                var html = "";
                $.each(data.dataList,function (i,n){
                    html += '<tr class="active">';
                    html += '<td><input type="checkbox" name="xz" value="'+n.id+'"/></td>';
                    html += '<td style="width: 500px"><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'st/detail.do?id='+n.id+'\';">'+n.title+'</a></td>';
                    html += '<td>'+n.owner+'</td>';
                    html += '<td>'+n.startDate+'</td>';
					html += '<td>'+n.type+'</td>';
                    html += '</tr>';

                })
                $("#questionBody").html(html);

				//计算总页数
				var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;


				//数据添加完毕后，结合分页插件，对前端显示分页信息
				$("#questionPage").bs_pagination({
					currentPage: pageNo, // 页码
					rowsPerPage: pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: data.total, // 总记录条数

					visiblePageLinks: 3, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,

					onChangePage : function(event, data){
						pageList(data.currentPage , data.rowsPerPage);
					}
				});

			}
        })

    }
	
</script>
</head>
<body>

	<input type="hidden" id="hidden-title"/>
	<input type="hidden" id="hidden-owner"/>
	<input type="hidden" id="hidden-startDate"/>
	<input type="hidden" id="hidden-type"/>

	<!-- 创建试题的模态窗口 -->
	<div class="modal fade" id="createQuestionModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">

					</button>
					<h4 class="modal-title" id="myModalLabel1">添加试题</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="questionAddForm">
					
						<div class="form-group">
							<label for="create-marketStOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">

								</select>
							</div>
                            <label for="create-marketStType" class="col-sm-2 control-label">类型<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-type">
									<option value="单选题">单选题</option>
									<option value="多选题">多选题</option>
									<option value="判断题">判断题</option>
								</select>

							</div>
						</div>
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startDate" style="cursor:pointer;"  readonly="readonly">
							</div>
						</div>

						<div class="form-group">
							<label for="create-title" class="col-sm-2 control-label">题目</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-title"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="create-marketStOption" class="col-sm-2 control-label">A:</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-optionA">
							</div>
						</div>
						<div class="form-group">
							<label for="create-marketStOption" class="col-sm-2 control-label">B:</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-optionB">
							</div>
						</div>
						<div class="form-group">
							<label for="create-marketStOption" class="create-optionC col-sm-2 control-label">C:</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control create-optionC" id="create-optionC">
							</div>
						</div>
						<div class="form-group">
							<label for="create-marketStOption" class="create-optionD col-sm-2 control-label">D:</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control create-optionD" id="create-optionD">
							</div>
					</div>
						<div class="form-group">
							<label for="create-answer" class="col-sm-2 control-label" id="create-answer">答案</label>
							<label  style="cursor: pointer;"><input style="margin: 12px; cursor: pointer;"  type="radio" name="answer" value="A"/>A</label>
							<label style="cursor: pointer;"><input style="margin: 12px;cursor: pointer;"   type="radio" name="answer" value="B"/>B</label>
							<label class="create-optionC" style="cursor: pointer;"><input style="margin: 12px;cursor: pointer;"   type="radio" name="answer" value="C"/>C</label>
							<label class="create-optionD" style="cursor: pointer;"><input style="margin: 12px;cursor: pointer;"   type="radio" name="answer" value="D"/>D</label>

						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">发布试题</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改试题的模态窗口 -->
	<div class="modal fade" id="editquestionModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改试题</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
                        <input type="hidden" id="edit-id">
					
						<div class="form-group">
							<label for="edit-marketStOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">

								</select>
							</div>
							<label for="edit-marketStType" class="col-sm-2 control-label">类型<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-type">
									<option value="单选题">单选题</option>
									<option value="多选题">多选题</option>
									<option value="判断题">判断题</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startDate" style="cursor:pointer;"  readonly="readonly">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-title" class="col-sm-2 control-label">题目</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-title"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="edit-marketStOption" class="col-sm-2 control-label">A:</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-optionA">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-marketStOption" class="col-sm-2 control-label">B:</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-optionB">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-marketStOption" class="col-sm-2 control-label edit-optionC">C:</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control edit-optionC" id="edit-optionC">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-marketStOption" class="col-sm-2 control-label edit-optionD">D:</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control edit-optionD" id="edit-optionD">
							</div>
						</div>

						<div class="form-group">
							<label for="edit-answer" class="col-sm-2 control-label" id="edit-answer">答案</label>
							<label style="cursor: pointer;" ><input style="margin: 12px; cursor: pointer;" type="radio" name="answer" value="A"/>A</label>
							<label style="cursor: pointer;" ><input style="margin: 12px;cursor: pointer;"  type="radio" name="answer" value="B"/>B</label>
							<label style="cursor: pointer;" class="edit-optionC"><input style="margin: 12px;cursor: pointer;"  type="radio" name="answer" value="C"/>C</label>
							<label style="cursor: pointer;" class="edit-optionD"><input style="margin: 12px;cursor: pointer;"  type="radio" name="answer" value="D"/>D</label>

						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>试题列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">题目</div>
				      <input class="form-control" type="text" id="search-title">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control time" type="text" id="search-startDate" />
				    </div>
				  </div>
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">类型</div>
							<input class="form-control" type="text" id="search-type">
						</div>
					</div>
				  <button type="button" id="searchBtn" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger"  id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>题目</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>类型</td>
						</tr>
					</thead>
					<tbody id="questionBody">
<%--						<tr class="active">--%>
<%--							<td><input type="checkbox" /></td>--%>
<%--							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/question/detail.jsp';">发传单</a></td>--%>
<%--                            <td>zhangsan</td>--%>
<%--							<td>2020-10-10</td>--%>
<%--							<td>2020-10-20</td>--%>
<%--						</tr>--%>

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="questionPage" style="right: 0px;"></div>

			</div>
			
		</div>
		
	</div>
</body>
</html>