<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update money</title>

<link
	href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
	rel="stylesheet">
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="./style/index.css" />
<style>
body {
	font-family: Verdana, Geneva, sans-serif;
	margin: 0;
}

#moneyinfo p {
color: #7A0000;
}

#submitbutton {
	height: 30px;
	width: 70px;
	background-color: #98CB4A;
	text-align: center;
	float: left;
	color: white;	
	margin-left: 10px;
	margin-top: 2px;
}

#submitbutton p {
	position: relative;
	bottom: 11px;
	color: white;
}

#submitbutton:hover {
	cursor: pointer;
	cursor: hand;
}

#update {
	float: left;
}

#update input {
	float: left;
	height: 20px;
	font-size: 1.1em;
	padding: 5px;
}
#main {
	padding: 5px;
	float: left;
	border-right: 1px solid #990000;
	width: 110px;
	font-size: 1.1em;
	text-align: center;
	margin-top: 5px;
}
</style>
</head>
<body>
	<c:if test="${empty sessionScope['loginUser']}">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>

	<c:if
		test="${not empty sessionScope['year'] and not empty sessionScope['month'] }">

		<div id="container">
			<div id="topbar">

				<div class="fixedwith">
					<div id="logodiv">
						<!-- put logo image here -->
						<img src="images/logoexp.png" />
					</div>
				<div id="main">
					<a href="index.jsp" style="text-decoration: none;">Cash slips</a>
				</div>						
					<div id="logoutdiv">
						<a href="logout.jsp" style="text-decoration: none;">Logout,
							${sessionScope['loginUser']}</a>
					</div>

				</div>
			</div>
			<div class="break"></div>

			<div id="titlebar">
				<div class="fixedwith">
					<div id="titleheader">Update month money</div>
					<div class="break"></div>
					<div id="topicmenu">
						<c:out value="Year: ${sessionScope['year']}" />
						<c:out value="Month: ${sessionScope['month']}" />
					</div>
				</div>
			</div>
			<div class="break"></div>

			<sql:setDataSource var="ds" dataSource="/jdbc/demo" />
			<sql:query var="moneyresult" dataSource="${ds}"
				sql="select monthMoney from date
	where month=? and year=?">
				<sql:param value="${sessionScope['month']}" />
				<sql:param value="${sessionScope['year']}" />
			</sql:query>

			<div id="moneyinfo">
				<div class="fixedwith">
					<p>Month money: ${moneyresult.rows[0].monthMoney}</p>
				

				<form action="updatemoney.jsp" id="update">
					<input type="text" name="newmoney" id="thenew">
				</form>
				<div id="submitbutton">
					<p>Update</p>
				</div>

			</div>
		</div>
</div>







	</c:if>
	<script>
		$("#submitbutton").click(function() {
			if (!$.trim($("#thenew").val()).length) {
				alert("Fill in the field");
			} else {
				$("#update").submit();
			}

		});
	</script>
</body>
</html>