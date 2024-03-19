<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign Up Form by Colorlib</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="./resources/fonts/material-icon/css/material-design-iconic-font.min.css">
<!-- Main css -->
<link rel="stylesheet" href="/my-tomcat-app/resources/css/style.css">
</head>
<body>
	<header>
		<div class="logo">
			<img src="/my-tomcat-app/resources/images/VHEC_logo.png" alt="logo">
		</div>
	</header>
	<div class="main">
		<!-- Sign in  Form -->
		<section class="sign-in">
			<div class="container">
				<div class="signin-content">
					<div class="signin-image">
						<figure>
							<img src="./resources/images/signin-image.jpg"
								alt="sing up image">
						</figure>
						<a href="register.jsp" class="signup-image-link">Create an
							account ?</a>
					</div>

					<div class="signin-form">
						<h2 class="form-title">Login</h2>
						<form method="post" action="loginServlet" class="register-form"
							id="login-form" >
							<div class="form-group">
								<input type="text" name="email" id="email"
									placeholder="Your Email" /> <span id="email-error"
									class="error-message"></span>
							</div>
							<div class="form-group">
								<input type="password" name="password" id="password"
									placeholder="Password" /> <span id="password-error"
									class="error-message"></span>
							</div>
							 <span id="not-found-error"
									class="error-message"></span>
							<div class="form-group form-button">
								<input type=button name="signin" id="signin"
									class="form-submit" value="Log in" />
							</div>
						</form>
					</div>
				</div>
			</div>
		</section>
	</div>
</body>
<!-- JS -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
<script src="/my-tomcat-app/resources/js/validate-config.js"></script>
<script src="/my-tomcat-app/resources/js/main.js"></script>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>