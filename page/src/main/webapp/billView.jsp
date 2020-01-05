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
            <span>账单管理页面 >> 信息查看</span>
        </div>
        <div class="providerView">
            <p><strong>订单编号：</strong><span>${BILL.billCode}</span></p>
            <p><strong>商品名称：</strong><span>${BILL.productName}</span></p>
            <p><strong>商品单位：</strong><span>${BILL.productUnit}</span></p>
            <p><strong>商品数量：</strong><span>${BILL.productCount}</span></p>
            <p><strong>总金额：</strong><span>${BILL.totalPrice}</span></p>
            <p><strong>供应商：</strong><span>${PROVIDER.proName}</span></p>
            <p><strong>是否付款：</strong><span>${BILL.isPayment eq 1?"已付款":"未付款"}</span></p>

            <a href="javascript:window.history.go(-1)">返回</a>
        </div>
    </div>
    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
    </div>
</body>
</html>