<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%-- Check if the user is logged in --%>
	<c:if test="${empty sessionScope['loginUser']}">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>

	<c:out value="Year: ${sessionScope['year']}" />
	<c:out value="Month: ${sessionScope['month']}" />
	<c:out value="Day: ${param.day}" />
	<c:out value="Product: ${param.names}" />

	<c:if
		test="${not empty sessionScope['year'] and not empty sessionScope['month'] and not empty param.day}">

		<sql:setDataSource var="ds" dataSource="/jdbc/demo" />
		<sql:update var="rows" dataSource="${ds }"
			sql="delete from cashslip 
			where day=? and product=?
			and Date_id in (select id from date
			where month=? and year=?)">
			<sql:param value="${param.day }"/>			
			<sql:param value="${param.product }"/>
			<sql:param value="${sessionScope['month']}"/>
			<sql:param value="${sessionScope['year'] }"/>
		</sql:update>

<c:redirect url="edit.jsp" >
<c:param name="day" value="${param.day }"></c:param>
</c:redirect>


	</c:if>
</body>
</html>