
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
						</div>
					</div>
						<%@ include file="../component/searchbar.jsp"%>
						<c:choose>
							<c:when test="${not empty searchResult}">
								<div class="row">
									<div class="d-flex justify-content-end">
										<div class="hint-text">Showing <b>${endRecord}</b> of <b>${totalUsers}</b> entries</div>
									</div>
								</div>
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
											<tr data-id="${user.id}">
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
					<div class="d-flex justify-content-end">
					<c:if test="${listUser != null  }">
						<ul class="pagination">
							<!-- Hiá»n thá» liÃªn káº¿t "Previous" -->
							<li
								class="page-item <c:if test="${pageNumber == 1}">disabled</c:if>">
								<a class="page-link"
								href="/my-tomcat-app/home?page=${pageNumber - 1}">Previous</a>
							</li>

							<!-- Hiá»n thá» cÃ¡c liÃªn káº¿t trang -->
							<c:forEach var="page" begin="1" end="${totalPages}">
								<li
									class="page-item <c:if test="${pageNumber == page}">active</c:if>">
									<a class="page-link" href="/my-tomcat-app/home?page=${page}">${page}</a>
								</li>
							</c:forEach>

							<!-- Hiá»n thá» liÃªn káº¿t "Next" -->
							<li
								class="page-item <c:if test="${pageNumber == totalPages}">disabled</c:if>">
								<a class="page-link"
								href="/my-tomcat-app/home?page=${pageNumber + 1}">Next</a>
							</li>
						</ul>
					</c:if>
				</div>

		
		</div>
		<div class="table-wrapper-add">
			<div class="row">
					<div class="d-flex justify-content-start">
						<a href="/my-tomcat-app/user" class="btn btn-success"><span>Add
								User</span></a>
					</div>
			</div>
		</div>
	</div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var rows = document.querySelectorAll('tbody tr');
        // Kiểm tra xem đã lưu trạng thái dòng được chọn trong sessionStorage chưa
        var selectedRows = sessionStorage.getItem('selectedRows');
        if (selectedRows) {
            selectedRows = JSON.parse(selectedRows);
            selectedRows.forEach(function(rowId) {
                var selectedRow = document.querySelector('tr[data-id="' + rowId + '"]');
                if (selectedRow) {
                    selectedRow.classList.add('selected');
                }
            });
        }
        // Bắt sự kiện double click trên dòng
        rows.forEach(function(row) {
            row.addEventListener('dblclick', function() {
                var userId = this.getAttribute('data-id');
                window.location.href = '/my-tomcat-app/user/detail?id=' + userId;
                // Lấy danh sách dòng đã được chọn từ sessionStorage
                var selectedRows = sessionStorage.getItem('selectedRows');
                if (!selectedRows) {
                    selectedRows = [];
                } else {
                    selectedRows = JSON.parse(selectedRows);
                }
                // Kiểm tra xem dòng đã được chọn chưa
                var index = selectedRows.indexOf(userId);
                if (index === -1) {
                    // Nếu chưa được chọn, thêm vào danh sách
                    selectedRows.push(userId);
                } else {
                    // Nếu đã được chọn, loại bỏ khỏi danh sách
                    selectedRows.splice(index, 1);
                }
                // Lưu danh sách các dòng đã được chọn vào sessionStorage
                sessionStorage.setItem('selectedRows', JSON.stringify(selectedRows));
                // Loại bỏ lựa chọn trước đó và thêm lựa chọn mới
                rows.forEach(function(r) {
                    r.classList.remove('selected');
                });
                selectedRows.forEach(function(rowId) {
                    var selectedRow = document.querySelector('tr[data-id="' + rowId + '"]');
                    if (selectedRow) {
                        selectedRow.classList.add('selected');
                    }
                });
            });
        });
    });
</script>

<!-- Footer-->
        <!-- Bootstrap core JS-->
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
		<!-- Core theme JS-->
		<script src="../resources/js/scripts.js"></script>
	</body>
</html>