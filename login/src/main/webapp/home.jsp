<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.models.User" %>
<%@ page import = "com.demo.models.Job" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Search</title>
    <link rel="stylesheet" href="css/home.css">
</head>
<body>
	<div class="backgroundBody">
		<button type="button" id="logo" class="icon-button">
			<span class="icon-logo"></span>
		</button>
	    <button type="button" id="logout" class="icon-button" onClick="Logout()">
			<span class="icon icon-logout"></span>
		</button>
		<button type="button" id="logout" class="icon-button">
			<span class="icon icon-noti"></span>
		</button>
		<button type="button" id="logout" class="icon-button">
			<span class="icon icon-person"></span>
		</button>

    </div>
    <div class="container">
        <h1>User Search</h1>
        <%
		    User userSearch = (User) request.getAttribute("userSearch");
        	Integer ageForm = (Integer) request.getAttribute("ageForm");
        	Integer ageTo = (Integer) request.getAttribute("ageTo");
		    String nameValue = (userSearch != null && userSearch.getName() != null) ? userSearch.getName() : "";
		    int ageValue = (userSearch != null && userSearch.getAge() > 0) ? userSearch.getAge() : 0; 
		    String genderValue = (userSearch != null && userSearch.getGender() != null) ? userSearch.getGender() : "";
		    String emailValue = (userSearch != null && userSearch.getEmail() != null) ? userSearch.getEmail() : "";
		    String jobValue = (userSearch != null && userSearch.getJob() != null) ? userSearch.getJob() : "";
		%>
        <form action="home" method="post" class="form-grid">
            <div class="form-column">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= nameValue %>" placeholder="Enter name">
                <label for="job">Job:</label>
                <select id="job" name="job">
                    <option value="">Select occupation</option>
				    <%
				        List<Job> occupations = (List<Job>) request.getAttribute("occupations");
				        if (occupations != null) {
				            for (Job occupation : occupations) {
				            	 String selected = ""; 
				                 if (jobValue.equals(String.valueOf(occupation.getIdJob()))) {
				                     selected = "selected";
				                 }
				    %>
				    <option value="<%= occupation.getIdJob() %>"  <%= selected %>> <%= occupation.getName() %></option>
				    <%
				            }
				        }
				    %>
                </select>
                <div class = "fullWidth">
                	<label for="email">Email:</label>
	                <input type="text" id="email" name="email" value="<%= emailValue %>" placeholder="Enter email">
	            </div>
            </div>
            <div class="form-column">
                <label for="age">Age:</label>
                <input type="number" id="ageForm" name="ageForm"  value="<%= (ageForm != null && ageForm == -1) ? "" : ageForm %>">
				<label>~</label>
				<input type="number" id="ageTo" name="ageTo" value="<%= (ageTo != null && ageTo == -1) ? "" : ageTo %>">
				<br>
                <div class="gender-radio">
                	<label for="gender">Gender:</label>
                    <input type="radio" id="male" name="gender" value="Male" <%= (genderValue.equals("Female")) ? "" : "checked"%>>
                    <label for="male">Male</label>
                    <input type="radio" id="female" name="gender" value="Female" <%= (genderValue.equals("Female")) ? "checked" : "" %>>
                    <label for="female">Female</label>
                </div>
                <button id = "search" type="submit" class="custom-button">Search</button>
            </div>
        </form>
        <br>
        <div class="results">
	        <% if (request.getAttribute("totalRecords") != null && request.getAttribute("currentPage") != null && (int)request.getAttribute("totalRecords") > 0) { %>
			    <% 
			        int currentPage = (int) request.getAttribute("currentPage");
			        int recordsPerPage = 5;
			        int totalRecords = (int) request.getAttribute("totalRecords");
			        int startRecord = (currentPage - 1) * recordsPerPage + 1;
			        int endRecord = Math.min(currentPage * recordsPerPage, totalRecords);
			    %>
			    <p>Showing <%= startRecord %>-
			       <%= endRecord %> 
			       of <%= totalRecords %> results</p>
			<% } %>
            <table border="1">
            	<thead>
	            	<tr>
	                    <th class="color-th">Name</th>
	                    <th class="color-th">Age</th>
	                    <th class="color-th">Gender</th>
	                    <th class="color-th">Occupation</th>
	                    <th class="color-th">Email</th>
	                </tr>
            	</thead>
				<tbody>
				<%
			        List<User> userList = (List<User>) request.getAttribute("userList");
			        if (userList != null && !userList.isEmpty()) {
			            for (User user : userList) {
				%>
			                <tr onclick="GoDetail(<%=user.getId()%>)">
			                    <td><%= user.getName() %></td>
			                    <td class="text-right"><%= user.getAge() %></td>
			                    <td><%= user.getGender() %></td>
			                    <td><%= user.getJob() %></td>
			                    <td><%= user.getEmail() %></td>
			                </tr>
				<%
			            }
			        } else {
				%>
				            <tr>
				                <td colspan="6">No data available</td>
				            </tr>
				<%
				    }
				%>

		        </tbody>
            </table>
            <br>
            <%
            	int total = (int)request.getAttribute("totalPages");
            	if(total>1){
            %>
            <div class="pagination">
	            <% if ((int)request.getAttribute("currentPage") > 1) { %>
	                <a href="home?currentPage=<%= (int)request.getAttribute("currentPage") - 1 %>">&lt;</a>
	            <% } %>
	            <% for (int i = 1; i <= total; i++) { %>
	                <a href="home?currentPage=<%= i %>"><%= i %></a>
	            <% } %>
	            <% if ((int)request.getAttribute("currentPage") < (int)request.getAttribute("totalPages")) { %>
	                <a href="home?currentPage=<%= (int)request.getAttribute("currentPage") + 1 %>">&gt;</a>
	            <% } %>
	        </div>
	        <%	} %>
    	</div>
        <button id="add" type="button" class="custom-button" onclick="add_user()">Add user</button>
</body>
<script>
function Logout() {
    <% session.invalidate(); %>
    window.location.href = "index.jsp";
}

function add_user() {
    window.location.href = "user?source=add";
}

function GoDetail(userId) {
    window.location.href = "user?source=detail&id="+userId;
}
</script>
</html>
