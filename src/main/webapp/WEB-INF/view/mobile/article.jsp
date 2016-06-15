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
    <link rel="shortcut icon" href="${ctx }/favicon.ico"/>
    <link rel="stylesheet" href="${ctx }/static/bootstrap2/css/bootstrap.min.css">
</head>
<body>
<div class="breadcrumb span3" style="margin: 5px 10px;">
    <blockquote>
        <p>${article.title }</p>
        <small>
            作者：${article.writer }，&nbsp;&nbsp;
            浏览量：${article.pageView }<br/>
            发表于：<fmt:formatDate value="${article.createDate }"/>，&nbsp;&nbsp;
            更新于：<font color="black"><fmt:formatDate value="${article.updateDate }"/></font>
        </small>
    </blockquote>
</div>

<c:if test="${not empty article.description}">
    <div class="breadcrumb span3" style="margin: 0px 10px;; background-color: #F5FCEE;">
            ${article.description }
    </div>
</c:if>

<div class="breadcrumb span3" style="margin: 5px 10px;">
    <c:if test="${not empty article.environment }">
        <strong>测试于：</strong>${article.environment }<br/><br/>
    </c:if>

    <div id="test-editormd-view">
        <textarea>${article.content }</textarea>
    </div>

    <c:if test="${not empty attachments }">
        <strong>下载：</strong><br/>
        <div class="alert alert-success">
            <table>
                <c:forEach items="${attachments }" var="attachment">
                    <tr>
                        <td><a href="${ctx }/download/${attachment.id }">${attachment.name }</a></td>
                        <td align="right">&nbsp;&nbsp;${attachment.size }</td>
                        <td class="span1"></td>
                        <td>&nbsp;&nbsp;下载${attachment.downloads }次</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </c:if>
</div>

<c:if test="${not empty relativeArticles}">
    <div class="breadcrumb span3" style="margin-left: 10px; margin-bottom:5px">
        <strong>相关文章：</strong>
        <ul class="unstyled">
            <c:forEach items="${relativeArticles }" var="data">
                <li>
                    <a href="${ctx }/mobile/article/${data.id }.html" target="_blank">${data.title }</a>
                </li>
            </c:forEach>
        </ul>
    </div>
</c:if>

<div class="breadcrumb span3" style="margin-left: 10px; margin-bottom:0px">
    <span> 上一篇：
        <c:if test="${empty preArticle }">无</c:if>
        <c:if test="${not empty preArticle }">
            <a href="${ctx }/mobile/article/${preArticle.id}.html" target="_blank">${preArticle.title}</a>
        </c:if>
    </span>
    <br/>
    <span> 下一篇：
        <c:if test="${empty nextArticle }">无</c:if>
        <c:if test="${not empty nextArticle }">
            <a href="${ctx }/mobile/article/${nextArticle.id}.html" target="_blank">${nextArticle.title}</a>
        </c:if>
    </span>
</div>

<div class="bdsharebuttonbox" style="margin-left: 10px">
    <a href="#" class="bds_more" data-cmd="more"></a>
    <a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
    <a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
    <a href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a>
    <a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
    <a href="#" class="bds_youdao" data-cmd="youdao" title="分享到有道云笔记"></a>
    <a href="#" class="bds_fbook" data-cmd="fbook" title="分享到Facebook"></a>
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

<script>
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
</body>
</html>



