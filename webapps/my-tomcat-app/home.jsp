

	<!-- Header-->

<%@ include file="../component/header.jsp" %>
 	<div class="row mt-5">
        <div class="col-md-5 mx-auto">
            <div class="input-group">
                <input class="form-control border rounded-pill" type="search" value="search" id="example-search-input">
            </div>
        </div>
    </div>
    
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
								<a href="/my-tomcat-app/user" class="btn btn-success" ><i class="material-icons">&#xE147;</i> <span>Add New Employee</span></a>
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
									<td>${user.job_name}</td>
									<td class="action">
										<a href="#" data-id="${user.id}" data-toggle="modal" data-target="#viewDetailModal"><i class="fa-solid fa-info"></i></a>
										<a href="/my-tomcat-app/user/edit?id=<c:out value='${user.id}' />" class="edit" ><i class="fa-solid fa-pencil"></i></a>
										<a href="#deleteEmployeeModal" data-id="${user.id}" class="delete" data-toggle="modal"><i class="fa-solid fa-trash"></i></a>
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

		<script>
			$(document).ready(function(){
				$('#deleteEmployeeModal').on('show.bs.modal', function (e) {
					var userId = $(e.relatedTarget).data('id');
					console.log(userId);
					var deleteUrl = "/my-tomcat-app/user/delete?id=" + userId;
            		$('#confirmDeleteBtn').attr('href', deleteUrl);
				});
			});

			$(document).ready(function(){
				$('#viewDetailModal').on('show.bs.modal', function (e) {
					var userId = $(e.relatedTarget).data('id');
					$.ajax({
						url: '/my-tomcat-app/home/detail?id=' + userId,
						method: 'GET',
						success: function(response) {
							console.log(response);
							$('#detailName').text(response.name);
							$('#detailAge').text(response.age);
							$('#detailGender').text(response.gender ? 'Male' : 'Female');
							$('#detailEmail').text(response.email);
							$('#detailJob').text(response.job_name);
						},
						error: function() {
						}
					});
				});
			});
		</script>
	<!-- Footer-->
<%@ include file="../component/footer.jsp" %>