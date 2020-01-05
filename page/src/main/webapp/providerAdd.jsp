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
            <span>供应商管理页面 >> 供应商添加页面</span>
        </div>
        <div class="providerAdd">
            <form action="#" method="post" id="addProForm">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div class="">
                    <label for="providerId">供应商编码：</label>
                    <input type="text" name="providerId" id="providerId"/>
                    <span>*请输入供应商编码</span>
                </div>
                <div>
                    <label for="providerName">供应商名称：</label>
                    <input type="text" name="providerName" id="providerName"/>
                    <span >*请输入供应商名称</span>
                </div>
                <div>
                    <label for="people">联系人：</label>
                    <input type="text" name="people" id="people"/>
                    <span>*请输入联系人</span>

                </div>
                <div>
                    <label for="phone">联系电话：</label>
                    <input type="text" name="phone" id="phone"/>
                    <span>*请输入联系电话</span>
                </div>
                <div>
                    <label for="address">联系地址：</label>
                    <input type="text" name="address" id="address"/>
                    <span></span>
                </div>
                <div>
                    <label for="fax">传真：</label>
                    <input type="text" name="fax" id="fax"/>
                    <span></span>
                </div>
                <div>
                    <label for="describe">描述：</label>
                    <input type="text" name="describe" id="describe"/>
                </div>
                <div class="providerAddBtn">
                    <!--<a href="#">保存</a>-->
                    <!--<a href="providerList.jsp">返回</a>-->
                    <input type="button" value="保存" onclick="submit10()"/>
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

//测试注释
    function submit10(){
        if(checkPeo()&&checkProPho()){
            $.ajax({
                url:"${pageContext.request.contextPath}/provider/add.do",
                type:"post",
                dataType:"text",
                data:$("#addProForm").serialize(),
                success:function (data) {
                    if(data=="success"){
                        alert("添加成功");
                        window.location.href="${pageContext.request.contextPath}/provider/getAll.do";
                    }else if(data=="error"){
                        alert("添加失败");
                        window.location.href="${pageContext.request.contextPath}/provider/getAll.do";
                    }
                },
                error:function () {
                    alert("添加异常");
                }
            });
        }
    }


    $("#providerId").blur(function () {
        checkProCodeExits();
    });

    $("#providerName").blur(function () {
        checkProName();
    });

    $("#people").blur(function () {
        checkPeo()
    });

    $("#phone").blur(function () {
        checkProPho();
    });

    function checkPeo() {
        var people = $("#people").val();
        $("#people+span").html("");
        if(people==""){
            $("#people+span").html("请填写联系人");
            return false;
        }
        return true;
    }

    function checkProPho() {
        var phone = /^1(3|4|5|7|8)\d{9}$/g;
        var proPhone = document.getElementById("phone").value;
        $("#phone+span").html("");
        if(!phone.test(proPhone)){
            $("#phone+span").html("手机号格式不正确，请重新填写");
            return false;
        }
        return true;
    }

    function checkProName() {
        $("#providerName+span").html("");
        var providerName = $("#providerName").val();
        if(providerName==""){
            $("#providerName+span").html("请填写供应商名称");
            return false;
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/provider/test1.do?providerName="+providerName,
            type:"get",
            dataType:"text",
            success:function (data) {
                if(data=="none"){
                    $("#providerName+span").html("");
                    return true;
                }
                if(data=="exits"){
                    $("#providerName+span").html("供应商已存在,请重新输入");
                    return false;
                }
                if(data=="error"){
                    $("#providerName+span").html("请输入供应商");
                    return false;
                }
            }
        });
    }


    function checkProCodeExits() {
        var providerId = $("#providerId").val();
        if(providerId==""){
            $("#providerId+span").html("请输入供应商编码");
            return false;
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/provider/test.do?providerId="+providerId,
            type:"get",
            dataType:"text",
            success:function (data) {
                if(data=="none"){
                    $("#providerId+span").html("");
                    return true;
                }
                if(data=="exits"){
                    $("#providerId+span").html("供应商编码已存在,请重新输入");
                    return false;
                }
                if(data=="error"){
                    $("#providerId+span").html("请输入供应商编码");
                    return false;
                }
            }
        });
    }



</script>
</body>
</html>