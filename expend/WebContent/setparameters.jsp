<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<c:if test="${empty sessionScope['loginUser']}">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>
	
	<c:if test="${not empty param.year }">
		<c:set scope="session" var="year" value="${param.year }" />
	</c:if>
	
	<c:if test="${not empty param.month }">
		<c:set scope="session" var="month" value="${param.month }" />
	</c:if>
	
	<c:redirect url="index.jsp">	
	</c:redirect>	
</body>
</html>