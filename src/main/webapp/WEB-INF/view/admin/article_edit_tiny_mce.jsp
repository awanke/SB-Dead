<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<script src="${ctx}/static/tiny_mce/tiny_mce_src.js"></script>
<script type="text/javascript" src="${ctx }/static/uploadify/jquery.uploadify.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }/static/uploadify/uploadify.css">
<script type="text/javascript">
    tinyMCE.init({
        // General options
        relative_urls: false,
        mode: "exact",
        elements: "content",
        theme: "advanced",
        plugins: "autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave,visualblocks",

        // Theme options
        theme_advanced_buttons1: "bold,strikethrough,forecolor,formatselect,|,bullist,numlist,|,link,unlink,image,|,undo,redo,|,sub,sup,template,hr,removeformat,search,preview,code",
        theme_advanced_toolbar_location: "top",
        theme_advanced_toolbar_align: "left",
        theme_advanced_statusbar_location: "bottom",
        theme_advanced_resizing: true,

        // Example content CSS (should be your site CSS)
        //content_css : "css/content.css",

        // Drop lists for link/image/media/template dialogs
        template_external_list_url: "${ctx }/static/tiny_mce/plugins/template/list.jsp",
        // external_link_list_url : "lists/link_list.js",
        // external_image_list_url : "lists/image_list.js",
        // media_external_list_url : "lists/media_list.js",

        // Style formats
        style_formats: [
            {title: 'Bold text', inline: 'b'},
            {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
            {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
            {title: 'Example 1', inline: 'span', classes: 'example1'},
            {title: 'Example 2', inline: 'span', classes: 'example2'},
            {title: 'Table styles'},
            {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
        ],

        // Replace values for the template plugin
        template_replace_values: {
            username: "Some User",
            staffid: "991234"
        }
    });
</script>

<div class="content">
    <form class="form-horizontal" method="post" action="${ctx }/admin/article/save">
        <input type="hidden" name="id" value="${article.id}"/>

        <div class="control-group">
            <label class="control-label">标题</label>
            <div class="controls">
                <input type="text" class="span6" name="title" value="${article.title }">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">关键词</label>
            <div class="controls">
                <input type="text" class="span4" placeholder="用于seo,每个词之间使用英文逗号分隔" name="keywords"
                       value="${article.keywords }" onKeyUp="replaceChineseComma(this)">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">摘要</label>
            <div class="controls">
                <textarea rows="4" class="span6" name="description">${article.description }</textarea>
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
				<textarea rows="40" class="span9" name="content">
					<c:out value="${article.content }" escapeXml="true"/>
				</textarea>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">环境</label>
            <div class="controls">
                <input type="text" class="span4" placeholder="本代码测试通时的相关环境，版本等" name="environment"
                       value="${article.environment }" onKeyUp="replaceChineseComma(this)">
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
        $("#uploadFile").uploadify({
            'debug': false,
            'method': 'post',
            'file_post_name': 'uploadFile',
            'formData': {'articleId': '${article.id}'},
            'buttonText': '选择文件',
            'width': '80',
            'height': '25',
            'swf': '${ctx }/static/uploadify/uploadify.swf',
            'uploader': '${ctx }/admin/attachment/save;jsessionid=${pageContext.session.id}',
            'queueID': 'uploadFileQueue',
            'onUploadStart': function (file) {
                if ('${article.id}' == '0') {
                    alert('请先保存文章');
                    $('#uploadFile').uploadify('cancel');
                }
            },
            'onUploadSuccess': function (file, json, response) {
                var data = eval("(" + json + ")");
                var attachment = "";
                attachment += "<tr id='att" + data.id + "'>";
                attachment += "<td><a href='${ctx }/download/" + data.id + "'>" + data.name + "</a></td>";
                attachment += "<td align='right'>" + data.size + "</td>";
                attachment += "<td>" + data.downloads + "</td>";
                attachment += "<td>" + data.createDate + "</td>";
                attachment += "<td><a href='javascript:onDelete(" + data.id + ");'>删除</a></td></tr>";
                $("#attachments").append(attachment);
            }
        });
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