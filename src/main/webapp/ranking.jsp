<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="<%=request.getContextPath()%>" scope="application"/>

<% String key = (String)request.getParameter("key"); 
	System.out.println(key);
	if(key==null || key.equals("intake")){
		key = "섭취횟수";
	}else if(key.equals("search")){
		key = "조회수";
	}
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
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link href="css/typography-default.css" rel="stylesheet">
<!-- Color Scheme (In order to change the color scheme, replace the blue.css with the color scheme that you prefer) -->
<link href="css/skins/light_blue.css" rel="stylesheet">
<!-- Custom css -->
<link href="css/custom.css" rel="stylesheet">
<title>Insert title here</title>
<script src="js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="https://unpkg.com/vue"></script>
<script type="text/javascript">
	window.onload = function(){
		$('#<%=key%>').addClass('active');
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
table, table * {
	text-align:center;
	margin:auto;
}
.imgbox {
	height: 100px;
}
.imgbox img {
	height:100%;
	width:auto;
}
.b {
	width:50%;
	height:60px;
}
.s {
    padding-top: 10px;
    font-size: larger;
}
</style>
</head>
<body>
	<div id="head">
		<jsp:include page="menu.jsp" />
	</div>
	<section class="main-container">
		<div class="container " style="text-align: center;" >
			<form action="${path}/ranking" method="get" id="ranking">
				<div class="btn-group" data-toggle="buttons" style="width:60%;">
					<label class="btn btn-default center b" @click="setKey('intake')" id="섭취횟수" >
						<input type="radio" value="intakecnt" class="center"> <span class="center s">섭취횟수</span>
					</label>
					<label class="btn btn-default center b" @click="setKey('search')" id="조회수"  >
						<input type="radio" value="searchcnt" class="center"><span class="center s">조회수</span>
					</label>
				</div>
			</form>
		</div>
		<div class="container" style="text-align: center;">
			<table class="table table-hover" >
				<tr class="tabler">
					<th style="text-align:center;" >순위</th>
					<th style="text-align:center;"  >상품이미지</th>
					<th style="text-align:center;"  >상품명</th>
					<th style="text-align:center;"  ><%=key %></th>
				</tr>
				<c:forEach var="food" varStatus="status" items="${list }">
					<form method="get" id="upintake${food.code}" name="upintake">
					<tr >
						<td class="cetner" style="vertical-align: middle;" >
						<c:choose>
						<c:when test="${status.count < 4 }">
						<div class="cetner">
							<img src="img/trophy0${status.count }.png" class="cetner">
						</div>
						</c:when>						
						<c:otherwise>
							${status.count}
						</c:otherwise>
						</c:choose>
						</td>
						<td class="tableval" style="vertical-align: middle;">
							<div class="imgbox">
								<a href="${path}/foods/detail?code=${food.code}" >
									<img src=${food.imgPath } class="center" id="prodImg0">
								</a>
							</div>
						</td>
						<td class= "tableval" style="vertical-align: middle;">
							<h3><strong>${food.name}</strong></h3>
						</td>
						<td class="tableval" style="vertical-align: middle;">
							${food.searchcnt}
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
	<script type="text/javascript">
		var ranking = new Vue({
			el : '#ranking',
			data : {
				key : '<%=key%>'
			},
			methods : {
				setKey : function(key){
					console.log(key)
					this.sortkey = key
					console.log(this.sortkey)
					location.href="${path}/ranking?key="+key
				},
				foodview : function(code){
					console.log(code);
					location.href="${path}/foods/detail?code="+code;
				}
			}
		});
	</script>
</body>
</html>