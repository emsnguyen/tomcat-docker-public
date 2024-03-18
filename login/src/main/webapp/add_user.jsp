<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import = "com.demo.models.Job" %>
<%@ page import = "com.demo.models.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User</title>
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/add.css">
    <style>
	    
    </style>
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
    	<%
		    String source = request.getParameter("source");
    		String userId = request.getParameter("id");
    		User userInfo = (User) request.getAttribute("userInfo");
		    if ("add".equals(source)) {
		%>
		    <h1>Add User</h1>
		<%  
		    } else if ("edit".equals(source)) {
		%>
			<h1>Edit User</h1>
		<% 
		    } else {
		%>
			<h1>User Detail</h1>
		<% 
		    }
		%>
        <form action="user" method="post" class="form-grid">
	        <div class="form-row">
	            <div class="form-column">
	            	<%
					if (("detail".equals(source)) || ("edit".equals(source))) {
					%>
			        	<label id="lb_id">Id:</label>
			        	<input type="text" id="userId" name="userId" value="<%=userId%>" readonly style="border: none;">
					<%
					} 
					%>
	            	<%
					if (("detail".equals(source))) {
					%>
			        	<label for="Name" id="lb_name" >Name:</label>
			        	<input type="text" id="name" name="name" value="<%=userInfo==null ? "" : userInfo.getName() %>" readonly style="border: none;">
			        	<label for="Job" id="lb_job">Job:</label>
			        	<input type="text" id="job" name="job" value="<%=userInfo==null ? "" :userInfo.getJob()%>" readonly style="border: none;">
			        	<label for="Email" id="lb_email">Email:</label>
			        	<input type="text" id="email" name="email" value="<%=userInfo==null ? "" : userInfo.getEmail()%>" readonly style="border: none;">
		        	<%
					} else {
		        	%>
		                <label for="name">Name:</label>
		                <input type="text" id="name" name="name" value="<%= userInfo==null ? "" : userInfo.getName() %>" placeholder="Enter name" <%= "detail".equals(source) ? "readonly" : "" %>>
		                <label for="job">Job:</label>
		                <select id="job" name="job">
					    <option value="" <%="detail".equals(source) ? "disabled" : "" %>>Select occupation</option>
							<%
							    List<Job> occupations = (List<Job>) request.getAttribute("occupations");
							    String selected = "";
								if (occupations != null) {
							        for (Job occupation : occupations) {
							        	if(userInfo!=null && userInfo.getJob().equals(occupation.getName())){
							        		selected = "selected";
							        	}
							%>
							<option value="<%= occupation.getIdJob() %>" <%=selected%> <%="detail".equals(source) ? "disabled" : "" %>><%= occupation.getName()  %></option>
							<%
							        }
							    }
							%>
						</select>
						<%
						if (("add".equals(source))) {
						%>
				        	<label for="email">Email:</label>
			                <input type="email" id="email" name="email" value="<%=userInfo==null ? "" : userInfo.getEmail() %>" placeholder="Enter email" <%="detail".equals(source) ? "readonly" : "" %>>
			        	<%
						}
					 }
		        	%>
	            </div>
	            <% if (!("detail".equals(source))) {%>
	            <div class="form-column">
	                <label for="age">Age:</label>
	                <input type="number" id="age" name="age" value="<%=userInfo==null ? "" : userInfo.getAge() %>" placeholder="Age" <%="detail".equals(source) ? "readonly" : "" %>>
	                <label for="gender">Gender:</label>
	                <div class="gender-radio">
	                    <input type="radio" id="male" name="gender" value="Male" <%=userInfo==null ? "" : "Male".equals(userInfo.getGender()) ? "checked" : "" %> <%="detail".equals(source) ? "disabled" : "" %>>
	                    <label for="male">Male</label>
	                    <input type="radio" id="female" name="gender" value="Female" <%=userInfo==null ? "" : "Female".equals(userInfo.getGender()) ? "checked" : "" %> <%="detail".equals(source) ? "disabled" : "" %>>
	                    <label for="female">Female</label>
	                </div>
	                <%
					    if (!("add".equals(source))) {
					%>
				        	<label for="email">Email:</label>
			                <input type="email" id="email" name="email" value="<%=userInfo==null ? "" : userInfo.getEmail() %>" placeholder="Enter email" <%="detail".equals(source) ? "readonly" : "" %>>
		        	<%
					    }
		        	%>
	            </div>
	            <%}%>
            </div>
            <div class="form-row">
            <%
		    if ("add".equals(source)) {
			%>
		        <button type="submit" id="add_user" class="custom-button" name="action" value="add">Add</button>
	        <%  
			    } else if ("edit".equals(source)) {
			%>
		        <button type="submit" id="edit" class="custom-button" name="action" value="save_edit">Edit</button>
			<% 
			    } else {
			%>
				<button type="submit" id="edit" class="custom-button" name="action" value="edit">Edit</button>
				<button type="submit" id="delete" class="custom-button" name="action" value="delete">Delete</button>
				<button type="submit" id="cancel" class="custom-button" name="action" value="cancel">Cancel</button>
			<% 
			    }
			%>
		  
		    </div>
        </form>
    </div>
</body>	
<script>
function Logout() {
    <% session.invalidate(); %>
    window.location.href = "index.jsp";
}
</script>
</html>
