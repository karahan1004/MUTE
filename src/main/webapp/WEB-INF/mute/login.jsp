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


function loginToSpotify() {
    var client_id = '61731dfa4f5a4f81a934c76fe09958d8';
    var redirect_uri = 'http://localhost:9089/mute/main';

    var scope = 'user-read-private user-read-email user-read-currently-playing playlist-read-private playlist-modify-private user-modify-playback-state';


    var spotifyAuthURL = 'https://accounts.spotify.com/authorize?' +
        'client_id=' + client_id +
        '&redirect_uri=' + redirect_uri +
        '&response_type=code' +
        '&scope=' + encodeURIComponent(scope);

    // Redirect the user to the Spotify authentication page
    window.location.href = spotifyAuthURL;

}

</script>

<body>

	<nav>
		<div>
			<img id="logo" alt="logo" src="resources/images/mutelogo.png" height="385" width="385"><!--로고 -->
			<h1>간편로그인</h1>
			<br><br><br>
<!-- 			<p><img id="spotify" alt="spotify-loginBtn" onclick="location.href='spotify.jsp'" src="resources/images/btn_spotify.png" height="130" width="450"></p>
 -->			<!-- spotifyBtn 이미지 바꿔야 함. 뒷배경 없는 걸로...! -->
			<img src="resources/images/btn_spotify.png" id="spotify-btn" type="button" onclick="loginToSpotify()">
			<!-- 'location.href='spotifyLogin' -->
			
		</div>
		
		
	
	</nav>
</body>
</html>