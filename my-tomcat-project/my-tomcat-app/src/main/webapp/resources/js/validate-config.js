// validate-config.js

//-- Login Form --//
$(document).ready(function() {
    $('#signin').click(function(event) {
        event.preventDefault();
        // Ngăn chặn sự kiện submit mặc định

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
                    } 
                    else {
                        $('#login-form').unbind('submit').submit();
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


//-- Add User Form --//
$(document).ready(function() {
    $('#add-user-form').submit(function(event) {
        event.preventDefault(); // Ngăn chặn sự kiện submit mặc định

        if ($('#add-user-form').valid()) { // Kiểm tra dữ liệu trước khi gửi AJAX
            var email = $('#email').val();
            if (email !== '') {
                $.ajax({
                    url: '/my-tomcat-app/user/insert', 
                    type: 'POST',
                    data: {
                        email: email
                    },
                    success: function(response) {
                        if (response === 'exists') {
                            $('#exists-error').text("Another user with this email has already existed. Please use another one");
                        } else {
                            $('#add-user-form').unbind('submit').submit();
                        }
                    }
                });
            }
        }
    });

    $('#add-user-form').validate({
        rules: {
			name: {
                required: true
            },
            job_id: {
                required: true
            },
            email: {
                required: true,
                email: true
            },
        },
        messages: {
			name: {
                required: "Please enter your name"
            },
            job_id: {
                required: "Please enter your job"
            },
            email: {
                required: "Please enter your email address",
                email: "Please enter a valid email address"
            },
        },
        errorElement: 'span',
        errorPlacement: function(error, element) {
            error.addClass('error-message');
            error.insertAfter(element);
        }
    });
});


//-- Edit User Form --//
$(document).ready(function() {
    $('#edit-user-form').submit(function(event) {
        event.preventDefault();
         if ($('#edit-user-form').valid()) {
	        var userId = $('input[name="id"]').val();
	        var updated_at = $('#updated_at').val();
	        if (userId !== '') {
	            $.ajax({
	                url: '/my-tomcat-app/user/isEdited', 
	                type: 'POST',
	                data: {
	                    id: userId,
	                    updated_at: updated_at
	                },
	                success: function(response) {
                        if (response === 'updated') {
                            alert("The record was updated while you are editing. Please reload!");
                        } else {
                            $('#exists-error').text("");
                            $('#edit-user-form').unbind('submit').submit(); // Gửi form nếu không có lỗi
                        }
                    }
	            });
        	}
        }
    });

    $('#edit-user-form').validate({
        rules: {
            name: {
                required: true
            },
            job_id: {
                required: true
            },
            email: {
                required: true,
                email: true
            },
        },
        messages: {
            name: {
                required: "Please enter your name"
            },
            job_id: {
                required: "Please enter your job"
            },
            email: {
                required: "Please enter your email address",
                email: "Please enter a valid email address"
            },
        },
        errorElement: 'span',
        errorPlacement: function(error, element) {
            error.addClass('error-message');
            error.insertAfter(element);
        }
    });
});



//-- Delete User Form --//
$(document).ready(function() {
    $('#deleteEmployeeModal').on('show.bs.modal', function(event) {
        var button = $(event.relatedTarget);
        var id = button.data('id');
        var updated_at = button.data('updated_at');

        $('#modal-button-delete').data('id', id);
        $('#modal-button-delete').data('updated_at', updated_at);
    });

    $('#modal-button-delete').click(function(event) {
        event.preventDefault();

        var id = $(this).data('id');
        var updated_at = $(this).data('updated_at');

        $.ajax({
            url: '/my-tomcat-app/user/isEdited',
            type: 'POST',
            data: {
                id: id,
                updated_at: updated_at
            },
            success: function(response) {
                if (response === 'updated') {
                    alert("The record was updated while you are editing. Please reload!");
                    window.location.href = '/my-tomcat-app/home';
                }else{
					 window.location.href = '/my-tomcat-app/user/delete?id=' + id;
				}
            }
        });
    });
});





//-- Search Form --//
$.validator.addMethod("maxAgeGreaterThanMin", function(value, element) {
    var minAge = $('#minAge').val();
    var maxAge = $('#maxAge').val();
    if (minAge !== '' && maxAge !== '') {
        return parseInt(minAge) < parseInt(maxAge);
    }
    $('#age-error').text('Age to cannot be bigger than age from.'); // Đặt nội dung thông báo lỗi
    return true; // Nếu một trong hai trường rỗng, không cần kiểm tra
});


$(document).ready(function() {
    $('#search-form').validate({
        rules: {
            minAge: {
                digits: true
            },
            maxAge: {
                digits: true,
                maxAgeGreaterThanMin: true 
            }
        },
        messages: {
       
        },
        errorElement: 'span',
        errorPlacement: function(error, element) {
            error.addClass('error-message');
            error.insertAfter(element);
        }
    });
});
