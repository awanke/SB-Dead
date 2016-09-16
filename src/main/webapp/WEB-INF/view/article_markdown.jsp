<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" type="text/css" href="${ctx }/static/editor_md/css/editormd.preview.css">

<div class="breadcrumb pull-left" style="width:840px;">
    <blockquote>
        <p>${article.title }</p>
        <small>
            作者：${article.writer },&nbsp;&nbsp;

            发表于：<fmt:formatDate value="${article.createDate }" pattern="yyyy-MM-dd"/>,&nbsp;&nbsp;

            更新于：<font color="black"><fmt:formatDate value="${article.updateDate }" pattern="yyyy-MM-dd"/></font>,&nbsp;&nbsp;

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

    <div id="test-editormd-view" style="width:815px;">
        <textarea><c:out value="${article.content}" escapeXml="true" /></textarea>
    </div>

    <div id="attachments"></div>
    <hr/>

    <div class="bdsharebuttonbox" style="margin-left: 10px">
        <a href="#" class="bds_more" data-cmd="more"></a>
        <a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
        <a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a>
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

<script src="${ctx}/static/jquery/jquery-1.10.2.min.js"></script>
<script src="${ctx}/static/editor_md/lib/marked.min.js"></script>
<script src="${ctx}/static/editor_md/lib/prettify.min.js"></script>
<script src="${ctx}/static/editor_md/lib/raphael.min.js"></script>
<script src="${ctx}/static/editor_md/lib/underscore.min.js"></script>
<script src="${ctx}/static/editor_md/lib/sequence-diagram.min.js"></script>
<script src="${ctx}/static/editor_md/lib/flowchart.min.js"></script>
<script src="${ctx}/static/editor_md/lib/jquery.flowchart.min.js"></script>
<script src="${ctx}/static/editor_md/js/editormd.min.js"></script>

<script type="text/javascript">
    $(function () {
        var testEditormdView2 = editormd.markdownToHTML("test-editormd-view", {
            htmlDecode: "style,script,iframe",  // you can filter tags decode
            emoji: true,
            taskList: true,
            tex: true,  // 默认不解析
            flowChart: true,  // 默认不解析
            sequenceDiagram: true,  // 默认不解析
        });
    });

    window._bd_share_config = {
        "common": {
            "bdSnsKey": {},
            "bdText": "",
            "bdMini": "2",
            "bdMiniList": false,
            "bdPic": "",
            "bdStyle": "1",
            "bdSize": "24"
        }, "share": {}
    };
    with (document)0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];</script>
</script>