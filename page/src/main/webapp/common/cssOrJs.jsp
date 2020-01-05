<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
<script src="${pageContext.request.contextPath}/laydate/laydate.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/js/layer/layer.js"></script>
<script src="${pageContext.request.contextPath}/js/layui/layui.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/layui/css/layui.css"/>
<script src="${pageContext.request.contextPath}/js/js.js"></script>

<script>
    function logout() {
        if(confirm("确定离开吗?")){
            window.location.href="${pageContext.request.contextPath}/user/logout.do";
        }
    }
</script>