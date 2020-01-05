<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/JSTLPage.jsp"%>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>系统登录 - 超市账单管理系统</title>
    <%@ include file="common/cssOrJs.jsp"%>
</head>
<body class="login_bg">
    <section class="loginBox">
        <header class="loginHeader">
            <h1>超市账单管理系统</h1>
        </header>
        <section class="loginCont">
            <form class="loginForm" method="post" id="loginForm" action="#">
                <div class="inputbox">
                    <label for="user">用户名：</label>
                    <input id="user" type="text" name="username" placeholder="请输入用户名" required/>
                    <span style="color: red;font-size: 10px"></span>
                </div>
                <div class="inputbox" id="inputbox">
                    <label for="mima">密码：</label>
                    <input id="mima" type="password" name="password" placeholder="请输入密码" required/>
                    <span style="color: red;font-size: 10px"></span>
                </div>
                <span style="color: red;font-size: 10px"></span>
                <div class="subBtn">
                    <button type="button" id="submit" class="layui-btn">登陆</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>

            </form>
        </section>
    </section>

<script>

    $("#user").blur(function () {
        checkuser();
    });
    $("#mima").blur(function () {
       checkmima();
    });

    function checkuser() {
       var username = $("#user").val();
       if(username==""){
           layer.msg('请输入账号!!', {icon: 5});
           return false;
       }
       return true;
    }

    function checkmima() {
        var mima = $("#mima").val();
        if(mima==""){
            layer.msg('请输入密码!!', {icon: 5});
            return false;
        }
        return true;
    }

    $("#submit").click(function () {
        if(checkuser()&&checkmima()){
            $.ajax({
               url:"${pageContext.request.contextPath}/user/login.do",
                type:"post",
                dataType:"text",
                data: $("#loginForm").serialize(),
                success:function (data) {
                    if(data=="success"){
                        window.location.href="${pageContext.request.contextPath}/welcome.jsp";
                    }
                    if (data=="error"){
                        layer.msg('服务器异常!!', {icon: 5});
                        $("#mima").val("");
                    }
                    if(data=="NOEXITS"||data=="passError"){
                        layer.msg('账号或密码错误，请重试!!', {icon: 5});
                        $("#mima").val("");
                    }
                    if(data=="NUMOUT"){
                        layer.msg('超过五次登陆失败,请30分钟后重试', {icon: 5});
                        $("#mima").val("");
                    }
                }
            });
        }
    });


</script>

</body>
</html>