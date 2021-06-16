<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SafeFood</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
</style>
</head> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sess_id = (String) request.getSession().getAttribute("loginid");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>SafeFood</title>

<!-- Mobile Meta -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- The Project's core CSS file -->
<!-- Use css/rtl_style.css for RTL version -->
<link href="css/style.css" rel="stylesheet">
<!-- The Project's Typography CSS file, includes used fonts -->
<!-- Used font for body: Roboto -->
<!-- Used font for headings: Raleway -->
<!-- Use css/rtl_typography-default.css for RTL version -->
<link href="css/typography-default.css" rel="stylesheet">
<!-- Color Scheme (In order to change the color scheme, replace the blue.css with the color scheme that you prefer) -->
<link href="css/skins/light_blue.css" rel="stylesheet">
<!-- Custom css -->
<link href="css/custom.css" rel="stylesheet">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript">
	function updatebtn(code){
		var frm = document.getElementById("upcart"+code);
		frm.action="cartupdate.do";
		frm.submit();
	}
	function intakebtn(code){
		var frm = document.getElementById("upcart"+code);
		frm.action="cartintake.do";
		frm.submit();
	}
	function deletebtn(code){
		var frm = document.getElementById("upcart"+code);
		frm.action="cartdelete.do";
		frm.submit();
	}
</script>
<style type="text/css">
.pagetop div {
	display: inline-block;
}

.pagetop div h3 {
	color: white;
}

.userinfo {
	background-color: silver;
}

#userbutton * {
	display: inline-block;
}
</style>
</head>
<body>
	<div id="head">
		<jsp:include page="menu.jsp" />
	</div>
	<section class="main-container">
		<div class="container" style="text-align: center;">
			<table class="table table-hover">
				<tr class="tabler">
					<th class="tablekey">상품코드</th>
					<th class="tablekey">상품이미지</th>
					<th class="tablekey">상품명</th>
					<th class="tablekey"></th>
					<th class="tablekey"></th>
				</tr>
				<c:forEach var="cart" items="${list }">
					<form method="get" id="upcart${cart.code}" name="upcart">
					<tr>
						<td class="tableval"><br />
						<br />
						<br />${cart.code }</td>
						<td class="tableval">
							<div class=" row grid-space-10">
								<div class="col-lg-4 col-md-6 isotope-item app-development">
									<div class="image-box hc-shadow-2 text-center mb-20">
										<div class="overlay-container">
											<img src=${cart.img } class="center"
												id="prodImg0">
											<div class="overlay-top"></div>
											<div class="overlay-bottom">
												<div class="links">
													<a class="btn btn-gray-transparent btn-animated btn-sm"
														id="info0" href="foodview.do?code=${cart.code }">상품
														정보로 이동 <i class="+pl-10 fa fa-arrow-right"></i>
													</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</td>
						<td class="tableval">${cart.name }</td>
						<td class="tableval"><input type="number" name="quantity"
							style="width: 30%"
							placeholder="${cart.quantity }" value="${cart.quantity }" /><br/>
							<input type="hidden" name="code"
							class="form-control" style="width: 30%"
							value="${cart.code }"/>
							<input type="hidden" name="id"
							class="form-control" style="width: 30%"
							value="<%=sess_id%>"/>
							<button class="btn btn-info" type="submit"
								onclick="updatebtn(${cart.code })">
								<b>수 정</b>
							</button></td>
						<td class="tableval">
							<button class="btn btn-info" type="submit"
								onclick="intakebtn(${cart.code })">
								<b>섭 취</b>
							</button> <br />
							<button class="btn btn-info" type="submit"
								onclick="deletebtn(${cart.code })">
								<b>삭 제</b>
							</button>
						</td>
					</tr>
					</form>
				</c:forEach>
			</table>
		</div>

	</section>
	<!-- main-container end -->

	<footer>
		<jsp:include page="copyright.jsp" />
	</footer>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>