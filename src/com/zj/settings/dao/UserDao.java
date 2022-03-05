package com.zj.settings.dao;

import com.zj.domain.Question;
import com.zj.domain.User;

import java.util.List;
import java.util.Map;

public interface UserDao {
    User login(Map<String, String> map);

    List<User> getUserList();

    User getUserEmail(String email);

    int saveUser(User user);

    int getTotalByCondition(Map<String, Object> map);

    List<Question> getUserListByCondition(Map<String, Object> map);

    int deleteUser(String[] ids);

    User getUser(int id);

    int updateUser(User user);
}
