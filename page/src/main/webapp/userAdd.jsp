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
            <span>用户管理页面 >> 用户添加页面</span>
        </div>
        <div class="providerAdd">
            <form id="addForm" action="##" method="post">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <input type="hidden" value="<s:principal property='id'></s:principal>" name="createdBy">
                <div class="">
                    <label for="userId">用户编码：</label>
                    <input type="text" name="userId" id="userId"/>
                    <span>*请输入用户编码，且不能重复</span>
                </div>
                <div>
                    <label for="userName">用户名称：</label>
                    <input type="text" name="userName" id="userName"/>
                    <span >*请输入用户名称</span>
                </div>
                <div>
                    <label for="userpassword">用户密码：</label>
                    <input type="password" name="userpassword" id="userpassword"/>
                    <span>*密码长度必须大于6位小于20位</span>

                </div>
                <div>
                    <label for="userRemi">确认密码：</label>
                    <input type="password" name="userRemi" id="userRemi"/>
                    <span>*请输入确认密码</span>
                </div>
                <div>
                    <label >用户性别：</label>

                    <select name="gender">
                        <option value="2">男</option>
                        <option value="1">女</option>
                    </select>
                    <span></span>
                </div>
                <div>
                    <label for="data">出生日期：</label>
                    <input type="text" name="data" id="data"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="userphone">用户电话：</label>
                    <input type="text" name="userphone" id="userphone"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="userAddress">用户地址：</label>
                    <input type="text" name="userAddress" id="userAddress"/>
                </div>
                <div>
                    <label >用户类别：</label>
                    <input type="radio" value="1" name="userType"/>管理员
                    <input type="radio" value="2" name="userType"/>经理
                    <input type="radio" value="3" name="userType" checked/>普通用户

                </div>
                <div class="providerAddBtn">
                    <input type="button" value="保存" id="submit" onclick="submit1()"/>
                    <input type="button" value="返回" onclick="history.back(-1)"/>
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

    laydate.render({
        elem: '#data'
    });

    function submit1(){
        if(checkPhone()&&checkPass()&&checkName()&&checkBir()){
            $.ajax({
                url:"${pageContext.request.contextPath}/user/add.do",
                type:"post",
                dataType:"text",
                data:$("#addForm").serialize(),
                success:function (data) {
                    if(data=="success"){
                        alert("添加成功");
                        window.location.href="${pageContext.request.contextPath}/user/getAll.do";
                    }else if(data=="error"){
                        alert("添加失败");
                        window.location.href="${pageContext.request.contextPath}/user/getAll.do";
                    }
                },
                error:function () {
                    alert("添加异常");
                }
            });
        }
    }

    $("#userId").blur(function () {
        checkUserCode();
    });

    $("#userRemi,#userpassword").blur(function () {
        checkPass();
    });

    $("#userphone").blur(function () {
        checkPhone();
    });

    $("#data").blur(function () {
        checkBir();
    });

    $("#userName").blur(function () {
        checkName();
    });

    function checkName() {
        $("#userName+span").html("");
        var userName = $("#userName").val();
        if(userName==""){
            $("#userName+span").html("请填写用户名");
            return false;
        }
        if(userName.length>12){
            $("#userName+span").html("用户名不能大于12位");
            return false;
        }
        return true;
    }

    function checkBir() {
        $("#data+span").html("");
        var data = $("#data").val();
        var date = /^[0-9]{4}[-][0-9]{2}[-][0-9]{2}/g;
        if(data==""||!date.test(data)){
            $("#data+span").html("请正确填写生日!");
            return false;
        }
        return true;
    }

    function checkPhone() {
        var phone = /^1(3|4|5|7|8)\d{9}$/g;
        var userPhone = document.getElementById("userphone").value;
        $("#userphone+span").html("");
        if(!phone.test(userPhone)){
            $("#userphone+span").html("手机号格式不正确，请重新填写");
            return false;
        }
        return true;
    }

    function checkUserCode(){
        var userCode = $("#userId").val();
        if(userCode==""){
            $("#userId+span").html("请输入用户id");
            return false;
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/user/test.do?userCode="+userCode,
            type:"get",
            dataType:"text",
            success:function (data) {
                if(data=="none"){
                    $("#userId+span").html("");
                    return true;
                }
                if(data=="exits"){
                    $("#userId+span").html("用户id已存在,请重新输入");
                    return false;
                }
                if(data=="error"){
                    $("#userId+span").html("请输入用户id");
                    return false;
                }
            }
        });
    }

    function checkPass() {
        var pass = /^\S{6,12}$/g;
        $("#userRemi+span").html("");
        $("#userpassword+span").html("");
        var password = document.getElementById("userpassword").value;
        var repass = document.getElementById("userRemi").value;
        if(!pass.test(password)){
            $("#userpassword+span").html("密码长度为6~12位");
            return false;
        }
        // if(!pass.test(repass)){
        //     $("#userRemi+span").html("密码长度为6~12位");
        //     return false;
        // }

        if(password!=repass){
            $("#userRemi+span").html("两次密码不一致,请重新输入");
            // $("#userpassword+span").html("两次密码不一致,请重新输入");
            return false;
        }
        return true;
    }



</script>

</body>
</html>