<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error page</title>
</head>
<body>
	<h1>!!!!!!!!!!!!- Login Error -!!!!!!!!!!!!</h1>
	<h3><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/></h3>
	<h3><c:out value="${msg}"/> </h3>
</body>
</html>