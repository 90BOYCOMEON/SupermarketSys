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
                <span>密码修改页面</span>
            </div>
            <div class="providerAdd">
                <form action="#" method="post" id="passForm">
                    <!--div的class 为error是验证错误，ok是验证成功-->
                    <div class="">
                        <label for="oldPassword">旧密码：</label>
                        <input type="password" name="oldPassword" id="oldPassword" required/>
                        <span>*请输入原密码</span>
                    </div>
                    <div>
                        <label for="newPassword">新密码：</label>
                        <input type="password" name="newPassword" id="newPassword" required/>
                        <span >*请输入新密码</span>
                    </div>
                    <div>
                        <label for="reNewPassword">确认新密码：</label>
                        <input type="password" name="reNewPassword" id="reNewPassword" required/>
                        <span >*请输入新确认密码，保证和新密码一致</span>
                    </div>
                    <div class="providerAddBtn">
                        <!--<a href="#">保存</a>-->
                        <input type="button" value="保存" onclick="submitEdit()"/>
                    </div>
                </form>
            </div>
        </div>
        <div class="layui-footer">
            <!-- 底部固定区域 -->
            © layui.com - 底部固定区域
        </div>
    </div>
<script>
    $("#newPassword,#reNewPassword").blur(function () {
        checkPass();
    });

    $("#oldPassword").blur(function () {
        checkeOld();
    });

    function submitEdit() {
        if(checkeOld()&&checkPass()){
            if(confirm("确定修改吗?")){
                $.ajax({
                   url:"${pageContext.request.contextPath}/user/edit.do",
                    type:"post",
                    dataType:"text",
                    data:$("#passForm").serialize(),
                    success:function (data) {
                        if(data=="success"){
                            alert("修改成功");
                            window.location.href="${pageContext.request.contextPath}/user/logout.do";
                        }
                        if(data=="PSSWORDERROR"){
                            $("#oldPassword+span").html("密码错误,请重试");
                            $("#oldPassword").val("");
                        }
                        if(data=="error"){
                            alert("服务器异常，请重试!");
                        }
                    }
                });
            }
        }
    }


    function checkeOld() {
        $("#oldPassword+span").html("");
        var oldpass= $("#oldPassword").val();
        if(oldpass==""){
            $("#oldPassword+span").html("请输入旧密码");
            return false;
        }
        if(oldpass.length>15||oldpass.length<6){
            $("#oldPassword+span").html("旧密码长度不能小于6");
            return false;
        }
        return true;
    }

    function checkPass() {
        var pass = /^\S{6,12}$/g;
        $("#newPassword+span").html("");
        $("#reNewPassword+span").html("");
        var password = document.getElementById("newPassword").value;
        var repass = document.getElementById("reNewPassword").value;
        if(!pass.test(password)){
            $("#newPassword+span").html("密码长度为6~12位");
            return false;
        }

        if(password!=repass){
            $("#reNewPassword+span").html("两次密码不一致,请重新输入");
            return false;
        }
        return true;
    }
</script>
</body>
</html>