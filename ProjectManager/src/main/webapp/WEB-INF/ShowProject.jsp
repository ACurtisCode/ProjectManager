<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/main.css">
<!-- change to match your file/naming structure -->
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<ul class="nav">
			<li class="nav-item" id="pageTitle">Project Manager</li>
			<li class="nav-item">
			  <a class="nav-link active" href="/dashboard">Back</a>
			</li>
		  </ul>
		<div>
			<h1>Project Details</h1>
		</div>
		<div class="card" style="padding: 15px;">
			<table class="table">
				<tbody>
					<tr>
						<td>Project:</td>
						<td>${ project.getTitle() }</td>
					</tr>
					<tr>
						<td>Description:</td>
						<td>${ project.getDescription() }</td>
					</tr>
					<tr>
						<td>Due Date:</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd"
								value="${project.getDueDate()}" /></td>
					</tr>
				</tbody>
			</table>
			<a href="/projects/${ project.getId() }/tasks">See tasks!</a>
		</div>

		<c:if test="${ project.getManager() == user }">
			<form:form action="/delete/${ project.getId() }" method="post">
				<input type="submit" value="Delete" />
			</form:form>
		</c:if>
	</div>
</body>
</html>