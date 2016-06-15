<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="content">
    <input type="button" class="btn btn-small btn-primary" value="添加" onclick="edit();">
    <input type="button" class="btn btn-small btn-danger" value="删除"
           onclick="doBatch('ids', '${ctx}/admin/permission/delete?ids=');">

    <table class="table table-bordered table-striped table-condensed">
        <thead>
        <tr>
            <th>
                <input type="checkbox" id="selectall" name="selectall" onclick="selectAll('selectall', 'ids')">
            </th>
            <th>权限值</th>
            <th>状态</th>
            <th>排序</th>
            <th>创建时间</th>
            <th>更新时间</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.datas }" var="data">
            <tr>
                <td class="span1"><input type="checkbox" name="ids" value="${data.id }"></td>
                <td>
                    <a href="${ctx }/admin/permission/edit?id=${data.id }" title="${data.value }">${data.value }</a>
                </td>
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

<script src="${ctx}/static/js/common.js"></script>
<script type="text/javascript">
    function edit() {
        window.location.href = '${ctx}/admin/permission/edit';
    }
</script>