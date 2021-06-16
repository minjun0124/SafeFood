<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sess_id = (String) request.getSession().getAttribute("loginid");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.js"></script>
<style type="text/css">
body {
	padding-top: 100px
}

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

.listtr {
	cursor: pointer;
}
</style>
</head>
<body>
	<div id="head">
		<jsp:include page="menu.jsp" />
	</div>
	<br>
	<br>
	<div class="page-wrapper">
		<div align="center">
			<h2>
				<strong>Q & A</strong>
			</h2>
		</div>
		<!-- header-container end -->
		<section id="qnatable" class="main-container">
			<div class="container">
				<div class="row">
					<!-- main start -->
					<!-- ================ -->
					<div class="main col-12">
						<!-- page-title start -->
						<!-- ================ -->

						<div>
							<div align="left" style="width: 150px;">
								<input type="text" name="word" class="form-control"
									placeholder="검색" v-model="word" @keyup.enter='searchTitle'
									v-cloak>
							</div>
							<table class="table table-hover">
								<tr>
									<th style="width: 10%;">번호</th>
									<th style="width: 10%;">답변</th>
									<th style="width: 50%;">제목</th>
									<th style="width: 15%;">글쓴이</th>
									<th style="width: 15%;">등록일</th>
								</tr>
								<template v-for="question in info">
								<tr class="listtr">
									<td>{{question.qcode}}</td>
									<td><span v-if="isAnswered(question.isanswered)"
										class="label label-success">답변완료</span> <span v-else
										class="label label-danger">답변대기</span></td>
									<td @click="questionDetail(question.qcode)">{{question.title}}</td>
									<td>{{question.id}}</td>
									<td>{{question.date}}</td>
								</tr>
								</template>

							</table>
							<%
								if (sess_id != null) {
							%>
							<div align="center">
								<button type="button" class="btn btn-primary"
									@click="questionInsert">작성하기</button>
							</div>
							<%
								}
							%>
						</div>


						<!-- main end -->
					</div>
				</div>
			</div>
			<div class="bottom">
				<!-- <div align="center" v-html="bean.pagelink"></div> -->
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
	<script type="text/javascript">
		var qnatable = new Vue({
			el : '#qnatable',
			data : {
				info : null,
				loading : true,
				error : false,
				word : ''
			}
			 , mounted : function(){
				axios.get('http://70.12.108.177:8197/SafeFoodBoot/api/searchAllQ')
					.then( response => (this.info = response.data))
					.catch(error => {
						console.log(error)
						this.errored = true;
					})
					.finally( () => this.loading=false )
					
				/* axios.get('http://localhost:8197/SafeFoodBoot/api/getPageBean')
					.then( response => (this.info = response.data))
					.catch(error => {
						console.log(error)
						this.errored = true;
					})
					.finally( () => this.loading=false ) */
			}
			,
			methods : {
				questionDetail : function(qcode) {
					location.href = "qdetail.jsp?qcode=" + qcode;
				},
				questionInsert : function() {
					location.href = "qinsert.jsp";
				}
				,searchTitle : function() {
					console.log(this.word)
					console.log(encodeURI(this.word, "UTF-8"))
					info = null
					loading : true
					error : false
					axios.get('http://70.12.108.177:8197/SafeFoodBoot/api/searchQbyTitle/'+encodeURI(this.word, "UTF-8"))
						.then(response => (this.info = response.data))
						.catch(error => {
							console.log(error)
							this.errored = true;
						})
						.finally( ()=> this.loading=false);
				}
				, isAnswered : function(isanswered){
					if(isanswered == 'y')
						return true
					else return false
				}
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