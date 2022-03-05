package com.zj.settings.controller;

import com.zj.domain.User;
import com.zj.settings.service.UserService;
import com.zj.settings.service.impl.UserServiceImpl;
import com.zj.utils.DateTimeUtil;
import com.zj.utils.PrintJson;
import com.zj.utils.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class ReController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/settings/user/saveRegist.do".equals(path)){
            System.out.println("进入到注册功能！");
            String username =request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String sex = request.getParameter("sex");
            //管理员权限1，普通用户0
            int isAdmin = 0;
            //创建时间
            String createTime = DateTimeUtil.getSysTime();
            UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
            User user = new User();
            user.setEmail(email);
            user.setUsername(username);
            user.setSex(sex);
            user.setPassword(password);
            user.setIsAdmin(isAdmin);
            user.setCreateTime(createTime);
            try {
                us.saveRegist(user);
                PrintJson.printJsonFlag(response,true);
            }catch (Exception e){
                e.printStackTrace();
                String msg = e.getMessage();
                Map<String,Object> map = new HashMap<>();
                map.put("success",false);
                map.put("msg",msg);
                PrintJson.printJsonObj(response,map);
            }
        }
    }
}
