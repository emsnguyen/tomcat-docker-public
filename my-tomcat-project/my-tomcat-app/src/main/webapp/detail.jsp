
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
<link rel="icon" type="image/x-icon" href="./resources/assets/favicon.ico" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<!-- Đường dẫn tới Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-xMHDyt2KmjN48bI7qzwe3AznZMw03KCH1Kt7eMP4OL9y2H9z2+P58jOVUa4+8wM9Ex0W2I3DzMc20SjQdEM/9A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/251df2663c.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&display=swap" rel="stylesheet">
<!-- Core theme CSS (includes Bootstrap)-->
<link href="resources/css/index-styles.css" rel="stylesheet" />
<c:if test="${userExist != null}">
	<link href="../resources/css/index-styles.css" rel="stylesheet" />
</c:if>
</head>
	<body id="page-top">
		<%
			String email = (String) session.getAttribute("email");
			if (email == null) {
				response.sendRedirect("index.jsp");
			}
		%>
		<nav
			class="navbar navbar-expand-lg text-uppercase "
			id="mainNav">
			<header>
				<div class="logo">
					<c:if test="${userExist != null}">
						<img src="../resources/images/VHEC_logo.png" alt="logo">
					</c:if>
					<c:if test="${userExist == null}">
						<img src="resources/images/VHEC_logo.png" alt="logo">
					</c:if>
				</div>
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
							class="nav-link py-3 px-0 px-lg-3 rounded" href="#portfolio"><i class="fa-regular fa-bell"></i></a></li>
						<li class="nav-item mx-0 mx-lg-1"><a
							class="nav-link py-3 px-0 px-lg-3 rounded" href="#about"><i class="fa-regular fa-user"></i></a></li>
						<li class="nav-item mx-0 mx-lg-1"><a
							class="nav-link py-3 px-0 px-lg-3 rounded" href="/my-tomcat-app/logoutServlet"><i class="fa-solid fa-arrow-right-from-bracket"></i></a></li>
					</ul>
				</div>
			</div>
		</nav>
		<c:if test="${userExist != null}">
			<div class="container">
				<div class="modal-content">
					<form >
						<div class="modal-header">		
							<h4 class="modal-title">User Details</h4>
							
							<a href="/my-tomcat-app/home" class="close">&times;</a>
						</div>

						<div class="modal-body">
							<div class='row'>
								<h6>Id</h6>
								<label>${userExist.id}</label>
								<h6>Name</h6>
								<label>${userExist.name}</label>
								<h6>Job</h6>
								<label>${userExist.job_name}</label>
								<h6>Email</h6>
								<label>${userExist.email}</label>
							</div>
						</div>
						<div class="btn-footer">
							<a href="/my-tomcat-app/user/edit?id=<c:out value='${userExist.id}' />" class="btn btn-edit" >Edit</a>
							<a href="#deleteEmployeeModal" data-id="${userExist.id}" class="btn btn-delete" data-toggle="modal">Delete</a>
						</div>
					</form>
				</div>
			</div>
			<div id="deleteEmployeeModal" class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content">
							<div class="modal-header">						
								<h4 class="modal-title">Delete User</h4>
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							</div>
							<div class="modal-body">					
								<p>Are you sure you want to delete these Records?</p>
								<p class="text-warning"><small>This action cannot be undone.</small></p>
							</div>
							<div class="modal-footer">							
								<a href="/my-tomcat-app/user/delete?id=<c:out value='${userExist.id}' />" class="btn btn-danger" >Delete</a>
							</div>
					</div>
				</div>
			</div>
		</c:if>				
        <!-- Bootstrap core JS-->
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
		<!-- Core theme JS-->
			<script src="../resources/js/scripts.js"></script>
	</body>
</html>
