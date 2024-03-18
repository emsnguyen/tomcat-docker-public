
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Freelancer - Start Bootstrap Theme</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="./resources/assets/favicon.ico" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<!-- Đường dẫn tới Font Awesome CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
	integrity="sha512-xMHDyt2KmjN48bI7qzwe3AznZMw03KCH1Kt7eMP4OL9y2H9z2+P58jOVUa4+8wM9Ex0W2I3DzMc20SjQdEM/9A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/251df2663c.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&display=swap"
	rel="stylesheet">
<!-- Core theme CSS (includes Bootstrap)-->
<link href="../resources/css/index-styles.css" rel="stylesheet" />
<link href="resources/css/index-styles.css" rel="stylesheet" />
</head>
<body id="page-top">
	<%
	String email = (String) session.getAttribute("email");
	if (email == null) {
		response.sendRedirect("index.jsp");
	}
	%>
	<nav class="navbar navbar-expand-lg text-uppercase " id="mainNav">
		<header>
			<c:if test="${userExist != null}">
				<div class="logo">
					<img src="../resources/images/VHEC_logo.png" alt="logo">
				</div>
			</c:if>
			<c:if test="${userExist == null}">
				<div class="logo">
					<img src="resources/images/VHEC_logo.png" alt="logo">
				</div>
			</c:if>
		</header>
		<div class="container">
			<button
				class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded"
				type="button" data-bs-toggle="collapse"
				data-bs-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded" href="#portfolio"><i
							class="fa-regular fa-bell"></i></a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded" href="#about"><i
							class="fa-regular fa-user"></i></a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded"
						href="/my-tomcat-app/logoutServlet"><i
							class="fa-solid fa-arrow-right-from-bracket"></i></a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="modal-content">
			<c:if test="${userExist != null}">
				<form action="/my-tomcat-app/user/update" method="post"
					onsubmit="return validateForm()">
			</c:if>
			<c:if test="${userExist == null}">
				<form action="/my-tomcat-app/user/insert" method="post"
					onsubmit="return validateForm()">
			</c:if>
			<div class="modal-header">
				<c:if test="${userExist != null}">
					<h4 class="modal-title">Edit User</h4>
				</c:if>
				<c:if test="${userExist == null}">
					<h4 class="modal-title">Add User</h4>
				</c:if>
			</div>
			<div class="modal-body">
				<div class='row'>
					<div class='col-6'>
						<c:if test="${userExist != null}">
							<input type="hidden" name="id"
								value="<c:out value='${userExist.id}' />" readonly />
							<div class="form-group">
								<h6>Id</h6>
							</div>
							<div class="form-group">
								<label>${userExist.id}</label>
							</div>
						</c:if>
						<div class="form-group">
							<h6>Name</h6>
							<input type="text" name="name"
								value="<c:out value='${userExist.name}' />" class="form-control"
								required>
						</div>

						<div class="form-group">
							<h6>Job</h6>
							<select class="form-control" name="job_id">
								<option value="" selected>Select job</option>
								<c:forEach var="job" items="${listJob}">
									<c:choose>
										<c:when test="${job.id eq userExist.job_id}">
											<option value="${job.id}" selected>${job.name}</option>
										</c:when>
										<c:otherwise>
											<option value="${job.id}">${job.name}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>

						<c:if test="${userExist == null}">
							<div class="form-group">
								<h6>Email</h6>
								<input name="email" id="email"
									value="<c:out value='${userExist.email}' />"
									class="form-control" required> <span id="email-error"
									class="error-message"></span>
							</div>
						</c:if>
					</div>
					<div class='col-6'>
						<div class="form-group">
							<h6>Age</h6>
							<input type="number" name="age"
								value="<c:out value='${userExist.age}' />" class="age">
						</div>

						<div class="form-group">
							<h6>Gender</h6>
							<c:choose>
								<c:when test="${userExist == null}">
									<label class="gender_label"><input type="radio"
										name="gender" value="1"> Male</label>
									<label class="gender_label"><input type="radio"
										name="gender" value="0"> Female</label>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${userExist.gender == true}">
											<label class="gender_label"><input type="radio"
												name="gender" value="1" checked> Male</label>
											<label class="gender_label"><input type="radio"
												name="gender" value="0"> Female</label>
										</c:when>
										<c:otherwise>
											<label class="gender_label"><input type="radio"
												name="gender" value="1"> Male</label>
											<label class="gender_label"><input type="radio"
												name="gender" value="0" checked> Female</label>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</div>
						<c:if test="${userExist != null}">
							<div class="form-group">
								<h6>Email</h6>
								<input name="email" id="email"
									value="<c:out value='${userExist.email}' />"
									class="form-control" required> <span id="email-error"
									class="error-message"></span>
							</div>
						</c:if>
					</div>
				</div>
			</div>
			<div class="btn-footer">
				<c:if test="${userExist != null}">
					<input type="submit" class="btn btn-edit" value="Edit">
				</c:if>
				<c:if test="${userExist == null}">
					<input type="submit" class="btn btn-success" value="Add">
				</c:if>
				<a href="/my-tomcat-app/home" class="btn btn-default">Cancel</a>
			</div>
			</form>
		</div>
	</div>

	<script>
		function validateForm() {
			var email = document.getElementById('email').value;
			var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (!emailRegex.test(email)) {
				document.getElementById('email-error').innerHTML = "Invalid email address";
				return false;
			} else {
				document.getElementById('email-error').innerHTML = "";
				return true;
			}
		}
	</script>
	<!-- Footer-->
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<c:if test="${userExist != null}">
		<script src="../resources/js/scripts.js"></script>
	</c:if>
	<script src="resources/js/scripts.js"></script>
</body>
</html>
