<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <c:choose>
        <c:when test="${not empty article.keywords}">
            <c:set var="keywords" value="${article.keywords}"></c:set>
            <c:set var="description" value="${article.description}"></c:set>
        </c:when>
        <c:otherwise>
            <c:set var="keywords" value="极限编程"></c:set>
            <c:set var="description" value="极限编程"></c:set>
        </c:otherwise>
    </c:choose>
    <meta name="keywords" content="${keywords }"/>
    <meta name="description" content="${description }"/>
    <title>${article.title }<c:if test="${not empty article.title}">_</c:if>极限编程</title>

    <link rel="shortcut icon" href="${ctx }/favicon.ico"/>
    <link rel="stylesheet" href="${ctx }/static/css/basic.css">
    <link rel="stylesheet" href="${ctx }/static/bootstrap2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx }/static/jquery/blitzer/jquery-ui.min.css">

    <script src="${ctx }/static/jquery/jquery-1.10.2.min.js"></script>
    <script src="${ctx }/static/bootstrap2/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
    <div class="content">
        <h1 class="transform">
            <a>极限编程</a>
        </h1>

        <form class="navbar-form pull-right" style="margin-top: 20px;" id="kwform" action="${ctx }/">
            <div class="input-append">
                <input type="text" class="span4" placeholder="输入关键词查询" id="kw" name="kw" value="${page.conditions.kw }">
                <button type="submit" class="btn">搜索</button>
            </div>
        </form>
    </div>
</div>

<div class="container" style="width:1180px;">
    <div class="content">
        <div class="row">
            <div class="navbar navbar-inverse">
                <div class="navbar-inner">
                    <div class="container">
                        <div class="nav-collapse collapse">
                            <ul class="nav" style="height:40px;">
                                <li>
                                    <a href="${ctx }/"><span>首页</span></a>
                                </li>
                                <c:forEach items="${catalogList.items }" var="data">
                                    <li class="dropdown">
                                        <a class="dropdown-toggle" href="${ctx }?catalog=${data.id}"
                                           data-hover="dropdown">${data.name }
                                        </a>
                                        <c:if test="${not empty data.items }">
                                            <ul class="dropdown-menu">
                                                <c:forEach items="${data.items }" var="data2">
                                                    <li class="<c:if test="${not empty data2.items }">dropdown-submenu</c:if>">
                                                        <a href="${ctx }?catalog=${data2.id}">${data2.name }</a>
                                                        <ul class="dropdown-menu">
                                                            <c:forEach items="${data2.items }" var="data3">
                                                                <li class="<c:if test="${not empty data3.items }">dropdown-submenu</c:if>">
                                                                    <a href="${ctx }?catalog=${data3.id}">${data3.name }</a>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:forEach>
                                <li>
                                    <a href="${ctx }/aboutme"><span>关于</span></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="span3 breadcrumb pull-right" style="margin-bottom: 0px; margin-left: 0px; padding: 0px;">
                <div style="padding-top:15px;padding-left:15px;">
                    <p>关注大数据,分布式,机器学习,数据挖掘,搜索
                    <p>github <a target="_blank" href="https://github.com/hong0220">https://github.com/hong0220<a/>
                    <p>qq群 <a target="_blank"
                              href="http://shang.qq.com/wpa/qunwpa?idkey=d5dec4e45fe3843d5c0fe8ca5c77aae2e0cf19df72aa4ae26500c31ff63d2735"><img
                            border="0" src="http://pub.idqqimg.com/wpa/images/group.png" alt="Java技术交流群"
                            title="Java技术交流群"></a>
                    <p>签名:自己选择的路，跪着也要走完
                </div>
                <%--<%@ include file="/view/include/marquee.jsp" %>--%>
                <hr>

                <strong>&nbsp;分类目录</strong>
                <select id="catalogId" style="width: 230px">
                    <option>选择目录</option>
                    <c:forEach items="${catalogList.items }" var="data">
                        <option value="${data.id}">${data.name } &nbsp; (${data.sum })</option>
                        <c:forEach items="${data.items }" var="data2">
                            <option value="${data2.id}">&nbsp;&nbsp;&nbsp;${data2.name } &nbsp; (${data2.sum })</option>
                            <c:forEach items="${data2.items }" var="data3">
                                <option value="${data3.id}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${data3.name } &nbsp;
                                    (${data3.sum })
                                </option>
                            </c:forEach>
                        </c:forEach>
                    </c:forEach>
                </select>
                <hr>

                <%--<div>--%>
                    <%--<iframe width="100%" height="100" class="share_self" frameborder="0" scrolling="no"--%>
                            <%--src="http://widget.weibo.com/weiboshow/index.php?language=&width=0&height=550&fansRow=2&ptype=1&speed=0&skin=1&isTitle=1&noborder=0&isWeibo=0&isFans=0&uid=2199178482&verifier=607c53d8&dpc=1"></iframe>--%>
                <%--</div>--%>
                <%--<hr>--%>

                <div>
                    <embed src="http://www.xiami.com/widget/44213257_3621488,174652,_235_346_FF8719_494949_0/multiPlayer.swf"
                           type="application/x-shockwave-flash" width="300" height="200" wmode="opaque"></embed>
                </div>
                <hr>

                <strong>&nbsp;文章归档</strong>
                <select id="articleId" style="width: 230px">
                    <option>选择月份</option>
                    <c:forEach items="${monthStat }" var="item">
                        <option>${item.month } (${item.count })</option>
                    </c:forEach>
                </select>
                <hr>

                <div id="tagcloud">
                    <c:forEach items="${catalogList.items }" var="data">
                        <a href="#">${data.name }</a>
                        <c:forEach items="${data.items }" var="data2">
                            <a href="#">${data2.name }</a>
                            <c:forEach items="${data2.items }" var="data3">
                                <a href="#">${data3.name }</a>
                            </c:forEach>
                        </c:forEach>
                    </c:forEach>
                </div>
                <hr>
            </div>

            <sitemesh:body/>
        </div>
    </div>

    <hr style="margin: 20px 0 10px;">

    <footer>
        <div class="copyright">
            &nbsp;&nbsp;&nbsp;&nbsp;
            <a target="_blank">Copyright © 极限编程.</a>
        </div>
    </footer>
</div>

<script src="${ctx }/static/jquery/jquery-ui.js"></script>
<script src="${ctx }/static/jquery/jquery.windstagball.js"></script>
<script src="${ctx }/static/bootstrap2/js/bootstrap-hover-dropdown.min.js"></script>
<script type="text/javascript">
    $(function () {
        $("#tagcloud").windstagball({
            radius: 110,
            speed: 3
        });

        var catalogDropdown = document.getElementById("catalogId");

        function oncatalogChange() {
            if (catalogDropdown.options[catalogDropdown.selectedIndex].value > 0) {
                location.href = "${ctx }?catalog=" + catalogDropdown.options[catalogDropdown.selectedIndex].value;
            }
        }

        catalogDropdown.onchange = oncatalogChange;

        // 智能搜索提示
        $("#kw").autocomplete({
            source: "${ctx }/suggest"
        });
    });
</script>
</body>
</html>
