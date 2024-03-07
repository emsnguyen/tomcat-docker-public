<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Personal Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f2f2f2;
        }

        form {
            width: 400px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"],
        input[type="email"],
        select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .logout-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #008CBA;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            cursor: pointer;
        }
        #gender-options {
		    margin-bottom: 10px;
		}
		.radio-center {
		    text-align: center;
		}
		
        
    </style>
</head>
<body>

<button class="logout-button" onclick="logout()">Logout</button>

<form action="welcome" method="get">
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
</form>

<script>
function logout() {
    <% session.invalidate(); %>
    window.location.href = "index.jsp";
}
</script>

</body>
</html>
