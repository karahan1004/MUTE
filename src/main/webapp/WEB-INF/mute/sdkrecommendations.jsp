<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="se.michaelthelin.spotify.model_objects.specification.Track"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Genre Recommendations</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="https://sdk.scdn.co/spotify-player.js"></script>
    <script>
    let player;
    let device_id;
    	window.onSpotifyWebPlaybackSDKReady = () => {
    	  const token = '${accessToken}'; // 사용자의 액세스 토큰을 여기에 설정
    	  player = new Spotify.Player({
    	    name: 'Web Playback SDK',
    	    getOAuthToken: (cb) => { cb(token); }
    	  });
    	  console.dir(player)
    	  // 로그인 및 초기화
    	   
    	  // Ready
    player.on('ready', data => {
        console.log('Ready with Device ID', data.device_id);
        device_id=data.device_id;
        // Play a track using our new device ID
        //play(data.device_id);
    });
    	  
    	  
    	  player.connect();
    	  console.log("===연결됨======================================")
    	};
    	
        const SPOTIFY_API_BASE = 'https://api.spotify.com/v1/me/player';
        const accessToken = "${accessToken}"; // Java 코드에서 받아온 accessToken
        // 이미지 토글 상태를 나타내는 객체
        var isPlayingMap = {};
     // 이미지 클릭 이벤트에 플레이/일시정지 기능 추가
     
        function togglePlayPause(trackUri, imageElement) {
            console.log("트랙에 대한 재생/일시정지 클릭: " + trackUri);
            const isPlaying = imageElement.classList.contains('playing');
            
            $.ajax({
                url: SPOTIFY_API_BASE + (isPlaying ? '/pause' : '/play') + '?device_id=' + device_id,
                type: 'PUT',
                headers: {
                    'Authorization': 'Bearer ' + accessToken,
                    'Content-Type': 'application/json',
                },
                data: JSON.stringify({
                    uris: [trackUri],
                    device_ids: [device_id]
                }),
                success: function () {
                    // 이미지 토글 호출
                    togglePlayPauseImage(trackUri, imageElement);
                },
                error: function (error) {
                    console.error('트랙 재생/일시정지 실패:', error);
                    console.error('API 호출 실패 상세 정보:', error.responseText);
                },
            });
        }
     // 이미지 토글 함수
        function togglePlayPauseImage(trackUri, imageElement) {
            // 이미지 토글
            if (imageElement.classList.contains('playing')) {
                imageElement.src = '<c:url value="/resources/images/play_pl.png"/>';
                console.log("음악 일시정지");
            } else {
                imageElement.src = '<c:url value="/resources/images/pause_pl.png"/>';
                console.log("음악 재생");
            }
            // 토글 클래스 추가/제거
            imageElement.classList.toggle('playing');
        }

        // 이미지 클릭 이벤트에 플레이/일시정지 기능 추가
        function playPause(trackUri, playPauseImage) {
            console.log("트랙에 대한 재생/일시정지 클릭: " + trackUri);
            $.ajax({
                url: SPOTIFY_API_BASE + '/play?device_id=' + device_id,
                type: 'PUT',
                headers: {
                    'Authorization': 'Bearer ' + accessToken,
                    'Content-Type': 'application/json',
                },
                data: JSON.stringify({
                    uris: [trackUri],
                    device_ids: [device_id]
                }),
                success: function () {
                    // 이미지 토글 호출
                    togglePlayPauseImage(trackUri, playPauseImage);
                },
                error: function (error) {
                    console.error('트랙 재생/일시정지 실패:', error);
                    console.error('API 호출 실패 상세 정보:', error.responseText);
                },
            });
        }

        // 일시정지 함수
        function pausePlay(trackUri) {
            console.log('음악 일시정지 시도 중...');
            $.ajax({
                url: SPOTIFY_API_BASE + '/pause?device_id=' + device_id,
                type: 'PUT',
                headers: {
                    'Authorization': 'Bearer ' + accessToken,
                    'Content-Type': 'application/json',
                },
                data: JSON.stringify({
                    uris: [trackUri],
                    device_ids: [device_id]
                }),
                success: function () {
                    console.log('음악 일시정지 성공');
                    // 일시정지 성공 후 추가 작업 수행
                    // 이미지 토글 호출
                    togglePlayPauseImage(trackUri);
                },
                error: function (error) {
                    console.error('음악 일시정지 실패:', error);
                    // 일시정지 실패 후 추가 작업 수행
                },
            });
        }

        
     	function playTest(uri){
     		const playlistUri = uri;
     		player.resume();
     		
     		/* player.play({
     		  uris: [playlistUri]
     		}); */
     	}
     	
        function setVolume(volume) {
            console.log('볼륨 조절: ' + volume);
            $.ajax({
                url: SPOTIFY_API_BASE + '/volume?volume_percent=' + volume,
                type: 'PUT',
                headers: {
                    'Authorization': 'Bearer ' + accessToken,
                },
                success: function () {
                    console.log('볼륨 조절 성공');
                },
                error: function (error) {
                    console.error('볼륨 조절 실패:', error);
                    console.error('API 호출 실패 상세 정보:', error.responseJSON);
                },
            });
            // UI에 현재 볼륨 표시
            $('#volumeLabel').text(volume);
        }
        // 이전 트랙으로 이동 함수
        function previousTrack() {
            console.log('이전 트랙으로 이동');
            $.ajax({
                url: SPOTIFY_API_BASE + '/previous',
                type: 'POST',
                headers: {
                    'Authorization': 'Bearer ' + accessToken,
                },
                success: function () {
                    console.log('이전 트랙으로 이동 성공');
                },
                error: function (error) {
                    console.error('이전 트랙으로 이동 실패:', error);
                },
            });
        }
        // 다음 트랙으로 이동 함수
        function nextTrack() {
            console.log('다음 트랙으로 이동');
            $.ajax({
                url: SPOTIFY_API_BASE + '/next',
                type: 'POST',
                headers: {
                    'Authorization': 'Bearer ' + accessToken,
                },
                success: function () {
                    console.log('다음 트랙으로 이동 성공');
                },
                error: function (error) {
                    console.error('다음 트랙으로 이동 실패:', error);
                },
            });
        }
        
        
    </script>
