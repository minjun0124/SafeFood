<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.safefood.model.domain.User"%>
<%
	String sess_id = (String) request.getSession().getAttribute("loginid");
%>
<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript">
	//조건 검색, 페이지 번호로 게시글 요청을 위한 메서드  
	function pagelist(pageNo) {
		//input 양식의 hidden으로 선언된 page에 요청된 페이지 정보 셋팅 
		$('#pageNo').val(pageNo);
		var href = "foodlist.do?pageNo="+pageNo;
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
<style type="text/css">

.modal-body div {
	padding-left: 30px;
	padding-right: 30px;
}
#searchFood *{
	margin:auto;
}
</style>
<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<a class="navbar-brand" href="index.do"
			style="color: #94b8ff; font-size: 30px; font-weight: bold">SSAFY</a>
		<div class="navbar-header">
			<button class="navbar-toggle collapsed" data-toggle="collapse"
				data-target="#target">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		</div>
		<div class="collapse navbar-collapse" id="target">
			<ul class="nav navbar-nav">
				<li><a href="foodlist.do">상품정보</a></li>
				<li><a href="ranking.do">베스트 섭취정보</a></li>
				<li><a href="intakelist.do">내 섭취 정보</a></li>
				<li><a href="prev_intake.do">예상 섭취 정보</a></li>
				<li><a href="qna.do">Q&A</a></li>
				<li><a href="notice.do">NOTICE</a></li>
			</ul>
			<%
				if (sess_id != null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li color="white"><a href="memInfo.do"><img alt="멤버이미지"
						src="img/mem_icon.jpg"></a></li>
				<li><a href="Logout.do">로그아웃</a></li>
			</ul>
			<%
				}
			%>
			<%-- <ul class="nav navbar-nav navbar-right">
				<li><jsp:useBean id="bean" class="com.ssafy.vo.PageBean"
						scope="request" /> 					<form action="foodlist.do" method="get" id="searchFood">
						<select name="key" id="key" class="form-control"
							style="display: inline-block; width: 20%">
							<option value="all">검색조건</option>
							<option value="name" <%=bean.getKey("name")%>>상품명</option>
							<option value="material" <%=bean.getKey("material")%>>영양정보명</option>
						</select> <input type="text" class="form-control" id="word" name="word"
							placeholder="검색하세요" style="width: 70%; display: inline-block"
							value=${bean.word } />
						<button type="submit" class="btn btn-default btn-lg"
							id="searchbtn" style="width: 8%; display: inline-block"
							onclick="pagelist(1)">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button>
					</form>

					<form class="nav navbar-form navbar-right" action="foodlist.do"
						method="get" id="searchFood" role="search">
						<select name="key" id="key" class="form-control"
							style="display: inline-block; width: 20%">
							<option value="all">검색조건</option>
							<option value="name" <%=bean.getKey("name")%>>상품명</option>
							<option value="material" <%=bean.getKey("material")%>>영양정보명</option>
						</select> <input type="text" class="form-control" id="word" name="word"
							placeholder="상품정보를 입력해주세요." aria-label="Search"
							value=${bean.word }>
						<button class="btn btn-outline-success" id="searchbtn"
							type="submit" onclick="pagelist(1)">검색</button>
					</form></li>
			</ul> --%>
		</div>
	</div>
