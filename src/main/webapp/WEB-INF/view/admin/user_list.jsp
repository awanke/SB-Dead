<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="content">
    <form class="breadcrumb form-search" style="margin-bottom:10px" action="#">
        <div>
            <label></label>
            <input type="text" maxlength="50" class="input-medium" placeholder="账号或昵称"
                   name="cName" value="${page.conditions.cName }">
            &nbsp;
            <input type="submit" value="查询" class="btn">
        </div>
    </form>

    <input type="button" class="btn btn-small btn-primary" value="添加" onclick="edit();">
    <input type="button" class="btn btn-small btn-danger" value="删除"
           onclick="doBatch('ids', '${ctx}/admin/user/delete?ids=');">

    <table class="table table-bordered table-striped table-condensed">
        <thead>
        <tr>
            <th class="span1">
                <input type="checkbox" id="selectall" name="selectall" onclick="selectAll('selectall', 'ids')">
            </th>
            <th class="span2">用户名</th>
            <th>昵称</th>
            <th>状态</th>
            <th>排序</th>
            <th>创建时间</th>
            <th>更新时间</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${page.datas }" var="data">
            <tr>
                <td><input type="checkbox" name="ids" value="${data.id }"></td>
                <td>
                    <a href="${ctx }/admin/user/edit?id=${data.id }" title="${data.username }">${data.username }</a>
                </td>
                <td>${data.name }</td>
                <td>
                    <c:choose>
                        <c:when test="${data.status==0}">
                            站内注册
                        </c:when>
                        <c:when test="${data.status==1}">
                            删除
                        </c:when>
                        <c:when test="${data.status==2}">
                            新浪微博
                        </c:when>
                        <c:when test="${data.status==3}">
                            qq登陆
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

<c:set var="params" value="cName=${page.conditions.cName }&"/>
<%@ include file="/view/include/pagination.jsp" %>

<script src="${ctx}/static/js/common.js"></script>
<script type="text/javascript">
    function edit() {
        window.location.href = '${ctx}/admin/user/edit';
    }
</script>