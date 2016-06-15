<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="breadcrumb span7">
    <h4>
        <small><a href="${ctx }/list" class="pull-right">更多&gt;&gt;</a></small>
        最近更新
    </h4>
    <ul class="unstyled">
        <c:forEach items="${page.datas }" var="data">
            <li>
                <span class="pull-right"><fmt:formatDate value="${data.createDate }" pattern="MM-dd"/></span>
                [<a href="${ctx }/list?catalog=${data.catalogId }">
                <c:forEach items="${catalogs }" var="catalog">
                    <c:if test="${data.catalogId==catalog.id }">
                        <c:choose>
                            <c:when test="${catalog.id == CATALOG_TUTORIAL}">
                                <font style=" font-weight:bold">${catalog.name }</font>
                            </c:when>
                            <c:otherwise>
                                ${catalog.name }
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
            </a>]
                <a href="${ctx }/article/${data.id }.html" target="_blank">${data.title }
                    <c:if test="${data.new}">
                        <%-- 近'3'天发布的文章则显示'new'图片 --%>
	    		        <span style="position:relative;height:14px;display:inline-block;width:32px;">
	    		            <img src="${ctx}/static/image/new.png" alt="new"
                                 style="position:absolute;top:-7px;margin-left:5px;"/>
	    		        </span>
                    </c:if>
                </a>
                <div style="margin-bottom: 15px; color:#776955">${data.description }</div>
            </li>
        </c:forEach>
    </ul>
</div>