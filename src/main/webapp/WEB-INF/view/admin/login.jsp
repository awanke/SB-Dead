<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
    <title>后台管理登录</title>
    <link rel="stylesheet" href="${ctx}/static/bootstrap2/css/bootstrap.min.css"/>
</head>
<body>
<div class="container" style="margin-top: 100px;">
    <form name="login-form" method="post" action="${ctx}/admin/login" style="width: 300px; margin: 0px auto;">
        <fieldset>
            <legend>系统登录</legend>

            <label>用户名</label>
            <input type="text" name="username"
                   class="span3 required" maxlength="30" value="admin"
                   required="required"/>

            <label>密 码</label>
            <input type="password"
                   name="password" class="span3 required" maxlength="30"
                   value="123" required="required"/>

            <div id="error" style="color: #d00; font-size: 18px; padding: 5px 0;">${loginerror}</div>

            <input type="button" id="btn-submit" onclick="login();"
                   class="btn btn-primary" value="登陆"/>
            <hr/>
            社交账号登陆<br>

            <a href="${ctx}/admin/beforeLogin4Sina">
                <img alt="使用新浪微博登陆" title="使用新浪微博登陆"
                     src="${ctx }/static/image/sina30.png" width="30" height="30"/>
            </a>
            <a href="${ctx}/admin/beforeLogin4qq">
                <img alt="使用qq登陆" title="使用qq登陆"
                     src="${ctx }/static/image/qq30.png" width="30" height="30"/>
            </a>
        </fieldset>
    </form>
</div>

<script type="text/javascript">
    window['login-form'].username.focus();
    function login() {
        document.getElementById('error').innerHTML = '';
        var u_txt = window['login-form'].username;
        var p_txt = window['login-form'].password;
        if (!/\S/.test(u_txt.value)) {
            document.getElementById('error').innerHTML = '您没有输入用户名！';
            u_txt.focus();
            return;
        }
        if (!/\S/.test(p_txt.value)) {
            document.getElementById('error').innerHTML = '请输入密码后再登陆！';
            p_txt.focus();
            return;
        }
        window['login-form'].submit();
    }

    /**
     *回车键监听
     */
    document.onkeydown = function (e) {
        var ev = document.all ? window.event : e;
        if (ev.keyCode == 13) {
            document.getElementById('btn-submit').click();
        }
    };
</script>
</body>
</html>
