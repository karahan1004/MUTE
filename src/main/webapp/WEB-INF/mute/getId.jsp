<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Nickname</title>
<link rel="stylesheet" href="resources/css/getId.css">
</head>
<body>
	<div id="imgLogo">
		<img id="logo" alt="logo" src="resources/images/mutelogo.png">
	</div>
	
	<div id="register">
		<h1>닉네임을 등록해주세요</h1>
		
		<input type = "text" id="getId" name="id" maxlength=10 placeholder="        닉네임은 최대 10자까지 가능합니다">
		<button type="button" onclick="" name="checkId" id="btn">중복 확인</button>
		<h3 id="alert"> ※ 해당 닉네임은 사용가능합니다!</h3>
		<h3 id="alert"> ※ 해당 닉네임은 이미 사용중입니다!</h3>
	</div>
</body>
</html>