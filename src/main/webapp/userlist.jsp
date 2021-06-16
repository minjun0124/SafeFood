<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
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
	<section class="main-container">
		<div class="container" style="text-align: center;">
			<table class="table table-hover">
				<tr class="tabler">
					<th class="tablekey">이름</th>
					<th class="tablekey">아이디</th>
					<th class="tablekey">전화번호</th>
					<th class="tablekey">회원상태</th>
					<th class="tablekey"></th>
				</tr>
				<c:forEach var="user" items="${list }">
					<tr>
						<td class="tableval">${user.name }</td>
						<td class="tableval">${user.id }</td>
						<td class="tableval">${user.phonenum }</td>
						<td class="tableval">
							<c:choose>
								<c:when test="${user.withdraw == 116}">
									<span style="color:red;">탈퇴 회원</span>
								</c:when>
								<c:otherwise>
									활동 회원
								</c:otherwise>							
							</c:choose>							
						</td>
						<td class="tableval">
							<c:if test="${user.withdraw == 116}">
								<a href="userdelete.do?id=${user.id }" class="btn btn-success btn-sm">회원 정보 삭제</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
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
</body>
</html>