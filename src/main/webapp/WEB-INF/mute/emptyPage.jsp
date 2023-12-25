<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="resources/css/playlist.css">
    <title>MU:TE</title>
</head>
<body>
    <header>
		<table id="navi-head">
			<tr>
				<td class="head-lg" rowspan="2"><a href="main"><img
						class="logo" src="resources/images/mutelogo.png"></a></td>
				<td class="head-na" rowspan="2"><a class="pl">${playlist.name}</a></td>
				<td class="head-ba"><a href="mypage"><img class="back"
						src="resources/images/gom_button.png"></a></td>

			</tr>
			<tr>
				<td class="head-ba" rowspan="3"><a class="backft" href="mypage">뒤로가기</a></td>
			</tr>
		</table>
	</header>
	<hr>
	<div>
		<table id="menu">
			<tr>
				<!-- 임시로 곰버튼 이미지 넣어둠 -->
				<td class="meal">앨범 표지</td>
				<td class="mesi">노래 제목</td>
				<td class="mega">가수 이름</td>
				<td class="medel">삭제</td>
			</tr>
		</table>
	</div>
	<hr>
	<br><br>
	<p>이 플레이리스트는 비어있습니다!</p>
</body>
</html>
