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
			<!-- 댓글 부분 !!!! -->
	<form id="commentForm" action="/mute/saveComment" method="post">
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
	
	</body>


</html>


