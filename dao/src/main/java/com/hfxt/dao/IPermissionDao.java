package com.hfxt.dao;

import com.hfxt.domain.Permission;

import java.util.List;

public interface IPermissionDao {

    public List<Permission> getAllPermissionByUserType(Integer userType);

    public List<Permission> getAllNotMenuByUserType(Integer userType);

}
