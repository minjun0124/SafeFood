<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.safefood.model.domain.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%
	User m = (User) request.getAttribute("member");
	String list =  m.getAllergy();
%> --%>
<%
	String sess_id = (String) request.getSession().getAttribute("loginid");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SafeFood</title>
<style type="text/css">
table {
	width: 400px;
	height: 300px;
	border-spacing: 20px;
	border-collapse: 1px solid #000;
	font-size: 20px;
}

table td {
	padding: 20px;
}
</style>
<script type="text/javascript">
</script>
<%-- <script type="text/javascript">
	window.onload = function() {
	}
	function modAction() {
		window.alert("회원정보수정.")
		var pw = password.value;
		var rpw = repassword.value;
		if (pw == rpw && pw ==
<%=m.getPw()%>
	) {
			window.location = "memMod.do";
			return;
		} else {
			window.alert("다시 입력해주세요.")
		}
	}
	function delAction() {
		window.alert("아이디와 비밀번호를 입력해주세요.")
		var pw = password.value;
		var rpw = repassword.value;
		if (pw == rpw && pw ==
<%=m.getPw()%>
	) {
			window.location = "memDelete.do";
			return;
		} else {
			window.alert("다시 입력해주세요.")
		}
	}
</script> --%>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
body {
	padding-top: 150px
}
</style>
</head>
<%!%>
<body>
	<div id="head">
		<jsp:include page="menu.jsp" />
	</div>
	<div class="page-wrapper">
		<div align="center">
			<h1>나의 정보</h1>
			<p>
				고객께서 가입하신 SafeFood 회원 정보입니다.</br>
			</p>
			<h3><%=sess_id%>님의 회원정보
			</h3>
			<hr>
			<table>
				<tr>
					<th>아이디:</th>
					<td>${user.id}</td>
				</tr>
				<tr>
					<th>이름:</th>
					<td>${user.name}</td>
				</tr>
				<tr>
					<th>주소:</th>
					<td>${user.addr}</td>
				</tr>
				<tr>
					<th>전화번호:</th>
					<td>${user.phonenum}</td>
				</tr>
				<tr>
					<th>알레르기:</th>
					<td>
						<p>${user.allergy}</p>
					</td>
				</tr>
			</table>
			<c:if test="${isAdmin == 1}">
				<a type="button" class="btn btn-success" href="userlist.do"
					style="margin-top: 8px"> <b>회원 목록</b>
				</a>
			</c:if>
			<button type="button" class="btn btn-info" data-toggle="modal"
				data-target="#memMod" style="margin-top: 8px">
				<b>회원 정보 수정</b>
			</button>
			<button type="button" class="btn btn-info" data-toggle="modal"
				data-target="#memDel" style="margin-top: 8px">
				<b>회원 정보 삭제</b>
			</button>
			<a class="btn btn-info" href="cartlist.do" style="margin-top: 8px">
				<b>나의 찜 목록</b>
			</a>
		</div>
		<!-- Mod popup -->
		<div class="modal fade" id="memMod" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h3 class="text-primary">
							회원정보 수정을 위해</br> 비밀번호를 다시 한번 입력해주세요.
						</h3>
					</div>
					<div class="modal-body">
						<div class="row">
							<form method="get" action="memMod.do" role="form"
								class="form-horizontal">
								<div class="form-group">
									<label class="control-label col-md-4">비밀번호 *:</label>
									<div class="col-md-8">
										<input type="password" class="form-control" name="password"
											id="pw1" value="" placeholder="비밀번호를 입력해주세요." required>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-4">비밀번호 확인 *:</label>
									<div class="col-md-8">
										<input type="password" class="form-control" name="repassword"
											id="repw1" value="" placeholder="비밀번호를 확인합니다. 다시 한번 입력해주세요." required>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3"></label>
									<div class="alert alert-success col-md-9" id="alert-success1">비밀번호가
										일치합니다.</div>
									<div class="alert alert-danger col-md-9" id="alert-danger1">비밀번호가
										일치하지 않습니다.</div>
								</div>
								<div class="form-group">
									<div class="col-md-3"></div>
									<div class="col-md-9">
										<button type="button" id="submit1" name="Login Now"
										 class="btn btn-info" disabled="true">회원 정보 수정</button> <input
											type="reset" name="Reset" value="재작성" class="btn btn-default">
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Mod end -->

		<!-- Del popup -->
		<div class="modal fade" id="memDel" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h3 class="text-primary">
							회원 탈퇴를 위해</br> 비밀번호를 다시 한번 입력해주세요.
						</h3>
					</div>
					<div class="modal-body">
						<div class="row">
							<form method="post" action="memDelete.do" role="form"
								class="form-horizontal">
								<div class="form-group">
									<label class="control-label col-md-4">비밀번호 *:</label>
									<div class="col-md-8">
										<input type="password" class="form-control" name="password"
											id="pw2" value="" placeholder="비밀번호를 입력해주세요." required>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-4">비밀번호 확인 *:</label>
									<div class="col-md-8">
										<input type="password" class="form-control" name="repassword"
											id="repw2" value="" placeholder="비밀번호를 확인합니다. 다시 한번 입력해주세요." required>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3"></label>
									<div class="alert alert-success col-md-9" id="alert-success2">비밀번호가
										일치합니다.</div>
									<div class="alert alert-danger col-md-9" id="alert-danger2">비밀번호가
										일치하지 않습니다.</div>
								</div>
								<div class="form-group">
									<div class="col-md-3"></div>
									<div class="col-md-9">
										<button type="button" id="submit2" name="memDel" 
											class="btn btn-info" disabled="true">회원 탈퇴</button> <input type="reset"
											name="Reset" value="재작성" class="btn btn-default">
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Del end -->

		<!-- footer start (Add "dark" class to #footer in order to enable dark footer) -->
		<!-- ================ -->
		<br> <br>
		<hr>
		<footer>
			<jsp:include page="copyright.jsp" />
		</footer>
		<!-- footer end -->

	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
		$(function() {
			$("#alert-success1").hide();
			$("#alert-danger1").hide();
			console.log("isin")
			$("#pw1").keyup(function() {
				var pw = $("#pw1").val();
				var repw = $("#repw1").val();
				if (pw != "" || repw != "") {
					if (pw == repw) {
						$("#alert-success1").show();
						$("#alert-danger1").hide();
						$("#submit1").prop("disabled", false);
					} else {
						$("#alert-success1").hide();
						$("#alert-danger1").show();
						$("#submit1").prop("disabled", true);
					}
				}
			});
			$("#repw1").keyup(function() {
				var pw = $("#pw1").val();
				var repw = $("#repw1").val();
				if (pw != "" || repw != "") {
					if (pw == repw) {
						$("#alert-success1").show();
						$("#alert-danger1").hide();
						$("#submit1").prop("disabled", false);
					} else {
						$("#alert-success1").hide();
						$("#alert-danger1").show();
						$("#submit1").prop("disabled", true);
					}
				}
			});
		});
		$(function() {
			$("#alert-success2").hide();
			$("#alert-danger2").hide();
			console.log("isin")
			$("#pw2").keyup(function() {
				var pw = $("#pw2").val();
				var repw = $("#repw2").val();
				if (pw != "" || repw != "") {
					if (pw == repw) {
						$("#alert-success2").show();
						$("#alert-danger2").hide();
						$("#submit2").prop("disabled", false);
					} else {
						$("#alert-success2").hide();
						$("#alert-danger2").show();
						$("#submit2").prop("disabled", true);
					}
				}
			});
			$("#repw2").keyup(function() {
				var pw = $("#pw2").val();
				var repw = $("#repw2").val();
				if (pw != "" || repw != "") {
					if (pw == repw) {
						$("#alert-success2").show();
						$("#alert-danger2").hide();
						$("#submit2").prop("disabled", false);
					} else {
						$("#alert-success2").hide();
						$("#alert-danger2").show();
						$("#submit2").prop("disabled", true);
					}
				}
			});
		});
		
		$("#submit1").click(function() {
			var query = {
				"id" : "<%=sess_id %>"
				, "pw" : $("#pw1").val()
			};
				console.log(query)
			$.ajax({
				url : "/SafeFoodSpring/pwcheck.do",
				type : "post",
				data : query,
				success : function(data) {
					if (data == 1) {
						location.href='/SafeFoodSpring/memMod.do';
					} else {
						alert("비밀번호가 틀립니다. 다시 시도해주세요.");
						location.reload();
					}
				}
			});
		});
		
		$("#submit2").click(function() {
			var query = {
				"id" : "<%=sess_id %>"
				, "pw" : $("#pw2").val()
			};
				console.log(query)
			$.ajax({
				url : "/SafeFoodSpring/pwcheck.do",
				type : "post" ,
				data : query,
				success : function(data) {
					if (data == 1) {
						location.href='/SafeFoodSpring/memDelete.do';
					} else {
						alert("비밀번호가 틀립니다. 다시 시도해주세요.");
						location.reload();
					}
				}
			});
		});
		
	</script>
</body>
</html>