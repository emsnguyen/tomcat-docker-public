<%@ page import="java.util.List" %>
<%@ page import="com.demo.models.User" %>
<%@ page import = "com.demo.models.Job" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search and Display Data</title>
    <link rel="stylesheet" href="css/insert_update.css">

</head>

<button class="logout-button" onclick="logout()">Logout</button>
<body>
    <div class="form-container">
        <form action="search" method="post">
        	<input type="hidden" name="formType" value="formSearch">
            <h2>Search</h2>
            <label for="name">Name:</label>
            <input type="text" id="name" name="name"><br>
            
            <label for="age">Age:</label>
            <input type="number" id="age" name="age"><br>
            
            <label for="gender">Gender:</label>
            <select id="gender" name="gender">
                <option value="">Select gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select><br>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email"><br>
            
            
            <label for="job">Occupation:</label><br>
            <select id="job" name="job">
		    <option value="">Select occupation</option>
			<%
			    List<Job> occupations = (List<Job>) request.getAttribute("occupations");
			    if (occupations != null) {
			        for (Job occupation : occupations) {
			%>
			<option value="<%= occupation.getIdJob() %>"><%= occupation.getName() %></option>
			<%
			        }
			    }
			%>
            
            <input type="submit" value="Search">
        </form>
        
        
        <form class="data-form" action="search" method="post">
        	<input type="hidden" name="formType" value="formTable">
        	<div class="radio-center">
                <button class="add-button" type="submit" name="action" value="add">Add</button>
                <button class="edit-button" type="submit" name="action" value="edit">Edit</button>
                <button class="delete-button" type="submit" name="action" value="delete">Delete</button>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Check box</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Gender</th>
                        <th>Email</th>
                        <th>Job</th>
                    </tr>
                </thead>
                <tbody>
				<%
				    List<User> searchResults = (List<User>) request.getAttribute("searchResults");
				    if (searchResults != null && !searchResults.isEmpty()) {
				        for (User user : searchResults) {
				%>
				            <tr onclick="if(event.target.type !== 'checkbox') showPopup('<%= user.getName() %>', <%= user.getAge() %>, '<%= user.getGender() %>', '<%= user.getEmail() %>', '<%= user.getJob() %>')">
				                <td><input type="checkbox" name="selectedIds" value="<%= user.getId() %>"></td>
				                <td><%= user.getName() %></td>
				                <td><%= user.getAge() %></td>
				                <td><%= user.getGender() %></td>
				                <td><%= user.getEmail() %></td>
				                <td><%= user.getJob() %></td>
				            </tr>
				<%
				        }
				    } else {
				        List<User> userList = (List<User>) request.getAttribute("userList");
				        if (userList != null && !userList.isEmpty()) {
				            for (User user : userList) {
				%>
				                <tr onclick="if(event.target.type !== 'checkbox') showPopup('<%= user.getName() %>', <%= user.getAge() %>, '<%= user.getGender() %>', '<%= user.getEmail() %>', '<%= user.getJob() %>')">
				                    <td><input type="checkbox" name="selectedIds" value="<%= user.getId() %>"></td>
				                    <td><%= user.getName() %></td>
				                    <td><%= user.getAge() %></td>
				                    <td><%= user.getGender() %></td>
				                    <td><%= user.getEmail() %></td>
				                    <td><%= user.getJob() %></td>
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
            
        </form>
    </div>

<script>
function logout() {
    <% session.invalidate(); %>
    window.location.href = "index.jsp";
}
function add() {
    window.location.href = "index.jsp";
}

function showPopup(name, age,gender,email,job) {
    //var user = JSON.parse(userJSON);
    alert("name: " + name + "\nage: " + age + "\ngender: " + gender+ "\nemail: " + email + "\njob: " + job);
}

</script>
</body>
</html>
