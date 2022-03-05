package com.zj.ksxt.controller;

import com.zj.domain.Score;
import com.zj.domain.User;
import com.zj.ksxt.service.ScoreService;
import com.zj.ksxt.service.impl.ScoreServiceImpl;
import com.zj.settings.service.UserService;
import com.zj.settings.service.impl.UserServiceImpl;
import com.zj.utils.DateTimeUtil;
import com.zj.utils.PrintJson;
import com.zj.utils.ServiceFactory;
import com.zj.vo.PaginationVO;
import javafx.fxml.LoadException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ScoreController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/ksxt/save.do".equals(path)){
            save(request,response);
        }else if("/ksxt/getScoreList.do".equals(path)){
            getScoreList(request,response);
        }else if("/ksxt/getRankList.do".equals(path)){
            getRankList(request,response);
        }else if("/ksxt/getPerc.do".equals(path)){
            getPerc(request,response);
        }else if("/admin/examinee.do".equals(path)){
            examinee(request,response);
        }else if("/admin/getExaminee.do".equals(path)){
            getExaminee(request,response);
        }
    }

    private void getExaminee(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("查看指定考生7次记录");
        Map<String,Object> map = new HashMap<>();
        try{
            Integer id = Integer.valueOf(request.getParameter("id"));
            ScoreService ss = (ScoreService) ServiceFactory.getService(new ScoreServiceImpl());
            List<Score> dataList = ss.examinee(request,id);
            if (dataList.size()==0){
                throw new LoadException("尚未找到该考生成绩记录或该考生未参加考试！");
            }else {
                map.put("success",true);
                map.put("dataList",dataList);
                PrintJson.printJsonObj(response,map);
            }

        }catch (Exception e){
            e.printStackTrace();
            String msg = e.getMessage();

            map.put("success",false);
            map.put("msg",msg);
            PrintJson.printJsonObj(response,map);
        }

    }

    private void examinee(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("进入到查看指定考生信息");
        UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
        Integer id = Integer.valueOf(request.getParameter("id"));
        User user =  us.getUser(id);;
        request.setAttribute("u",user);
        request.getRequestDispatcher("/admin/examinee.jsp").forward(request,response);
    }

    private void getPerc(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("进入到获取及格不及格比例人数");
        ScoreService ss = (ScoreService) ServiceFactory.getService(new ScoreServiceImpl());
        Map<String,Object> map =  ss.getPerc();
        for (Map.Entry<String,Object> entry: map.entrySet()
             ) {
            System.out.println(entry.getKey()+","+entry.getValue());
        }
        PrintJson.printJsonObj(response,map);
    }

    private void getRankList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("进入到查询成绩排名列表！");
        ScoreService ss = (ScoreService) ServiceFactory.getService(new ScoreServiceImpl());
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);
        //每页展现的记录数
        String pageSizeStr = request.getParameter("pageSize");
        //计算出略过的记录数
        int pageSize = Integer.valueOf(pageSizeStr);
        int skipCount = (pageNo-1)*pageSize;
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        PaginationVO<Score> pv = ss.getRankList(map);
        PrintJson.printJsonObj(response,pv);
    }

    private void getScoreList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("进入到查询用户最近7次的成绩");
        //session.getAttribute  通过session获取当前用户得到id
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        ScoreService ss = (ScoreService) ServiceFactory.getService(new ScoreServiceImpl());
        int [] ids = ss.getScoreList(user.getId());
        PrintJson.printJsonObj(response,ids);
    }

    private void save(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("进入到添加最近7次考试记录操作");
        String createTime = DateTimeUtil.getSysTime();
        HttpSession session = request.getSession(false);
        User user  = (User) session.getAttribute("user");
        Score score = new Score();
        String email = user.getEmail();
        email = email.substring(0,1)+"*"+email.substring(2);
        score.setEmail(email);
        score.setuId(user.getId());
        score.setUsername(user.getUsername());
        score.setScore((Integer) request.getAttribute("score"));
        score.setCreateTime(createTime);
        ScoreService ss = (ScoreService) ServiceFactory.getService(new ScoreServiceImpl());
        boolean flag = ss.save(score);
        PrintJson.printJsonFlag(response,flag);
    }
}
