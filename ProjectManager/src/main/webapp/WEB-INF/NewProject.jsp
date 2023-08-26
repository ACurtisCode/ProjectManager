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
		<h1 id="pageGreeting">Create a Project</h1>
		<div class="card" id="projectCard">
			<div class="card-body">
			  <h4 class="card-title">Project</h4>
			  <h6 class="card-subtitle mb-2 text-muted">Enter your project details</h6>
			  <p class="card-text">
		<table class="projectCardTable">
			<tbody>
				<tr class="projectRow">
		<form:form action="/project/add" method="post"
			modelAttribute="newProject" class="submit-box">
			<td><div class="form-group form-inline ">
				<form:label path="title" class="">Project Title:</form:label>
				<form:errors path="title" class="text-danger" />
				<form:input path="title" class="" />
			</div></td>
			<td><div class="form-group form-inline ">
				<form:label path="description" class="">Project Description:</form:label>
				<form:errors path="description" class="text-danger" />
				<form:textarea path="description" class="" />
			</div></td>
			<td><div class="form-group form-inline ">
				<form:label path="dueDate" class="">Due Date:</form:label>
				<form:errors path="dueDate" class="text-danger" />
				<form:input type="date" path="dueDate" class="" min="${ date }" />
			</div></td>
			<td><input type="submit" value="Submit" class="btn btn-primary" /></td>
		</form:form>
		</tr>
		</tbody>
		</table>
	</div>
	</div>
	</div>
</body>
</html>