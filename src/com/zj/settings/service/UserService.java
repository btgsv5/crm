package com.zj.settings.service;

import com.zj.domain.Question;
import com.zj.exception.LoginException;
import com.zj.domain.User;
import com.zj.vo.PaginationVO;

import java.util.List;
import java.util.Map;

public interface UserService {
    User login(String loginAct, String loginPwd) throws LoginException;

    List<User> getUserList();

    int saveRegist(User user) throws LoginException;

    PaginationVO<Question> pageList(Map<String, Object> map);

    boolean deleteUser(String[] ids);

    boolean updateUser(User user);

    User getUser(int id);
}
