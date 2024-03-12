<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Search</title>
    <link rel="stylesheet" href="css/home.css">
</head>
<body>

    <div class="container">
    	<button type="button" id="logout" class="custom-button" onClick="Logout()">Logout</button>
        <h1>User Search</h1>
        <form action="search" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" placeholder="Enter name">
            <label for="age">Age:</label>
            <input type="number" id="age" name="age" placeholder="Form">
            <label for="ageTo">~</label>
            <input type="number" id="ageTo" name="ageTo" placeholder="To">
            <label for="gender">Gender:</label>
		    <input type="radio" id="male" name="gender" value="Male" checked>
		    <label for="male">Male</label>
		    <input type="radio" id="female" name="gender" value="Female">
		    <label for="female">Female</label>
            <br>
            <label for="job">Job:</label>
            <select id="job" name="job">
                <option value="">All</option>
                <option value="student">Student</option>
                <option value="office_worker">Office Worker</option>
                <option value="teacher">Teacher</option>
            </select>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" placeholder="Enter email">
            <button type="submit" id="search" class="custom-button">Search</button>
            <br>
        </form>
        <br>
        <div class="results">
            <p>Showing 1-4 of 154 results</p>
            <table border="1">
                <tr>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Gender</th>
                    <th>Occupation</th>
                    <th>Email</th>
                </tr>
                <tr  onClick="GoDetail()">
                    <td>Nguyen Van A</td>
                    <td>25</td>
                    <td>Male</td>
                    <td>Student</td>
                    <td>nguyenvana@gmail.com</td>
                </tr>
                <tr  onClick="GoDetail()">
                    <td>Tran Thi B</td>
                    <td>30</td>
                    <td>Female</td>
                    <td>Office worker</td>
                    <td>tranthib@gmail.com</td>
                </tr>
                <tr  onClick="GoDetail()">
                    <td>Le Van C</td>
                    <td>40</td>
                    <td>Male</td>
                    <td>Teacher</td>
                    <td>levanc@gmail.com</td>
                </tr>
                <tr  onClick="GoDetail()">
                    <td>Pham Thi D</td>
                    <td>22</td>
                    <td>Female</td>
                    <td>Student</td>
                    <td>phamthid@gmail.com</td>
                </tr>
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
    window.location.href = "add_user.jsp";
}

function GoDetail() {
    window.location.href = "add_user.jsp";
}
</script>
</html>
