<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/mypage.css">
<title>MU:TE</title>
</head>
<body>

	<header>
		<table id="navi-head">
			<tr>
				<td rowspan="2"><a class="pl">안녕하세요   USERID님~</a></td>
				<td><a href="main"><img class="back"
					src="resources/images/gom_button.png"></a></td>
				<td rowspan="2"><img class="logo"
					src="resources/images/mutelogo.png"></td>
			</tr>
			<tr>
				<td><a class="backft" href="main">메인페이지</a></td>
			</tr>
		</table>
	</header>
	    <hr>
	        <table class="playListTable">
	       		<tr>
            <td class="mypl">내 플레이리스트</td>
            <td></td> 
            <br><br>
				</tr>
	        	<tr>
	        		<td><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">너무 우울해서 노래 플리 담았어ㅜㅜ</a></td>
					<!-- 부트스트랩 적용하기 제발-->
					<td class="edit"><img class="edit_img" src="resources/images/more.png">
					<img class="del_img" src="resources/images/del_pl.png"></td>
				</tr>
				<tr>
	        		<td ><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">사람이 할게 맞는건가?</a></td>
					<td class="edit"><img class="edit_img" src="resources/images/more.png">
					<img class="del_img" src="resources/images/del_pl.png"></td>
				</tr>
				<tr>
	        		<td ><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">백엔드 추천하시나요?</a></td>
					<td class="edit"><img class="edit_img" src="resources/images/more.png">
					<img class="del_img" src="resources/images/del_pl.png"></td>
				</tr>
				<tr>
	        		<td ><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">그럴리가요 American Girl~!</a></td>
					<td class="edit"><img class="edit_img" src="resources/images/more.png">
					<img class="del_img" src="resources/images/del_pl.png"></td>
				</tr>
			 
	        </table>

</body>
</html>