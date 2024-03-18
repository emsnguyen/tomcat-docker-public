// validate-config.js

$(document).ready(function() {
    // Thêm quy tắc validate chung tại đây
    $.validator.addMethod("customEmail", function(value, element) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
    }, "Invalid email address");

    // Cấu hình validate cho biểu mẫu đăng nhập
    $('#login-form').validate({
        rules: {
            email: {
                required: true,
                customEmail: true
            },
            password: {
                required: true
            }
        },
        messages: {
            email: {
                required: "Please enter your email address",
                customEmail: "Please enter a valid email address"
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

    // Cấu hình validate cho các biểu mẫu khác tại đây nếu cần
});
