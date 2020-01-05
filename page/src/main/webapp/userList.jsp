<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/JSTLPage.jsp"%>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
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
                <span>用户管理页面</span>
            </div>
            <div class="search">
                <span>用户名：</span>
                <input type="text" value="${NAME}" id="username" placeholder="请输入用户名"/>
                <input type="button" value="查询" onclick="goPage(document.getElementById('username').value,1,document.getElementById('select').value)"/>
<%--                <a href="${pageContext.request.contextPath}/userAdd.jsp">添加用户</a>--%>
            </div>
            <!--用户-->
            <table class="providerTable" cellpadding="0" cellspacing="0">
                <tr class="firstTr">
                    <th width="10%">用户编码</th>
                    <th width="20%">用户名称</th>
                    <th width="10%">性别</th>
                    <th width="10%">年龄</th>
                    <th width="10%">电话</th>
                    <th width="20%">用户类型</th>
                    <th width="20%">操作</th>
                </tr>
                <c:forEach var="u" items="${USERLIST}">
                    <tr>
                        <td>${u.userCode}</td>
                        <td>${u.userName}</td>
                        <td>${u.gender eq 1?"女":"男"}</td>
                        <td>${u.age}</td>
                        <td>${u.phone}</td>
                        <td>${u.userType eq 1?"管理员":u.userType eq 2?"经理":"普通用户"}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/user/get/${u.id}.do"><img src="${pageContext.request.contextPath}/img/read.png" alt="查看" title="查看"/></a>
                            <s:hasPermission name="/user/update">
                            <a href="${pageContext.request.contextPath}/user/update/${u.id}.do"><img src="${pageContext.request.contextPath}/img/xiugai.png" alt="修改" title="修改"/></a>
                            </s:hasPermission>
                            <s:hasPermission name="/user/del">
                            <a href="javascript:deleteId(${u.id});" class="removeUser"><img src="${pageContext.request.contextPath}/img/schu.png" alt="删除" title="删除"/></a>
                            </s:hasPermission>
                        </td>
                    </tr>
                </c:forEach>

            </table>
            <tr>
                <th width="10%" id="currentPage">当前:${PAGE.currentPage}/${PAGE.totalPage} 共${PAGE.totalCount}条数据</th>
                <th width="20%" ><input type="text" id="goto" width="15px"/><button type="button" value="跳转" id="button" onclick="goPage(document.getElementById('username').value,document.getElementById('goto').value,document.getElementById('select').value)">跳到</button></th>
                <th width="50%" id="page"><a href="#" id="top" onclick="goPage(document.getElementById('username').value,1,document.getElementById('select').value)"> 首页 </a><a href="#" id="pre" onclick="goPage(document.getElementById('username').value,${PAGE.currentPage-1},document.getElementById('select').value)"> 上一页 </a><a href="#" id="next" onclick="goPage(document.getElementById('username').value,${PAGE.currentPage+1},document.getElementById('select').value)"> 下一页 </a><a href="javascript:goPage(document.getElementById('username').value,${PAGE.totalPage},document.getElementById('select').value)" id="down"> 尾页 </a></th>
                <th width="10%" id="pageSize"><select id="select" onchange="goPage(document.getElementById('username').value,1,this.value)">
                    <option value="10" ${PAGE.pageSize eq 10?"selected":""}>10</option>
                    <option value="15" ${PAGE.pageSize eq 15?"selected":""}>15</option>
                    <option value="20" ${PAGE.pageSize eq 20?"selected":""}>20</option>
                </select>
                </th>
            </tr>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>
<script>

    function goPage(name,currentPage,pageSize) {
        var reg = /^\d+/g;
        if(currentPage >${PAGE.totalPage} || currentPage<=0||!reg.test(currentPage)){
            window.location.href="${pageContext.request.contextPath}/user/getAll.do?name="+name+"&currentPage=${PAGE.currentPage}&"+"pageSize="+pageSize;
        }else{
            window.location.href="${pageContext.request.contextPath}/user/getAll.do?name="+name+"&currentPage="+currentPage+"&pageSize="+pageSize;
        }
    }

    function deleteId(id) {
        var controller = "${pageContext.request.contextPath}/user/del/"+id+".do";
        if(confirm("确定删除吗?")){
            $.ajax({
                url:controller,
                type:"post",
                dataType:"text",
                success:function (data) {
                    if(data=="success"){
                        alert('删除成功!');
                        window.history.go(0);
                    }else if(data=="error"){
                        layer.msg('删除失败!', {icon: 5});
                    }else if(data=="NOTDEL"){
                        layer.msg('不能删除自己!', {icon: 5});
                    }else if(data=="NOTPERM"){
                        layer.msg('不能删除管理员!', {icon: 5});
                    }
                },
                error:function () {
                    layer.msg('请求异常!', {icon: 5});
                }
            });
        }
    }

</script>

</body>
</html>