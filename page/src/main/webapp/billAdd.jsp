<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/JSTLPage.jsp" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市账单管理系统</title>

    <%@ include file="common/cssOrJs.jsp" %>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <%@ include file="common/top.jsp"%>
    <div class="layui-body">
        <div class="center">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>账单管理页面 >> 订单添加页面</span>
        </div>
        <div class="providerAdd">
            <form action="#" method="post" id="ADDBILLFORM">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div class="">
                    <label for="billId">订单编码：</label>
                    <input type="text" name="billId" id="billId" required/>
                    <span>*请输入订单编码</span>
                </div>
                <div>
                    <label for="billName">商品名称：</label>
                    <input type="text" name="billName" id="billName" required/>
                    <span>*请输入商品名称</span>
                </div>
                <div>
                    <label for="billCom">商品单位：</label>
                    <input type="text" name="billCom" id="billCom" required/>
                    <span>*请输入商品单位</span>

                </div>
                <div>
                    <label for="billNum">商品数量：</label>
                    <input type="text" name="billNum" id="billNum" required/>
                    <span>*请输入大于0的正自然数，小数点后保留2位</span>
                </div>
                <div>
                    <label for="money">总金额：</label>
                    <input type="text" name="money" id="money" required/>
                    <span>*请输入大于0的正自然数，小数点后保留2位</span>
                </div>
                <div>
                    <label>供应商：</label>
                    <select name="supplier" id="supplier">
                    </select>
                    <span>*请选择供应商</span>
                </div>
                <div>
                    <label>是否付款：</label>
                    <input type="radio" value="0" name="zhifu" checked/>未付款
                    <input type="radio" value="1" name="zhifu"/>已付款
                </div>
                <div class="providerAddBtn">
                    <!--<a href="#">保存</a>-->
                    <!--<a href="billList.jsp">返回</a>-->
                    <input type="button" value="保存" onclick="submitBillAdd()"/>
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

    $(function () {
        $.ajax({
           url:"${pageContext.request.contextPath}/bill/getPro.do",
            type: "get",
            dataType: "json",
            success: function (data) {
               var str = "<option value=''>--请选择相应的提供商--</option>";
               for(var i=0;i<data.length;i++){
                   str+="<option value='"+data[i].id+"'>"+data[i].proName+"</option>";
               }
                $("#supplier").html(str);
            }
        });
    })


    function submitBillAdd() {
        if (checkDW() && checkPrice() && checkCount()&&checksup()) {
            $.ajax({
                url: "${pageContext.request.contextPath}/bill/add.do",
                type: "post",
                dataType: "text",
                data: $("#ADDBILLFORM").serialize(),
                success: function (data) {
                    if (data == "success") {
                        alert("添加成功");
                        window.location.href = "${pageContext.request.contextPath}/bill/getAll.do";
                    } else if (data == "error") {
                        alert("添加成功");
                        window.location.href = "${pageContext.request.contextPath}/bill/getAll.do";
                    }
                },
                error: function () {
                    alert("添加异常");
                }
            });
        }
    }

    function checksup(){
        $("#supplier+span").html("");
        var val = $("#supplier").val();
        if(val==""){
            $("#supplier+span").html("请选择供应商!");
            return false;
        }
        return true;
    }


    $("#billId").blur(function () {
        checkProId();
    });

    $("#billName").blur(function () {
        checkBillName();
    });

    $("#billCom").blur(function () {
        checkDW();
    });

    $("#money").blur(function () {
        checkPrice();
    });

    $("#billNum").blur(function () {
        checkCount();
    });

    function checkCount() {
        $("#billNum+span").html("");
        var count = $("#billNum").val();
        var reg = /^[1-9]{1}[0-9]{0,}(.[0-9]+){0,}$/g;
        if (count == "") {
            $("#billNum+span").html("请输入个数");
            return false;
        }

        if (!reg.test(count)) {
            $("#billNum+span").html("请正确输入个数");
            return false;
        }
        return true;
    }

    function checkPrice() {
        $("#money+span").html("");
        var price = $("#money").val();
        var reg = /^[1-9]{1}[0-9]{0,}(.[0-9]+){0,}$/g;
        if (price == "") {
            $("#money+span").html("请输入数字");
            return false;
        }

        if (!reg.test(price)) {
            $("#money+span").html("请正确输入数字");
            return false;
        }
        return true;
    }

    function checkDW() {
        $("#billCom+span").html("");
        var dw = $("#billCom").val();
        if (dw.length == "") {
            $("#billCom+span").html("请输入商品单位");
            return false;
        }
        return true;
    }

    function checkBillName() {
        var name = $("#billName").val();
        $("#billName+span").html("");
        if (name.length == "") {
            $("#billName+span").html("*请填写商品名称");
            return false;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/bill/test1.do?providerName=" + name,
            type: "get",
            dataType: "text",
            success: function (data) {
                if (data == "none") {
                    $("#billName+span").html("");
                    return true;
                }
                if (data == "exits") {
                    $("#billName+span").html("商品已存在,请重新输入");
                    return false;
                }
                if (data == "error") {
                    $("#billName+span").html("请输入商品");
                    return false;
                }
            }
        });
    }

    function checkProId() {
        var name = $("#billId").val();
        $("#billId+span").html("");
        if (name.length == "") {
            $("#billId+span").html("*请填写账单编码");
            return false;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/bill/test.do?providerId=" + name,
            type: "get",
            dataType: "text",
            success: function (data) {
                if (data == "none") {
                    $("#billId+span").html("");
                    return true;
                }
                if (data == "exits") {
                    $("#billId+span").html("账单编码已存在,请重新输入");
                    return false;
                }
                if (data == "error") {
                    $("#billId+span").html("请输入账单编码");
                    return false;
                }
            }
        });
    }

</script>

</body>
</html>