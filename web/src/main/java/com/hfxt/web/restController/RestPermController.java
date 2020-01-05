package com.hfxt.web.restController;


import com.alibaba.fastjson.JSONArray;
import com.hfxt.domain.Permission;
import com.hfxt.domain.User;
import com.hfxt.service.IPermissionService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping("/perm")
@RestController
public class RestPermController {

    @Autowired
    private IPermissionService permissionService;

    @RequestMapping(value = "/getMenu",produces = "text/html;charset=utf-8")
    public String getAllMenu(){

        Subject sb = SecurityUtils.getSubject();
        User user = (User)sb.getPrincipal();
        List<Permission> list = permissionService.getAllPermissionByUserType(user.getUserType());
        return JSONArray.toJSON(list).toString();
    }

}
