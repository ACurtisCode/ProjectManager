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
		<div>
			<h1>Project: ${ project.getTitle() }</h1>
			<a href="/dashboard">Back to dashboard</a>
		</div>

		<h4>Project Lead: ${ project.getManager().getUserName() }</h4>
		<div class="card" style="padding: 15px; margin-bottom: 20px;">
		<form:form action="/add/task/${ project.getId() }" method="post" modelAttribute="task">
			<table class="table">
				<tbody>
					<tr>
						<td><form:label path="mission">Add a task ticket for this team:</form:label>
						<form:errors path="mission" class="text-danger"/></td>
						<td><form:textarea path="mission"/></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" value="Submit"/>
		</form:form>
	</div>
		<ul>
		<c:forEach var="task" items="${ taskList }">
		<li><h4>Added by ${ task.getTaskOwner().getUserName() } on ${ task.getCreatedAt() }</h4>
		<p>${ task.getMission() }</p></li>
		</c:forEach>
	</ul>
	</div>
</body>
</html>