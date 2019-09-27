<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reviewPwForm</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
	<div class="jumbotron text-center">
		<h1>HWARANG</h1>
		<p>Your own exhibition</p>
	</div>
	<div align="center">
		<h3>Please enter a password to ${param.button}.</h3>
		<form action="checkPw" method="post">
			<input type="hidden" name="button" value="${param.button }">
			<input type="hidden" name="num" value="${param.num}">
			<input type="hidden" name="id" value="${param.id}">
			<input type="password" name="pw">
			<input type="submit" value="ok">
		</form>
	</div>
</div>
</body>
</html>