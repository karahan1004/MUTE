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

      	// 메인으로 리다이렉트 
      	  var redirectPath = "/mute/main";

      	// 리다이렉트 수행
      	  window.location.href = redirectPath;
			/* 버튼을 누르면 바로 saveComment로 넘어가는 듯함  */
		    }
		
		 function checkForm() {
		        var commentContent = document.getElementById('cmtBox').value;

		        if (commentContent.trim() === '') {
		            alert('댓글 내용을 입력하세요.');
		            return false; // 제출 중단
		        }

		        // 추가적인 검증 로직이 있다면 여기에 추가할 수 있습니다.

		        return true; // 폼이 유효하면 제출
		    }
		
	
		</script> 

</head>
	<body>
			<!-- 상단바 -->
			<table class="header">
		 			<tr class="top">
		 				<td id="logo"><img id="logoImg" alt="logo" src="resources/images/mutelogo.png" ></td>
						<td id="empty"></td>
						<% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
						<td class="nickname"><span id="nickname">${nickname} 님</span></td>
						<% } else { %>	
						<td></td>
						<% } %>
						
					    <% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
					        <td id="loggedIn">
					            <!-- 로그인 상태에 대한 스타일 -->
					            <a id="loginText" href="logout">로그아웃</a>
					        </td>
					    <% } else { %>
					        <td id="loggedOut">
					            <!-- 로그아웃 상태에 대한 스타일 -->
					            <a id="loginText" href="login">간편 로그인</a>
					        </td>
					    <% } %>
					    
					    <% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
						 <td class="mypage"><a href="mypage" id="mypageFont">마이페이지</a></td>
						 <% } else { %>	
						 <td class="mypage"><a href="javascript:checkLoginAndRedirect()" id="mypageFont">마이페이지</a></td>
					     <% } %>
					     
						
	 				</tr>
				</table>
			
			
				<!-- 핑크 박스 -->
				<table class="table1">
					<tr class="bottom">
						<td id="title" colspan="5"><h1>내가 듣는 노래가 아이스크림이라면?</h1></td>
						<!-- <td></td>
						<td></td>
						<td></td> -->
					</tr>
					<tr class="tr-2">
						
						 <!-- <td></td> -->
						 <td id="mainGom" colspan="5"><img id="bear" alt="bear" src="resources/images/origin_gom.png" ></td>
						 <!-- <td></td>
						 <td></td>
						 <td></td> -->
						
					</tr>
	
					<!-- 테스트하러가기 버튼 -->
					<tr class="bottom">
						<% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
						<td id="button" colspan="5"><button class="button" onclick="location.href='test1'">눌러서 맛보기</button></td>
					   <% } else { %>
					   	<td id="button" colspan="5"><button class="button" onclick="checkLoginAndRedirect()">눌러서 맛보기</button></td>
					   	
					   <% } %>
						<!-- <td></td>
						<td></td>
						<td></td> -->
					</tr>
				
				
				</table>
		
				<br>
				
				<!-- 댓글 REVIEW -->
				<form id="commentForm" action="/mute/saveComment" method="post" onsubmit="return checkForm();">
					<table class="table2">
						<tr>
							<td id="cnt"><span id="cmtCount">댓글 <c:out value="${reviewCount}" /></span></td>
						</tr>
					
			    		<!-- 댓글 입력 폼 -->
			   			 <tr class="cmt">
			   			    <td class="input"><input type="text" id="cmtBox" name="RV_CONTENT"></td>
			    		    <% if (session.getAttribute("accessToken") != null && !session.getAttribute("accessToken").toString().isEmpty()) { %>
			  		  <td><button type="submit" id="submit">댓글달기</button></td>
			  		  <% } else { %>
			  		  <td><button id="submit" onclick="checkLoginAndRedirect()">댓글달기</button></td>
			  		  <% } %>
			   		  
					  </tr>
					</table>
			  
			   		<!-- 댓글 내용 출력  -->
				<div id="please">
					<table class="table3">
					
						<tr>
							<td id="empty2"></td>
						</tr>
						
					    <c:forEach var="comment" items="${commentList}"> <!-- var는 ${commentList}를 comment라는 이름으로 선언 -->
						    <tr>
						        <td id="comment"><c:out value="${comment.s_NAME}"/></td>
						        <!-- s_NAME을 S_NAME으로 했을 떄는 오류가 남. RV_CONTENT를 rV_CONTENT로 했을 떄는 오류가 남. ==> WHY???? -->
						    </tr>
						     <tr>
						    	<td id="content"><c:out value="${comment.RV_CONTENT}"/></td>
						    </tr>
						</c:forEach>
			
						
					</table> 
				</div>
			  </form>
	
			<!-- 웹사이트 소개 -->
			<div class="intro">
				<span> <img src="resources/images/gom_button.png" alt="gom" id="gom"> </span> 
				<h1>안녕하세요!</h1>
				<h2>MU:TE와 함께 음악이 주는 행복을 느껴보세요</h2>
				<h2>어느샌가 머리속의 잡음이 사라질거에요!</h2>
				<h3>OUR REPOSITORY : <a href="https://github.com/cgmlwjd/MUTE.git" target="_blank">
	       			 <img src="resources/images/git_logo.png" alt="git" id="git"></a>
	       		</h3>
				<br>
			</div>
		</body>

</html>


