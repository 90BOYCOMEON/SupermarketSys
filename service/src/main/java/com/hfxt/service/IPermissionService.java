package com.hfxt.service;

import com.hfxt.domain.Permission;

import java.util.List;

public interface IPermissionService {

    public List<Permission> getAllPermissionByUserType(Integer userType);

    public List<Permission> getAllNotMenuByUserType(Integer userType);
}
