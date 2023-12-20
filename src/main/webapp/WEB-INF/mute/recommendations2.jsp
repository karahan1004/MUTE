<!-- recommendations2.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Genre Recommendations</title>

    <!-- Spotify Web Playback SDK 스크립트 추가 -->
    <script src="https://sdk.scdn.co/spotify-player.js"></script>
    <!-- 추가된 부분: jQuery 스크립트 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        // 추가된 부분: 전역 범위에 playPause 함수 정의
        function playPause(trackUri) {
            // Spotify Web Playback SDK를 사용하여 노래 재생 및 일시정지 토글
            // 이 코드는 Spotify Web Playback SDK에 따라야 합니다.
            // Spotify Web Playback SDK를 사용하는 방법은 Spotify의 공식 문서를 참조하세요.
            
            // 플레이어 상태에 따라 이미지 변경
            var image = document.getElementById('playPauseImage');
            var isPlaying = /* 플레이어 상태를 확인하는 코드 (예시로 true 또는 false 사용) */ true;

            if (isPlaying) {
                // 재생 중이면 일시정지 이미지로 변경
                image.src = 'resources/images/pause_pl.png';
            } else {
                // 일시정지 중이면 재생 이미지로 변경
                image.src = 'resources/images/play_pl.png';
            }
        }

        // Spotify Web Playback SDK 초기화
        window.onSpotifyWebPlaybackSDKReady = () => {
            // 아무 내용이 없어도 됩니다.
            // 필요한 경우 초기화 이후에 수행할 작업을 추가할 수 있습니다.
        }
    </script>
</head>
<body>

<h2>Genre Recommendations</h2>

<c:if test="${not empty recommendations}">
    <ul>
        <c:forEach var="track" items="${recommendations}">
            <li>
                ${track.name} by ${track.artists[0].name}
                <img src="${track.album.images[0].url}" alt="Album Cover" width="100" height="100">
                
                <!-- 노래 재생 및 일시정지 이미지 -->
                <!-- 수정된 부분: onclick 이벤트에서 playPause 함수 호출 -->
                <img id="playPauseImage" src="resources/images/play_pl.png" alt="Play/Pause" width="50" height="50" onclick="playPause('${track.uri}')">
            </li>
        </c:forEach>
    </ul>
</c:if>

<c:if test="${empty recommendations}">
    <p>No recommendations available.</p>
</c:if>

</body>
</html>