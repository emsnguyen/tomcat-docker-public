
<%@ include file="../component/header.jsp" %>
			<div class="container">
				<div class="modal-content">
					<c:if test="${userExist != null}">
						<form action="/my-tomcat-app/user/update" method="post" onsubmit="return validateForm()">
					</c:if>
					<c:if test="${userExist == null}">
						<form action="/my-tomcat-app/user/insert" method="post" onsubmit="return validateForm()">
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
										<input type="text" name="id" value="<c:out value='${userExist.id}' />" readonly />
									</c:if>  				
									<div class="form-group">
										<label>Name</label>
										<input type="text"  name="name" value="<c:out value='${userExist.name}' />" class="form-control" required>
									</div>
									<div class="form-group">
										<label>Job</label>
										<c:choose>
											<c:when test="${userExist == null}">
												<select class="form-control" name="job_id" >
													<c:forEach var="job" items="${listJob}">
														<option value="${job.id}">${job.name}</option>
													</c:forEach>
												</select>
											</c:when>
											<c:otherwise>
												<select class="form-control" name="job_id" >
													<c:forEach var="job" items="${listJob}">
														<c:if test="${job.id == userExist.job_id}">
															<option value="${job.id}" selected>${job.name}</option>
														</c:if>
														<c:if test="${job.id != userExist.job_id}">
															<option value="${job.id}">${job.name}</option>
														</c:if>
													</c:forEach>
												</select>
											</c:otherwise>
										</c:choose>
									</div>		
									<div class="form-group">
										<label>Email</label>
										<input  name="email"  id="email" value="<c:out value='${userExist.email}' />" class="form-control" required>
										<span id="email-error" class="error-message"></span>
									</div>
								</div>
								<div class='col-6'>
									<div class="form-group">
										<label>Age</label>
										<input type="number" name="age" value="<c:out value='${userExist.age}' />" class="form-control" >
									</div>

									<div class="form-group">
										<label>Gender</label><br>
										<c:choose>
											<c:when test="${userExist == null}">
												<label><input type="radio" name="gender" value="1"> Male</label>
												<label><input type="radio" name="gender" value="0"> Female</label>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${userExist.gender == true}">
														<label><input type="radio" name="gender" value="1" checked> Male</label>
														<label><input type="radio" name="gender" value="0"> Female</label>
													</c:when>
													<c:otherwise>
														<label><input type="radio" name="gender" value="1"> Male</label>
														<label><input type="radio" name="gender" value="0" checked> Female</label>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
						<div class="btn-footer">
							<c:if test="${userExist != null}">
								<input type="submit" class="btn btn-success" value="Save">
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
<%@ include file="../component/footer.jsp" %>
