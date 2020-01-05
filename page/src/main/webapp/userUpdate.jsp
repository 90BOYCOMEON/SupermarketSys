<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/JSTLPage.jsp"%>

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
            <span>用户管理页面 >> 用户修改页面</span>
        </div>
        <div class="providerAdd">
            <form action="##" method="post" id="updateForm">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <input type="hidden" value="${USER.id}" name="id">
                <input type="hidden" value="<s:principal property='id'></s:principal>" name="modifyBy">
                <div>
                    <label for="userName">用户名称：</label>
                    <input type="text" name="userName" id="userName" value="${USER.userName}"/>
                    <span >*</span>
                </div>

                <div>
                    <label >用户性别：</label>

                    <select id="gender" name="gender">
                        <option value="2" ${USER.gender eq 2?"selected":""}>男</option>
                        <option value="1" ${USER.gender eq 1?"selected":""}>女</option>
                    </select>
                </div>
                <div>
                    <label for="data">出生日期：</label>
                    <input type="text" name="birthday" id="data" value="<fmt:formatDate value='${USER.birthday}' pattern='yyyy-MM-dd'/> "/>
                    <span >*</span>
                </div>
                <div>
                    <label for="userphone">用户电话：</label>
                    <input type="text" name="phone" id="userphone" value="${USER.phone}"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="userAddress">用户地址：</label>
                    <input type="text" name="address" id="userAddress" value="${USER.address}"/>
                </div>
                <div>
                    <label >用户类别：</label>
                    <input type="radio" name="userType" value="1" ${USER.userType eq 1?"checked":""}/>管理员
                    <input type="radio" name="userType" <c:if test="${USER.userType eq 1}">disabled</c:if> value="2" ${USER.userType eq 2?"checked":""}/>经理
                    <input type="radio" name="userType" <c:if test="${USER.userType eq 1}">disabled</c:if> value="3" ${USER.userType eq 3?"checked":""}/>普通用户

                </div>
                <div class="providerAddBtn">
                    <!--<a href="#">保存</a>-->
                    <!--<a href="userList.jsp">返回</a>-->
                    <input type="button" value="保存" id="submit"/>
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


    $("#userName").blur(function () {
        checkUserName();
    });

    function checkUserName(){
        $("#userName+span").html("");
        var username = $("#userName").val();
        if(username==""){
            $("#userName+span").html("请输入用户名!");
            return false;
        }
        return true;
    }

    $("#data").blur(function () {
        checkdata();
    });

    function checkdata(){
        $("#data+span").html("");
        var data = $("#data").val();
        var date = /^[0-9]{4}[-][0-9]{2}[-][0-9]{2}/g;
        if(data==""||!date.test(data)){
            $("#data+span").html("请正确填写生日!");
            return false;
        }
        return true;
    }

    $("#userphone").blur(function () {
        checkPhoneReg();
    });

    function checkPhoneReg(){
        $("#userphone+span").html("");
        var phone = $("#userphone").val();
        var reg = /^1(3|4|5|7|8)\d{9}/g;
        if(phone==""){
            $("#userphone+span").html("请输入手机号");
            return false;
        }
        if(!reg.test(phone)){
            $("#userphone+span").html("请正确输入手机号格式");
            return false;
        }
        return true;
    }

    laydate.render({
        elem: '#data'
    });

    $("#submit").click(function () {
        if(confirm("确定修改?")){
            if( checkUserName()&&checkdata()&&checkPhoneReg()){
                $.ajax({
                    url:"${pageContext.request.contextPath}/user/update.do",
                    type:"post",
                    dataType:"text",
                    data:$("#updateForm").serialize(),
                    success:function (data) {
                        if(data=="success"){
                            alert("修改成功");
                            window.location.href="${pageContext.request.contextPath}/user/getAll.do";
                        }else if(data=="error"){
                            alert("修改失败");
                            window.location.href="${pageContext.request.contextPath}/user/getAll.do";
                        }
                    },
                    error:function () {
                        alert("修改异常");
                    }
                });
            }
        }

    })
</script>

</body>
</html>