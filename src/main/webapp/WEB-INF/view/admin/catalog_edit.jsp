<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="content">
    <form class="form-horizontal" method="post" action="${ctx }/admin/catalog/save">
        <input type="hidden" name="id" value="${catalog.id}"/>

        <div class="control-group">
            <label class="control-label">目录名</label>
            <div class="controls">
                <input type="text" name="name" value="${catalog.name }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">英文名称</label>
            <div class="controls">
                <input type="text" name="folder" value="${catalog.folder }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">所属父目录</label>
            <div class="controls">
                <select name="pid">
                    <option value="0">/</option>
                    <c:forEach items="${catalogList.items }" var="data">
                        <option value="${data.id}" <c:if test="${catalog.pid==data.id }">selected</c:if>>
                            &nbsp;${data.name }</option>
                        <c:forEach items="${data.items }" var="data2">
                            <option value="${data2.id}" <c:if test="${catalog.pid==data2.id }">selected</c:if>>
                                &nbsp;&nbsp;&nbsp;${data2.name }</option>
                            <c:forEach items="${data2.items }" var="data3">
                                <option value="${data3.id}" <c:if test="${catalog.pid==data3.id }">selected</c:if>>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${data3.name }</option>
                            </c:forEach>
                        </c:forEach>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">排序</label>
            <div class="controls">
                <input type="text" name="sort" value="${catalog.sort }">
            </div>
        </div>

        <div class="control-group">
            <div class="controls">
                <input type="submit" class="btn" value="保存">
            </div>
        </div>
    </form>
</div>
