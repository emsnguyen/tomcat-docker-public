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
<link rel="stylesheet" href="./resources/css/style.css">
</head>
<body>
	<header>
		<div class="logo">
			<img src="./resources/images/VHEC_logo.png" alt="logo">
		</div>
	</header>
	<div class="main">
		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form">
						<h2 class="form-title">Signup</h2>
					
						<form method="post" action="registerServlet" class="register-form"
							id="register-form" >
							<div class="form-group">
								<input
									type="text" name="name" id="name" placeholder="Your Name" />
								<span id="name-error" class="error-message"></span>
								<span id="exists-error" class="error-message"></span>
							</div>
							<div class="form-group">
								<input type="text" name="contact" id="contact"
									placeholder="Contact " />
							</div>
							<div class="form-group">
								<input
									type="text" name="email" id="email" placeholder="Your Email" />
								<span id="email-error" class="error-message"></span>
							</div>
							<div class="form-group">
								<input
									type="password" name="pass" id="pass" placeholder="Password" />
							</div>
							<div class="form-group">
								<input type="password" name="re_pass" id="re_pass"
									placeholder="Repeat your password" />
								<span id="pass-error" class="error-message"></span>
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit" value="Signup" />
							</div>
						</form>
					</div>
					<div class="signup-image">
						<figure>
							<img src="./resources/images/signup-image.jpg" alt="sing up image">
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
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
	<script src="/my-tomcat-app/resources/js/validate-config.js"></script>
	<script src="/my-tomcat-app/resources/js/main.js"></script>
</body>
</html>