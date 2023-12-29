<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
		
		<table class="table1">
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
					
					<td id="btnGom">
					<% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
					<img id="mypage" alt="mypage" onclick="location.href='logout'" src="resources/images/gom_button.png">
					<% } else { %>
					<img id="mypage" alt="mypage" onclick="location.href='login'" src="resources/images/gom_button.png">
					<% } %>
					</td>
					
 				</tr>

			
				<tr id="tr-2">
					<!-- <td></td> -->
					<!-- <td></td> -->
					 <% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
					 <td class="mypage"><a href="mypage" id="mypageFont">마이페이지</a></td>
					 <% } else { %>	
					 <td class="mypage"><a href="javascript:checkLoginAndRedirect()" id="mypageFont">마이페이지</a></td>
				     <% } %>
					
			<%-- 		<td id="login">
					  <!--  로그인 여부에 따라 버튼 텍스트 변경 -->
					   <% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
						<a id="loginText" href="logout">로그아웃</a>
					   <% } else { %>	
						<a id="loginText" href="login">간편 로그인</a>
					   <% } %> id="mypage"
					</td> --%>
					
					
					<% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
				        <td id="loggedIn">
				            <!-- 로그인 상태에 대한 스타일 -->
				            <a id="loginText" href="logout">로그아웃 ${nickname} 님</a>
				        </td>
				    <% } else { %>
				        <td id="loggedOut">
				            <!-- 로그아웃 상태에 대한 스타일 -->
				            <a id="loginText" href="login">간편 로그인</a>
				        </td>
				    <% } %>
					
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
		<br>
			<!-- 댓글 부분 !!!! -->
	<form id="commentForm" action="/mute/saveComment" method="post">
		<table class="table2">
			<tr>
				<td id="cnt">댓글 $(cnt)</td>
			</tr>
		
    		<!-- 댓글 입력 폼 -->
   			 <tr class="cmt">
   			    <td class="input"><input type="text" id="cmtBox" name="RV_CONTENT"></td>
    		    <td><button type="submit">댓글달기</button></td>
		    </tr>
			
  			  <!-- 사용자 정보 표시 예시 -->
  		<c:if test="${not empty boardVO.S_NAME}">
 			<tr>
   			   <td id="userId">USER ID: ${boardVO.S_NAME}</td>
   			</tr>
   		</c:if>
   		<!-- 댓글 내용 출력 예시 -->
	    <c:if test="${not empty boardVO.commentList}">
	        <c:forEach var="comment" items="${boardVO.commentList}">
	            <tr>
	                <td id="comment">${comment.RV_CONTENT}</td>
	            </tr>
	        </c:forEach>
	    </c:if>
			
		</table> 
  </form>
	
	</body>


</html>


