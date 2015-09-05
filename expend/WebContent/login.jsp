<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login page</title>
<style type="text/css">
body {
	font-family: Verdana, Geneva, sans-serif;
}

#wrapper {
	width: 300px;
	height: 300px;
	margin: 0 auto;
	background-color: #F7F7F7;
	border-radius: 11px;
	border: 1px solid lightgray;
}

#wrapper p {
	padding-top: 11px;
	text-align: center;
}

input {
	padding: 5px;
	margin-left: 40px;
	font-size: 0.9em;
	width: 211px;
	margin-bottom: 11px;
}

#sub {
	width: 226px;
}

#message {
	color: red;
	margin-left: 10px;
}
</style>
</head>
<body>
	<div id="wrapper">
		<p>LogIn to your account</p>
		<form action="dologin.jsp" method="post">
			<input type="text" name="username" placeholder="User Name" /><br />
			<input type="password" name="password" placeholder="Password" /><br />
			<input type="submit" value="LogIn" id="sub">
		</form>
		<div id="message">
			<c:if test="${not empty param.errorMessage }">
				<c:out value="${param.errorMessage}" />
			</c:if>
		</div>
	</div>
</body>
</html>