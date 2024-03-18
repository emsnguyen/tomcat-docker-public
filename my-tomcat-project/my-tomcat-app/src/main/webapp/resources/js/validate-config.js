// validate-config.js

//-- Login Form --//
$(document).ready(function() {
    $('#login-form').submit(function(event) {
        event.preventDefault(); // Ngăn chặn sự kiện submit mặc định

        var email = $('#email').val();
        var password = $('#password').val();
        if (email !== '' && password !== '' ) {
            $.ajax({
                url: 'loginServlet', 
                type: 'POST',
                data: {
                    email: email,
                    password: password
                },
                success: function(response) {
                    if (response === 'notfound') {
                        $('#not-found-error').text('Email or password does not match');
                    } else {
                        // Kiểm tra xem có lỗi nào khác không
                        if ($('#login-form').valid()) {
                            $('#login-form').unbind('submit').submit(); // Gửi form nếu không có lỗi
                        }
                    }
                }
            });
        }
    });

    $('#login-form').validate({
        rules: {
            email: {
                required: true,
                email: true
            },
            password: {
                required: true
            }
        },
        messages: {
            email: {
                required: "Please enter your email address",
                email: "Please enter a valid email address"
            },
            password: {
                required: "Please enter your password"
            }
        },
        errorElement: 'span',
        errorPlacement: function(error, element) {
            error.addClass('error-message');
            error.insertAfter(element);
        }
    });
});

//-- Register Form --//
$(document).ready(function() {
    $('#register-form').submit(function(event) {
        event.preventDefault(); // Ngăn chặn sự kiện submit mặc định

        var name = $('#name').val();
        if (name !== '') {
            $.ajax({
                url: 'registerServlet', 
                type: 'POST',
                data: {
                    name: name
                },
                success: function(response) {
                    if (response === 'exists') {
                        $('#exists-error').text('Another user with this name has already existed. Please use another one');
                    } else {
                        // Kiểm tra xem có lỗi nào khác không
                        if ($('#register-form').valid()) {
                            $('#register-form').unbind('submit').submit(); // Gửi form nếu không có lỗi
                        }
                    }
                }
            });
        }
    });

    $('#register-form').validate({
        rules: {
            name: {
                required: true
            },
            email: {
                required: true,
                email: true
            },
            pass: {
                required: true,
                minlength: 5
            },
            re_pass: {
                required: true,
                equalTo: '#pass'
            }
        },
        messages: {
            name: {
                required: "Please enter your name."
            },
            email: {
                required: "Please enter your email.",
                email: "Please enter a valid email address."
            },
            pass: {
                required: "Please enter your password.",
                minlength: "Your password must be at least 5 characters long."
            },
            re_pass: {
                required: "Please enter the same password as above",
                equalTo: "Please enter the same password as above"
            }
        },
        errorElement: 'span',
        errorPlacement: function(error, element) {
            error.addClass('error-message');
            error.insertAfter(element);
        },
        highlight: function(element, errorClass, validClass) {
            $(element).addClass(errorClass).removeClass(validClass);
            $(element).siblings('.error-message').addClass('error-message-active');
        },
        unhighlight: function(element, errorClass, validClass) {
            $(element).removeClass(errorClass).addClass(validClass);
            $(element).siblings('.error-message').removeClass('error-message-active');
        }
    });
});

