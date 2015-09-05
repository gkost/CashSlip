<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logged out</title>
</head>
<body>
	<%
		session.removeAttribute("loginUser");
	%>
	
	<c:remove var="year" scope="session" />
	<c:remove var="month" scope="session" />
	
	<c:redirect url="login.jsp">
	</c:redirect>
	<a href="index.jsp">Go to LogIn page</a>
</body>
</html>