</head>
<body>
    <h2>Genre Recommendations</h2>
    <table>
        <c:if test="${not empty recommendations}">
            <tr>
                <c:forEach var="track" items="${recommendations}">
                    <td>
                        ${track.name} by ${track.artistName} by ${track.id}
                        <img src="${track.coverImageUrl}" alt="Album Cover" width="100" height="100">
                        <!-- Spotify URI를 사용하여 트랙을 재생하는 링크 -->
                        <a href="javaScript:playTest('spotify:track:${track.id}')">Play on Spotify</a>
                        <!-- 플레이/일시정지 이미지 -->
						<img class="playPauseImage"
						    src="<c:url value='/resources/images/play_pl.png'/>"
						    alt="Play/Pause" width="50" height="50"
						    data-track-uri="${track.uri}"
						    onclick="togglePlayPause('${track.uri}', this);">
						
						<%-- <!-- 일시정지 이미지 -->
						<img class="pauseImage"
						    src="<c:url value='/resources/images/pause_pl.png'/>"
						    alt="Pause" width="50" height="50"
						    data-track-uri="${track.uri}"
						    onclick="togglePlayPause('${track.uri}', this);"> --%>
                    </td>
                </c:forEach>
            </tr>
        </c:if>
    </table>
    <c:if test="${empty recommendations}">
        <p>No recommendations available.</p>
    </c:if>
    <input type="range" min="0" max="100" value="50" onchange="setVolume(this.value)">
    <span id="volumeLabel">50</span>
    <button onclick="previousTrack()">이전 트랙</button>
    <button onclick="nextTrack()">다음 트랙</button>
</body>
</html>