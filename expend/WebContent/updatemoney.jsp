<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Updating</title>
</head>
<body>
	<%-- Check if the user is logged in --%>
	<c:if test="${empty sessionScope['loginUser']}">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>

	<c:if
		test="${not empty sessionScope['year'] and not empty sessionScope['month'] and not empty param.newmoney}">

		<sql:setDataSource var="ds" dataSource="/jdbc/demo" />
		<sql:update var="rows" dataSource="${ds }"
			sql="update date set monthMoney=?
			where month=? and year=?">
			<sql:param value="${param.newmoney }"/>
			<sql:param value="${sessionScope['month']}"/>
			<sql:param value="${sessionScope['year'] }"/>
		</sql:update>

<c:redirect url="index.jsp" >
</c:redirect>


</c:if>	
	
</body>
</html>