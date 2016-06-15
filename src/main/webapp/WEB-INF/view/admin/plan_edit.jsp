<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="content">
    <form class="form-horizontal" method="post" action="${ctx }/admin/plan/save">
        <input type="hidden" name="id" value="${plan.id}"/>
        <%--<fmt:formatDate value="${plan.createDate}" var="dateString" pattern="yyyy-mm-dd hh:MM:ss"/>--%>
        <%--<input type="hidden" name="createDate" value="${dateString}"/>--%>

        <div class="control-group">
            <label class="control-label">标题</label>
            <div class="controls">
                <input type="text" class="span6" name="title" value="${plan.title }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">内容</label>
            <div class="controls">
                <textarea rows="4" class="span6" name="content">${plan.content }</textarea>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">取消原因</label>
            <div class="controls">
                <input type="text" class="span6" name="cancelReason" value="${plan.cancelReason }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">优先级</label>
            <div class="controls">
                <select class="span1" name="level">
                    <c:forEach var="item" items="${LEVEL_MAP}">
                        <option value="${item.key}"
                                <c:if test="${plan.levelEnum.code==item.key }">selected</c:if>>${item.value}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">状态</label>
            <div class="controls">
                <select class="span1" name="status">
                    <c:forEach var="item" items="${STATUS_MAP}">
                        <option value="${item.key}"
                                <c:if test="${plan.status==item.key }">selected</c:if>>${item.value}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="control-group">
            <div class="controls">
                <input type="submit" class="btn" value="保存">
            </div>
        </div>
    </form>
</div>
