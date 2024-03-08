<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Personal Information</title>
    <link rel="stylesheet" href="css/insert_update.css">
</head>
<body>

<button class="logout-button" onclick="logout()">Logout</button>

<form action="welcome" method="post">
    <h2>Insert Personal Information</h2>
    <label for="name">Name:</label><br>
    <input type="text" id="name" name="name"><br>
    
    <label for="age">Age:</label><br>
    <input type="number" id="age" name="age"><br>
    
	<label for="gender">Gender:</label><br>
	<div id="gender-options" class="radio-center">
	    <input type="radio" id="male" name="gender" value="Male" checked>
	    <label for="male">Male</label>
	    <input type="radio" id="female" name="gender" value="Female">
	    <label for="female">Female</label><br>
	</div>

	    
	<label for="email">Email:</label><br>
	<input type="email" id="email" name="email"><br>
    
	<label for="job">Occupation:</label><br>
	<select id="job" name="job">
	    <option value="">Select occupation</option>
		<%
		    List<String> occupations = (List<String>) request.getAttribute("occupations");
		    if (occupations != null) {
		        for (String occupation : occupations) {
		%>
		<option value="<%= occupation %>"><%= occupation %></option>
		<%
		        }
		    }
		%>
</select><br><br>
    
    <input type="submit" value="Submit">
    <button type="button" onclick="search()">Search Personal Information</button>
</form>

<script>
function logout() {
    <% session.invalidate(); %>
    window.location.href = "index.jsp";
}

function search() {
    window.location.href = "search";
}
</script>

</body>
</html>
