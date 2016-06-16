<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!-- 跑马灯(Marquee),适合图片和文字,比html的marquee标签效果更加流畅 -->
<style type="text/css">
    #mar-tab {
        background: #fff;
        overflow: hidden;
        border: 1px #000;
        width: 280px;
        margin-left: 10px;
    }

    /* 内容文字可换成图片*/
    #mar-tab img {
        border: 3px solid #F2F2F2;
    }

    #mar-intab {
        float: left;
        width: 1000%;
    }

    #mar-tab1 {
        float: left;
    }

    #mar-tab2 {
        float: left;
    }

</style>
<div id="mar-tab">
    <div id="mar-intab">
        <div id="mar-tab1">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            自己选择的路，跪着也要走完
        </div>
        <div id="mar-tab2"></div>
    </div>
</div>
<script>
    // 数值越大,滚动越慢
    var speed = 30;
    var tab = document.getElementById("mar-tab");
    var tab1 = document.getElementById("mar-tab1");
    var tab2 = document.getElementById("mar-tab2");
    tab2.innerHTML = tab1.innerHTML;
    function Marquee() {
        if (tab2.offsetWidth - tab.scrollLeft <= 0)
            tab.scrollLeft -= tab1.offsetWidth
        else {
            tab.scrollLeft++;
        }
    }
    var MyMar = setInterval(Marquee, speed);
    tab.onmouseover = function () {
        clearInterval(MyMar);
    };
    tab.onmouseout = function () {
        MyMar = setInterval(Marquee, speed);
    };
</script>