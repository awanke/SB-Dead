<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="breadcrumb pull-left" style="width:840px;">
    <ul class="unstyled">
        <!-- 文章列表 -->
        <c:forEach items="${page.datas }" var="data">
            <c:set var="catalogId" value="${data.catalogId }${'' }"/>
            <li style="font-size: 15px;">
                <a href="${ctx }/article/${data.id }">${data.title }</a>
                <c:if test="${data.new}">
                    <%-- 近'3'天发布的文章则显示'new'图片 --%>
                    <img src="${ctx}/static/image/new.gif" alt="new" style="margin-top: -10px" title="近三天更新">
                </c:if>
                <div class="media">
                    <a class="pull-left" style="margin-left: 30px;">
                        <%
                            int r = (int) (Math.random() * 650);
                        %>
                        <img class="media-object" src="${ctx }/static/pic/<%=r%>.png"
                             style="width: 100px;height: 100px;">
                    </a>
                    <div class="media-body">
                        <div style="color:#776955;margin-left: 30px">${data.description }</div>
                    </div>
                </div>
                <div style="margin: 10px">
                    <span class="pull-left">
                         <span class="icon-eye-open"></span>&nbsp;${data.pageView}
                    </span>
                    <span class="pull-right">
                        <span class="icon-time"></span>
                        <fmt:formatDate value="${data.publishDate }" pattern="yyyy年MM月dd日"/>
                    </span>
                    <center>
                        <span>
                            <span class="icon-leaf"></span>&nbsp;${catalogs[catalogId].name}
                        </span>
                    </center>
                </div>
            </li>
            <hr/>
        </c:forEach>
    </ul>
</div>

<div class="pull-left" style="width:840px;">
    <em class="text-success pull-right">历时${page.elapsedTime } ms，查到结果${page.count } 个</em>
</div>

<div class="pull-left" style="width:840px;">
    <c:set var="params" value=""/>
    <c:if test="${not empty page.conditions.kw}">
        <c:set var="params" value="${params }kw=${page.conditions.kw }&"/>
    </c:if>
    <%@ include file="/include/pagination.jsp" %>
</div>

