<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript" src="https://unpkg.com/vue"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var userallergy = '${userallergy}';
		userallergy = userallergy.trim();
		console.log(userallergy);
		userallergy = userallergy.split(",");
		
		$(".allergy").each(function(){
			console.log(this.value);
			console.log(this.id);
			var foodallergy = this.value.trim();
			console.log("/"+foodallergy+"/");
			var id;
			if(foodallergy!=""){
				foodallergy = foodallergy.split(" ");
				for(var i=0; i<foodallergy.length; i++){
					for(var j=0; j<userallergy.length; j++){
						if(userallergy[j]==foodallergy[i]){
							id = "#" + this.id + "top";
							$(id).css("background-color", "rgba(255, 163, 163, 0.5)");	
							id = "#" + this.id + "bottom";
							$(id).css("background-color", "rgba(255, 163, 163, 0.5)");	
						}
					}
				}
			}
		})
	})
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
	<!-- scrollToTop -->
	<!-- ================ -->
	<!-- page wrapper start -->
	<!-- ================ -->
	<div class="page-wrapper">
	<div id="head">
		<jsp:include page="menu_food.jsp" />
	</div>
		<!-- header-container end -->
		<section class="main-container">
			<div class="container">
				<div class="row">
					<!-- main start -->
					<!-- ================ -->
					<div class="main col-12">
						<!-- page-title start -->
						<!-- ================ -->
						<c:if test="${empty list}">
							<div>
								<form action="loaddata.do">
									<button type="submit" class="btn btn-success">데이터 로드하기</button>
								</form>
							</div>
						</c:if>

						<div class=" row grid-space-10" id="foodcontainer">
							<c:forEach var="food" items="${list }">
								<div class="col-lg-4 col-md-6 isotope-item app-development">
									<div class="image-box hc-shadow-2 text-center mb-20">
										<div class="overlay-container">
											<img width='200' src=${food.img } class="center"
												id="prodImg0">
											<div class="overlay-top" id="${food.code }top" >
												<div class="text">
													<h3>
														<a id="prodName0"></a> ${food.name }
													</h3>
												</div>
											</div>
											<input type="hidden" class="allergy" id="${food.code }" value="${food.allergy }">
											<div class="overlay-bottom" id="${food.code}bottom" >
												<div class="links">
													<a class="btn btn-gray-transparent btn-animated btn-sm"
														id="info0" href="foodview.do?code=${food.code }">상품
														정보로 이동 <i class="+pl-10 fa fa-arrow-right"></i>
													</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<!-- main end -->
					</div>
				</div>
			</div>
			<div class="bottom">
				<center>${bean.pagelink}</center>
			</div>
		</section>
		<!-- main-container end -->
		<footer>
			<jsp:include page="copyright_food.jsp" />
		</footer>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
