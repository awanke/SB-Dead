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
            <label>标题：</label>
            <input type="text" maxlength="50" class="input-medium" name="cTitle" value="${page.conditions.cTitle }">
            &nbsp;

            <select class="span1" name="cLevel">
                <option value="-1">优先级</option>
                <c:forEach var="item" items="${LEVEL_MAP}">
                    <option value="${item.key}"
                            <c:if test="${page.conditions.cLevel==item.key }">selected</c:if>>${item.value}</option>
                </c:forEach>
            </select>

            &nbsp;
            <select class="span1" name="cStatus">
                <option value="-1">状态</option>
                <c:forEach var="item" items="${STATUS_MAP}">
                    <option value="${item.key}"
                            <c:if test="${page.conditions.cStatus==item.key }">selected</c:if>>${item.value}</option>
                </c:forEach>
            </select>

            &nbsp;
            <input type="submit" value="查询" class="btn">
        </div>
    </form>

    <input type="button" class="btn btn-small btn-primary" value="添加" onclick="edit();">
    <input type="button" class="btn btn-small btn-danger" value="删除"
           onclick="doBatch('ids', '${ctx}/admin/plan/delete?ids=');">

    <table class="table table-bordered table-striped table-condensed">
        <thead>
        <tr>
            <th>
                <input type="checkbox" id="selectall" name="selectall" onclick="selectAll('selectall', 'ids')">
            </th>
            <th class="span6">标题</th>
            <th>优先级</th>
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
                    <a href="${ctx }/admin/plan/edit?id=${data.id }" title="${data.content }">${data.title }</a>
                </td>
                <td>${data.levelEnum.name }</td>
                <td>
                    <c:choose>
                        <c:when test="${data.status==0}">
                            新建
                        </c:when>
                        <c:when test="${data.status==1}">
                            删除
                        </c:when>
                        <c:when test="${data.status==2}">
                            打开
                        </c:when>
                        <c:when test="${data.status==3}">
                            完成
                        </c:when>
                    </c:choose>
                </td>
                <td>${data.sort }</td>
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

<c:set var="params"
       value="cTitle=${page.conditions.cTitle }&cLevel=${page.conditions.cLevel }&cStatus=${page.conditions.cStatus }&"/>
<%@ include file="/include/pagination.jsp" %>

<script src="${ctx}/static/js/common.js"></script>
<script type="text/javascript">
    function edit() {
        window.location.href = '${ctx }/admin/plan/edit';
    }
</script>