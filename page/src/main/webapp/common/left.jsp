<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="left">
    <h2 class="leftH2"><span class="span1"></span>功能列表 <span></span></h2>
    <nav>
        <ul class="list">
            <li><a href="${pageContext.request.contextPath}/bill/getAll.do">账单管理</a></li>
            <li><a href="${pageContext.request.contextPath}/provider/getAll.do">供应商管理</a></li>
            <li><a href="${pageContext.request.contextPath}/user/getAll.do">用户管理</a></li>
            <li><a href="${pageContext.request.contextPath}/password.jsp">密码修改</a></li>
            <li><a href="javascript:logout()">退出系统</a></li>
        </ul>
    </nav>
</div>