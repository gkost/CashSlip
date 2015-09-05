<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>
	<c:if test="${empty param.username or empty param.password }">
		<c:redirect url="login.jsp">
			<c:param name="errorMessage"
				value="Please enter Username and Password"></c:param>
		</c:redirect>
	</c:if>

	<c:if test="${not empty param.username and not empty param.password }">
		<sql:setDataSource var="ds" dataSource="/jdbc/demo" />
		<sql:query var="result" dataSource="${ds}">
			SELECT COUNT(*) AS number from users
			WHERE user='${param.username }'
			AND pass='${param.password}'
		</sql:query>

		<c:forEach items="${result.rows}" var="r">
			<c:choose>
				<c:when test="${r.number gt 0 }">
					<c:set scope="session" var="loginUser" value="${param.username }" />
					<c:redirect url="index.jsp"></c:redirect>
				</c:when>
				<c:otherwise>
					<c:redirect url="login.jsp">
						<c:param name="errorMessage"
							value="User name or Password incorrect" />
					</c:redirect>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:if>
</body>
</html>