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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SafeFood</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="http://unpkg.com/vue"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.js"></script>
<style type="text/css">
body {
	padding-top: 100px
}

.listtr {
	cursor: pointer;
	width: 70%;
	align: center;
}

.modal-body div {
	padding-left: 30px;
	padding-right: 30px;
}
</style>
</head>
<body>
	<div id="head">
		<jsp:include page="menu.jsp" />
	</div>
	<br>
	<br>
	<br>
	<div class="page-wrapper">
		<div align="center">
			<h2>
				<strong>NOTICE</strong>
			</h2>
		</div>
		<!-- header-container end -->
		<section id="noticepage" class="main-container">
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
									<th style="width: 50%;">제목</th>
									<th style="width: 15%;">글쓴이</th>
									<th style="width: 15%;">등록일</th>
								</tr>
								<template v-for="notice in info">
								<tr class="listtr">
									<td>{{notice.no}}</td>
									<td data-toggle="modal" v-bind:data-target="target(notice.no)">{{notice.title}}</td>
									<td>{{notice.id}}</td>
									<td>{{notice.regdate}}</td>
								</tr>
								</template>

							</table>
							<div v-if="${isAdmin} == 1 " align="center">
								<button type="button" class="btn btn-primary"
									data-toggle="modal" data-target="#noticeForm">작성하기</button>
							</div>
						</div>

						<template v-for="notice in info">
						<div class="modal " v-bind:id="notice.no" role="dialog" >
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h3 class="text-primary">{{notice.title}}</h3>
									</div>
									<div class="modal-body">
										<div class="row">{{notice.contents}}</div>
									</div>
									<div class="modal-footer">
									<button v-if="${isAdmin} == 1 " type="button" class="btn btn-warning " 
											data-dismiss="modal" data-toggle="modal" data-target="#upform" @click='updateForm(notice)'>수정</button>
									<button v-if="${isAdmin} == 1 " type="button" class="btn btn-danger " @click="noticeDelete(notice.no)" >삭제</button>
										<button type="button" class="btn btn-default"
											data-dismiss="modal">닫기</button>
									</div>
								</div>
							</div>
						</div>
						</template>
						
						
						<div class="modal "  id="upform" role="dialog" >
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h3 class="text-primary center"><strong>공지사항 수정</strong></h3>
									</div>
									<div class="modal-body">
										<input type="hidden" id="upno" v-model="upno">
										<table class="table table-hover">
											<tr>
												<th style="width: 20%;">제목</th>
												<td style="width: 80%;"><input type="text" id="uptitle"
													class="form-control" v-model="uptitle">
												</td>
											</tr>
											<tr style="height: 300px;">
												<th style="width: 20%;">내용</th>
												<td style="width: 80%;"><textarea class="form-control"
														rows="15"  id = "upcontents" v-model="upcontents" ></textarea>
												</td>
											</tr>
										</table>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-warning" @click="noticeUpdate()">수정하기</button>
										<button type="button" class="btn btn-default"
											data-dismiss="modal">닫기</button>
									</div>
								</div>
							</div>
						</div>

						

						<div class="modal " id="noticeForm" role="dialog">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h3 class="text-primary center"><strong>공지사항 작성</strong></h3>
									</div>
									<div class="modal-body">
										<table class="table table-hover">
											<tr>
												<th style="width: 20%;">제목</th>
												<td style="width: 80%;"><input type="text" name="title"
													class="form-control" placeholder="제목" v-model="title">
												</td>
											</tr>
											<tr style="height: 300px;">
												<th style="width: 20%;">내용</th>
												<td style="width: 80%;"><textarea class="form-control"
														rows="15" placeholder="내용을 입력하세요." v-model="contents"></textarea>
												</td>
											</tr>
										</table>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-success" @click="noticeInsert">작성하기</button>
										<button type="button" class="btn btn-default"
											data-dismiss="modal">닫기</button>
									</div>
								</div>
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
		var noticepage = new Vue({
			el : '#noticepage',
			data : {
				id : '${loginid}',
				info : null,
				loading : true,
				error : false,
				word : '',
				title : '',
				contents: '',
				upno: '',
				uptitle : '',
				upcontents : ''
			}
			 , mounted : function(){
				axios.get('http://70.12.108.177:8197/SafeFoodBoot/api/notice/searchAllNotice')
					.then( response => (this.info = response.data))
					.catch(error => {
						console.log(error)
						this.errored = true;
					})
					.finally( () => this.loading=false )
			}
			,
			methods : {
				searchTitle : function() {
					console.log(this.word)
					console.log(encodeURI(this.word, "UTF-8"))
					info = null
					loading : true
					error : false
					axios.get('http://70.12.108.177:8197/SafeFoodBoot/api/notice/searchNoticebyTitle/'+encodeURI(this.word, "UTF-8"))
						.then(response => (this.info = response.data))
						.catch(error => {
							console.log(error)
							this.errored = true;
						})
						.finally( ()=> this.loading=false)
				}
				, target : function(no){
					return "#"+no;
				}
				, up_target : function(no){
					return "#"+no+"up";
				}
				, noticeInsert : function(){
					console.log('insert')
					axios.post("http://70.12.108.177:8197/SafeFoodBoot/api/notice/insertNotice"
							, {
								id : this.id
								, title : this.title
								, contents : this.contents
						
							})
						.then(response => {
							console.log(response)
							if(response.data.state=='true'){
								alert('등록 성공')
								location.href="noticelist.jsp"
							} else {
								alert('등록 실패')
							}
						})
				}
				, noticeDelete : function(no) {
					axios.delete("http://70.12.108.177:8197/SafeFoodBoot/api/notice/deleteNotice/"+no)
						.then( response => {
							if(response.data.state=='true'){
								alert('삭제 성공')
								location.href='noticelist.jsp'
							} else {
								alert('삭제 실패')
							}
						})
				}
				, updateForm : function(notice) {
					console.log(notice.no)
					this.upno = notice.no;
					this.uptitle = notice.title;
					this.upcontents = notice.contents;
				}
				, noticeUpdate : function(){
					if(this.uptitle=='') { alert('제목을 입력하세요 '); return}
					if(this.upcontents=='') { alert('제목을 입력하세요 '); return}
					axios.put("http://70.12.108.177:8197/SafeFoodBoot/api/notice/updateNotice", {
						no : this.upno
						, title : this.uptitle
						, contents : this.upcontents
					})
					.then(response => {
						console.log(response)
						if(response.data.state=='true'){
							alert('수정 성공')
							location.href="noticelist.jsp"
						} else {
							alert('수정 실패')
						}
					})
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