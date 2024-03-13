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
                <input type="text" id="name" name="name" placeholder="Enter name">
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
	                <input type="email" id="email" name="email" placeholder="Enter email">
	            </div>
            </div>
            <div class="form-column">
                <label for="age">Age:</label>
                <input type="number" id="ageForm" name="ageForm">
                <label >~</label>
                <input type="number" id="ageTo" name="ageTo">
                <br>
                <div class="gender-radio">
                	<label for="gender">Gender:</label>
                    <input type="radio" id="male" name="gender" value="Male" <%= (genderValue.equals("Female")) ? "" : "checked" %>>
                    <label for="male">Male</label>
                    <input type="radio" id="female" name="gender" value="Female" <%= (genderValue.equals("Female")) ? "checked" : "" %>>
                    <label for="female">Female</label>
                </div>
                <button id = "search" type="submit" class="custom-button">Search</button>
            </div>
        </form>
        <br>
        <div class="results">
            <p>Showing 1-4 of 154 results</p>
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
				    List<User> searchResults = (List<User>) request.getAttribute("searchResults");
				    if (searchResults != null && !searchResults.isEmpty()) {
				        for (User user : searchResults) {
				%>
				            <tr onclick="">
				                <td><%= user.getName() %></td>
				                <td><%= user.getAge() %></td>
				                <td><%= user.getGender() %></td>
				                <td><%= user.getJob() %></td>
				                <td><%= user.getEmail() %></td>
				            </tr>
				<%
				        }
				    } else {
				        List<User> userList = (List<User>) request.getAttribute("userList");
				        if (userList != null && !userList.isEmpty()) {
				            for (User user : userList) {
				%>
				                <tr onclick="GoDetail(<%=user.getId()%>)">
				                    <td><%= user.getName() %></td>
				                    <td><%= user.getAge() %></td>
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
				    }
				%>

		        </tbody>
            </table>
            <br>
            <div class="pagination">
            	<button id="add" type="button" class="custom-button" onclick="add_user()">Add user</button>
                <a href="#">&lt;</a>
                <a href="#">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">4</a>
                <a href="#">5</a>
                <a href="#">&gt;</a>
            </div>
        </div>
    </div>
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
