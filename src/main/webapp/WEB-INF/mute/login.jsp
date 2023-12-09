<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Hi!!!</h1>
</body>
</html>

/*login.jsp*/
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/login.css">
<title>MU:TE</title>
</head>

<script>
function clickSpotifyLogin() {

}

</script>

<body>

	<nav>
		<div>
			<img id="logo" alt="logo" src="resources/images/logo.png" height="385" width="484"><!--로고 -->
			<h1>간편로그인</h1>
		</div>
		
		<div id="id_login">
			<p><img id="spotify" alt="spotify-loginBtn" onclick="clickSpotifyLogin()" src="resources/images/btn_spotify.png" height="114" width="450"></p>
		
		</div>
		
	
	</nav>
</body>
</html>