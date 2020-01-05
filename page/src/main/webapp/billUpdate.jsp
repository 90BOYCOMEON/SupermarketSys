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
            <span>账单管理页面 >> 订单添加页面</span>
        </div>
        <div class="providerAdd">
            <form action="#" method="post" id="BillForm">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <input type="hidden" value="${BILL.id}" name="id">
                <input type="hidden" value="<s:principal property='id'></s:principal>" name="modifyBy">
                <div class="">
                    <label for="providerId">订单编码：</label>
                    <input type="text" name="providerId" id="providerId" value="${BILL.billCode}"/>
                    <span>*</span>
                </div>
                <div>
                    <label for="providerName">商品名称：</label>
                    <input type="text" name="providerName" id="providerName" value="${BILL.productName}"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="people">商品单位：</label>
                    <input type="text" name="people" id="people" value="${BILL.productUnit}"/>
                    <span>*</span>

                </div>
                <div>
                    <label for="phone">商品数量：</label>
                    <input type="text" name="phone" id="phone" value="${BILL.productCount}"/>
                    <span>*</span>
                </div>
                <div>
                    <label for="price">总金额：</label>
                    <input type="text" name="price" id="price" value="${BILL.totalPrice}"/>
                    <span>*</span>
                </div>
                <div>
                    <label for="fax">供应商：</label>
                    <select id="fax" name="fax">
                        <c:forEach var="p" items="${PROLIST}">
                            <option value="${p.id}" ${BILL.providerId eq p.id?"selected":""}>${p.proName}</option>
                        </c:forEach>
                    </select>
                    <span>*</span>
                </div>
                <div>
                    <label >是否付款：</label>
                    <input type="radio" name="zhifu" value="0" ${BILL.isPayment eq 0?"checked":""}/>未付款
                    <input type="radio" name="zhifu" value="1" ${BILL.isPayment eq 1?"checked":""}/>已付款
                </div>
                <div class="providerAddBtn">
                    <!--<a href="#">保存</a>-->
                    <!--<a href="billList.jsp">返回</a>-->
                    <input type="button" value="保存" onclick="submitBill()"/>
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

    function submitBill(){
        if(checkDW()&&checkPrice()&&checkCount()){
            if(confirm("确定修改吗?")){
                $.ajax({
                    url:"${pageContext.request.contextPath}/bill/update.do",
                    type:"post",
                    dataType:"text",
                    data:$("#BillForm").serialize(),
                    success:function (data) {
                        if(data=="success"){
                            alert("修改成功");
                            window.location.href="${pageContext.request.contextPath}/bill/getAll.do";
                        }else if(data=="error"){
                            alert("修改失败");
                            window.location.href="${pageContext.request.contextPath}/bill/getAll.do";
                        }
                    },
                    error:function () {
                        alert("修改异常");
                    }
                });
            }
        }
    }


    $("#providerId").blur(function () {
        checkProId();
    });

    $("#providerName").blur(function () {
        checkBillName();
    });

    $("#people").blur(function () {
        checkDW();
    });

    $("#price").blur(function () {
        checkPrice();
    });

    $("#phone").blur(function () {
        checkCount();
    });

    function checkCount() {
        $("#phone+span").html("");
        var count = $("#phone").val();
        var reg = /^[1-9]{1}[0-9]{0,}(.[0-9]+){0,}$/g;
        if(count==""){
            $("#phone+span").html("请输入个数");
            return false;
        }

        if(!reg.test(count)){
            $("#phone+span").html("请正确输入个数");
            return false;
        }
        return true;
    }

    function checkPrice() {
        $("#price+span").html("");
        var price = $("#price").val();
        var reg = /^[1-9]{1}[0-9]{0,}(.[0-9]+){0,}$/g;
        if(price==""){
            $("#price+span").html("请输入数字");
            return false;
        }

        if(!reg.test(price)){
            $("#price+span").html("请正确输入数字");
            return false;
        }
        return true;
    }

    function checkDW() {
        $("#people+span").html("");
        var dw = $("#people").val();
        if(dw.length==""){
            $("#people+span").html("请输入商品单位");
            return false;
        }
        return true;
    }

    function checkBillName() {
        var name = $("#providerName").val();
        $("#providerName+span").html("");
        if(name.length==""){
            $("#providerName+span").html("*请填写商品名称");
            return false;
        }
        if(name=="${BILL.productName}"){
            return true;
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/bill/test1.do?providerName="+name,
            type:"get",
            dataType:"text",
            success:function (data) {
                if(data=="none"){
                    $("#providerName+span").html("");
                    return true;
                }
                if(data=="exits"){
                    $("#providerName+span").html("商品已存在,请重新输入");
                    return false;
                }
                if(data=="error"){
                    $("#providerName+span").html("请输入商品");
                    return false;
                }
            }
        });
    }

    function checkProId() {
        var name = $("#providerId").val();
        $("#providerId+span").html("");
        if(name.length==""){
            $("#providerId+span").html("*请填写账单编码");
            return false;
        }
        if(name=="${BILL.billCode}"){
            return true;
        }

        $.ajax({
            url:"${pageContext.request.contextPath}/bill/test.do?providerId="+name,
            type:"get",
            dataType:"text",
            success:function (data) {
                if(data=="none"){
                    $("#providerId+span").html("");
                    return true;
                }
                if(data=="exits"){
                    $("#providerId+span").html("账单编码已存在,请重新输入");
                    return false;
                }
                if(data=="error"){
                    $("#providerId+span").html("请输入账单编码");
                    return false;
                }
            }
        });
    }

</script>

</body>
</html>