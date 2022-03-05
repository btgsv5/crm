package com.zj.settings.controller;

import com.zj.domain.Question;
import com.zj.domain.User;
import com.zj.settings.service.UserService;
import com.zj.settings.service.impl.UserServiceImpl;
import com.zj.utils.PrintJson;
import com.zj.utils.ServiceFactory;
import com.zj.vo.PaginationVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class UserController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/settings/user/pageList.do".equals(path)){
            pageList(request,response);
        }else if ("/settings/user/deleteUser.do".equals(path)){
            deleteUser(request,response);

        }else if ("/settings/user/deleteUser.do".equals(path)){
            deleteUser(request,response);

        }else if ("/settings/user/getUser.do".equals(path)){
            getUser(request,response);

        }else if ("/settings/user/updateUser.do".equals(path)){
            updateUser(request,response);

        }
    }

    private void getUser(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.valueOf(request.getParameter("id"));
        UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
        User user = us.getUser(id);
        PrintJson.printJsonObj(response,user);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) {
            String username = request.getParameter("username");
            String sex = request.getParameter("sex");
            User user = new User();
            user.setUsername(username);
            user.setSex(sex);
            UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
            boolean flag = us.updateUser(user);
            PrintJson.printJsonFlag(response,flag);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) {
        String []ids = request.getParameterValues("id");
        UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
        boolean flag = us.deleteUser(ids);
        PrintJson.printJsonFlag(response,flag);
    }

    private void pageList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("进入到查询信息列表的操作(结合条件查询+分页查询)");

        String username = request.getParameter("username");
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);
        //每页展现的记录数
        String pageSizeStr = request.getParameter("pageSize");
        //计算出略过的记录数
        int pageSize = Integer.valueOf(pageSizeStr);
        int skipCount = (pageNo-1)*pageSize;
        Map<String,Object> map = new HashMap<String, Object>();

        map.put("username",username);
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);

        UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());

        PaginationVO<Question> vo = us.pageList(map);

        PrintJson.printJsonObj(response,vo);
    }

}
