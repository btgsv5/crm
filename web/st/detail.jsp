<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
        $("#btn-answer").hide();
        $("#btn-as").click(function (){
            $("#btn-answer").show();
        });
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});


		showRemarkList();


        $("#remarkBody").on("mouseover",".remarkDiv",function(){
            $(this).children("div").children("div").show();
        })
        $("#remarkBody").on("mouseout",".remarkDiv",function(){
            $(this).children("div").children("div").hide();
        })

        //为保存按钮绑定事件
        $("#saveRemarkBtn").on("click",function (){
            $.ajax({
                url:"st/saveRemark.do",
                data:{
                    "noteContent":$.trim($("#remark").val()),
                    "questionId":"${q.id}",
                },
                type:"post",
                dataType:"json",
                success:function (data){

                    if (data.success){
                        /*
                            data
                                {"success":true/false,"qr":{备注}}
                         */
                        //如果添加成功
                        //将textarea中内容清空
                        $("#remark").val("");
                        // alert("添加备注成功")
                        //在textarea文本域上方新增一个div
                        var html = "";
                        html += '<div id="'+data.qr.id+'" class="remarkDiv" style="height: 60px;">';
                        html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
                        html += '<div style="position: relative; top: -40px; left: 40px;" >';
                        html += '<h5 id="e'+data.qr.id+'">'+data.qr.noteContent+'</h5>';
                        html += '<small style="color: gray;" id="s'+data.qr.id+'"> '+(data.qr.createTime)+' 由'+(data.qr.createBy)+'提交</small>';
                        html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
                        html += '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+data.qr.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
                        html += '&nbsp;&nbsp;&nbsp;&nbsp;';
                        html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+data.qr.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                        $("#remarkDiv").before(html);

                    }else {
                        alert("添加备注失败")
                    }
                }
            })
        });
        $("#updateRemarkBtn").on("click",function (){
            var id = $("#remarkId").val();
            $.ajax({
                url:"st/updateRemark.do",
                data:{
                    "id":id,
                    "noteContent":$.trim($("#noteContent").val())
                },
                type:"post",
                dataType:"json",
                success:function (data){
                    /*
                        data
                            {"success":true/false,"qr":{备注}}
                     */
                    if (data.success){
                        //修改备注成功后
                        //更新div中相应的信息，需要更新的内容有 noteContent editTime editBy
                        $("#e"+id).html(data.qr.noteContent);
                        $("#s"+id).html(data.qr.editTime+" 由"+data.qr.editBy+"提交");
                        //更新内容之后，关闭模态窗口
                        $("#editRemarkModal").modal("hide");

                    }else{
                        alert("更新备注失败")
                    }

                }
        })
	});
    });

	function showRemarkList(){
		$.ajax({
			url:"st/getRemarkListByAid.do",
			data:{
				"questionId":"${q.id}"
			},
			type:"get",
			dataType:"json",
			success:function (data){
				/*
                   data
                      [{备注1},{2},{3}]
                 */
				var html = "";
				$.each(data,function (i,n){
					html += '<div id="'+n.id+'" class="remarkDiv" style="height: 60px;">';
					html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
					html += '<div style="position: relative; top: -40px; left: 40px;" >';
					html += '<h5 id="e'+n.id+'">'+n.noteContent+'</h5>';
					html += ' <small style="color: gray;"id="s'+n.id+'"> '+(n.editFlag==0?n.createTime:n.editTime)+' 由用户'+(n.editFlag==0?n.createBy:n.editBy)+'提交</small>';
					html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
					html += '<a class="myHref" href="javascript:void(0);"onclick="editRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
					html += '&nbsp;&nbsp;&nbsp;&nbsp;';
					html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
					html += '</div>';
					html += '</div>';
					html += '</div>';
				})
				$("#remarkDiv").before(html);
			}
		})
	}
	function editRemark(id){

        $("#remarkId").val(id);

        var noteContent = $("#e"+id).html();

        $("#noteContent").val(noteContent);

        $("#editRemarkModal").modal("show");

    }
	function deleteRemark(id){
	    $.ajax({
            url:"st/deleteRemark.do",
            data: {
                "id":id
            },
            type: "post",
            dataType: "json",
            success:function (data){
                /*
                    data
                        "success:true/false"
                 */
                if (data.success){
                    $("#"+id).remove();
                    // showRemarkList();
                }else {
                    alert("删除备注失败")
                }
            }
        })
    }


	
</script>

</head>
<body>
	
	<!-- 修改市场活动备注的模态窗口 -->
	<div class="modal fade" id="editRemarkModal" role="dialog">
		<%-- 备注的id --%>
		<input type="hidden" id="remarkId">
        <div class="modal-dialog" role="document" style="width: 40%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">修改备注</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="noteContent" class="col-sm-2 control-label">内容</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="noteContent"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
                </div>
            </div>
        </div>
    </div>



	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>试题名称-${q.title} <small>${q.startDate}</small></h3>
		</div>

	</div>
	<div style="height: 40px"></div>
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${q.owner}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${q.title}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">开始日期</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${q.startDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5;position: relative; top: -20px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${q.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${q.createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${q.editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${q.editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
            <div style="width: 300px; color: gray;">描述</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5;top: -20px;"></div>
            <b>
                A:${q.optionA}
            </b><br/>
            <b>
                B:${q.optionB}
            </b><br/>
            <c:if test="${q.type!='判断题'}">
            <b>
                C:${q.optionC}
            </b><br/>
            <b>
                D:${q.optionD}
            </b>
            </c:if>
		</div>
        <div style="position: relative; left: 40px; height: 30px; top: 120px;">
            <div style="width: 300px; color: gray;">答案</div>
            <button id="btn-as">点击显示答案</button>
            <div id="btn-answer" style="width: 500px;position: relative; left: 200px; top: -20px;"><b style="color: red">${q.answer}&nbsp;&nbsp;</b></div>
            <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
	</div>
	
	<!-- 备注 -->
	<div id="remarkBody" style="position: relative; top: 40px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>

		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button id="saveRemarkBtn" type="button" class="btn btn-primary">保存</button>
				</p>
			</form>
		</div>
	</div>
	<div style="height: 200px;"></div>
</body>
</html>