<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<%-- 设置菜单选中状态专用 --%>
<c:set var="servletPath" value="${pageContext.request.servletPath}"/>
<c:set var="currentTab" value="${fn:substringAfter(servletPath, '/admin/')}"/>
<c:set var="currentTab" value="${fn:split(currentTab, '/')[0]}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>welcome to Hong</title>

    <link rel="shortcut icon" href="${ctx }/favicon.ico"/>
    <link rel="stylesheet" href="${ctx }/static/css/basic.css">
    <link rel="stylesheet" href="${ctx }/static/bootstrap2/css/bootstrap.min.css">

    <script src="${ctx }/static/jquery/jquery-1.10.2.min.js"></script>
    <script src="${ctx }/static/bootstrap2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="navbar">
    <div class="navbar-inner">
        <div class="container">
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <li class="<c:if test="${currentTab == 'welcome' }">active</c:if>">
                        <a target="_blank" href="${ctx }/">首页</a>
                    </li>

                    <li class="dropdown <c:if test="${currentTab=='article' || currentTab=='catalog' }">active</c:if>">
                        <a data-toggle="dropdown" class="dropdown-toggle" data-hover="dropdown">内容发布</a>
                        <ul class="dropdown-menu">
                            <li><a href="${ctx }/admin/article">文章列表</a></li>
                            <li class="divider"></li>
                            <li><a href="${ctx }/admin/catalog">目录管理</a></li>
                        </ul>
                    </li>

                    <li class="dropdown <c:if test="${currentTab=='user' || currentTab=='role' || currentTab=='permission' }">active</c:if>">
                        <a data-toggle="dropdown" class="dropdown-toggle" data-hover="dropdown">权限管理</a>
                        <ul class="dropdown-menu">
                            <li><a href="${ctx }/admin/user">用户角色管理</a></li>
                            <li class="divider"></li>
                            <li><a href="${ctx }/admin/role">角色管理</a></li>
                            <li class="divider"></li>
                            <li><a href="${ctx }/admin/permission">权限值管理</a></li>
                        </ul>
                    </li>

                    <li class="<c:if test="${currentTab == 'plan' }">active</c:if>">
                        <a href="${ctx }/admin/plan">计划管理</a>
                    </li>

                    <li class="<c:if test="${currentTab == 'system' }">active</c:if>">
                        <a href="${ctx }/admin/system">系统设置</a>
                    </li>

                    <li class="<c:if test="${currentTab == 'system' }">active</c:if>">
                        <a href="${ctx }/admin/druid">数据库监控</a>
                    </li>
                </ul>

                <ul class="nav pull-right">
                    <li><shiro:user><a>欢迎 <strong><shiro:principal/></strong> ！</a></shiro:user></li>
                    <li class="divider-vertical"></li>
                    <li><a href="${ctx }/admin/logout">退出</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="container" style="width:1380px;">
    <sitemesh:body/>

    <hr style="margin: 20px 0 10px;">

    <footer>
        <div class="copyright">
            &nbsp;&nbsp;&nbsp;&nbsp;
            <a target="_blank">Copyright © Hong.</a>
        </div>
    </footer>
</div>
<script src="${ctx }/static/bootstrap2/js/bootstrap-hover-dropdown.min.js"></script>
</body>
</html>