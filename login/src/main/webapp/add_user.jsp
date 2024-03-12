<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Search</title>
    <link rel="stylesheet" href="css/home.css">
    <style>
	    
    </style>
</head>
<body>
    <div class="container">
    	<button type="button" id="logout" class="custom-button" onClick="Logout()">Logout</button>
    	<h1>User Detail</h1>
        <form action="" method="post" class="form-grid">
            <div class="form-column">
	        	<label for="Id">Id:</label>
	        	<label for="Id">123</label>
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" placeholder="Enter name">
                <label for="job">Job:</label>
                <select id="job" name="job">
                    <option value="">All</option>
                    <option value="student">Student</option>
                    <option value="office_worker">Office Worker</option>
                    <option value="teacher">Teacher</option>
                </select>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Enter email">
            </div>
            <div class="form-column">
                <label for="age">Age:</label>
                <input type="number" id="age" name="age" placeholder="Age">
                <label for="gender">Gender:</label>
                <div class="gender-radio">
                    <input type="radio" id="male" name="gender" value="Male" checked>
                    <label for="male">Male</label>
                    <input type="radio" id="female" name="gender" value="Female">
                    <label for="female">Female</label>
                </div>
            </div>
        </form>
        <button type="submit" id="edit" class="custom-button">Edit</button>
        <button type="submit" id="delete" class="custom-button">Delete</button>
        <button type="submit" id="cancel" class="custom-button" onClick = "GoHome()">Cancel</button>
    </div>
</body>	
<script>
function Logout() {
    <% session.invalidate(); %>
    window.location.href = "index.jsp";
}

function GoHome() {
    window.location.href = "home.jsp";
}
</script>
</html>
