<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList,com.safefood.model.domain.Food"%>
<%@ page import="java.util.ArrayList,com.safefood.model.domain.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String sess_id = (String) request.getSession().getAttribute("loginid");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<meta name="description"
	content="The Project a Bootstrap-based, Responsive HTML5 Template">
<meta name="author" content="author">
<!-- Mobile Meta -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Favicon -->
<link rel="shortcut icon" href="images/favicon.ico">
<!-- Web Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i,700,700i"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:300,400,700"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Pacifico"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=PT+Serif"
	rel="stylesheet">
<!-- Bootstrap core CSS -->
<!-- Plugins -->
<link href="plugins/magnific-popup/magnific-popup.css" rel="stylesheet">
<link href="css/animations.css" rel="stylesheet">
<link href="plugins/slick/slick.css" rel="stylesheet">
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
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {

		console.log("start");
		$(".page-link").click(function() {
			curpage = $(this).text();
		});
		
		var userallergy = '${userallergy}';
		userallergy = userallergy.trim();
		console.log(userallergy);
		userallergy = userallergy.split(",");
		
		var foodallergy = '${food.allergy}'.trim();
		var result = "";
		
		if(foodallergy==''){
			result = "알레르기 성분 없음";
		}else {
			foodallergy = foodallergy.split(" ");
			var check;
			for(var i=0; i<foodallergy.length; i++){
				check = false;
				for(var j=0; j<userallergy.length; j++){
					if(userallergy[j]==foodallergy[i]){
						check = true;
						break;
					}
				}
				if(check){
					result += "<span class='warn'>"+foodallergy[i]+" </span>";
				} else {
					result += "<span>"+foodallergy[i]+" </span>";
				}
			}
			
		}
		$('#allergycheck').html(result);
	});
	function intake(){
		var frm = document.getElementById("food_action");
		frm.action="insertintake.do";
		frm.submit();
	}
	function cart(){
		var frm = document.getElementById("food_action");
		frm.action="cartinsert.do";
		frm.submit();
	}
</script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
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
#detail th{
	width: 35%;
}
#detail td {
	width: 65%;
}
.warn	{
	color: red;
	font-weight: bold;
}
</style>
<script type="text/javascript">
	google.charts.load("current", {
		packages : [ "corechart" ]
	});
	google.charts.setOnLoadCallback(drawChart);
	function drawChart() {
		var data = google.visualization.arrayToDataTable(
				[	[ ''	, '' 			],
					[ '칼로리'	, ${food.calory}	],
					[ '탄수화물'	, ${food.carbo} 	],
					[ '단백질'	, ${food.protein}	],
					[ '지방'		, ${food.fat}		],
					[ '당류'		, ${food.sugar} 	],
					[ '나트륨'	, ${food.natrium}*0.01	],
					[ '콜레스테롤'	, ${food.chole}		],
					[ '포화지방산'	, ${food.fattyacid}	],
					[ '트랜스지방'	, ${food.transfat}	]
				]);

		var options = {
			title : '영양정보',
			is3D : true,
		};

		var chart = new google.visualization.PieChart(document
				.getElementById('piechart_3d'));
		chart.draw(data, options);
	} 
</script>
<style type="text/css">
.inner-container {
	width: 70%;
}
#please, #please * {
	padding: 0px;
	margin:0px;
}
</style>
</head>
<body>
	<!-- page wrapper start -->
	<!-- ================ -->
	<div class="page-wrapper">
		<!-- header-container end -->
		<div id="head">
			<jsp:include page="menu_food.jsp" />
			<section class="main-container">
				<div class="inner-container center">
					<div class="row">
						<div class="col-sm-3">
							<img width='200' src='${food.img }' class="center" id="prodImg0" style="margin:auto;">
							<div class="overlay-top">
								<div class="text">
									<h3>
										<a id="prodName0"></a> ${food.name }
									</h3>
								</div>
							</div>
						</div>

						<div class="col-sm-4">
							<table class="table" id="detail">
								<tr>
									<th>제품이름</th>
									<td>${food.name}</td>
								</tr>
								<tr>
									<th>제조사이름</th>
									<td>${food.maker}</td>
								</tr>
								<tr>
									<th>제품칼로리</th>
									<td>${food.calory}</td>
								</tr>
								<tr>
									<th>첨가물</th>
									<td>${food.material}</td>
								</tr>
								<tr>
									<th>알레르기성분</th>
									<td>
										<c:choose>
											<c:when test="${food.allergy eq ' ' }">
												알레르기 성분 없음
											</c:when>
											<c:otherwise>
												<p id="allergycheck" > </p>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
									<%
									if (sess_id != null) {
									%>
								<tr>
									<td colspan="2">
									<form id="food_action" action="userintake.do" method="get" class="center">
									<input type="hidden" id="intakecode" name="intakecode" value="0"> 
									<input type="hidden" id="code" name="code" value=${food.code }> 
									<input type="hidden" id="id" name="id" value=<%=sess_id %>>
									
									
									<div >
											<input type="number" id="quantity" name="quantity" class="input-xlarge" value=1>
									</div>

									<div>
										<button class="btn btn-success" onclick="intake()">섭취하기</button>
										<button class="btn btn-info" onclick="cart()">찜하기</button>
									</div>
									</form>
									</td>
								</tr>
									<%
									}
									%>
							</table>
						</div>
						<div class="col-sm-5" style="height:400px;" id="please">
								<div id="piechart_3d" class="center"
									style="width: 100%; height: 100%; float: left;">
								</div>
						</div>
						
					</div>
					<!-- main end -->
				</div>
		</section>
		</div>

		<!-- main-container end -->
		<footer>
			<jsp:include page="copyright_food.jsp" />
		</footer>
	</div>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
