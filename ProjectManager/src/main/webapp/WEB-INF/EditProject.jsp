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
		<h1>Create a Project</h1>
		<form:form action="/projects/edit/${updateProject.getId()}" method="post"
			modelAttribute="updateProject">
			<div class="form-group form-inline ">
				<form:label path="title" class="">Project Title:</form:label>
				<form:errors path="title" class="text-danger" />
				<form:input path="title" value="${updateProject.getTitle()}" class="" />
			</div>
			<div class="form-group form-inline ">
				<form:label path="description" class="">Project Description:</form:label>
				<form:errors path="description" class="text-danger" />
				<form:textarea path="description" value="${updateProject.getDescription()}" class="" />
			</div>
			<div class="form-group form-inline ">
				<form:label path="dueDate" class="">Due Date:</form:label>
				<form:errors path="dueDate" class="text-danger" />
				<form:input type="date" path="dueDate" class="" min="${ date }" />
			</div>
			<form:button action="/dashboard" method="post">Cancel</form:button>
			<input type="submit" value="Submit" class="btn btn-primary" />
		</form:form>
	</div>
</body>
</html>