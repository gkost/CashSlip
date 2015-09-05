<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Day "${param.day }"</title>

<link
	href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
	rel="stylesheet">
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="./style/index.css" />
<link rel="stylesheet" type="text/css" href="./style/table.css">
<style>
#fixedwith2 {
	margin: 0 auto;
	width: 400px;
}

#editfield {
	margin: 20px 0 0 0;
}

#editfield input {
	margin-bottom: 10px;
}

#editprbutton {
	height: 30px;
	width: 70px;
	background-color: #98CB4A;
	text-align: center;
	float: left;
}

#editprbutton p {
	position: relative;
	bottom: 11px;
	color: white;
}

#editprbutton:hover {
	cursor: pointer;
	cursor: hand;
}

#deletebutton {
	height: 30px;
	width: 70px;
	background-color: #BB1919;
	text-align: center;
	float: left;
	margin-left: 193px;
}

#deletebutton p {
	position: relative;
	bottom: 11px;
	color: white;
}

#deletebutton:hover {
	cursor: pointer;
	cursor: hand;
}

form input {
	height: 20px;
	font-size: 1.2em;
	padding: 5px;
}

#newpr {
	width: 244px;
}

#newcost {
	width: 60px;
}

#main {
	padding: 5px;
	margin-top: 5px;
float: left;
	border-right: 1px solid #990000;
	width: 110px;
	font-size: 1.1em;
	text-align: center;
}
#logodiv {
	float: left;
}
#bodypage {
margin-top: 10px;
}
</style>

</head>
<body>
	<%-- Check if the user is logged in --%>
	<c:if test="${empty sessionScope['loginUser']}">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>

	<c:if
		test="${not empty sessionScope['year'] and not empty sessionScope['month'] and not empty param.day}">
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
					<div id="titleheader">Edit cash slip</div>
					<div class="break"></div>
					<div id="topicmenu">
						<c:out value="Date: ${param.day }.${sessionScope['month']}.${sessionScope['year']}" />	
					</div>
				</div>
			</div>
			<div class="break"></div>

		<div id="bodypage">
			<div class="fixedwith">
				<%-- make query for the given day day --%>
				<sql:setDataSource var="ds" dataSource="/jdbc/demo" />
				<sql:query var="slip" dataSource="${ds}"
					sql="select product, cost from cashslip
		where Date_id in(
		select id from date
		where month=? and year=?) and day=?">
					<sql:param value="${sessionScope['month']}" />
					<sql:param value="${sessionScope['year']}" />
					<sql:param value="${param.day}" />
				</sql:query>
				<table class="cashslip">
					<thead>
						<tr>
							<th>Product</th>
							<th>Price</th>
						</tr>
					</thead>
					<c:set var="total" value="0"></c:set>
					<tbody class="selectable-2">
						<c:forEach items="${slip.rows}" var="r">
							<c:set var="total" value="${total + r.cost}" />
							<tr>

								<td>${r.product}</td>
								<td class="unselectable">${r.cost}</td>

							</tr>

						</c:forEach>
					</tbody>
					<tfoot>
						<tr id="tableFooter">
							<td>Total</td>
							<td>${total}</td>
						</tr>
					</tfoot>
				</table>
				<div class="break"></div>

				<div id="editfield">
					<form action="updaterow.jsp" id="makeedit">

						<input type="hidden" name=day value="${param.day }"> <input
							type="hidden" name="oldname" id="abc" /> Product: <input
							type="text" name="newproduct" id="newpr" /><br /> Price: <input
							type="text" name="newprice" value="0.00" id="newcost" /><br />
					</form>
					<div id="editprbutton">
						<p>Edit</p>
					</div>

					<div id="deletebutton">
						<p>Delete</p>
					</div>
					<form action="deleteproduct.jsp" id="makedelete">
						<input type="hidden" name="day" value="${param.day }"> 
						<input type="hidden" name="product" id="delproduct">
					</form>
				</div>

			</div>
		</div>

	</c:if>





	<script>
		$(function() {
			$(".selectable-2").selectable({
				stop : function() {
					var result = $("#select-result2").empty();
					var result2 = $("#abc").empty();
					var result3 = $("#newpr").empty();
					var res4 = $("#delproduct").empty();
					var selected = $(".ui-selected td", this).html();
					result.append(selected);
					result2.val(selected);
					result3.val(selected);
					res4.val(selected);
				}
			});
		});

		$("#editprbutton").click(
				function() {
					if (!$.trim($("#newcost").val()).length
							|| !$.trim($("#newpr").val()).length) {
						alert("Fill in the field");
					} else {
						$("#makeedit").submit();
					}
				});
		
		$("#deletebutton").click(
				function() {
					if (!$.trim($("#newpr").val()).length) {
						alert("Select to delete");
					} else {
						$("#makedelete").submit();
					}
				});		
	</script>
</body>
</html>