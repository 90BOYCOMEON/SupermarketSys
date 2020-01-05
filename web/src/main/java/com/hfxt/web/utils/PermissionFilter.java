package com.hfxt.web.utils;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class PermissionFilter extends AuthorizationFilter {
    @Override
    protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse, Object o) throws Exception {

        String[] role = (String[])o;
        Subject sb = SecurityUtils.getSubject();
        for (int i = 0;i<role.length;i++){
            boolean b = sb.hasRole(role[i]);
            if(b){
                return true;
            }
        }
        return false;
    }
}
