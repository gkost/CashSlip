<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.ArrayList, java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Expenditures</title>
<link
	href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
	rel="stylesheet">
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="./style/table.css" />
<link rel="stylesheet" type="text/css" href="./style/index.css" />
<style>
</style>

</head>
<body>
	<c:if test="${empty sessionScope['loginUser']}">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>
	<sql:setDataSource var="ds" dataSource="/jdbc/demo" />

	<div id="topbar">

		<div class="fixedwith">
			<div id="logodiv">
				<!-- put logo image here -->
				<img src="images/logoexp.png" />
			</div>
			<div id="logoutdiv">
				<a href="logout.jsp" style="text-decoration: none;">Logout,
					${sessionScope['loginUser']} </a>
			</div>

		</div>
	</div>
	<div class="break"></div>

	<div id="titlebar">
		<div class="fixedwith">
			<div id="titleheader">
				Cash slips <span id="username"></span>
			</div>
			<div class="break"></div>
			<div id="topicmenu">

				<form action="setparameters.jsp" class="menuform" id="selectform">

					<sql:query var="resy" dataSource="${ds }"
						sql="select distinct year from date
								order by year desc">
					</sql:query>

					<select class="dateOptions" name="year" id="year">
						<c:choose>


							<c:when test="${empty sessionScope['year'] }">

								<c:set scope="session" var="year" value="${resy.rows[0].year }" />

								<c:forEach items="${resy.rows}" var="r1">
									<option ${r1.year eq  sessionScope['year'] ? 'selected' :''}>${r1.year}</option>
								</c:forEach>
							</c:when>

							<c:otherwise>
								<c:forEach items="${resy.rows}" var="r1">
									<option ${r1.year eq  sessionScope['year'] ? 'selected' :''}>${r1.year}</option>
								</c:forEach>
							</c:otherwise>

						</c:choose>
					</select>
					
					<sql:query var="resm" dataSource="${ds }"
						sql="select month from date where year=?
						order by month desc">
						<sql:param value="${sessionScope['year']}"></sql:param>
					</sql:query>


					<select class="dateOptions" name="month" id="month">
					<c:choose>
							<c:when test="${empty sessionScope['month'] }">

								<c:set scope="session" var="month" value="${resm.rows[0].month }" />

								<c:forEach items="${resm.rows}" var="r2">
									<option ${r2.month eq  sessionScope['month'] ? 'selected' :''}>${r2.month}</option>
								</c:forEach>
							</c:when>

							<c:otherwise>
								<c:forEach items="${resm.rows}" var="r2">
									<option ${r2.month eq  sessionScope['month'] ? 'selected' :''}>${r2.month}</option>
								</c:forEach>
							</c:otherwise>					
					
					</c:choose>

						
						
					</select>
				</form>
				<div id="selectbutton">
					<p>Select</p>
				</div>

				<div id="editform">
					<form action="edit.jsp" id="editstuff">
						<div>
							<p>Day:</p>
							<p>
								<span id="select-result"></span>
							</p>
						</div>


						<input type="hidden" name="day" id="s23">
					</form>
				</div>
				<div id="editbutton">
					<p>Edit</p>
				</div>
			</div>
		</div>
	</div>

	<div class="break"></div>

	<div id="cashbody">
		<div class="fixedwith">
			<div id="selectable-1">
				<%-- Grab distinct days --%>
				<sql:query var="slipresult" dataSource="${ds}"
					sql="select distinct(day) from cashslip
		where Date_id in(
		select id from date
		where month=? and year=?)
		order by day desc">
					<sql:param value="${sessionScope['month']}" />
					<sql:param value="${sessionScope['year']}" />
				</sql:query>




				<c:forEach items="${slipresult.rows }" var="sr">

					<%-- make query for every distinct day --%>
					<sql:query var="slip" dataSource="${ds}"
						sql="select product, cost from cashslip
		where Date_id in(
		select id from date
		where month=? and year=?) and day=?">
						<sql:param value="${sessionScope['month']}" />
						<sql:param value="${sessionScope['year']}" />
						<sql:param value="${sr.day}" />
					</sql:query>

					<c:set var="daytemp" value="${sr.day }" scope="page" />

					<table class="cashslip">
						<tr>
							<th><span class="day">${sr.day}</span>,Product</th>
							<th>Price</th>
						</tr>
						<c:set var="total" value="0"></c:set>
						<c:forEach items="${slip.rows}" var="r">
							<c:set var="total" value="${total + r.cost}" />
							<tr>
								<td>${r.product}</td>
								<td>${r.cost}</td>
							</tr>
						</c:forEach>
						<tr id="tableFooter">
							<td>Total</td>
							<td>${total}</td>
						</tr>
					</table>
					<br />
					<c:set var="grandTotal" value="${grandTotal + total }" />
				</c:forEach>


			</div>


			<div id="summary">

				<div id="grandtotal">
					<p>Grand Total</p>
					<div id="grandbox">${grandTotal }</div>
				</div>


				<%-- Take the money for the given Year - Month period --%>
				<sql:query var="mon" dataSource="${ds }"
					sql="select monthMoney from date
	where month=? and year=? ">
					<sql:param value="${sessionScope['month']}" />
					<sql:param value="${sessionScope['year']}" />
				</sql:query>

				<div id="monthmoney">
					<p>Month money</p>
					<div id="monthbox">${mon.rows[0].monthmoney }</div>
				</div>

				<div id="remainmoney">
					<p>Remain money</p>
					<div id="remainbox">${mon.rows[0].monthmoney -grandTotal}</div>
				</div>

			</div>


		</div>
	</div>


	<div class="break"></div>

	<div id="editproduct">
		<div class="fixedwith">
			<div id="edit1">
				<form id="target" action="insertproduct.jsp">

					<jsp:useBean id="date" class="java.util.Date" />

					<span class="label">Product:</span> <input type="text"
						name="product" id="productin" value="" /> <span class="label">Price:</span>
					<input type="text" name="price" id="pricein" />
					<div class="break"></div>

					<div id="date">
						<span class="label">Year:</span> <input type="text" name="year"
							id="yearin"
							value="<fmt:formatDate value="${date }" pattern="yyyy" />">

						<span class="label">Month:</span> <input type="text" name="month"
							id="monthin"
							value="<fmt:formatDate value="${date }" pattern="MM" />" /> <span
							class="label">Day:</span> <input type="text" name="day"
							id="dayin"
							value="<fmt:formatDate value="${date }" pattern="dd" />" />
						<div id="addbutton">
							<p>Add</p>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>





	<script>
		$(function() {
			$("#selectable-1").selectable({
				stop : function() {
					var result = $("#select-result").empty();
					var result2 = $("#s23").empty();
					var theader = $(".ui-selected th .day", this).html();
					result.append(theader);
					result2.val(theader)
				}
			});
		});

		$("#addbutton").click(
				function() {
					if (!$.trim($("#productin").val()).length
							|| !$.trim($("#pricein").val()).length
							|| !$.trim($("#yearin").val()).length
							|| !$.trim($("#monthin").val()).length
							|| !$.trim($("#dayin").val()).length) {
						alert("Fill in all the fields!");
					} else {
						$("#target").submit();
					}
				});

		$("#editbutton").click(function() {

			if (!$.trim($("#select-result").html()).length) {
				alert("Please, slect cash slip to edit!")
			} else {
				$("#editstuff").submit();
			}
		});

		$("#selectbutton").click(function() {
			$("#selectform").submit();
		});

		$("#monthbox").click(function() {

			if (!$.trim($("#monthbox").html()).length) {
				alert("Please, slect a date first!")
			} else {
				window.location = "insertmoney.jsp";
			}
		});
		
		$("#year").change(function() {
			$("#selectform").submit();
		});
		
		$("#month").change(function() {
			$("#selectform").submit();
		});
	</script>
</body>
</html>