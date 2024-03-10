
		<%@ include file="./component/header.jsp" %>
  
    <!-- Add Modal HTML -->
				<c:if test="${userExist != null}">
					<form action="user/update" method="post">
				</c:if>
				<c:if test="${userExist == null}">
					<form action="user/insert" method="post">
				</c:if>
						<div class="modal-header">		
							<c:if test="${userExist != null}">
								<h4 class="modal-title">Edit Employee</h4>
							</c:if>
							<c:if test="${userExist == null}">
								<h4 class="modal-title">Add Employee</h4>
							</c:if>				
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						</div>
						<div class="modal-body">					
							<div class="form-group">
								<label>Name</label>
								<input type="text"  name="name" value="<c:out value='${userExist.name}' />" class="form-control" required>
							</div>
							<div class="form-group">
								<label>Age</label>
								<input type="number" name="age" value="<c:out value='${userExist.age}' />" class="form-control" >
							</div>

							<div class="form-group">
								<label>Gender</label><br>
								<c:choose>
									<c:when test="${userExist == null}">
										<!-- Nếu người dùng không tồn tại, hiển thị các lựa chọn giới tính -->
										<label><input type="radio" name="gender" value="0"> Male</label>
										<label><input type="radio" name="gender" value="1"> Female</label>
									</c:when>
									<c:otherwise>
										<!-- Nếu người dùng tồn tại, hiển thị giới tính dựa trên dữ liệu có sẵn -->
										<c:choose>
											<c:when test="${userExist.gender == false}">
												<label><input type="radio" name="gender" value="0" checked> Male</label>
												<label><input type="radio" name="gender" value="1"> Female</label>
											</c:when>
											<c:otherwise>
												<label><input type="radio" name="gender" value="0"> Male</label>
												<label><input type="radio" name="gender" value="1" checked> Female</label>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="form-group">
								<label>Email</label>
								<input type="email"  name="email" value="<c:out value='${userExist.email}' />" class="form-control" required>
							</div>
							 <div class="form-group">
								<label>Job</label>
								 <c:choose>
									<c:when test="${userExist == null}">
										<!-- Nếu người dùng không tồn tại, hiển thị dropdown chọn công việc -->
										<select class="form-control" name="job_id" >
											<c:forEach var="job" items="${listJob}">
												<option value="${job.id}">${job.name}</option>
											</c:forEach>
										</select>
									</c:when>
									<c:otherwise>
										<!-- Nếu người dùng tồn tại, hiển thị dropdown chọn công việc với giá trị đã chọn trước đó -->
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
						</div>
						<div class="modal-footer">
							<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
							<c:if test="${userExist != null}">
								<input type="submit" class="btn btn-success" value="Save">
							</c:if>
							<c:if test="${userExist == null}">
								<input type="submit" class="btn btn-success" value="Add">
							</c:if>
						</div>
					</form>

<%@ include file="./component/footer.jsp" %> 