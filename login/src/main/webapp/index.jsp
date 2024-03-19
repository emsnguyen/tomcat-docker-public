<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Sign Up Form by Colorlib</title>
	
	<!-- Font Icon -->
	<link rel="stylesheet"
		href="fonts/material-icon/css/material-design-iconic-font.min.css">
	
	<!-- Main css -->
	<link rel="stylesheet" href="css/style.css">
</head>
<body>

	<div class="main">
		<%
			int login = request.getAttribute("login") == null ? 0 : (int) request.getAttribute("login");
		%>
		<!-- Sing in  Form -->
		<section class="sign-in">
			<div class="container">
				<div class="signin-content">
					<div class="signin-image">
						<figure>
							<img src="images/signin-image.jpg" alt="sing up image">
						</figure>
						<a href="register.jsp" class="signup-image-link">Create an
							account</a>
					</div>

					<div class="signin-form">
						<h2 class="form-title">Sign in</h2>
						<form action="login" method="post" class="register-form"
							id="login-form">
							<div class="form-group">
									<input
									type="text" name="username" id="username"
									placeholder="User Name" />
							<%if(login != 0){ %>
								<label class="error">Username or password does not match.</label>
							<%}%>
							</div>
							<div class="form-group">
								<input
									type="password" name="password" id="password"
									placeholder="Password" />
							<%if(login != 0){ %>
								<label class="error">Username or password does not match.</label>
							<%}%>
							</div>
							<div class="form-group">
								
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signin" id="signin"
									class="form-submit" value="Login" />
							</div>
						</form>
						
					</div>
				</div>
			</div>
		</section>

	</div>

	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>