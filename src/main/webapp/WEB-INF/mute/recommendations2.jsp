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
            // 플레이어 상태에 따라 이미지 변경
            var image = document.getElementById('playPauseImage');
            console.log("트랙에 대한 재생/일시정지 클릭: " + trackUri);

            // 현재 플레이어 상태 가져오기 (state를 플레이어의 상태로 업데이트)
            player.getCurrentState().then(state => {
                if (!state) {
                    console.error('플레이어 상태를 가져올 수 없습니다.');
                    return;
                }

                var isPlaying = !state.paused; // 플레이어가 일시정지 상태인지 확인

                console.log("플레이어 상태: " + isPlaying);

                if (isPlaying) {
                    // 재생 중이면 일시정지 이미지로 변경
                    image.src = '<c:url value="/resources/images/pause_pl.png"/>';
                } else {
                    // 일시정지 중이면 재생 이미지로 변경
                    image.src = '<c:url value="/resources/images/play_pl.png"/>';
                }
            });
        }

        // Spotify Web Playback SDK 초기화
        window.onSpotifyWebPlaybackSDKReady = () => {
            console.log("Spotify Web Playback SDK is ready.");

            // player 객체 초기화
            const player = new Spotify.Player({
                name: 'Your Player Name',
                getOAuthToken: callback => {
                    // 여기에 Spotify 액세스 토큰을 얻는 로직 추가
                    callback('accessToken');
                },
                volume: 0.5 // 초기 볼륨 설정
            });

            // player 연결 및 초기화 로직 추가
            player.connect().then(success => {
                if (success) {
                    console.log('The Web Playback SDK successfully connected to Spotify!');
                }
            }).catch(error => {
                console.error('Error connecting the Web Playback SDK to Spotify:', error);
            });

            // 추가된 이벤트 리스너
            player.addListener('player_state_changed', (state) => {
                console.log('플레이어 상태 변경: ', state);
                // 플레이어 상태에 따라 추가 작업 수행
            });
        };
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
                <img id="playPauseImage" src="<c:url value='/resources/images/play_pl.png'/>" alt="Play/Pause" width="50" height="50" onclick="playPause('${track.uri}')">
            </li>
        </c:forEach>
    </ul>
</c:if>

<c:if test="${empty recommendations}">
    <p>No recommendations available.</p>
</c:if>

</body>
</html>