<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>


<script type="text/javascript" src="${ctx }/static/uploadify/jquery.uploadify.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }/static/uploadify/uploadify.css">

<script type="text/javascript" src="${ctx }/static/wangEditor/js/wangEditor.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }/static/wangEditor/css/wangEditor.min.css">

<div class="content">
    <form class="form-horizontal" method="post" action="${ctx }/admin/article/save">
        <input type="hidden" name="id" value="${article.id}"/>

        <div class="control-group">
            <label class="control-label">标题</label>
            <div class="controls">
                <input type="text" class="span9" name="title" value="${article.title }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">关键词</label>
            <div class="controls">
                <input type="text" class="span9" placeholder="用于seo,每个词之间使用英文逗号分隔" name="keywords"
                       value="${article.keywords }" onKeyUp="replaceChineseComma(this)">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">摘要</label>
            <div class="controls">
                <textarea rows="4" class="span9" name="description">${article.description }</textarea>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">来源</label>
            <div class="controls">
                <select class="span3" name="source">
                    <c:forEach items="${SOURCE_MAP}" var="item">
                        <option value="${item.key}"
                                <c:if test="${article.source==item.key }">selected</c:if>>${item.value}</option>
                    </c:forEach>
                </select>
                &nbsp; 目录 &nbsp;
                <select class="span3" name="catalogId">
                    <c:forEach items="${catalogList.items }" var="data">
                        <option value="${data.id}" <c:if test="${article.catalogId==data.id }">selected</c:if>>
                            &nbsp;${data.name }</option>
                        <c:forEach items="${data.items }" var="data2">
                            <option value="${data2.id}" <c:if test="${article.catalogId==data2.id }">selected</c:if>>
                                &nbsp;&nbsp;&nbsp;${data2.name }</option>
                            <c:forEach items="${data2.items }" var="data3">
                                <option value="${data3.id}"
                                        <c:if test="${article.catalogId==data3.id }">selected</c:if>>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${data3.name }</option>
                            </c:forEach>
                        </c:forEach>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">正文</label>
            <div class="controls">
              <textarea rows="40" class="span9" name="content" id="content">
                    <c:out value="${article.content }" escapeXml="true"/>
              </textarea>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">环境</label>
            <div class="controls">
                <select class="span8" name="environment">
                    <option value="wangEditor">wangEditor</option>
                    <option value="markdown">markdown</option>
                    <option value="其他">其他</option>
                </select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">附件</label>
            <div class="controls">
                <table class="table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th>文件</th>
                        <th>大小</th>
                        <th>下载量</th>
                        <th>上传时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="attachments"></tbody>
                </table>
                <input type="file" id="uploadFile" name="uploadFile"/>
                <div id="uploadFileQueue"></div>
            </div>
        </div>

        <div class="control-group">
            <div class="controls">
                <input type="submit" class="btn" value="保存">
            </div>
        </div>
    </form>
</div>

<script src="${ctx}/static/js/common.js"></script>
<script type="text/javascript">
    // 上传附件
    $(function () {
        var editor = new wangEditor('content');
        editor.config.uploadImgUrl = '${ctx }/admin/attachment/wangEditorSavePic';
        editor.config.uploadParams = {
            token: 'abcdefg',
            user: 'wangfupeng1988'
        };
        editor.config.uploadHeaders = {
            'Accept' : 'text/x-json'
        };
        editor.config.hideLinkImg = true;
        editor.config.uploadImgFileName = 'wangEditor-image-file'
        editor.create();
    });

    // 附件列表
    $(function () {
        $.ajax({
            type: "POST",
            url: "${ctx}/admin/attachment",
            data: "articleId=${article.id}",
            dataType: "json",
            success: function (data) {
                var attachments = "";
                for (var i = 0; i < data.length; i++) {
                    attachments += "<tr id='att" + data[i].id + "'>";
                    attachments += "<td><a href='${ctx }/download/" + data[i].id + "'>" + data[i].name + "</a></td>";
                    attachments += "<td align='right'>" + data[i].size + "</td>";
                    attachments += "<td>" + data[i].downloads + "</td>";
                    attachments += "<td>" + data[i].createDate + "</td>";
                    attachments += "<td><a href='javascript:onDelete(" + data[i].id + ");'>删除</a></td></tr>";
                }
                $("#attachments").append(attachments);
            }
        });
    });

    // 删除附件
    function onDelete(id) {
        if (!confirm('确定删除么？')) return;
        $.ajax({
            type: "POST",
            url: "${ctx}/admin/attachment/delete",
            data: "id=" + id,
            success: function (data) {
                // 必须有json返回才会执行
                $("#att" + id).remove();
            }
        });
    }
</script>