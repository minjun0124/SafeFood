<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="<%=request.getContextPath()%>" scope="application"/>
<!DOCTYPE html>
<html lang="ko">
<script type="text/javascript">
window.onload = function() {
	if ('${msg }' == 'loginplz') {
		alert("로그인 후 이용해주세요.");
	}
};
</script>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SafeFood</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
</style>
</head>
<body>
	<div id="head">
		<jsp:include page="menu.jsp" />
	</div>
	<div class="page-wrapper">
		<!-- main-container start -->
		<!-- ================ -->
		<section class="main-container">

			<div class="container">

				<div class="row float-sm-left">
					<div class="col-sm-6 float-sm-left">
						<div id="carousel-example-generic"
							class="carousel slide float-sm-left" data-ride="carousel"
							style="width: 600px; height: 400px;">
							<!-- Indicators -->
							<ol class="carousel-indicators">
								<li data-target="#carousel-example-generic" data-slide-to="0"
									class="active"></li>
								<li data-target="#carousel-example-generic" data-slide-to="1"></li>
								<li data-target="#carousel-example-generic" data-slide-to="2"></li>
							</ol>
							<!-- Wrapper for slides -->
							<div class="carousel-inner" role="listbox">
								<div class="item active">
									<img src="img/Salad1.jpg" alt="...">
									<div class="carousel-caption">...</div>
								</div>
								<div class="item">
									<img src="img/Salad2.jpg" alt="...">
									<div class="carousel-caption">...</div>
								</div>
								<div class="item">
									<img src="img/Salad3.jpg" alt="...">
									<div class="carousel-caption">...</div>
								</div>
								...
							</div>

							<!-- Controls -->
							<a class="left carousel-control" href="#carousel-example-generic"
								role="button" data-slide="prev"> <span
								class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a> <a class="right carousel-control"
								href="#carousel-example-generic" role="button" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right"
								aria-hidden="true"></span> <span class="sr-only">Next</span>
							</a>
						</div>
					</div>
					<!-- carousel end -->
					<div class="col-sm-6 float-sm-left">
						<div class="row float-sm-left">
							<div class="col-sm-6 float-left">
								<img alt="fruit1" src="img/img1.jpg">
							</div>
							<div class="col-sm-6 float-left">
								<img alt="fruit2" src="img/img2.jpg">
							</div>
						</div>
						<div class="row float-sm-left">
							<div class="col-sm-6 float-left">
								<img alt="fruit1" src="img/img3.jpg">
							</div>
							<div class="col-sm-6 float-left">
								<img alt="fruit2" src="img/img4.jpg">
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- main-container end -->

		<footer>
			<jsp:include page="copyright.jsp" />
		</footer>

	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
		$(".idCheck").click(function() {
			var query = {
				id : $("#id").val()
			};
			console.log(query)
			$.ajax({
				url : "/SafeFoodSpring/idCheck.do",
				type : "post",
				data : query,
				success : function(data) {
					console.log(data)

					if (data == 1) {
						$(".result .msg").text("사용 불가");
						$(".result .msg").attr("style", "color:#f00");
						$("#submit").prop("disabled", true);
						console.log("isin")
					} else {
						$(".result .msg").text("사용 가능");
						$(".result .msg").attr("style", "color:#00f");
						$("#submit").prop("disabled", false);
					}
				}
			});
		});

		$(function() {
			$("#alert-success").hide();
			$("#alert-danger").hide();
			$("#pw").keyup(function() {
				var pw = $("#pw").val();
				var repw = $("#repw").val();
				if (pw != "" || repw != "") {
					if (pw == repw) {
						$("#alert-success").show();
						$("#alert-danger").hide();
						$("#submit").prop("disabled", false);
					} else {
						$("#alert-success").hide();
						$("#alert-danger").show();
						$("#submit").prop("disabled", true);
					}
				}
			});
			$("#repw").keyup(function() {
				var pw = $("#pw").val();
				var repw = $("#repw").val();
				if (pw != "" || repw != "") {
					if (pw == repw) {
						$("#alert-success").show();
						$("#alert-danger").hide();
						$("#submit").prop("disabled", false);
					} else {
						$("#alert-success").hide();
						$("#alert-danger").show();
						$("#submit").prop("disabled", true);
					}
				}
			});
		});
	</script>
</body>
</html>