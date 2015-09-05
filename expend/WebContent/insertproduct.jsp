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
	<c:if test="${empty sessionScope['loginUser']}">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>
	<c:choose>
		<c:when
			test="${empty param.year or empty param.month or empty param.day or empty param.price or empty param.product }">
			<c:out value="some of the parameters are empty" />
		</c:when>

		<c:otherwise>
			<sql:setDataSource var="ds" dataSource="/jdbc/demo" />
			<%-- Take the Date_id --%>
			<sql:query var="res1" dataSource="${ds }"
				sql="select id from date where month=? and year=?">
				<sql:param value="${param.month }" />
				<sql:param value="${param.year }" />
			</sql:query>

			<%-- if such date doesn't exist, then create it --%>
			<c:if test="${empty res1.rows[0].id }">
				<sql:update var="upd" dataSource="${ds }"
					sql="insert into date values(null, ${param.month }, ${param.year }, 0.00)">
				</sql:update>

				<%-- Take the Date_id --%>
				<sql:query var="res1" dataSource="${ds }"
					sql="select id from date where month=? and year=?">
					<sql:param value="${param.month }" />
					<sql:param value="${param.year }" />
				</sql:query>
			</c:if>

			<sql:update var="res2" dataSource="${ds }"
				sql="insert into cashslip values(null, ${param.day}, '${param.product }', ${param.price }, ${res1.rows[0].id })">
			</sql:update>

			<div>
				<p>Inserted values:</p>
				<p>Date: ${param.day}.${param.month}.${param.year}</p>
				<p>Product: ${param.product }</p>
				<p>Price: ${param.price }</p>

				<form action="index.jsp">
					<input type="submit" value="Go back to Slips">
				</form>
			</div>
			<c:redirect url="index.jsp"></c:redirect>
		</c:otherwise>

	</c:choose>
</body>
</html>