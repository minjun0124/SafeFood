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

<link href="css/style.css" rel="stylesheet">
<link href="css/typography-default.css" rel="stylesheet">
<link href="css/skins/light_blue.css" rel="stylesheet">
<link href="css/custom.css" rel="stylesheet">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

	function updatebtn(code){
		var frm = document.getElementById("upintake"+code);
		frm.action="intakeupdate.do";
		frm.submit();
	}
	function deletebtn(intakecode){
		location.href="intakedelete.do?intakecode="+intakecode;
	}
	window.onload = function() {
		var id = "<%=sess_id%>";
		if (id == "null") {
			console.log("is in")
			location.href="/SafeFoodSpring/reIndex.do?msg='loginplz'";
		}
	};
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
	<table>
	<tr>
	<td>
		<div class="container " style="text-align: left; margin-left: 350px">
			<div style="display: inline-block;">
				<div id="barchart_material" style="width: 1000px; height: 300px;"></div>
			</div>
		</div>
	</td>
	<td>
	<div>
	섭취 적용 목록:<br/>
	<p id="intakeExam"></p>
	<br>
	<br>
	<hr>
	<p> 현재 섭취 목록이 마음에 드세요? </p>
	<button type="button" class="btn btn-info prevIntake" name="intake">
	이대로 섭취하기</button>
	</div>
	</td>
	</tr>
	</table>
		<hr>
		<div style="margin-left: 380px">
		<div>* 아래는 회원님이 찜하신 목록입니다.</div><br/>
		<div> '섭취한다면?' 버튼을 클릭하고 섭취시 예상되는 영양정보를 확인해보세요.</div>
		</div>
		<div class="container" style="text-align: center;">
			<table class="table table-hover">
				<tr class="tabler">
					<th class="tablekey">선 택</th>
					<th class="tablekey">상품이미지</th>
					<th class="tablekey">상품명</th>
					<th class="tablekey">수 량</th>
					<th class="tablekey"></th>
				</tr>
				
				<c:forEach var="food" items="${recommend }">
					<form method="get" id="upcart${food.code}" name="upcart">
						<tr  style="background-color: aliceblue;">
							<td class="tableval"><br />
								<button type="button" class="btn btn-info" name="intake"
									onclick="regraph(${food.code}, '${food.name}', ${food.calory}, ${food.carbo}, ${food.protein}, ${food.fat}, ${food.sugar}, ${food.natrium}, ${food.chole}, ${food.fattyacid}, ${food.transfat})">
									섭취한다면?</button></td>
							<td class="tableval">
								<div class=" row grid-space-10">
									<div class="col-lg-4 col-md-6 isotope-item app-development">
										<div class="image-box hc-shadow-2 text-center mb-20">
											<div class="overlay-container">
												<img src=${food.img } class="center" id="prodImg0">
												<div class="overlay-top"></div>
												<div class="overlay-bottom">
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
								</div>
							</td>
							<td class="tableval">${food.name }</td>
							<td class="tableval"><input type="number"
								id="quantity${food.code}" name="quantity" style="width: 30%"
								placeholder=1 value=1 /><br /></td>
						</tr>
					</form>
				</c:forEach>
				
				<c:forEach var="food" items="${list }">
					<form method="get" id="upcart${food.code}" name="upcart">
						<tr>
							<td class="tableval"><br />
								<button type="button" class="btn btn-info" name="intake"
									onclick="regraph(${food.code}, '${food.name}', ${food.calory}, ${food.carbo}, ${food.protein}, ${food.fat}, ${food.sugar}, ${food.natrium}, ${food.chole}, ${food.fattyacid}, ${food.transfat})">
									섭취한다면?</button></td>
							<td class="tableval">
								<div class=" row grid-space-10">
									<div class="col-lg-4 col-md-6 isotope-item app-development">
										<div class="image-box hc-shadow-2 text-center mb-20">
											<div class="overlay-container">
												<img src=${food.img } class="center" id="prodImg1">
												<div class="overlay-top"></div>
												<div class="overlay-bottom">
													<div class="links">
														<a class="btn btn-gray-transparent btn-animated btn-sm"
															id="info1" href="foodview.do?code=${food.code }">상품
															정보로 이동 <i class="+pl-10 fa fa-arrow-right"></i>
														</a>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</td>
							<td class="tableval">${food.name }</td>
							<td class="tableval"><input type="number"
								id="quantity${food.code}" name="quantity" style="width: 30%"
								placeholder=1 value=1 /><br /></td>
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
	var calory		=	0 ;
	var carbo		=	0 ;
	var protein		=	0 ;
	var fat         =   0 ;
	var sugar       =   0 ;
	var natrium     =   0 ;
	var chole       =   0 ;
	var fattyacid   =   0 ;
	var transfat    =   0 ;
	
	calory		+=	${sum.calory};               
	carbo		+=	${sum.carbo	};             
	protein		+=	${sum.protein};              
	fat         +=  ${sum.fat    };              
	sugar       +=  ${sum.sugar  };              
	natrium     +=  ${sum.natrium}*0.01;         
	chole       +=  ${sum.chole  };              
	fattyacid   +=  ${sum.fattyacid};            
	transfat    +=  ${sum.transfat};             
	
	var intakeExam = document.getElementById('intakeExam');
	var str = "";
	function intakeInfo (code, name, quantity) {
		var intakeReturn = {
				e_code : code
				, e_name : name
				, e_quantity : quantity
				
				,getCode : function () {
					return this.e_code;
				}
				,getName : function () {
					return this.e_name;
				}
				,getQuantity : function () {
					return this.e_quantity;
				}
				,increase : function (quantity) {
					this.e_quantity += quantity
				}
				,addString : function () {
					return this.e_name + " " + this.e_quantity;
				}
				,controlString : function () {
					return this.e_code + " " + this.e_quantity + " ";
				}
				
		};
		return intakeReturn;
	}
	var e_intake = [];
	
	function regraph(code, name,  s_calory, s_carbo, s_protein, s_fat, s_sugar, s_natrium, s_chole, s_fattyacid, s_transfat){
		calory		+=    s_calory		* $("#quantity"+code).val();
		carbo		+=    s_carbo		* $("#quantity"+code).val();
		protein		+=    s_protein		* $("#quantity"+code).val();
		fat         +=    s_fat         * $("#quantity"+code).val();
		sugar       +=    s_sugar       * $("#quantity"+code).val();
		natrium     +=    s_natrium     * $("#quantity"+code).val()*0.01;
		chole       +=    s_chole       * $("#quantity"+code).val();
		fattyacid   +=    s_fattyacid   * $("#quantity"+code).val();
		transfat    +=    s_transfat    * $("#quantity"+code).val();
		var check = true;
		
		for (var i in e_intake) {
			if (e_intake[i].getCode() == code) {
				e_intake[i].increase($("#quantity"+code).val()*1);
				check = false;
				break;
			}
		}
		if (check) {
			e_intake.push(intakeInfo(code, name, $("#quantity"+code).val()*1));
		}
		str = '';
		for (var i in e_intake) {
			str += "<b>" + e_intake[i].addString() + "개" + "</b><br/>";
		}
		intakeExam.innerHTML = str;
		drawChart();
	}
	
	google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['', '1일권장량', '예상섭취량'],
        [ '칼로리'	,2400, calory	],
		[ '탄수화물'	, 360, carbo 	],
		[ '단백질'	, 150, protein	],
		[ '지방'		, 40, fat		],
		[ '당류'		, 30, sugar 	],
		[ '나트륨'	, 20, natrium	],
		[ '콜레스테롤'	, 300, chole	],
		[ '포화지방산'	, 20, fattyacid	],
		[ '트랜스지방'	, 2, transfat	]
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
    
	$(".prevIntake").click(function() {
		var conStr = '';
		for (var i in e_intake) {
			conStr += e_intake[i].controlString();
		}
		var query = {
			"e" : conStr,
			"id" : "<%=sess_id %>"
		};
			console.log(query)
		$.ajax({
			url : "/SafeFoodSpring/intakePrev.do",
			type : "get",
			data : query,
			success : function(data) {
				alert("섭취가 완료되었습니다.")
				location.reload();
			}
		});
	})
    
</script>
</body>
</html>