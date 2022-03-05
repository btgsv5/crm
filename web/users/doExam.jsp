<%@ page import="java.util.List" %>
<%@ page import="com.zj.domain.Question" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%   String path = request.getRequestURI();
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() + request.getContextPath() + "/";
List<Question> dataDan = (List<Question>) session.getAttribute("dataDan");
List<Question> dataDuo = (List<Question>) session.getAttribute("dataDuo");
List<Question> dataPan = (List<Question>) session.getAttribute("dataPan");
%>
<html>
<head>
    <title>开始考试</title>
    <base href="<%=basePath%>"/>
    <meta charset="UTF-8">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <link href="jquery/css/main.css" rel="stylesheet" type="text/css" />
    <link href="jquery/css/iconfont.css" rel="stylesheet" type="text/css" />
    <link href="jquery/css/test.css" rel="stylesheet" type="text/css" />
    <style>
        .addRed{
            background-color: red;
        }
    </style>
</head>
<body style="position: relative">

<div class="main">
    <!--nr start-->
    <div class="test_main">
        <div class="nr_left">
            <div class="test">
                <form id="fm">
<%--                    单选题--%>
                    <div class="test_content">
                        <div class="page-header test_content_title">
                            <h3>单选题
                            <small class="label label-info">
                                <span>共</span><i class="content_lit"><%=dataDan.size()%></i><span>题，</span><span>合计</span><i class="content_fs">50</i><span>分</span>
                            </small>
                            </h3>
                        </div>
                    </div>
                    <div class="test_content_nr">
                        <ul>
                            <%
                                for (int i =0;i<dataDan.size();i++ ) {
                                   %>
                            <li id="qu_0_<%out.print(i);%>">
                                <div class="test_content_nr_tt">
                                    <i><% out.print(i+1);%></i><span>(5分)</span><font><%=dataDan.get(i).getTitle()%></font>
                                </div>

                                <div class="test_content_nr_main">
                                    <ul class="list-group">
                                        <li class="option" >

                                            <label for="0_answer_<%=i%>_option_1">
                                                <input type="radio" class="radioOrCheck" id="0_answer_<%=i%>_option_1" value="A" name="answer<%=i%>" />
                                                A.<p class="ue" style="display: inline;"><%=dataDan.get(i).getOptionA()%></p>
                                            </label>
                                        </li>

                                        <li class="option">
                                            <label for="0_answer_<%=i%>_option_2">
                                                <input type="radio" class="radioOrCheck" id="0_answer_<%=i%>_option_2" value="B" name="answer<%=i%>" />
                                                B.<p class="ue" style="display: inline;"><%=dataDan.get(i).getOptionB()%></p>
                                            </label>
                                        </li>

                                        <li class="option">
                                            <label for="0_answer_<%=i%>_option_3">
                                                <input type="radio" class="radioOrCheck" id="0_answer_<%=i%>_option_3" value="C" name="answer<%=i%>" />
                                                C.<p class="ue" style="display: inline;"><%=dataDan.get(i).getOptionC()%></p>
                                            </label>
                                        </li>

                                        <li class="option">
                                            <label for="0_answer_<%=i%>_option_4">
                                                <input type="radio" class="radioOrCheck" id="0_answer_<%=i%>_option_4" value="D" name="answer<%=i%>" />
                                                D.<p class="ue" style="display: inline;"><%=dataDan.get(i).getOptionD()%></p>
                                            </label>
                                        </li>

                                    </ul>
                                </div>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </div>

<%--                    多选题--%>
                    <div class="test_content">
                        <div class="test_content_title page-header">
                            <h3>多选题
                                <small class="label label-info">
                                    <span>共</span><i class="content_lit"><%=dataDuo.size()%></i><span>题，</span><span>合计</span><i class="content_fs">25</i><span>分</span>
                                </small>
                            </h3>
                        </div>
                    </div>
                    <div class="test_content_nr">
                        <ul>
                            <% for (int i = 0; i < dataDuo.size(); i++) {

                                %>
                            <li id="qu_1_<%=i%>">
                                <div class="test_content_nr_tt">
                                    <i><%=i+1%></i><span>(5分)</span><font><%=dataDuo.get(i).getTitle()%></font>
                                </div>

                                <div class="test_content_nr_main">
                                    <ul>

                                        <li class="option"><input id="1_answer_<%=i%>_option_1" type="checkbox" value="A" name="answer<%=dataDan.size()*2+i%>" />
                                            <label for="1_answer_<%=i%>_option_1">
                                                A.
                                                <p class="ue" style="display: inline;"><%=dataDuo.get(i).getOptionA()%></p>
                                            </label>
                                        </li>

                                        <li class="option"><input id="1_answer_<%=i%>_option_2" type="checkbox" value="B" name="answer<%=dataDan.size()*2+i%>" />
                                            <label for="1_answer_<%=i%>_option_2">
                                                B.
                                                <p class="ue" style="display: inline;"><%=dataDuo.get(i).getOptionB()%></p>
                                            </label>
                                        </li>

                                        <li class="option"><input id="1_answer_<%=i%>_option_3" type="checkbox" value="C" name="answer<%=dataDan.size()*2+i%>" />
                                            <label for="1_answer_<%=i%>_option_3">
                                                C.
                                                <p class="ue" style="display: inline;"><%=dataDuo.get(i).getOptionC()%></p>
                                            </label>
                                        </li>

                                        <li class="option"><input id="1_answer_<%=i%>_option_4" type="checkbox" value="D" name="answer<%=dataDan.size()*2+i%>>"/>
                                            <label for="1_answer_<%=i%>_option_4">
                                                D.
                                                <p class="ue" style="display: inline;"><%=dataDuo.get(i).getOptionD()%></p>
                                            </label>
                                        </li>

                                    </ul>
                                </div>
                            </li>
                           <%
                            }
                           %>
                        </ul>
                    </div>

<%--                    判断--%>
                    <div class="test_content">
                        <div class="test_content_title page-header">
                            <h3>判断题
                                <small class="label label-info">
                                    <span>共</span><i class="content_lit"><%=dataPan.size()%></i><span>题，</span><span>合计</span><i class="content_fs">25</i><span>分</span>
                                </small>
                            </h3>
                        </div>
                    </div>
                    <div class="test_content_nr">
                        <ul>
                            <%
                                for (int i =0;i<dataPan.size();i++ ) {
                            %>
                            <li id="qu_2_<%out.print(i);%>">
                                <div class="test_content_nr_tt">
                                    <i><% out.print(i+1);%></i><span>(5分)</span><font><%=dataPan.get(i).getTitle()%></font>
                                </div>

                                <div class="test_content_nr_main">
                                    <ul>
                                        <li class="option" >
                                            <label for="2_answer_<%=i%>_option_1">
                                                <input type="radio" class="radioOrCheck" id="2_answer_<%=i%>_option_1" value="A" name="answer<%=dataDan.size()+i%>" />
                                                A.<p class="ue" style="display: inline;"><%=dataPan.get(i).getOptionA()%></p>
                                            </label>
                                        </li>

                                        <li class="option">
                                            <label for="2_answer_<%=i%>_option_2">
                                                <input type="radio" class="radioOrCheck" id="2_answer_<%=i%>_option_2" value="B" name="answer<%=dataDan.size()+i%>" />
                                                B.<p class="ue" style="display: inline;"><%=dataPan.get(i).getOptionB()%></p>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </div>


            </div>

        </div>
        <div class="nr_right">
            <div class="nr_rt_main">
                <div class="rt_nr1">
                    <div class="list-group-item-info">
                        <h1>答题卡</h1>
                    </div>
                    <div class="timer" style="color: #d9534f;font-size: 30px">
                        <strong id="minute">0分</strong>
                        <strong id="second">0秒</strong>
                    </div>
                    <div class="rt_content">
                        <div class="rt_content_tt">
                            <h2>单选题</h2>
                            <p>
                                <span>共</span><i class="content_lit">10</i><span>题</span>
                            </p>
                        </div>
                        <div class="rt_content_nr answerSheet">
                            <ul>
                                <%
                                    for (int i = 0; i < dataDan.size(); i++) {
                                        %>
                                <li><a href="<%=path%>#qu_0_<%=i%>" class="qu_0_<%=i%>" ><%=i+1%></a></li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </div>

                    <div class="rt_content">
                        <div class="rt_content_tt">
                            <h2>多选题</h2>
                            <p>
                                <span>共</span><i class="content_lit"><%=dataDuo.size()%></i><span>题</span>
                            </p>
                        </div>
                        <div class="rt_content_nr answerSheet">
                            <ul>
                                <%
                                    for (int i = 0; i < dataDuo.size(); i++) {
                                        %>

                                     <li><a href="<%=path%>#qu_1_<%=i%>" class="qu_1_<%=i%>"> <%=i+1%></a></li>
                                <%
                                    }
                                %>

                            </ul>
                        </div>
                    </div>

                    <div class="rt_content">
                        <div class="rt_content_tt">
                            <h2>判断题</h2>
                            <p>
                                <span>共</span><i class="content_lit"><%=dataPan.size()%></i><span>题</span>
                            </p>
                        </div>
                        <div class="rt_content_nr answerSheet">
                            <ul>
                                <%
                                    for (int i = 0; i < dataPan.size(); i++) {
                                %>
                                <li><a href="<%=path%>#qu_2_<%=i%>" class="qu_2_<%=i%>"> <%=i+1%></a></li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                    <button style="margin-top: 50px" type="button" class="btn btn-success btn-lg" id="doBtn">提交试卷</button>
                </div>

            </div>
        </div>
    </div>
    </form>
    <!--nr end-->
    <div class="foot">


    </div>
</div>
<%--<%
    for (int i = 0; i < dataDan.size(); i++) {
          <li id="qu_0_<%=i%>);%>">
    }
%>--%>
<input type="hidden" id="danH"  value="<%=dataDan.size()%>"/>
<input type="hidden" id="duoH" value="<%=dataDuo.size()%>"/>
<input type="hidden" id="panH" value="<%=dataPan.size()%>"/>

<script>

    $(function() {
        if (window.top!=window){
            window.top.location=window.location;
        }
       let danH = $('#danH').val();
       let duoH = $('#duoH').val();
       let panH = $('#panH').val();

        timer(intDiff);
        $(".option").click(function () {
            let examId = $(this).closest('.test_content_nr_main').closest('li').attr('id'); // 得到题目ID
             $('a[class=' + examId + ']').addClass('list-group-item-info'); // 根据题目ID找到对应答题卡

        });
       $('#doBtn').click(function () {
           for (let i = 0; i < danH; i++) {
               if ($('#qu_0_'+i+' .option input[type="radio"]:checked').val()==undefined){
                   $("#modelStu").modal("show");
                   return false;
               }
           }
           for (let i = 0; i < duoH; i++) {
               if ($('#qu_1_'+i+' .option input[type="checkbox"]:checked').val()==undefined){
                   $("#modelStu").modal("show");
                   return false;
               }
           }
           for (let i = 0; i < panH; i++) {
               if ($('#qu_2_'+i+' .option input[type="radio"]:checked').val()==undefined){
                   $("#modelStu").modal("show");
                   return false;
               }
           }
           $("#subBtn").trigger("click");
       })
    $("#subBtn").click(function () {
            $.ajax({
                url:"st/doExam.do",
                type:"get",
                data:$('#fm').serialize(),
                dataType:"json",
                success:function (data) {
                    if (data.success){
                        window.location.href="users/index.jsp";
                    }else {
                        alert("提交失败")
                    }
                }
            })

    })
    });
    //计时器
    var intDiff = parseInt(1800);//倒计时总秒数量
    function timer(intDiff) {
        window.setInterval(function () {
            var minute = 0,
                second = 0;//时间默认值
            if (intDiff > 0) {
                minute = Math.floor(intDiff / 60);
                second = Math.floor(intDiff) - (minute * 60);
            }
            if (minute <= 9) minute = '0' + minute;
            if (second <= 9) second = '0' + second;
            $('#minute').html('<s></s>' + minute + '分');
            $('#second').html('<s></s>' + second + '秒');
            intDiff--;
            if (intDiff <= 0) {
                clearInterval(timer);   //定时器清除；
                $("#subBtn").trigger("click");

            }
        }, 1000);

    }

</script>
<div id="modelStu" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">提交提醒</h4>
            </div>
            <div class="modal-body">
                <p>当前有未选择的题目，请仔细检查填写，如想提交点击确定</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="subBtn" class="btn btn-primary">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


</body>
</html>
