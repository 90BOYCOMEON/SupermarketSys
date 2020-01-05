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
                <span>账单管理页面</span>
            </div>
            <div class="search">
                <span>商品名称：</span>
                <input type="text" name="productName" id="productName" value="${PRONAME}" placeholder="请输入商品的名称"/>
                
                <span>供应商：</span>
                <select name="providerId" id="providerId">
                    <option value="">--请选择--</option>
                    <c:forEach var="p" items="${PROLIST}">
                        <option value="${p.id}" ${p.id eq PROID?"selected":""}>${p.proName}</option>
                    </c:forEach>
                </select>

                <span>是否付款：</span>
                <select name="isPayment" id="isPayment">
                    <option value="" >--请选择--</option>
                    <option value="1" ${ISPAY eq 1?"selected":""}>已付款</option>
                    <option value="0" ${ISPAY eq 0?"selected":""}>未付款</option>
                </select>

                <input type="button" value="查询" onclick="goPage(document.getElementById('productName').value,document.getElementById('goto').value,document.getElementById('select').value,document.getElementById('isPayment').value,document.getElementById('providerId').value)"/>
<%--                <a href="${pageContext.request.contextPath}/billAdd.jsp">添加订单</a>--%>
            </div>
            <!--账单表格 样式和供应商公用-->
            <table class="providerTable" cellpadding="0" cellspacing="0">
                <tr class="firstTr">
                    <th width="10%">账单编码</th>
                    <th width="20%">商品名称</th>
                    <th width="10%">供应商</th>
                    <th width="10%">账单金额</th>
                    <th width="10%">是否付款</th>
                    <th width="20%">创建时间</th>
                    <th width="20%">操作</th>
                </tr>
                <c:forEach var="b" items="${BILL}">
                    <tr>
                        <td>${b.billCode}</td>
                        <td>${b.productName}</td>
                        <td>${b.proName}</td>
                        <td>${b.totalPrice}</td>
                        <td>${b.isPayment eq 1?"已支付":"未支付"}</td>
                        <td><fmt:formatDate value="${b.creationDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/bill/get/${b.id}.do"><img src="${pageContext.request.contextPath}/img/read.png" alt="查看" title="查看"/></a>
                            <s:hasPermission name="/bill/update">
                            <a href="${pageContext.request.contextPath}/bill/update/${b.id}.do"><img src="${pageContext.request.contextPath}/img/xiugai.png" alt="修改" title="修改"/></a>
                            </s:hasPermission>
                            <s:hasPermission name="/bill/del">
                            <a href="javascript:deleteId(${b.id});" class="removeBill"><img src="${pageContext.request.contextPath}/img/schu.png" alt="删除" title="删除"/></a>
                            </s:hasPermission>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <tr>
                <th width="10%" id="currentPage">当前:${PAGE.currentPage}/${PAGE.totalPage} 共${PAGE.totalCount}条数据</th>
                <th width="20%" ><input type="text" id="goto" width="15px"/><button type="button" value="跳转" id="button" onclick="goPage(document.getElementById('productName').value,document.getElementById('goto').value,document.getElementById('select').value,document.getElementById('isPayment').value,document.getElementById('providerId').value)">跳到</button></th>
                <th width="50%" id="page"><a href="#" id="top" onclick="goPage(document.getElementById('productName').value,1,document.getElementById('select').value,document.getElementById('isPayment').value,document.getElementById('providerId').value)"> 首页 </a><a href="#" id="pre" onclick="goPage(document.getElementById('productName').value,${PAGE.currentPage-1},document.getElementById('select').value,document.getElementById('isPayment').value,document.getElementById('providerId').value)"> 上一页 </a><a href="#" id="next" onclick="goPage(document.getElementById('productName').value,${PAGE.currentPage+1},document.getElementById('select').value,document.getElementById('isPayment').value,document.getElementById('providerId').value)"> 下一页 </a><a href="javascript:goPage(document.getElementById('productName').value,${PAGE.totalPage},document.getElementById('select').value,document.getElementById('isPayment').value,document.getElementById('providerId').value)" id="down"> 尾页 </a></th>
                <th width="10%" id="pageSize"><select id="select" onchange="goPage(document.getElementById('productName').value,1,this.value,document.getElementById('isPayment').value,document.getElementById('providerId').value)">
                    <option value="10" ${PAGE.pageSize eq 10?"selected":""}>10</option>
                    <option value="15" ${PAGE.pageSize eq 15?"selected":""}>15</option>
                    <option value="20" ${PAGE.pageSize eq 20?"selected":""}>20</option>
                </select>
                </th>
            </tr>
        </div>

        <div class="layui-footer">
            <!-- 底部固定区域 -->
            © layui.com - 底部固定区域
        </div>
    </div>

<script>
    function goPage(name,currentPage,pageSize,isPayment,providerId) {
        var reg = /^\d+/g;
        if(currentPage >${PAGE.totalPage} || currentPage<=0||!reg.test(currentPage)){
            window.location.href="${pageContext.request.contextPath}/bill/getAll.do?productName="+name+"&currentPage=${PAGE.currentPage}&"+"pageSize="+pageSize+"&providerId="+providerId+"&isPayment="+isPayment;
        }else{
            window.location.href="${pageContext.request.contextPath}/bill/getAll.do?productName="+name+"&currentPage="+currentPage+"&pageSize="+pageSize+"&providerId="+providerId+"&isPayment="+isPayment;
        }

    }
    function deleteId(id) {
        var controller = "${pageContext.request.contextPath}/bill/del/"+id+".do";
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