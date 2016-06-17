<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="pagination">
    <ul>
        <li <c:if test="${!page.hasPrevious }">class="disabled"</c:if>>
            <a <c:if test="${page.hasPrevious }">href="?${params }page=${page.current - 1 }"</c:if>>&lt;&lt;</a>
        </li>

        <c:forEach var="i" begin="1" end="${page.totalPages}">
            <li <c:if test="${page.current==i }">class="active"</c:if>>
                <a href="?${params }page=${i }">${i }</a>
            </li>
        </c:forEach>

        <li <c:if test="${!page.hasNext}">class="disabled"</c:if>>
            <a <c:if test="${page.hasNext}">href="?${params }page=${page.current + 1 }"</c:if>>&gt;&gt;</a>
        </li>
    </ul>
</div>