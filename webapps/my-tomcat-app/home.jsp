

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
										<input type="number" name="minAge" id="minAge" placeholder="0" value="${param.minAge}" maxlength="2" pattern="\d{1,2}" />
										~ 
										<input type="number" name="maxAge" id="maxAge" placeholder="0" value="${param.maxAge}" maxlength="2" pattern="\d{1,2}" />
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
									<button class="btn-delete" onclick="resetForm()" id="delete">RESET</button>
									<button type="submit" class="btn-search">SEARCH</button>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="d-flex justify-content-end">
									<div class="hint-text">Showing <b>${pageSize}</b> out of <b>${totalUsers}</b> entries</div>
								</div>
							</div>
						</div>
						</div>
					</form>
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
			function resetForm() {
				document.getElementById("name").value = "";
				document.getElementById("minAge").value = "";
				document.getElementById("maxAge").value = "";
				document.querySelector('input[name="gender"]:checked').checked = false;
				document.getElementById("email").value = "";
				document.querySelector('job_id').value = ""; 
			}
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