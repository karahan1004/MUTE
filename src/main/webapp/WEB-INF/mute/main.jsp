<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MU:TE</title>
<link rel="stylesheet" href="resources/css/main.css">
	 <script>
		// 버튼 클릭 시 실행되는 함수
		function checkLoginAndRedirect() {
	       alert("로그인이 필요합니다.");
      	   console.log('checkLoginAndRedirect 함수 호출됨');


		    }
		</script> 

</head>
	<body>
		<table>
	 			<tr class="top">
	 				<td id="logo" rowspan="2"><img id="logoImg" alt="logo" src="resources/images/mutelogo.png" ></td>
	 				<td id="mainGom" rowspan="3"><img id="bear" alt="bear" src="resources/images/origin_gom.png" ></td>
					<td id="btnGom">
					<% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
					<img id="mypage" alt="mypage" onclick="location.href='mypage'" src="resources/images/gom_button.png">
					<% } else { %>
					<img id="mypage" alt="mypage" onclick="checkLoginAndRedirect()" src="resources/images/gom_button.png">
					<% } %>
					</td>
					
					<td id="login">
					  <!--  로그인 여부에 따라 버튼 텍스트 변경 -->
					   <% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
						<a id="loginText" href="logout">로그아웃</a>
					   <% } else { %>	
						<a id="loginText" href="login">간편 로그인</a>
					   <% } %>
					</td>
					
 				</tr>

			
				<tr id="tr-2">
					<!-- <td></td> -->
					<!-- <td></td> -->
					 <% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
					 <td id="mypage"><a href="mypage" id="mypageFont">마이페이지</a></td>
					 <% } else { %>	
					 <td id="mypage"><a href="javascript:checkLoginAndRedirect()" id="mypageFont">마이페이지</a></td>
				     <% } %>
					<td></td>
					
				</tr>

			
			<tr>
				<td></td>
				<!-- <td></td> -->
				<td></td>
				<td></td>
			</tr>
			
			<tr class="bottom">
				<td id="title" colspan="4"><h1>내가 듣는 노래가 아이스크림이라면?</h1></td>
				<!-- <td></td>
				<td></td>
				<td></td> -->
			</tr>
			
			<tr class="bottom">
				<% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
				<td id="button" colspan="4"><button class="button" onclick="location.href='test1'">눌러서 맛보기</button></td>
			   <% } else { %>
			   	<td id="button" colspan="4"><button class="button" onclick="checkLoginAndRedirect()">눌러서 맛보기</button></td>
			   	
			   <% } %>
				<!-- <td></td>
				<td></td>
				<td></td> -->
			</tr>
		
		
		</table>
			<!-- 댓글 부분 !!!! -->
		<table>
			<tr>
				<td>댓글</td>
			</tr>
			<tr>
				<td> <!-- seding 버튼  --></td>
			</tr>
			<tr>
				<td>Spotify User ID: $(userId)</td>
			</tr>
		</table>
	
	</body>


</html>


