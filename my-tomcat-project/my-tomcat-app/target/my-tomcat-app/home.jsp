

	<!-- Header-->

<%@ include file="../component/header.jsp" %>
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
					<%@ include file="../component/searchbar.jsp" %>
					<c:if test="${searchResult != null}">
						<div class="row">
							<div class="d-flex justify-content-end">
								<div class="hint-text">Showing <b>${pageSize}</b> out of <b>${totalUsers}</b> entries</div>
							</div>
						</div>
					</c:if>	
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
							<c:forEach var="user" items="${listUser}">
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
					<div class="row">
						<div class="col-sm-6">
							<a href="/my-tomcat-app/user" class="btn btn-success" ><span>Add User</span></a>
						</div>
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
					</div>
				</div>
			</div>        
		</div>
		<script>
				document.addEventListener('DOMContentLoaded', function() {
					var rows = document.querySelectorAll('tbody tr');
					rows.forEach(function(row) {
						row.addEventListener('dblclick', function() {
							var userId = this.getAttribute('data-id');
							window.location.href = '/my-tomcat-app/user/detail?id=' + userId;
							rows.forEach(function(r) {
								r.classList.remove('selected');
							});
							this.classList.add('selected');
						});
					});
				});
		</script>
	<!-- Footer-->
<%@ include file="../component/footer.jsp" %>