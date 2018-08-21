<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Login V19</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png"
	href="/resources/loginResources/images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="/resources/loginResources/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/loginResources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/loginResources/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/loginResources/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css"
	href="/resources/loginResources/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/loginResources/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/loginResources/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/loginResources/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css"
	href="/resources/loginResources/css/util.css">
<link rel="stylesheet" type="text/css"
	href="/resources/loginResources/css/main.css">
</head>

<body onload="document.forms[0].reset()">
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-50">
				<form class="login100-form validate-form" method="post">
					<span class="login100-form-title p-b-33"> Create Acount </span>

					<div style="float: left; margin-right: 7px" class="wrap-input50 validate-input"
						data-validate="아이디를 입력해주세요" data-checkId="이미 존재하는 ID입니다.">
						<input class="input50 inputId" type="text" name="mid"
							placeholder="ID">
					</div>

						<button style="width: 38%; float: left;" class="login100-form-btn idCheck">중복확인</button>
					
					<div class="wrap-input100 validate-input m-t-80"
						data-validate="사용하실 비밀번호를 입력해주세요">
						<input id="mpw1" class="input100 mpw" type="password" name="mpw"
							placeholder="Password"> <span class="focus-input100-1"></span>
						<span class="focus-input100-2"></span>
					</div>

					<div class="wrap-input100 validate-input m-t-10"
						data-validate="비밀번호 확인을 위해 입력해주세요">
						<input id="mpw2" class="input100 mpw2" type="password" name="mpw2"
							placeholder="Password"> <span class="focus-input100-1"></span>
						<span class="focus-input100-2"></span>
					</div>

					<div class="wrap-input100 validate-input m-t-10"
						data-validate="이름을 입력해주세요">
						<input class="input100" type="text" name="mname"
							placeholder="Name"> <span class="focus-input100-1"></span>
						<span class="focus-input100-2"></span>
					</div>

					<div class="wrap-input100 validate-input m-t-10"
						data-validate="이메일을 ex@abc.xyz 방식으로 입력해주세요">
						<input class="input100" type="text" name="email"
							placeholder="E-Mail"> <span class="focus-input100-1"></span>
						<span class="focus-input100-2"></span>
					</div>

					<div class="m-t-10">
						<select class="form-control" name="favor">
						<option value="없음">가장 좋아하는 장르를 선택해주세요.</option>
						<option value="코미디">코미디</option>
						<option value="액션">액션</option>
						<option value="드라마">드라마</option>
						<option value="SF">SF</option>
						<option value="다큐멘터리">다큐멘터리</option> 			
						</select>
						<span class="focus-input100-1"></span>
						<span class="focus-input100-2"></span>
					</div>

					<div class="container-login100-form-btn m-t-20">
						<button class="login100-form-btn signUP">회원 가입</button>
					</div>

					<div class="text-center">
						<span class="txt1">로그인 하시려면</span> <a href="login"
							class="txt2 hov1">여기를 클릭</a>
					</div>
					
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form>
			</div>
		</div>
	</div>
	<!-- javascript -->
	<script
		src="resources/loginResources/vendor/jquery/jquery-3.2.1.min.js"></script>
	<script
		src="resources/loginResources/vendor/animsition/js/animsition.min.js"></script>
	<script src="resources/loginResources/vendor/bootstrap/js/popper.js"></script>
	<script
		src="resources/loginResources/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="resources/loginResources/vendor/select2/select2.min.js"></script>
	<script
		src="resources/loginResources/vendor/daterangepicker/moment.min.js"></script>
	<script
		src="resources/loginResources/vendor/daterangepicker/daterangepicker.js"></script>
	<script
		src="resources/loginResources/vendor/countdowntime/countdowntime.js"></script>
	<script src="resources/loginResources/js/main.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
<script>
var idCheck = false;
var inputId = "";
var pattern = /[{}~!@#$%^&*()_+=<>?/\/]/;
$(".signUP").on("click", function(e) {
	var mpw = document.getElementById("mpw1").value; // 입력한 비밀번호
	var confirmMpw = document.getElementById("mpw2").value; // 입력한 비밀번호 확인
	if (mpw != confirmMpw) {
		console.log("비밀번호 불일치")
		alert("입력한 비밀번호가 서로 다릅니다.")
		return false;
	}
	if (idCheck == false || $('.inputId').val() != inputId) {
		console.log(inputId + "/" + $('.inputId').val())
		alert("아이디 중복확인을 해주세요");
		return false;
	}

});

$(".idCheck").on("click", function(e) {
	e.preventDefault();
	var id = $('.inputId').val();
	
	if(id == ""){
		alert("아이디를 입력해주세요");
		$(".inputId").focus();
		return false;
	}
	
	if (pattern.test(id) == true) {
		console.log(pattern.test(id));
		alert("아이디에 특수문자는 사용할 수 없습니다.");
		return false;
	}

	$.ajax({
		type : 'POST',
		beforeSend : function(xhr) {
			xhr.setRequestHeader('x-CSRFToken','${_csrf.token}');
		},
		url : "/idCheck",
		dataType : "json",
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		headers : {
			"content-type" : "application/json",
			"x-http-method-override" : "POST"
		},
		
		data : id,
		success : function(data) {
			if (data === 1) {
				alert("이미 존재하는 아이디입니다");
			}
			if (data === 0) {
				alert("사용 가능한 아이디입니다")
				idCheck = true; //아이디 중복확인 한것 확인됬을 경우 true로 저장
				inputId = id;
			}
		}
	});
});
</script>
</body>
</html>