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
			  <a class="nav-link active" href="/projects/new">New Project</a>
			</li>
			<li class="nav-item">
			  <a class="nav-link" href="/logout">Logout</a>
			</li>
		  </ul>
		<div id="pageGreeting">
			<h1>Welcome ${ user.getUserName() }</h1>
		</div>
		<div>
			<h4>All projects</h4>
			<table class="table projectTable">
				<thead class="thead-light">
					<tr>
						<th>Project</th>
						<th>Team Lead</th>
						<th>Due Date</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="project" items="${ freeProjects }">
						<tr>
							<td><a href="/projects/${ project.getId() }">${ project.getTitle() }</a></td>
							<td>${ project.getManager().getUserName() }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${project.getDueDate()}" /></td>
							<td><a href="/projects/join/${ project.getId() }">Join Team</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div>
			<h4>Your Projects</h4>
			<table class="table projectTable">
				<thead class="thead-light">
					<tr>
						<th>Project</th>
						<th>Team Lead</th>
						<th>Due Date</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="project" items="${ ownedProjects }">
						<tr>
							<td><a href="/projects/${ project.getId() }">${ project.getTitle() }</a></td>
							<td>${ project.getManager().getUserName() }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${project.getDueDate()}" /></td>
									<td><c:if test="${project.getManager()==user}">
								<a href="/projects/edit/${project.getId()}">Edit</a>
							</c:if>
							<c:if test="${ project.getManager() == user }">
								<form:form action="/delete/${ project.getId() }" method="post">
									<input class="btn btn-danger" type="submit" value="Delete" />
								</form:form>
							</c:if></td>
							<c:if test="${project.getManager()!=user}">
								<td><a href="/projects/leave/${ project.getId() }">Leave team</a></td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

	</div>
</body>
</html>
