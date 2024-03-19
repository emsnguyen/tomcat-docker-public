<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Sign Up Form by Colorlib</title>
	
	<link rel="stylesheet"
		href="fonts/material-icon/css/material-design-iconic-font.min.css">
	
	<link rel="stylesheet" href="css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
	<script src="js/validation.js" type="text/javascript"></script>
    <style>
	
    </style>
</head>
<body>

	<div class="main">
		<%
			int userExist = request.getAttribute("userExist") == null ? 0 : (int) request.getAttribute("userExist");
			String name = request.getAttribute("name") == null ? "" : (String) request.getAttribute("name");
			String mail = request.getAttribute("mail") == null ? "" : (String) request.getAttribute("mail");
		%>
		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form">
						<h2 class="form-title">Sign up</h2>
						
						<form action="register" method="post" class="register-form"
							id="register-form">
							<div class="form-group">
							<input
									type="text" name="name" id="name" value="<%=name%>" placeholder="Your Name" />
							</div>
							<div class="form-group">
							<input
									type="text" name="username" id="username" placeholder="User name" />
							<%if(userExist != 0){ %>
								<label class="error">Another user with this username has already existed.</label>
							<%}%>
							</div>
							<div class="form-group">
							<input
									type="password" name="password" id="password" placeholder="Password" />
							</div>
							<div class="form-group">
								<input type="password" name="re_pass" id="re_pass"
									placeholder="Repeat your password" />
							</div>
							<div class="form-group">
								<input type="text" name="contact" id="contact"
									placeholder="Email" value = "<%=mail%>"/>
							</div>
							<div class="form-group">
								<input type="checkbox" name="agree-term" id="agree-term"
									class="agree-term" /> <label for="agree-term"
									class="label-agree-term"><span><span></span></span>I
									agree all statements in <a href="#" class="term-service">Terms
										of service</a></label>
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit" value="Register" />
							</div>
						</form>
					</div>
					<div class="signup-image">
						<figure>
							<img src="images/signup-image.jpg" alt="sing up image">
						</figure>
						<a href="index.jsp" class="signup-image-link">I am already
							member</a>
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