<%@ include file="../component/header.jsp"%>
<c:if test="${userExist != null}">
	<div class="container">
		<div class="modal-content">
			<form>
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
					<a
						href="/my-tomcat-app/user/edit?id=<c:out value='${userExist.id}' />"
						class="btn btn-edit">Edit</a> 
					<a href="#" class="btn btn-delete"
						data-toggle="modal" data-target="#deleteEmployeeModal"
						data-id="${userExist.id}"
						data-updated_at="${userExist.updated_at}"
						>Delete</a>
				</div>
			</form>
		</div>
	</div>
	<div id="deleteEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Delete User</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<p>Are you sure you want to delete user with name
						<b>${userExist.name}</b></p>
					<p class="text-warning">
						<small>This action cannot be undone.</small>
					</p>
					<span id="exists-error" class="error-message"></span> 
				</div>
				
				<div class="modal-footer">
					<a id="modal-button-delete" href="/my-tomcat-app/user/delete?id=<c:out value='${userExist.id}' />"  class="btn btn-danger">Delete</a>
				</div>
			</div>
		</div>
	</div>
</c:if>

<%@ include file="../component/footer.jsp"%>

