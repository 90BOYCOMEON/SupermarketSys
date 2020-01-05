package com.hfxt.service.impl;

import com.alibaba.fastjson.JSON;
import com.hfxt.dao.IUserDao;
import com.hfxt.domain.Pager;
import com.hfxt.domain.User;
import com.hfxt.service.IUserService;
import com.hfxt.utils.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private IUserDao userDao;

    @Resource
    private RedisUtils redisUtils;

    @Override
    public String delUserById(Integer id) {
        boolean exist = redisUtils.exist(id + "u");
        if(exist){
            redisUtils.delete(id+"u");
        }
        Integer row = userDao.delUserById(id);
        return row>0?"success":"error";
    }

    @Override
    public String updateUserById(User user) {
        Map<String, Object> map = toMap(user);
        Integer row = userDao.updateUserById(map);
        redisUtils.delete(user.getId()+"u");
        redisUtils.delete(user.getUserCode()+"u");
        redisUtils.delete(user.getUserName()+"u");
        User user1 = userDao.getUserById(user.getId());
        redisUtils.delete(user1.getUserCode()+"u");
        redisUtils.delete(user1.getUserName()+"u");
        redisUtils.set(user1.getId()+"u",JSON.toJSON(user1).toString());
        redisUtils.set(user1.getUserCode()+"u",JSON.toJSON(user1).toString());
        redisUtils.set(user1.getUserName()+"u",JSON.toJSON(user1).toString());
        return row>0?"success":"error";
    }

    @Override
    public String saveUserById(User user) {
        User user1 = userDao.getUserByUserCode(user.getUserCode());
        if(user1!=null){
            return "userExits";
        }
        Map<String, Object> map = toMap(user);
        return userDao.saveUserById(map)>0?"success":"error";
    }

    @Override
    public User getUserById(Integer id) {
        Object id1 = redisUtils.get(id+"u");
        if(id1!=null){
            return JSON.parseObject(id1.toString(), User.class);
        }
        User user = userDao.getUserById(id);
        if (user==null){
            return null;
        }
        redisUtils.set(id+"u",JSON.toJSON(user).toString());
        return user;
    }

    @Override
    public List<User> getAllUserByPage(String name, Pager pager) {

        List<User> userList = userDao.getAllUserByPage(name, pager);
        pager.setTotalCount(userDao.getCount(name));
        return userList;
    }

    @Override
    public User getUserByName(String userName) {
        Object name = redisUtils.get(userName+"u");
        if(name!=null){
            return JSON.parseObject(name.toString(), User.class);
        }
        User user = userDao.getUserByName(userName);
        if(user==null){
            return null;
        }
        redisUtils.set(userName+"u",JSON.toJSON(user).toString());
        return user;
    }

    @Override
    public User getUserByUserCode(String userCode) {
        Object code = redisUtils.get(userCode+"u");
        if(code!=null){
            return JSON.parseObject(code.toString(), User.class);
        }
        User user = userDao.getUserByUserCode(userCode);
        if(user==null){
            return null;
        }
        redisUtils.set(userCode+"u",JSON.toJSON(user).toString());
        return user;
    }

    @Override
    public Map<String, Object> toMap(User user) {
        Map<String,Object> map = new HashMap<>();
        map.put("id",user.getId());
        map.put("userCode",user.getUserCode());
        map.put("userName",user.getUserName());
        map.put("userPassword",user.getUserPassword());
        map.put("gender",user.getGender());
        map.put("birthday",user.getBirthday());
        map.put("phone",user.getPhone());
        map.put("address",user.getAddress());
        map.put("userType",user.getUserType());
        map.put("createBy",user.getCreateBy());
        map.put("creationDate",user.getCreationDate());
        map.put("modifyBy",user.getModifyBy());
        map.put("modifyDate",user.getModifyDate());
        map.put("status",user.getStatus());
        map.put("salt",user.getSalt());
        return map;
    }
}
