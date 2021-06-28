<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<style type="text/css">
body {
	padding-top: 150px
}
</style>
</head>
<body>
	<div id="head">
		<jsp:include page="menu.jsp" />
	</div>
	<div class="page-wrapper">
		<div align="center">
			<h1>${msg_psearch }</h1>
		</div>
		<form method="post" id="modform" action="update" role="form"
			class="form-horizontal">
			<%-- <div class="form-group">
				<label class="control-label col-md-3">고객님의 아이디 *: <%=sess_id%></label>
			</div> --%>
			<div class="form-group">
				<label class="control-label col-md-3">비밀번호 *:</label>
				<div class="col-md-5">
					<input type="password" class="form-control" id="mod_pw" name="password" value=""
						placeholder="비밀번호를 입력해주세요." required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-3">비밀번호 확인 *:</label>
				<div class="col-md-5">
					<input type="password" class="form-control" id="mod_repw" name="repassword"
						value="" placeholder="비밀번호를 확인합니다. 다시 한번 입력해주세요." required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-3"></label>
				<div class="alert alert-success col-md-5" id="alert-success-mod">비밀번호가
					일치합니다.</div>
				<div class="alert alert-danger col-md-5" id="alert-danger-mod">비밀번호가
					일치하지 않습니다.</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-3">이 름 *:</label>
				<div class="col-md-5">
					<input type="text" class="form-control" name="name" value=""
						placeholder="이름을 입력해주세요." required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-3">주 소 *:</label>
				<div class="col-md-5">
					<input type="text" class="form-control" name="address" value=""
						placeholder="주소 입력해주세요." required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-3">전화번호 *:</label>
				<div class="col-md-5">
					<input type="text" class="form-control" name="phone" value=""
						placeholder="전화번호를 입력해주세요." required>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-3">알레르기 *:</label>
				<div class="col-md-5">
					<fieldset class="form-group">
						<legend class="col-form-legend col-sm-3"> Check</legend>
						<div class="row">
							<div class="col-md-10">
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox1' type="checkbox" value="대두"> <label
										class="form-check-label">대두 </label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox2' type="checkbox" value="땅콩"> <label
										class="form-check-label">땅콩 </label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox3' type="checkbox" value="우유"> <label
										class="form-check-label">우유 </label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox4' type="checkbox" value="게"> <label
										class="form-check-label">게</label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox5' type="checkbox" value="세우"> <label
										class="form-check-label">세우</label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox6' type="checkbox" value="참치"> <label
										class="form-check-label">참치</label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox7' type="checkbox" value="연어"> <label
										class="form-check-label">연어</label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox8' type="checkbox" value="쑥"> <label
										class="form-check-label">쑥 </label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox9' type="checkbox" value="소고기"> <label
										class="form-check-label">소고기</label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox10' type="checkbox" value="닭고기"> <label
										class="form-check-label">닭고기 </label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox11' type="checkbox" value="돼지고기"> <label
										class="form-check-label">돼지고기</label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox12' type="checkbox" value="복숭아"> <label
										class="form-check-label">복숭아 </label>
								</div>
								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox13' type="checkbox" value="민들레"> <label
										class="form-check-label">민들레</label>
								</div>

								<div class="form-check form-check-inline">
									<input name="allergy" class="form-check-input"
										id='inlineCheckbox14' type="checkbox" value="계란흰자"> <label
										class="form-check-label">계란흰자 </label>
								</div>
							</div>
						</div>
					</fieldset>
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-3"></div>
				<div class="col-md-5">
					<input type="submit" id="mod_submit" disabled="true" value="회원 정보 수정"
						class="btn btn-info"/> <input type="reset" name="Reset"
						value="재작성" class="btn btn-default">
				</div>
			</div>
		</form>


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
	 $(function(){
	        $("#alert-success-mod").hide();
	        $("#alert-danger-mod").hide();
	        $("#mod_pw").keyup(function(){
	            var pw=$("#mod_pw").val();
	            var repw=$("#mod_repw").val();
	            if(pw != "" || repw != ""){
	                if(pw == repw){
	                    $("#alert-success-mod").show();
	                    $("#alert-danger-mod").hide();
	                    $("#mod_submit").prop("disabled", false);
	                }else{
	                    $("#alert-success-mod").hide();
	                    $("#alert-danger-mod").show();
	                    $("#mod_submit").prop("disabled", true);
	                }    
	            }
	        });
	        $("#mod_repw").keyup(function(){
	            var pw=$("#mod_pw").val();
	            var repw=$("#mod_repw").val();
	            if(pw != "" || repw != ""){
	                if(pw == repw){
	                    $("#alert-success-mod").show();
	                    $("#alert-danger-mod").hide();
	                    $("#mod_submit").prop("disabled", false);
	                }else{
	                    $("#alert-success-mod").hide();
	                    $("#alert-danger-mod").show();
	                    $("#mod_submit").prop("disabled", true);
	                }    
	            }
	        });
	    });
	
	</script>
</body>
</html>