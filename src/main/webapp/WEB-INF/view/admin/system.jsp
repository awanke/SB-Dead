<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="content">
    <strong>重建Solr索引</strong>
    <form class="breadcrumb form-search">
        <select id="entity" class="span1">
            <option value="ENTITY_ARTICLE">文章</option>
            <option value="ENTITY_SEARCHLOG">搜索词</option>
        </select>
        <input type="button" class="btn" id="buildIndex" value="确定">
        <div id="buildIndexStatus" style="height:60px">索引重建进度状态</div>
    </form>

    <strong>一键静态化所有页面</strong>
    <form class="breadcrumb form-search">
        <input type="hidden" id="proInp" value="0">
        <input type="button" class="btn" id="staticAll" value="确定">&nbsp;&nbsp;
        <span id="staticAllStatus"></span>
        <div id="progress" class="progress progress-striped active"
             style="width: 60%; margin-bottom: 0px; margin-top: 10px;">
            <div class="bar" id="bar" style="width: 0%;"></div>
        </div>
        进度:<span id="proSp" style="color: blue; margin-left: 10px;">0%</span>
    </form>

    <strong>静态化指定页面</strong>
    <form class="breadcrumb form-search">
        <label>文章id:&nbsp;</label><input type="text" class="span1" id="articleid">&nbsp;&nbsp;
        <input type="button" class="btn" id="staticOne" value="确定 ">&nbsp;&nbsp;
        <span id="staticOneStatus"></span>
    </form>
</div>

<script type="text/javascript">
    var timeID = null;

    function doTimer() {
        timeID = setInterval("showProgress()", 3000);
    }

    function showProgress() {
        $.ajax({
            url: "${ctx}/admin/static/showProgress",
            type: "POST",
            success: function (data) {
                var d = data;
                var now = $("#proInp").val();
                if (d > now) {
                    $("#bar").css("width", d + "%");
                    $("#proSp").html(d + "%");
                    $("#proInp").val(d);
                }
            },
            error: function () {
                $("#proInp").val("0");
                //清楚定时器
                window.clearInterval(timeID);
                alert("请求服务器失败！");
            }
        });
    }

    $(function () {
        $('#staticAll').bind('click', function () {
            doTimer();

            $.ajax({
                url: "${ctx}/admin/static/staticAll",
                type: "POST",
                success: function (data) {
                    //清楚定时器
                    window.clearInterval(timeID);
                    var d = data;
                    if (d.indexOf('未授权操作', 0) > -1) {
                        $('#staticAllStatus').html("未授权操作！");
                        return;
                    } else {
                        $("#bar").css("width", "100%");
                        $("#proSp").html("100%");
                        $("#proInp").val("0");
                        alert(d);
                    }
                },
                error: function () {
                    $("#proInp").val("0");
                    window.clearInterval(timeID); //清楚定时器
                    alert("请求服务器失败！");
                }
            });
        });

        $('#staticOne').bind('click', function () {
            if ($("#articleid").val() == '' || $("#articleid").val() == null) {
                alert("请输入文章id！");
            } else if ($("#articleid").val() != '' && $("#articleid").val() != null
                    && isNaN($("#articleid").val())) {
                alert("请输入数字！");
            } else {
                $.ajax({
                    url: "${ctx}/admin/static/staticOne",
                    data: {
                        "articleid": $("#articleid").val(),
                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        var d = data;
                        if (d.indexOf('未授权操作', 0) > -1) {
                            $('#staticOneStatus').html("未授权操作！");
                            return;
                        } else {
                            alert(d);
                        }
                    },
                    error: function () {
                        alert("请求服务器失败！");
                    }
                });
            }
        });

        // 给重建索引按钮绑定点击事件
        $('#buildIndex').bind('click', function () {
            var entity = $("#entity").val();
            var html = $.ajax({
                url: "${ctx}/admin/system/rebuildIndex?entity="
                + entity,
                async: false
            }).responseText;

            if (html.indexOf('未授权操作', 0) > -1) {
                $('#buildIndexStatus').html("未授权操作！");
                return;
            }

            // 点击重建索引按钮显示索引重建进度
            clearInterval(interval); //清理一次，下面再执行
            var message = "";
            var interval = "";
            interval = setInterval(
                    function () {
                        $.ajax({
                            url: "${ctx}/admin/system/checkBuildStatus?entity="
                            + entity,
                            dataType: "json",
                            success: function (data) {
                                message = data;
                            }
                        });

                        // 索引重建完毕，需要去掉定时器
                        if (message.substring(0, 4) == 'idle') {
                            clearInterval(interval);
                        }

                        $('#buildIndexStatus').html(message);

                    }, 500);
        });
    });
</script>