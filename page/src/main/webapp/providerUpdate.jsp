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
            <span>供应商管理页面 >> 供应商修改页</span>
        </div>
        <div class="providerAdd">
            <form action="#" method="post" id="updateProForm">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <input type="hidden" value="${PROVIDER.id}" name="id">
                <input type="hidden" value="<s:principal property='id'></s:principal>" name="modifyBy">

                <div class="">
                    <label for="providerId">供应商编码：</label>
                    <input type="text" name="providerId" id="providerId" value="${PROVIDER.proCode}" readonly/>
                    <span>*</span>
                </div>
                <div>
                    <label for="providerName">供应商名称：</label>
                    <input type="text" name="providerName" id="providerName" value="${PROVIDER.proName}"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="people">联系人：</label>
                    <input type="text" name="people" id="people" value="${PROVIDER.proContact}"/>
                    <span>*</span>

                </div>
                <div>
                    <label for="phone">联系电话：</label>
                    <input type="text" name="phone" id="phone" value="${PROVIDER.proPhone}"/>
                    <span></span>
                </div>
                <div>
                    <label for="address">联系地址：</label>
                    <input type="text" name="address" id="address" value="${PROVIDER.proAddress}"/>
                    <span></span>

                </div>
                <div>
                    <label for="fax">传真：</label>
                    <input type="text" name="fax" id="fax" value="${PROVIDER.proFax}"/>
                    <span></span>

                </div>
                <div>
                    <label for="describe">描述：</label>
                    <input type="text" name="describe" id="describe" value="${PROVIDER.proDesc}"/>
                    <span></span>

                </div>
                <div class="providerAddBtn">
                    <input type="button" value="保存" onclick="updateByPro()"/>
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

    $("#providerName").blur(function () {
        checkProName();
    });

    $("#people").blur(function () {
        checkPeople();
    });

    $("#phone").blur(function () {
        checkPhone();
    });

    function checkPhone() {
        var reg = /^1(3|4|5|7|8)\d{9}/g;
        var name = $("#phone").val();
        $("#phone+span").html("");
        if(name.length==""){
            $("#phone+span").html("*请填写手机号");
            return false;
        }
        if(!reg.test(name)){
            $("#phone+span").html("*请填写正确格式");
            return false;
        }
        return true;
    }

    function checkPeople() {
        var name = $("#people").val();
        $("#people+span").html("");
        if(name.length==""){
            $("#people+span").html("*请填写联系人名称");
            return false;
        }
        return true;
    }

    function checkProName() {
        var name = $("#providerName").val();
        $("#providerName+span").html("");
        if(name.length==""){
            $("#providerName+span").html("*请填写供应商名称");
            return false;
        }
        if(name=="${PROVIDER.proName}"){
            return true;
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/provider/test1.do?providerName="+name,
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

    function updateByPro() {
        if(checkProName()&&checkPeople()&&checkPhone()){
            if(confirm("确定修改吗?")){
                $.ajax({
                    url:"${pageContext.request.contextPath}/provider/update.do",
                    type:"post",
                    dataType:"text",
                    data:$("#updateProForm").serialize(),
                    success:function (data) {
                        if(data=="success"){
                            alert("修改成功");
                            window.location.href="${pageContext.request.contextPath}/provider/getAll.do";
                        }else if(data=="error"){
                            alert("修改失败");
                            window.location.href="${pageContext.request.contextPath}/provider/getAll.do";
                        }
                    },
                    error:function () {
                        alert("修改异常");
                    }
                });
            }
        }
    }



</script>
</body>
</html>