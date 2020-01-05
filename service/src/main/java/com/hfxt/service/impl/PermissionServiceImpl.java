package com.hfxt.service.impl;

import com.hfxt.dao.IPermissionDao;
import com.hfxt.domain.Permission;
import com.hfxt.service.IPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermissionServiceImpl implements IPermissionService {
    @Autowired
    private IPermissionDao permissionDao;

    @Override
    public List<Permission> getAllPermissionByUserType(Integer userType) {
        return permissionDao.getAllPermissionByUserType(userType);
    }

    @Override
    public List<Permission> getAllNotMenuByUserType(Integer userType) {
        return permissionDao.getAllNotMenuByUserType(userType);
    }
}
