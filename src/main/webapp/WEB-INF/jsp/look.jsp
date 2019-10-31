<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>

<title>消息</title>
<meta charset="UTF-8">
</head>

<body>


	<table class="table table-bordered table-hover"  align="center">
		<thead>
			<tr bgcolor="#ff0">
				<th width="5%">编号</th>
				<th width="10%">名称</th>
				<th width="10%">邮箱</th>
				<th width="25%">主题</th>
				<th width="30%">信息</th>
				<th width="15%">时间</th>
				<th width="10%">操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="message" items="${messages}">
				<tr>
					<td>${message.id}</td>
					<td>${message.name}</td>
					<td>${message.email}</td>
					<td>${message.subject}</td>
					<td>${message.msg}</td>
					<td>${message.date}</td>
					<td><a href="${pageContext.request.contextPath}/delete.action?id=${message.id}">删除</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</body>
</html>
