$().ready(function() {
	$("#register-form").validate({
		onfocusout: false,
		onkeyup: false,
		onclick: false,
		rules: {
			"username": {
				required: true,
			},
			"password": {
				required: true,
				minlength: 5
			},
			"re_pass": {
				equalTo: "#password"
			},
			"name": {
				required: true,
			},
			"contact": {
				required: true,
				email: true
			},
		},
		messages: {
			"username": {
				required: "Please enter your username.",
			},
			"password": {
				required: "Please enter your password.",
				minlength: "Your password must be at least 5 characters long."
			},
			"re_pass": {
				equalTo: "Please enter the same password as above",
			},
			"name": {
				required: "Please enter your name.",
			},
			"contact": {
				required: "Please enter your email.",
				email: "Please enter a valid email address."
			},
		}
	});
});
