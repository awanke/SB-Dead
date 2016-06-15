<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="content">
    <form class="form-horizontal" method="post" action="${ctx }/admin/user/save">
        <input type="hidden" name="id" value="${user.id}"/>

        <div class="control-group">
            <label class="control-label">用户名</label>
            <div class="controls">
                <input type="text" name="username" value="${user.username }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">密码</label>
            <div class="controls">
                <input type="password" name="password" value="${user.password }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">重复密码</label>
            <div class="controls">
                <input type="password" name="repeatPassword" value="${user.repeatPassword }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">昵称</label>
            <div class="controls">
                <input type="text" name="name" value="${user.name }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">拥有角色</label>
            <div class="controls">
                <table class=" table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="selectall" onChange="selectAll('selectall','roleIds');">
                        </th>
                        <th>
                            角色名
                        </th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${roles}" var="data">
                        <c:set value="" var="checked"/>
                        <tr>
                            <c:forEach items="${roleIds }" var="innerData">
                                <c:if test="${innerData==data.id}">
                                    <c:set value="checked" var="checked"/>
                                </c:if>
                            </c:forEach>
                            <td><input type="checkbox" name="roleIds" value="${data.id}" ${checked }></td>
                            <td>${data.value }</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <input type="submit" class="btn" value="保存">
            </div>
        </div>
    </form>
</div>

<script src="${ctx}/static/js/common.js"></script>