<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MU:TE</title>
<link rel="stylesheet" href="resources/css/main.css">

</head>

<body>
	<header>
		<nav>
			<table class="header-container">
				<tr>
					<td id="td-t"><img id="logo" alt="logo" src="resources/images/mutelogo.png" ></td>
					<td id="td-m"><img id="mypage" alt="mypage" onclick="location.href='mypage'" src="resources/images/gom_button.png"></td>
					<td id="td-l"><a id="login" href="login">간편로그인</a></td>
				</tr>
			</table>
		</nav>
	</header>
	
	<table id="center">
		<tr>
			<td>
				<img id="bear" alt="bear" src="resources/images/origin_gom.png" >
			</td>
		</tr>
		<tr>
			<td><h1 id="headline">내가 듣는 노래가 아이스크림이라면?</h1></td>
		</tr>
		<tr>
			<td><button class="button" onclick="location.href='question1.jsp">눌러서 맛보기</button></td>
		</tr>
	</table>
</body>



</html>
<!-- ////
	<nav>
		<header>
			<table class="head">
				<tr>
					<td id="td-t"><img id="logo" alt="logo" src="resources/images/mutelogo.png" ></td>
					<td id="td-b"><img id="bear" alt="bear" src="resources/images/origin_gom.png" ></td>
					<td id="td-t"><img id="mypage" alt="mypage" onclick="location.href='mypage'" src="resources/images/gom_button.png"></td>
					<td id="td-t td-l"><a id="login" href="login">간편로그인</a></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td>마이페이지</td>
					<td></td>
				</tr>
			</table>
	
		</header>
	
		<div>
			<h1 id="headline">내가 듣는 노래가 아이스크림이라면?</h1>
			<button class="button" onclick="location.href='question1.jsp">눌러서 맛보기</button>
		</div>
		
		댓글 기능 구현 !!!!
		<div>
		</div>
	</nav> -->
