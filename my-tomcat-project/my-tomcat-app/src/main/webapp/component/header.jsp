<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Freelancer - Start Bootstrap Theme</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="./resources/assets/favicon.ico" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<!-- Đường dẫn tới Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-xMHDyt2KmjN48bI7qzwe3AznZMw03KCH1Kt7eMP4OL9y2H9z2+P58jOVUa4+8wM9Ex0W2I3DzMc20SjQdEM/9A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/251df2663c.js" crossorigin="anonymous"></script>
<script src="./resources/js/validate.js"></script>
<!-- Google fonts-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&display=swap" rel="stylesheet">
<!-- Core theme CSS (includes Bootstrap)-->
<link href="resources/css/index-styles.css" rel="stylesheet" />

</head>
	<body id="page-top">
		<%
			String email = (String) session.getAttribute("email");
			if (email == null) {
				response.sendRedirect("index.jsp");
			}
		%>
		<%@ include file="../component/navigation.jsp" %>