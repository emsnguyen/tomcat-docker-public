<div class="s009">
	<form action="/my-tomcat-app/home/search" method="post"
		id="search-form">
		<div class="inner-form">
			<div class="advance-search">
				<div class="row">
					<div class="col-6">
						<div class="input-field">
							<div class="col-2">
								<label>Name</label>
							</div>
							<input type="text" name="name" id="name" placeholder="name"
								value="${param.name}" />
						</div>
					</div>
					<div class="col-6">
						<div class="input-field">
							<div class="col-2">
								<label>Gender</label>
							</div>
							<label class="gender-label"><input type="radio"
								name="gender" value="1" ${param.gender == '1' ? 'checked' : ''}>
								Male</label> <label class="gender-label"><input type="radio"
								name="gender" value="0" ${param.gender == '0' ? 'checked' : ''}>
								Female</label>
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
										<option value="${job.id}"
											${param.job_id == job.id ? 'selected' : ''}>${job.name}</option>
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
							<input type="number" name="minAge" id="minAge"
								value="${param.minAge}" maxlength="3" /> 
								<label class="age-label">~</label> 
							<input type="number" name="maxAge"
								id="maxAge" value="${param.maxAge}" maxlength="3" />
						</div>
						<span id="age-error" class="error error-message"></span>
					</div>
					 
				</div>
				<div class="row third">
					<div class="col-12">
						<div class="input-field">
							<div class="col-1">
								<label>Email</label>
							</div>
							<input type="text" name="email" id="email" placeholder="email"
								value="${param.email}" />
						</div>
					</div>
				</div>
				<div class="row">
					<div class="d-flex justify-content-end">
						<div class="group-btn">
							<button type="submit" class="btn-search">SEARCH</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>