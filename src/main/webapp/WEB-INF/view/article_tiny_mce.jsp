<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="breadcrumb pull-left" style="width:840px;">
    <blockquote>
        <p>${article.title }</p>
        <small>
            作者：<a href="${baseURL}${ctx }/articles/writer/${article.writer }">${article.writer }</a>，&nbsp;&nbsp;

            发表于：<fmt:formatDate value="${article.createDate }" pattern="yyyy-MM-dd"/>，&nbsp;&nbsp;

            更新于：<font color="black"><fmt:formatDate value="${article.updateDate }" pattern="yyyy-MM-dd"/></font>，&nbsp;&nbsp;

            浏览量：<span id="pageView">${article.pageView }</span>
        </small>
    </blockquote>
    <hr/>

    <c:if test="${article.description}">
        ${article.description }
    </c:if>

    <c:if test="${article.environment}">
        <strong>测试于：</strong>${article.environment }<br/><br/>
    </c:if>

    <c:out value="${article.content}" escapeXml="false" />

    <div id="attachments"></div>
    <hr/>

    <div class="bdsharebuttonbox" style="margin-left: 10px">
        <a href="#" class="bds_more" data-cmd="more"></a>
        <a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
        <a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
        <a href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a>
        <a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
        <a href="#" class="bds_youdao" data-cmd="youdao" title="分享到有道云笔记"></a>
        <a href="#" class="bds_fbook" data-cmd="fbook" title="分享到Facebook"></a>
    </div>
</div>

<c:if test="${not empty relativeArticles}">
    <div class="pull-left breadcrumb" style="width:840px;">
        <strong>相关文章：</strong>
        <ul class="unstyled">
            <c:forEach items="${relativeArticles }" var="data">
                <li>
                    <a href="${data.id }.html" target="_blank">${data.title }</a>
                </li>
            </c:forEach>
        </ul>
    </div>
</c:if>

<div class="pull-left" style="width:840px;">
    <c:if test="${not empty preArticle}">
        <span> 上一篇：
            <a href="${preArticle.id}.html">${preArticle.title }</a>
        </span>
    </c:if>
    <br/>
    <c:if test="${not empty nextArticle}">
        <span> 下一篇：
            <a href="${nextArticle.id}.html">${nextArticle.title }</a>
        </span>
    </c:if>
</div>

<script type="text/javascript">
    window._bd_share_config = {
        "common": {
            "bdSnsKey": {},
            "bdText": "",
            "bdMini": "2",
            "bdMiniList": false,
            "bdPic": "",
            "bdStyle": "1",
            "bdSize": "24"
        },
        "share": {},
        "image": {
            "viewList": ["qzone", "tsina", "sqq", "weixin", "youdao", "fbook"],
            "viewText": "分享到：",
            "viewSize": "24"
        },
        "selectShare": {
            "bdContainerClass": null,
            "bdSelectMiniList": ["qzone", "tsina", "sqq", "weixin", "youdao", "fbook"]
        }
    };
    with (document)0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];
</script>