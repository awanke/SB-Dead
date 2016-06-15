<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="content">
    <input type="button" class="btn btn-small btn-primary" value="添加" onclick="edit();">
    <table class="table table-bordered table-striped table-condensed">
        <thead>
        <tr>
            <th>目录名</th>
            <th>英文名称</th>
            <th>深度</th>
            <th>父id</th>
            <th>路径</th>
            <th>状态</th>
            <th>排序</th>
            <th>创建时间</th>
            <th>更新时间</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.datas }" var="data">
            <tr>
                <td>
                    <a href="${ctx }/admin/catalog/edit?id=${data.id }">${data.name }</a>
                </td>
                <td>${data.folder }</td>
                <td>${data.deep }</td>
                <td>${data.pid }</td>
                <td>${data.pidPath }</td>
                <td>
                    <c:choose>
                        <c:when test="${data.status==0}">
                            未删除
                        </c:when>
                        <c:when test="${data.status==1}">
                            删除
                        </c:when>
                    </c:choose>
                </td>
                <td>${data.sort}</td>
                <td>
                    <fmt:formatDate value="${data.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>
                    <fmt:formatDate value="${data.updateDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/view/include/pagination.jsp" %>
<script type="text/javascript">
    function edit() {
        window.location.href = '${ctx}/admin/catalog/edit';
    }
</script>