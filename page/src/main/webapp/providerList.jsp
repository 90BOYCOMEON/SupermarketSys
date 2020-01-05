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
            <span>供应商管理页面</span>
        </div>
        <div class="search">
            <span>供应商名称：</span>
            <input type="text" value="${NAME}" name="proName" id="proName" placeholder="请输入供应商的名称"/>
            <input type="button" value="查询" onclick="goPage(document.getElementById('proName').value,1,document.getElementById('select').value)"/>
<%--            <a href="${pageContext.request.contextPath}/providerAdd.jsp">添加供应商</a>--%>
        </div>
        <!--供应商操作表格-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">供应商编码</th>
                <th width="20%">供应商名称</th>
                <th width="10%">联系人</th>
                <th width="10%">联系电话</th>
                <th width="10%">传真</th>
                <th width="20%">创建时间</th>
                <th width="20%">操作</th>
            </tr>

            <c:forEach var="p" items="${PROVIDERLIST}">
                <tr>
                    <td>${p.proCode}</td>
                    <td>${p.proName}</td>
                    <td>${p.proContact}</td>
                    <td>${p.proPhone}</td>
                    <td>${p.proFax}</td>
                    <td><fmt:formatDate value="${p.creationDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/provider/get/${p.id}.do"><img src="${pageContext.request.contextPath}/img/read.png" alt="查看" title="查看"/></a>
                        <s:hasPermission name="/provider/update">
                        <a href="${pageContext.request.contextPath}/provider/update/${p.id}.do"><img src="${pageContext.request.contextPath}/img/xiugai.png" alt="修改" title="修改"/></a>
                        </s:hasPermission>
                        <s:hasPermission name="/provider/del">
                        <a href="javascript:deletePro(${p.id});" class="removeProvider"><img src="${pageContext.request.contextPath}/img/schu.png" alt="删除" title="删除"/></a>
                        </s:hasPermission>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <tr>
            <th width="10%" id="currentPage">当前:${PAGE.currentPage}/${PAGE.totalPage} 共${PAGE.totalCount}条数据</th>
            <th width="20%" ><input type="text" id="goto" width="15px"/><button type="button" value="跳转" id="button" onclick="goPage(document.getElementById('proName').value,document.getElementById('goto').value,document.getElementById('select').value)">跳到</button></th>
            <th width="50%" id="page"><a href="#" id="top" onclick="goPage(document.getElementById('proName').value,1,document.getElementById('select').value)"> 首页 </a><a href="#" id="pre" onclick="goPage(document.getElementById('proName').value,${PAGE.currentPage-1},document.getElementById('select').value)"> 上一页 </a><a href="#" id="next" onclick="goPage(document.getElementById('proName').value,${PAGE.currentPage+1},document.getElementById('select').value)"> 下一页 </a><a href="javascript:goPage(document.getElementById('proName').value,${PAGE.totalPage},document.getElementById('select').value)" id="down"> 尾页 </a></th>
            <th width="10%" id="pageSize"><select id="select" onchange="goPage(document.getElementById('proName').value,1,this.value)">
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
    function goPage(proName,currentPage,pageSize) {
        var reg = /^\d+/g;
        if(currentPage >${PAGE.totalPage} || currentPage<=0 ||!reg.test(currentPage)){
            window.location.href="${pageContext.request.contextPath}/provider/getAll.do?proName="+proName+"&currentPage=${PAGE.currentPage}&"+"pageSize="+pageSize;
        }else{
            window.location.href="${pageContext.request.contextPath}/provider/getAll.do?proName="+proName+"&currentPage="+currentPage+"&pageSize="+pageSize;
        }
    }

    function deletePro(id) {
        var controller = "${pageContext.request.contextPath}/provider/del/"+id+".do";
        if(confirm("该供应商可能存在订单，确定要删除吗?")){
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