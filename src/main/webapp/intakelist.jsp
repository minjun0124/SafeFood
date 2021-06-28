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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="https://unpkg.com/vue"></script>
<script type="text/javascript">
	function updatebtn(code){
		var frm = document.getElementById("upintake"+code);
		frm.action="intakeupdate.do";
		frm.submit();
	}
	function deletebtn(intakecode){
		location.href="intakedelete.do?intakecode="+intakecode;
	}
	google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['', ''],
        [ '칼로리'	, ${sum.calorie}	],
		[ '탄수화물'	, ${sum.carbohydrate} 	],
		[ '단백질'	, ${sum.protein}	],
		[ '지방'		, ${sum.fat}		],
		[ '당류'		, ${sum.sugar} 	],
		[ '나트륨'	, ${sum.sodium}*0.01	],
		[ '콜레스테롤'	, ${sum.cholesterol}		],
		[ '포화지방산'	, ${sum.fattyAcid}	],
		[ '트랜스지방'	, ${sum.transFat}	]
      ]);

      var options = {
        chart: {
          title: '총 섭취 영양성분',
        },
        bars: 'horizontal' // Required for Material Bar Charts.
      };

      var chart = new google.charts.Bar(document.getElementById('barchart_material'));

      chart.draw(data, google.charts.Bar.convertOptions(options));
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
		<div class="container " style="text-align: center;">
			<jsp:useBean id="pagebean" class="com.safefood.model.domain.PageBean" scope="request"></jsp:useBean>
			<form action="intakelist.do" method="get" id="searchForm">
				<table style="width: 100%; " class="center">
				<tbody style="width: 100%; ">
					<tr style="width: 100%; ">
						<td style="width: 40%;padding:10px;">
							<div>
								<select name="key" id="key" v-model="key" class="form-control">
									<option value="code">제품코드</option>
									<option value="year">섭취년도</option>
									<option value="month">섭취월</option>
								</select> <select name="word" id="word" class="form-control">
									<option v-if="key=='code'" v-for="code in codes"
										v-bind:value="code">{{code}}</option>
									<option v-if="key=='year'" v-for="year in years"
										v-bind:value="year">{{year}}</option>
									<option v-if="key=='month'" v-for="month in months"
										v-bind:value="month">{{month}}</option>
								</select>
							<button type="submit" class="btn btn-info"
								style="width: 100%; height: 100%;">검색</button>
							</div>

						</td>

						<td style="width: 60%;padding-left:100px;">
							<div  style=" display:inline-block;">
								<div id="barchart_material" style="width: 600PX; height: 300px;"></div>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
			</form>
		</div>
		<div class="container" style="text-align: center;">
			<table class="table table-hover">
				<tr class="tabler">
					<th class="tablekey">상품코드</th>
					<th class="tablekey">상품이미지</th>
					<th class="tablekey">섭취일자</th>
					<th class="tablekey"></th>
					<th class="tablekey"></th>
				</tr>
				<c:forEach var="intake" items="${list }">
					<form method="get" id="upintake${intake.code}" name="upintake">
					<tr>
						<td class="tableval"><br />
						<br />
						<br />${intake.code }</td>
						<td class="tableval">
							<div class=" row grid-space-10">
								<div class="col-lg-4 col-md-6 isotope-item app-development">
									<div class="image-box hc-shadow-2 text-center mb-20">
										<div class="overlay-container">
											<img src=${intake.imgPath } class="center"
												id="prodImg0">
											<div class="overlay-top"></div>
											<div class="overlay-bottom">
												<div class="links">
													<a class="btn btn-gray-transparent btn-animated btn-sm"
														id="info0" href="foods/detail?code=${intake.code }">상품
														정보로 이동 <i class="+pl-10 fa fa-arrow-right"></i>
													</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</td>
						<td class="tableval">${intake.intakedate }</td>
						<td class="tableval">
							<input type="number" name="quantity" style="width: 30%" placeholder="${intake.quantity }" /><br/>
							<input type="hidden" name="code" class="form-control" style="width: 30%" value="${intake.code }"/>
							<input type="hidden" name="id" class="form-control" style="width: 30%" value="${loginid }"/>
							<input type="hidden" name="intakecode" class="form-control" style="width: 30%" value="${intake.intakecode }"/>
							<button class="btn btn-info" type="submit" onclick="updatebtn(${intake.code })">
								<b>수 정</b>
							</button>
						</td>
						<td class="tableval">
							<button class="btn btn-info" type="button" onclick="deletebtn(${intake.intakecode})">
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
	<script type="text/javascript">
		var searchForm = new Vue({
			el : '#searchForm',
			data : {
				key : '',
				codes : ${codes},
				years : ${years},
				months : ${months}
			}
		})
		window.onload = function() {
			var id = "<%=sess_id%>";
			if (id == "null") {
				console.log("is in")
				location.href="/SafeFoodSpring/reIndex.do?msg='loginplz'";
			}
		};
	</script>
</body>
</html>