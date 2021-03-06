<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="naviTab" value="filter" scope="request" />
<t:base>

<jsp:attribute name="styles">
<link href="<c:url value="/webjars/bootstrap-datepicker/1.2.0/css/datepicker.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/filter.css" />" rel="stylesheet">
</jsp:attribute>

<jsp:attribute name="scripts">
<script type="text/javascript" src="<c:url value="/webjars/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.js" />"></script>
<script type="text/javascript" src="<c:url value="/webjars/bootstrap-datepicker/1.2.0/js/locales/bootstrap-datepicker.zh-CN.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/filter.js" />"></script>
<script type="text/javascript">
new Filter({
    contextPath: '${pageContext.request.contextPath}'
});
</script>
</jsp:attribute>

<jsp:body>
<form class="form-inline filter-form" method="get" action="" id="frmFilter">
  <input type="hidden" name="page" value="${page}">
  <input type="text" name="date" placeholder="日期" class="input-medium" value="${date}">
  <select name="os" class="input-medium">
    <option value="">系统</option>
    <option value="ios" ${os == 'ios' ? 'selected="selected"' : ''}>iOS</option>
    <option value="android" ${os == 'android' ? 'selected="selected"' : ''}>Android</option>
  </select>
  <select name="version" class="input-medium">
    <option value="">版本</option>
    <c:forEach var="key" items="${versionList}">
    <option value="${key}" ${key == version ? 'selected="selected"' : ''}>${key}</option>
    </c:forEach>
  </select>
  <select name="channel" class="input-medium">
    <option value="">渠道</option>
    <c:forEach var="key" items="${channelList}">
    <option value="${key}" ${key == channel ? 'selected="selected"' : ''}>${key}</option>
    </c:forEach>
  </select>
  <input type="submit" value="筛选" class="btn" id="btnFilter">
</form>

<table class="table table-condensed table-striped">
  <tr>
    <th>Unique ID</th>
    <th>Page Name</th>
    <th>Action Name</th>
    <th>Client Time</th>
  </tr>
  <c:forEach var="actionLog" items="${actionLogList}">
  <tr>
    <td><a href="<c:url value="/user?date=${date}&uniqid=${actionLog.uniqueId}" />">${actionLog.uniqueId}</a></td>
    <td>${empty pageLkp[actionLog.pageId] ? actionLog.pageId : pageLkp[actionLog.pageId]}</td>
    <td>${empty actionLkp[actionLog.actionId] ? actionLog.actionId : actionLkp[actionLog.actionId]}</td>
    <td>${actionLog.logTime}</td>
  </tr>
  </c:forEach>
</table>

<c:if test="${totalPage >= 1}">

<div class="pagination pagination-small pagination-centered">
  <ul>
    <li ${page == 1 ? 'class="disabled"' : ''}><a href="javascript:void(0)">&lt;&lt;</a></li>
    <li ${page == 1 ? 'class="disabled"' : ''}><a href="javascript:void(0)" page="${page > 1 ? (page - 1) : 1}">&lt;</a></li>
    <c:forEach var="i" begin="${(page - 4 >= 1) ? (page - 4) : 1}" end="${page - 1}">
    <li><a href="javascript:void(0)" page="${i}">${i}</a></li>
    </c:forEach>
    <li class="active"><a href="javascript:void(0)" page="${page}">${page}</a></li>
    <c:forEach var="i" begin="${page + 1}" end="${(page + 4 <= totalPage) ? (page + 4) : totalPage}">
    <li><a href="javascript:void(0)" page="${i}">${i}</a></li>
    </c:forEach>
    <li ${page == totalPage ? 'class="disabled"' : ''}><a href="javascript:void(0)" page="${page < totalPage ? (page + 1) : totalPage}">&gt;</a></li>
    <li ${page == totalPage ? 'class="disabled"' : ''}><a href="javascript:void(0)" page="${totalPage}">&gt;&gt;</a></li>
  </ul>
</div>

</c:if>

</jsp:body>

</t:base>
