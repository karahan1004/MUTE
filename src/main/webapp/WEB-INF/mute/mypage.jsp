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
		<table id="head">
	    <tr>
    		<td rowspan="2"><a class="pl">안녕하세요 UserID님~</a></td>
			<td><img class="back" href="main"
				src="resources/images/gom_button.png"></td>
			<td rowspan="2"><img class="logo"
				src="resources/images/mutelogo.png"></td>
			</tr>
			<tr>
				<td><a class="backft" href="main">메인페이지</a></td>
			</tr>
			</table>
	    </header>
	    <hr>
	    <div class="myplay">
	   		<h2>내 플레이리스트</h2>
	    </div>
	    <!-- div 테이블로 변경해보자 -->
	  
	        <table class="playListTable">
	       
	        	<tr>
	        		<td ><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">너무 우울해서 노래 플리 담았어ㅜㅜ</a></td>
					<!-- <td class="del"><img class="del_img" src="resources/images/del_pl.png"></td>  -->
				<tr>
				<tr>
	        		<td ><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">사람이 할게 맞는건가?</a></td>
				<tr>
				<tr>
	        		<td ><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">너무 우울해서 노래 플리 담았어ㅜㅜ</a></td>
				<tr>
				<tr>
	        		<td ><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">너무 우울해서 노래 플리 담았어ㅜㅜ</a></td>
				<tr>
			 
	        </table>

</body>
</html>