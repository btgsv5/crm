package com.zj.settings.service.impl;

import com.zj.domain.Question;
import com.zj.exception.LoginException;
import com.zj.settings.dao.UserDao;
import com.zj.settings.service.UserService;
import com.zj.utils.SqlSessionUtil;
import com.zj.domain.User;
import com.zj.vo.PaginationVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {

    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);
    @Override
    public User login(String loginAct, String loginPwd) throws LoginException {
        Map<String,String> map =new HashMap<>();
        map.put("loginAct",loginAct);
        map.put("loginPwd",loginPwd);
        User user = userDao.login(map);
        if (user == null){
            throw new LoginException("邮箱密码不存在或错误！");
        }
        //如果执行到此说明返回的用户有记录
        return user;
    }

    @Override
    public List<User> getUserList() {
        return userDao.getUserList();
    }

    @Override
    public int saveRegist(User user) throws LoginException {
        User ur = userDao.getUserEmail(user.getEmail());
        if (ur!=null){
            throw new LoginException("邮箱已存在，请重新输入！");
        }

        return userDao.saveUser(user);
    }

    @Override
    public PaginationVO<Question> pageList(Map<String, Object> map) {
        //取得total
        int total = userDao.getTotalByCondition(map);
        //取得dataList
        List<Question> dataList = userDao.getUserListByCondition(map);

        //创建一个vo对象，将total和dataList封装到vo中
        PaginationVO<Question> vo = new PaginationVO();
        vo.setTotal(total);
        vo.setDataList(dataList);
        //将vo返回
        return vo;
    }

    @Override
    public boolean deleteUser(String[] ids) {
        boolean flag = true;
        int count = userDao.deleteUser(ids);
        if (count!= ids.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean updateUser(User user) {
        int count = userDao.updateUser(user);
        if (count!=1){
            return false;
        }
        return true;
    }

    @Override
    public User getUser(int id) {
        User user = userDao.getUser(id);

        return user;
    }
}
