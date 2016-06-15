<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="content">
    <form class="form-horizontal" method="post" action="${ctx }/admin/role/save">
        <input type="hidden" name="id" value="${role.id}"/>

        <div class="control-group">
            <label class="control-label">角色名</label>
            <div class="controls">
                <input type="text" name="value" value="${role.value }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">排序</label>
            <div class="controls">
                <input type="text" name="rank" value="${role.sort }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">拥有权限</label>
            <div class="controls">
                <table class=" table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="selectall" onChange="selectAll('selectall','permissionIds');">
                        </th>
                        <th>
                            权限值
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${permissions}" var="data">
                        <c:set value="" var="checked"/>
                        <tr>
                            <c:forEach items="${permissionIds }" var="innerData">
                                <c:if test="${innerData==data.id}">
                                    <c:set value="checked" var="checked"/>
                                </c:if>
                            </c:forEach>
                            <td><input type="checkbox" name="permissionIds" value="${data.id}" ${checked }></td>
                            <td>${data.value}</td>
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