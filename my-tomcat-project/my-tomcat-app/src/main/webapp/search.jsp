<!-- Header-->

<%@ include file="../component/header.jsp"%>
<!-- Content-->
<div class="container-xl">
	<div class="table-responsive">
		<div class="table-wrapper">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-6">
						<h2>
							User <b>Search</b>
						</h2>
					</div>
				</div>
			</div>
			<%@ include file="../component/searchbar.jsp"%>
			<c:choose>
				<c:when test="${not empty searchResult}">
					<div class="row">
						<div class="d-flex justify-content-end">
							<div class="hint-text">
								Showing <b>${endRecord}</b> of <b>${totalUsers}</b> entries
							</div>
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
					<div class="not-found-text">
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
<%@ include file="../component/footer.jsp"%>