</div>
<div class=" banner dark-translucent-bg"
	style="background-image: url('img/backimg.jpg'); background-position: 50% 28%; padding-top: 120px; min-height: 200px;">
	<!-- breadcrumb end -->
	<div class="container" style="text-align: center;">
		<div class="row justify-content-lg-center">
			<div class="col-lg-12 text-center pv-20">
				<h2>
					What We <strong>Provide</strong>
				</h2>
				<p>건강한 삶을 위한 먹거리 프로젝트</p>
				<div>
					<jsp:useBean id="bean" class="com.safefood.model.domain.PageBean"
						scope="request" />
					<form  method="get" id="searchFood" >
						<input type="hidden" id="pageNo" name="pageNo" value=${bean.pageNo }>
						<select name="key" id="key" class="form-control"
							style="display: inline-block; width: 20%">
							<option value="all">검색조건</option>
							<option value="name" <%=bean.getKey("name")%>>상품명</option>
							<option value="material" <%=bean.getKey("material")%>>첨가물</option>
						</select> 
						<input type="text" class="form-control" id="word" name="word"
							placeholder="검색하세요" style="width: 70%; display: inline-block" value=${bean.word } > 
						<input type="submit" class="btn btn-default btn-lg" id="searchbtn"
							style="width: 8%; display: inline-block" onclick="pagelist(1)" value="검색">
					</form>
				</div>
			</div>
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
					<form method="post" action="regist.do" role="form"
						class="form-horizontal">
						<div class="form-group">
							<input type="hidden" id="withdraw" name="withdraw" value="f" />
							<input type="hidden" id="isadmin" name="isadmin" value="0" />
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">아이디 *:</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="id" value=""
									placeholder="아이디를 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">비밀번호 *:</label>
							<div class="col-md-9">
								<input type="password" class="form-control" name="pw" value=""
									placeholder="비밀번호를 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">비밀번호 확인 *:</label>
							<div class="col-md-9">
								<input type="password" class="form-control" name="repw" value=""
									placeholder="비밀번호를 확인합니다. 다시 한번 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">이 름 *:</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="name" value=""
									placeholder="이름을 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">주 소 *:</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="addr" value=""
									placeholder="주소 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">전화번호 *:</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="phonenum" value=""
									placeholder="전화번호를 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">알레르기 *:</label>
							<div class="col-md-9">
								<fieldset class="form-group">
									<div class="btn-group-justified" data-toggle="buttons">
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox1' value="대두">대두
										</label>
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox2' value="땅콩">땅콩
										</label>
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox3' value="우유">우유
										</label>
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox4' value="게">게
										</label>
									</div>	
									<div class="btn-group-justified" data-toggle="buttons">
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox5' value="새우">새우
										</label>
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox6' value="참치">참치
										</label>
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox7' value="연어">연어
										</label>
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox8' value="쑥">쑥
										</label>
									</div>
									<div class="btn-group-justified" data-toggle="buttons">
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox9' value="소고기">소고기
										</label>
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox10' value="닭고기">닭고기
										</label>
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox11' value="돼지고기">돼지고기
										</label>
									</div>
									<div class="btn-group-justified" data-toggle="buttons">
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox12' value="복숭아">복숭아
										</label>
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox13' value="민들레">민들레
										</label>
										<label class="btn btn-default">
											<input type="checkbox" autocomplete="off" name="allergy" id='inlineCheckbox14' value="계란흰자">계란흰자
										</label>
									</div>
								</fieldset>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-3"></div>
							<div class="col-md-9">
								<input type="submit" name="Signup Now" value="가입 신청"
									class="btn btn-info"> <input type="reset" name="Reset"
									value="재작성" class="btn btn-default">
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
				<div class="row">
					<form method="post" action="userlogin.do" role="form"
						class="form-horizontal">
						<div class="form-group">
							<label class="control-label col-md-3">아이디 *:</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="id" value=""
									placeholder="아이디를 입력해주세요" required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">비밀번호 *:</label>
							<div class="col-md-9">
								<input type="password" class="form-control" name="pw" value=""
									placeholder="비밀번호를 입력해주세요." required>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-3"></div>
							<div class="col-md-9">
								<input type="submit" name="Login Now" value="로그인"
									class="btn btn-info">
								<!-- <input type="button"
									name="pw search" value="비밀번호 찾기" class="btn btn-info"
									onclick="PwSearch()"> -->
								<button type="button" class="btn btn-info" data-toggle="modal"
									data-target="#PwSearch" style="margin-top: 8px">
									<b>비밀번호 찾기</b>
								</button>
								<input type="reset" name="Reset" value="재작성"
									class="btn btn-default">
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
								<input type="text" class="form-control" name="phonenum" value=""
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
