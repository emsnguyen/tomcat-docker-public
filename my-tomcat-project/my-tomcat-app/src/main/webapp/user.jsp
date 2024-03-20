<!-- Header-->

<%@ include file="../component/header.jsp"%>
<!-- Content-->
<div class="container">
	<div class="modal-content">
		<c:if test="${userExist != null}">
			<form id="edit-user-form" action="/my-tomcat-app/user/update"
				method="post" >
		</c:if>
		<c:if test="${userExist == null}">
			<form id="add-user-form" action="/my-tomcat-app/user/insert"
				method="post">
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
							value="<c:out value='${userExist.id}' />" />
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
							value="<c:out value='${userExist.name}' />" class="form-control">
						<span id="name-error" class="error-message"></span>
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
						</select> <span id="job-error" class="error-message"></span>
					</div>

					<c:if test="${userExist == null}">
						<div class="form-group">
							<h6>Email</h6>
							<input name="email" id="email"
								value="<c:out value='${userExist.email}' />"
								class="form-control"> <span id="email-error"
								class="error-message"></span> <span id="exists-error"
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
								class="error-message"></span> <span id="exists-error"
								class="error-message"></span>
						</div>
						<input type="text" name="updated_at" id="updated_at"
							value="<c:out value='${userExist.updated_at}' />" class="form-control">
					</c:if>
				</div>
			</div>
		</div>
		<div class="btn-footer">
			<c:if test="${userExist != null}">
				<input type="submit" id="edit-user-btn" class="btn btn-edit" value="Edit">
			</c:if>
			<c:if test="${userExist == null}">
				<input type="submit" class="btn btn-success" value="Add">
			</c:if>
			<a href="/my-tomcat-app/home" class="btn btn-default">Cancel</a>
		</div>
		</form>
	</div>
</div>

<!-- Footer-->
<%@ include file="../component/footer.jsp"%>
