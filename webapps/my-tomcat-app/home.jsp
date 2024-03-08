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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="./resources/css/index-styles.css" rel="stylesheet" />


</head>
	<body id="page-top">
		<%
			String email = (String) session.getAttribute("email");
			if (email == null) {
				response.sendRedirect("index.jsp");
			}
		%>
		<!-- Navigation-->
		<nav
			class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top"
			id="mainNav">
			<div class="container">
				<a class="navbar-brand" href="#page-top">Unique Developer</a>
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
							class="nav-link py-3 px-0 px-lg-3 rounded" href="#portfolio">Portfolio</a></li>
						<li class="nav-item mx-0 mx-lg-1"><a
							class="nav-link py-3 px-0 px-lg-3 rounded" href="#about">About</a></li>
						<li class="nav-item mx-0 mx-lg-1"><a
							class="nav-link py-3 px-0 px-lg-3 rounded" href="#contact">Contact</a></li>
						<li class="nav-item mx-0 mx-lg-1"><a
							class="nav-link py-3 px-0 px-lg-3 rounded" href="/my-tomcat-app/logoutServlet">Logout</a></li>
					</ul>
				</div>
			</div>
		</nav>
		<!-- Masthead-->
		<header class="masthead bg-primary text-white text-center">
			<div class="container d-flex align-items-center flex-column">
				<!-- Masthead Avatar Image-->
				<img class="masthead-avatar mb-5" src="./resources/assets/img/avataaars.svg"
					alt="..." />
				<!-- Masthead Heading-->
				<h1 class="masthead-heading text-uppercase mb-0">Welcome To Unique Developer</h1>
				<!-- Icon Divider-->
				<div class="divider-custom divider-light">
					<div class="divider-custom-line"></div>
					<div class="divider-custom-icon">
						<i class="fas fa-star"></i>
					</div>
					<div class="divider-custom-line"></div>
				</div>
				<!-- Masthead Subheading-->
				<p class="masthead-subheading font-weight-light mb-0">Java
					Development - Web Development - Python</p>
			</div>
		</header>

		<!-- Content-->
		<div class="container-xl">
			<div class="table-responsive">
				<div class="table-wrapper">
					<div class="table-title">
						<div class="row">
							<div class="col-sm-6">
								<h2>Manage <b>Employees</b></h2>
							</div>
							<div class="col-sm-6">
								<a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Employee</span></a>
								<a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Delete</span></a>						
							</div>
						</div>
					</div>
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th>
									<span class="custom-checkbox">
										<input type="checkbox" id="selectAll">
										<label for="selectAll"></label>
									</span>
								</th>
								<th>Name</th>
								<th>Age</th>
								<th>Gender</th>
								<th>Email</th>
								<th>Job</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="user" items="${listUser}">
								<tr>
									<td>
										<span class="custom-checkbox">
											<input type="checkbox" id="checkbox1" name="options[]" value="1">
											<label for="checkbox1"></label>
										</span>
									</td>
									<td>${user.name}</td>
									<td>${user.age}</td>
									<td>${user.gender ? 'Male' : 'Female'}</td>
									<td>${user.email}</td>
									<td>${user.job_id}</td>
									<td>
										<a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="fa-solid fa-pencil"></i></a>
										<a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="fa-solid fa-trash"></i></a>
									</td>
								</tr>
							 </c:forEach>
						</tbody>
					</table>
					<div class="clearfix">
						<div class="hint-text">Showing <b>5</b> out of <b>25</b> entries</div>
						<ul class="pagination">
							<li class="page-item disabled"><a href="#">Previous</a></li>
							<li class="page-item"><a href="#" class="page-link">1</a></li>
							<li class="page-item"><a href="#" class="page-link">2</a></li>
							<li class="page-item active"><a href="#" class="page-link">3</a></li>
							<li class="page-item"><a href="#" class="page-link">4</a></li>
							<li class="page-item"><a href="#" class="page-link">5</a></li>
							<li class="page-item"><a href="#" class="page-link">Next</a></li>
						</ul>
					</div>
				</div>
			</div>        
		</div>
		<!-- Add Modal HTML -->
		<div id="addEmployeeModal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<form >
						<div class="modal-header">						
							<h4 class="modal-title">Add Employee</h4>
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						</div>
						<div class="modal-body">					
							<div class="form-group">
								<label>Name</label>
								<input type="text"  name="id" class="form-control" required>
							</div>
							<div class="form-group">
								<label>Age</label>
								<input type="number" name="number" class="form-control" required>
							</div>
							<div class="form-group">
								<label>Gender</label><br>
								<label><input type="radio" name="gender" value="male"> Male</label>
								<label><input type="radio" name="gender" value="female"> Female</label>
							</div>
							<div class="form-group">
								<label>Email</label>
								<input type="email"  name="Email" class="form-control" required>
							</div>
							 <div class="form-group">
								<label>Job</label>
								<select class="form-control" required>
									<option value="">Select Job</option>
									<c:forEach var="job" items="${listJob}">
										<option value="${job.id}">${job.name}</option>
									</c:forEach>
								</select>
							</div>					
						</div>
						<div class="modal-footer">
							<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
							<input type="submit" class="btn btn-success" value="Add">
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- Edit Modal HTML -->
		<div id="editEmployeeModal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<form>
						<div class="modal-header">						
							<h4 class="modal-title">Edit Employee</h4>
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						</div>
						<div class="modal-body">					
							<div class="form-group">
								<label>Name</label>
								<input type="text" class="form-control" required>
							</div>
							<div class="form-group">
								<label>Age</label>
								<input type="number" class="form-control" required>
							</div>
							<div class="form-group">
								<label>Gender</label><br>
								<label><input type="radio" name="gender" value="male"> Male</label>
								<label><input type="radio" name="gender" value="female"> Female</label>
							</div>
							<div class="form-group">
								<label>Email</label>
								<input type="email" class="form-control" required>
							</div>
							 <div class="form-group">
								<label>Job</label>
								<select class="form-control" required>
									<option value="">Select Job</option>
									<c:forEach var="job" items="${listJob}">
										<option value="${job.id}">${job.name}</option>
									</c:forEach>
								</select>
							</div>					
						</div>
						<div class="modal-footer">
							<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
							<input type="submit" class="btn btn-info" value="Save">
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- Delete Modal HTML -->
		<div id="deleteEmployeeModal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<form>
						<div class="modal-header">						
							<h4 class="modal-title">Delete Employee</h4>
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						</div>
						<div class="modal-body">					
							<p>Are you sure you want to delete these Records?</p>
							<p class="text-warning"><small>This action cannot be undone.</small></p>
						</div>
						<div class="modal-footer">
							<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
							<input type="submit" class="btn btn-danger" value="Delete">
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- Footer-->
		<footer class="footer text-center">
			<div class="container">
				<div class="row">
					<!-- Footer Location-->
					<div class="col-lg-4 mb-5 mb-lg-0">
						<h4 class="text-uppercase mb-4">Location</h4>
						<p class="lead mb-0">
							2215 John Daniel Drive <br /> Clark, MO 65243
						</p>
					</div>
					<!-- Footer Social Icons-->
					<div class="col-lg-4 mb-5 mb-lg-0">
						<h4 class="text-uppercase mb-4">Around the Web</h4>
						<a class="btn btn-outline-light btn-social mx-1" href="#!"><i
							class="fab fa-fw fa-facebook-f"></i></a> <a
							class="btn btn-outline-light btn-social mx-1" href="#!"><i
							class="fab fa-fw fa-twitter"></i></a> <a
							class="btn btn-outline-light btn-social mx-1" href="#!"><i
							class="fab fa-fw fa-linkedin-in"></i></a> <a
							class="btn btn-outline-light btn-social mx-1" href="#!"><i
							class="fab fa-fw fa-dribbble"></i></a>
					</div>
					<!-- Footer About Text-->
					<div class="col-lg-4">
						<h4 class="text-uppercase mb-4">About Freelancer</h4>
						<p class="lead mb-0">
							Freelance is a free to use, MIT licensed Bootstrap theme created
							by <a href="http://startbootstrap.com">Start Bootstrap</a> .
						</p>
					</div>
				</div>
			</div>
		</footer>
		<!-- Copyright Section-->
		<div class="copyright py-4 text-center text-white">
			<div class="container">
				<small>Copyright &copy; Your Website 2021</small>
			</div>
		</div>
		<!-- Bootstrap core JS-->
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
		<!-- Core theme JS-->
		<script src="./resources/js/scripts.js"></script>
	</body>
</html>
