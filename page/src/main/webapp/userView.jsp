<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/JSTLPage.jsp"%>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市账单管理系统</title>
    <%@ include file="common/cssOrJs.jsp"%>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <%@ include file="common/top.jsp"%>
    <div class="layui-body">
        <div class="center">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>用户管理页面 >> 用户信息查看页面</span>
        </div>
        <div class="providerView">
            <p><strong>用户编号：</strong><span>${USER.userCode}</span></p>
            <p><strong>用户名称：</strong><span>${USER.userName}</span></p>
            <p><strong>用户性别：</strong><span>${USER.gender eq 1?"女":"男"}</span></p>
            <p><strong>出生日期：</strong><span><fmt:formatDate value="${USER.birthday}" pattern="yyyy-MM-dd"/> </span></p>
            <p><strong>用户电话：</strong><span>${USER.phone}</span></p>
            <p><strong>用户地址：</strong><span>${USER.address}</span></p>
            <p><strong>用户类别：</strong><span>${USER.userType eq 1?"管理员":USER.userType eq 2?"经理":"普通用户"}</span></p>

            <a href="javascript:window.history.go(-1)">返回</a>
        </div>
    </div>
    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
    </div>
</body>
</html>