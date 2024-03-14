
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
<link href="../resources/css/index-styles.css" rel="stylesheet" />
<script>
    function resetForm() {
        // Xóa giá trị trong các trường tìm kiếm
        document.getElementById("name").value = "";
        document.querySelector('input[name="gender"]:checked').checked = false;
        document.getElementById("minAge").value = "";
        document.getElementById("maxAge").value = "";
        document.getElementById("email").value = "";
        document.querySelector('select[name="job_id"]').value = "";
    }
</script>

</head>
	<body id="page-top">
		<%
			String email = (String) session.getAttribute("email");
			if (email == null) {
				response.sendRedirect("/index.jsp");
			}
		%>
		    <!-- Navigation-->
		<nav
			class="navbar navbar-expand-lg text-uppercase "
			id="mainNav">
			<header>
				<div class="logo">
					<img src="../resources/images/VHEC_logo.png" alt="logo">
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
		<!-- Content-->
		<div class="container-xl">
			<div class="table-responsive">
				<div class="table-wrapper">
					<div class="table-title">
						<div class="row">
							<div class="col-sm-6">
								<h2>User <b>Search</b></h2>
							</div>
							<%-- <div class="col-sm-6">
								<a href="/my-tomcat-app/user" class="btn btn-success" ><i class="material-icons">&#xE147;</i> <span>Add New Employee</span></a>
								<a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Delete</span></a>						
							</div> --%>
						</div>
					</div>
						<div class="s009">
							<form action="/my-tomcat-app/home/search" method="post" onsubmit="showLoading()">
								<div class="inner-form">
								<div class="advance-search">
									<div class="row">
									<div class="col-6">
										<div class="input-field">
										<div class="col-2">
											<label>Name</label>
										</div>
										<input type="text" name="name" id="name" placeholder="name" value="${param.name}" />
										</div>
									</div>
									<div class="col-6">
										<div class="input-field">
										<div class="col-2">
											<label>Gender</label>
										</div>
										<label><input type="radio" name="gender" value="1" ${param.gender == '1' ? 'checked' : ''}> Male</label>
										<label><input type="radio" name="gender" value="0" ${param.gender == '0' ? 'checked' : ''}> Female</label>
										</div>
									</div>
									</div>
									<div class="row second">
									<div class="col-6">
										<div class="input-field">
										<div class="col-2">
											<label>Job</label>
										</div>
										<div class="input-select">
											<select class="form-control" name="job_id">
											<option value="">Select job</option>
											<c:forEach var="job" items="${listJob}">
												<option value="${job.id}" ${param.job_id == job.id ? 'selected' : ''}>${job.name}</option>
											</c:forEach>
											</select>
										</div>
										</div>
									</div>
									<div class="col-6">
										<div class="input-field">
										<div class="col-2">
											<label>Age</label>
										</div>
										<input type="number" name="minAge" id="minAge" placeholder="0" value="${param.minAge}" />
										~ 
										<input type="number" name="maxAge" id="maxAge" placeholder="0" value="${param.maxAge}" />
										</div>
									</div>
									</div>
									<div class="row third">
										<div class="col-12">
										<div class="input-field">
											<div class="col-1">
											<label>Email</label>
											</div>
											<input type="text" name="email" id="email" placeholder="email" value="${param.email}" />
										</div>
										</div>
									</div>
									<div class="row">
									<div class="d-flex justify-content-end">
										<div class="group-btn">
										<button type="button" class="btn-delete" onclick="resetForm()">RESET</button>
										<button type="submit" class="btn-search">SEARCH</button>
										</div>
									</div>
									</div>

									<c:if test="${searchResult != null}">
										<div class="row">
											<div class="d-flex justify-content-end">
												<div class="hint-text">Showing <b>${pageSize}</b> out of <b>${totalUsers}</b> entries</div>
											</div>
										</div>
									</c:if>
								</div>
								</div>
							</form>
						</div>
						<c:choose>
							<c:when test="${not empty searchResult}">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>Name</th>
											<th>Age</th>
											<th>Gender</th>
											<th>Job</th>
											<th>Email</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="user" items="${searchResult}">
											<tr>
												<td>${user.name}</td>
												<td>${user.age}</td>
												<td>${user.gender ? 'Male' : 'Female'}</td>
												<td>${user.job_name}</td>
												<td>${user.email}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:when>
							<c:otherwise>
								<div class= "not-found-text">
									<h1>No Records</h1>
								</div>
							</c:otherwise>
						</c:choose>
					<div class="row">
						<div class="col-sm-6">
							<a href="/my-tomcat-app/user" class="btn btn-success" ><span>Add User</span></a>
						</div>
						<c:if test="${searchResult != null}">
							<div class="col-sm-6">
								<ul class="pagination">
									<!-- Hiển thị liên kết "Previous" -->
									<li class="page-item <c:if test="${pageNumber == 1}">disabled</c:if>">
										<a class="page-link" href="/my-tomcat-app/home?page=${pageNumber - 1}">Previous</a>
									</li>

									<!-- Hiển thị các liên kết trang -->
									<c:forEach var="page" begin="1" end="${totalPages}">
										<li class="page-item <c:if test="${pageNumber == page}">active</c:if>">
											<a class="page-link" href="/my-tomcat-app/home?page=${page}">${page}</a>
										</li>
									</c:forEach>

									<!-- Hiển thị liên kết "Next" -->
									<li class="page-item <c:if test="${pageNumber == totalPages}">disabled</c:if>">
										<a class="page-link" href="/my-tomcat-app/home?page=${pageNumber + 1}">Next</a>
									</li>
								</ul>
							</div>
						</c:if>
					</div>
				</div>
			</div>        
		</div>
		<!-- View Detail Modal HTML -->
		<div id="viewDetailModal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">						
						<h4 class="modal-title">User Detail</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<!-- Thêm các trường dữ liệu để hiển thị chi tiết của người dùng -->
						<p>Name: <span id="detailName"></span></p>
						<p>Age: <span id="detailAge"></span></p>
						<p>Gender: <span id="detailGender"></span></p>
						<p>Email: <span id="detailEmail"></span></p>
						<p>Job: <span id="detailJob"></span></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

			<!-- Delete Modal HTML -->
			<div id="deleteEmployeeModal" class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content">
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
								<a href="#" id="confirmDeleteBtn" class="btn btn-danger">Delete</a>
							</div>
					</div>
				</div>
			</div>
			
	
<!-- Footer-->
        <!-- Bootstrap core JS-->
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
		<!-- Core theme JS-->
		<script src="../resources/js/scripts.js"></script>
	</body>
</html>