<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	<div class="page-wrapper">
		<div align="center">
			<h2><strong>문의 등록하기</strong></h2>
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
						<div align="center">
							<input type='hidden' v-model="id" v_bind:value=${loginid}>
							<table class="table table-hover">
								<tr>
									<th style="width:20%;"> 제목 </th>
									<td style="width:80%;">
										<input type="text" name="title" class="form-control" placeholder="제목"  v-model="title">
									</td>
								</tr>	
								<tr style="height:300px;">
									<th style="width:20%;"> 내용 </th>
									<td style="width:80%;">
										<textarea class="form-control" rows="15" placeholder="내용을 입력하세요."  v-model="contents"></textarea>
									</td>
								</tr>	
							</table>
							<div align="center">
								<button   type="button" class="btn btn-primary" @click="questionInsert">완료</button>
							</div>
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
			el : '#qnatable'
			, data : {
				id : '${loginid}'
				, title : ''
				, contents : ''
			}
			, methods : {
				questionInsert : function(){
					if(this.title==''){alert("제목을 입력하세요"); return}
					if(this.contents.length<=30){alert("내용을 최소 30자 이상 입력하세요"); return}
						axios.post("http://70.12.108.177:8197/SafeFoodBoot/api/insertQ"
								, {
									id : this.id
									, title : this.title
									, contents : this.contents
								})
						.then(response => {
							console.log(response)
							if(response.data.state=='true'){
								alert('등록 성공')
								location.href="qna.do"
							} else {
								alert('등록 실패')
							}
						})
				}
			}
		})
	
	</script>
</body>
</html>