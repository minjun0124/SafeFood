<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.safefood.model.domain.User"%>
<%
	String sess_id = (String) request.getSession().getAttribute("loginid");
%>
<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
#loginfrm * {
	margin: 3px;
}

.modal-body>div {
	padding-left: 30px;
	padding-right: 30px;
}

.btn {
	padding: 0px;
	margin: 0px;
}
</style>
<script type="text/javascript">
	//조건 검색, 페이지 번호로 게시글 요청을 위한 메서드  
	function pagelist(pageNo) {
		$('#pageNo').val(pageNo);
		var href = "foodlist.do?pageNo=" + pageNo;
		console.log(href);
		$('#searchFood').attr("action", href);
		$('#searchFood').submit();
	}
	//게시글 번호나 타이틀을 클릭하면 해당 게시글 요청을 위한 메서드 
	function getFood(no) {
		//input 양식의 hidden으로 선언된 no(게시글 번호)에 요청된 게시글 번호를 셋팅
		document.getElementById("code").value = code;
		var frm = document.getElementById("frm");
		frm.action = "searchFood.do";
		frm.submit();
	}
</script>
<div class="navbar navbar-inverse navbar-fixed-top">
<br>
	<div class="container">
		<div class="collapse navbar-collapse" id="target">
			<a class="navbar-brand" href="index.do"
				style="color: #94b8ff; font-size: 30px; font-weight: bold">SSAFY</a>
			<ul class="nav navbar-nav">
				<li><a href="foodlist.do">상품정보</a></li>
				<li><a href="ranking.do">베스트 섭취정보</a></li>
				<li><a href="intakelist.do">내 섭취 정보</a></li>
				<li><a href="prev_intake.do">예상 섭취 정보</a></li>
				<li><a href="qna.do">Q&A</a></li>
				<li><a href="notice.do">NOTICE</a></li>
			</ul>
			<jsp:useBean id="bean" class="com.safefood.model.domain.PageBean" scope="request" />
			<form action="foodlist.do" method="get" id="searchFood" role="search">
				<ul class="nav navbar-nav navbar-center" style="margin-top: 8px;">
					<li><select name="key" id="key" class="form-control">
							<option value="all">검색조건</option>
							<option value="name" <%=bean.getKey("name")%>>상품명</option>
							<option value="material" <%=bean.getKey("material")%>>첨가물</option>
					</select></li>
					<li><input type="text" class="form-control" id="word"
						name="word" placeholder="상품정보를 입력해주세요." aria-label="Search"
						value=${bean.word }></li>
					<li>
						<button class="btn btn-outline-success" id="searchbtn"
							type="submit" onclick="pagelist(1)">검색</button>
					</li>
				</ul>
			</form>
			<%
				if (sess_id != null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li color="white"><a href="memInfo"><img alt="멤버이미지"
						src="img/mem_icon.jpg"></a></li>
				<li><a href="Logout.do">로그아웃</a></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li>
					<button type="button" class="btn btn-info" data-toggle="modal"
						data-target="#signup" style="margin-top: 8px; margin-right: 3px;">
						<b>회원가입</b>
					</button>
				</li>
				<li>
					<button type="button" class="btn btn-info" data-toggle="modal"
						data-target="#login" style="margin-top: 8px">
						<b>로그인</b>
					</button>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</div>
</div>


<!-- signup popup -->
<div class="modal fade" id="signup" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h3 class="text-primary">가입정보를 입력해주세요.</h3>
			</div>
			<div class="modal-body">
				<div class="row">
					<form method="post" action="registerUser" role="form"
						class="form-horizontal">
						<div class="form-group">
							<input type="hidden" id="withdraw" name="withdraw" value="f" />
							<input type="hidden" id="isAdmin" name="isAdmin" value="0" />
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">아이디</label>
							<div class="col-md-8">
								<input type="text" class="form-control" name="id" id="id"
									value="" placeholder="아이디를 입력해주세요." required>
							</div>
							<div class="col-md-1">
								<button type="button" class="btn btn-warning btn-sm idCheck"
									style="margin-left: -20px;">중복확인</button>
							</div>
						</div>
						<p class="result" style="margin-left: 200px;">
							<span class="msg"></span>
						</p>
						<div class="form-group">
							<label class="control-label col-md-3">비밀번호</label>
							<div class="col-md-9">
								<input type="password" class="form-control" id="pw" name="password" value=""
									placeholder="비밀번호를 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">비밀번호 확인</label>
							<div class="col-md-9">
								<input type="password" class="form-control" id="repw" name="repw" value=""
									placeholder="비밀번호를 확인합니다. 다시 한번 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
						<label class="control-label col-md-3"></label>
						<div class="alert alert-success col-md-9" id="alert-success">비밀번호가
							일치합니다.</div>
						<div class="alert alert-danger col-md-9" id="alert-danger">비밀번호가 일치하지
							않습니다.</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">이 름</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="name" value=""
									placeholder="이름을 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">주 소</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="address" value=""
									placeholder="주소 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">전화번호</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="phone" value=""
									placeholder="전화번호를 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">알레르기</label>
							<div class="col-md-9">
								<fieldset class="form-group">
									<div class="btn-group-justified" data-toggle="buttons">
										<label class="btn btn-default"> <input type="checkbox"
											autocomplete="off" name="allergy" id='inlineCheckbox1'
											value="대두">대두
										</label> <label class="btn btn-default"> <input
											type="checkbox" autocomplete="off" name="allergy"
											id='inlineCheckbox2' value="땅콩">땅콩
										</label> <label class="btn btn-default"> <input
											type="checkbox" autocomplete="off" name="allergy"
											id='inlineCheckbox3' value="우유">우유
										</label> <label class="btn btn-default"> <input
											type="checkbox" autocomplete="off" name="allergy"
											id='inlineCheckbox4' value="게">게
										</label>
									</div>
									<div class="btn-group-justified" data-toggle="buttons">
										<label class="btn btn-default"> <input type="checkbox"
											autocomplete="off" name="allergy" id='inlineCheckbox5'
											value="새우">새우
										</label> <label class="btn btn-default"> <input
											type="checkbox" autocomplete="off" name="allergy"
											id='inlineCheckbox6' value="참치">참치
										</label> <label class="btn btn-default"> <input
											type="checkbox" autocomplete="off" name="allergy"
											id='inlineCheckbox7' value="연어">연어
										</label> <label class="btn btn-default"> <input
											type="checkbox" autocomplete="off" name="allergy"
											id='inlineCheckbox8' value="쑥">쑥
										</label>
									</div>
									<div class="btn-group-justified" data-toggle="buttons">
										<label class="btn btn-default"> <input type="checkbox"
											autocomplete="off" name="allergy" id='inlineCheckbox9'
											value="소고기">소고기
										</label> <label class="btn btn-default"> <input
											type="checkbox" autocomplete="off" name="allergy"
											id='inlineCheckbox10' value="닭고기">닭고기
										</label> <label class="btn btn-default"> <input
											type="checkbox" autocomplete="off" name="allergy"
											id='inlineCheckbox11' value="돼지고기">돼지고기
										</label>
									</div>
									<div class="btn-group-justified" data-toggle="buttons">
										<label class="btn btn-default"> <input type="checkbox"
											autocomplete="off" name="allergy" id='inlineCheckbox12'
											value="복숭아">복숭아
										</label> <label class="btn btn-default"> <input
											type="checkbox" autocomplete="off" name="allergy"
											id='inlineCheckbox13' value="민들레">민들레
										</label> <label class="btn btn-default"> <input
											type="checkbox" autocomplete="off" name="allergy"
											id='inlineCheckbox14' value="계란흰자">계란흰자
										</label>
									</div>
								</fieldset>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-3"></div>
							<div class="col-md-9">
								<input type="submit" id="submit" name="Signup Now"
									disabled="true" value="가입 신청" class="btn btn-info"> <input
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
<!-- signup end -->

<!-- login popup -->
<div class="modal fade" id="login" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h3 class="text-primary">환영합니다.</h3>
			</div>
			<div class="modal-body">
				<div class="row" id='loginfrm'>
					<form method="post" action="userlogin" role="form"
						class="form-horizontal">
						<div class="row">
							<label class="control-label col-md-3">아이디</label>
							<div class="col-md-8">
								<input type="text" class="form-control" name="id" value=""
									placeholder="아이디를 입력해주세요" required>
							</div>
						</div>
						<div class="row">
							<label class="control-label col-md-3">비밀번호</label>
							<div class="col-md-8">
								<input type="password" class="form-control" name="password" value=""
									placeholder="비밀번호를 입력해주세요." required>
							</div>
						</div>
						<div class="row">
							<div class="col-md-3"></div>
							<div class="col-md-8">
								<input type="submit" name="Login Now" value="로그인"
									class="btn btn-info"> <input type="button"
									class="btn btn-info" data-toggle="modal"
									data-target="#PwSearch" value="비밀번호 찾기"> <input
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
<!-- login end -->


<!-- PwSearch  -->
<div class="modal fade" id="PwSearch" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h3 class="text-primary">환영합니다.</h3>
			</div>
			<div class="modal-body">
				<div class="row">
					<form method="post" action="PwSearch.do" role="form"
						class="form-horizontal">
						<div class="form-group">
							<label class="control-label col-md-3">아이디 *:</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="id" value=""
									placeholder="아이디를 입력해주세요" required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">전화번호 *:</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="phone" value=""
									placeholder="'-'을 포함하여 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-3"></div>
							<div class="col-md-9">
								<input type="submit" name="PwSearch" value="비밀번호 찾기"
									class="btn btn-info">
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
