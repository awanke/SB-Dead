<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

var tinyMCETemplateList = [
	["Template Normal", "${ctx }/static/tiny_mce/plugins/template/templates/normal.htm", "一般文章通用"],
    ["Template Exception", "${ctx }/static/tiny_mce/plugins/template/templates/exception.htm", "异常类文章使用"],
    ["Template Copyright", "${ctx }/static/tiny_mce/plugins/template/templates/copyright.htm", "转文版权使用"],
    ["Template Serie", "${ctx }/static/tiny_mce/plugins/template/templates/serie.htm", "系列文章使用"]
];
