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
            <select class="span1" name="cCatalog">
                <option value="-1">目录</option>
                <c:forEach items="${catalogs }" var="item">
                    <option value="${item.id }"
                            <c:if test="${page.conditions.cCatalog==item.id }">selected</c:if>>${item.name }
                    </option>
                </c:forEach>
            </select>

            &nbsp;
            <select class="span1" name="cSource">
                <option value="-1">来源</option>
                <c:forEach items="${SOURCE_MAP}" var="item">
                    <option value="${item.key}"
                            <c:if test="${page.conditions.cSource==item.key }">selected</c:if>>${item.value}
                    </option>
                </c:forEach>
            </select>

            &nbsp;
            <select class="span1" name="cStatus">
                <option value="-1">状态</option>
                <c:forEach items="${STATUS_MAP}" var="item">
                    <option value="${item.key}"
                            <c:if test="${page.conditions.cStatus==item.key }">selected</c:if>>${item.value}
                    </option>
                </c:forEach>
            </select>

            &nbsp;
            <input type="submit" value="查询" class="btn">
        </div>
    </form>

    <input type="button" class="btn btn-small btn-primary" value="添加" onclick="edit();">
    <input type="button" class="btn btn-small" value="预览" onclick="preview();">
    <input type="button" class="btn btn-small btn-success" value="发布"
           onclick="doBatch('ids', '${ctx}/admin/article/publish?ids=');">
    <input type="button" class="btn btn-small btn-danger" value="删除"
           onclick="doBatch('ids', '${ctx}/admin/article/delete?ids=');">

    <table class="table table-bordered table-striped table-condensed">
        <thead>
        <tr>
            <th>
                <input type="checkbox" id="selectall" name="selectall" onclick="selectAll('selectall', 'ids')">
            </th>
            <th class="span6">标题</th>
            <th>作者</th>
            <th>所属目录</th>
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
                    <a href="${ctx }/admin/article/edit?id=${data.id }">${data.title }</a>
                </td>
                <td>${data.writer }</td>
                <td>
                    <c:forEach items="${catalogs }" var="catalog">
                        <c:if test="${data.catalogId==catalog.id }">${catalog.name }</c:if>
                    </c:forEach>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${data.status==0}">
                            编辑中
                        </c:when>
                        <c:when test="${data.status==1}">
                            已删除
                        </c:when>
                        <c:when test="${data.status==2}">
                            已提交
                        </c:when>
                        <c:when test="${data.status==3}">
                            已发布
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

<c:set var="params" value="cTitle=${page.conditions.cTitle }&
	cCatalog=${page.conditions.cCatalog }&cStatus=${page.conditions.cStatus }&"/>
<%@ include file="/view/include/pagination.jsp" %>

<script src="${ctx}/static/js/common.js"></script>
<script type="text/javascript">
    function edit() {
        window.location.href = '${ctx}/admin/article/edit';
    }

    function preview() {
        var tagbox = document.getElementsByName('ids');
        var id = 0;
        var num = 0;
        for (var i = 0; i < tagbox.length; i++) {
            if (tagbox[i].checked) {
                id = tagbox[i].value;
                num++;
            }
        }
        if (num == 0) {
            alert("请选择需要预览的文章");
            return;
        }
        if (num > 1) {
            alert("不能同时预览多篇文章");
            return;
        }

        $.ajax({
            type: "POST",
            url: "${ctx}/admin/article/preview",
            data: "articleId=" + id,
            success: function (url) {
                // 必须有json返回才会执行
                window.location.href = url;
            }
        });
    }
</script>