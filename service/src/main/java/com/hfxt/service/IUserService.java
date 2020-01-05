package com.hfxt.service;

import com.hfxt.domain.Pager;
import com.hfxt.domain.User;

import java.util.List;
import java.util.Map;

public interface IUserService {

    public String delUserById( Integer id);

    public String updateUserById(User user);

    public String saveUserById(User user);

    public User getUserById(Integer id);

    public List<User> getAllUserByPage(String name, Pager pager);

    public User getUserByName(String userName);

    public User getUserByUserCode(String userCode);

    public Map<String,Object> toMap(User user);

}
