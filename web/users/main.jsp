<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="jquery/bootstrap_3.3.0/css/bootstrap.min.css">
    <script src="ECharts/echarts.js"></script>
    <script src="jquery/jquery-1.11.1-min.js" type="text/javascript"></script>
    <script src="jquery/bootstrap_3.3.0/js/bootstrap.min.js" type="text/javascript"></script>
    <link rel="shortcut icon" href="#" />
</head>

<script>
    $(function () {
        $.ajax({
            url:'ksxt/getScoreList.do',
            type:'get',
            dataType:"json",
            async:true,
            success:function (data){
                //echarts需要的题类型和数量
                var option = {
                    title: {
                        text: '自己最近7次成绩'
                    },
                    tooltip: {
                        trigger: 'axis'
                    },
                    xAxis: {
                        type: 'category',
                        data: ['第一次', '第二次', '第三次', '第四次', '第五次', '第六次', '第七次']
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [
                        {
                            data: data,
                            type: 'line'
                        }
                    ]
                };
                myChart.setOption(option);
            }

        });

         $.ajax({
        url: 'ksxt/getPerc.do',
        type:'get',
        dataType:"json",
        success:function (data){

           var option2 = {
                title: {
                    text: '所有考试比列',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: '{a} <br/>{b} : {c} ({d}%)'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left'
                },
                series: [
                    {
                        name: '所占比例',
                        type: 'pie',
                        radius: '50%',
                        data:  data.datalist
                        /*[
                            { value: 1048, name: 'Search Engine' },
                            { value: 71, name: 'Direct' },
                            { value: 580, name: 'Email' },
                            { value: 484, name: 'Union Ads' },
                            { value: 300, name: 'Video Ads' }
                        ]*/,
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };

            myChart2.setOption(option2);
        }
    });
    })
</script>
</head>
<body>
<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div style="margin-top: 30px;margin-left: 30px;">
<div id="main" style=" float:left;width: 600px;height:600px;"></div>
<div id="main2" style="float: right;width: 600px;height:600px;"></div>
</div>
</body>
<script>
    var myChart = echarts.init(document.getElementById('main'));
    var myChart2 = echarts.init(document.getElementById('main2'));
</script>
</html>