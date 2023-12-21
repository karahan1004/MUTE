<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page
    import="se.michaelthelin.spotify.model_objects.specification.Track"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Genre Recommendations</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<script>
    const SPOTIFY_API_BASE = 'https://api.spotify.com/v1/me/player';
    const accessToken = "${accessToken}"; // Java 코드에서 받아온 accessToken
    console.log(accessToken);

    function playPause(trackUri) {
        console.log("트랙에 대한 재생/일시정지 클릭: " + trackUri);

        $.ajax({
            url : SPOTIFY_API_BASE + '/play',
            type : 'PUT',
            headers : {
                'Authorization' : 'Bearer ' + accessToken,
                'Content-Type' : 'application/json',
            },
            data : JSON.stringify({
                uris : [ trackUri ],
            }),
            success : function() {
                console.log('트랙 재생/일시 정지 성공');
            },
            error : function(error) {
                console.error('트랙 재생/일시 정지 실패:', error);
                console.error('API 호출 실패 상세 정보:', error.responseText);
            },
        });
    }

    function setVolume(volume) {
        console.log('볼륨 조절: ' + volume);

        $.ajax({
            url : SPOTIFY_API_BASE + '/volume',
            type : 'PUT',
            headers : {
                'Authorization' : 'Bearer ' + accessToken,
            },
            data : {
                volume_percent : volume,
            },
            success : function() {
                console.log('볼륨 조절 성공');
            },
            error : function(error) {
                console.error('볼륨 조절 실패:', error);
            },
        });

        // UI에 현재 볼륨 표시
        $('#volumeLabel').text(volume);
    }

    function previousTrack() {
        console.log('이전 트랙으로 이동');

        $.ajax({
            url : SPOTIFY_API_BASE + '/previous',
            type : 'POST',
            headers : {
                'Authorization' : 'Bearer ' + accessToken,
            },
            success : function() {
                console.log('이전 트랙으로 이동 성공');
            },
            error : function(error) {
                console.error('이전 트랙으로 이동 실패:', error);
            },
        });
    }

    function nextTrack() {
        console.log('다음 트랙으로 이동');

        $.ajax({
            url : SPOTIFY_API_BASE + '/next',
            type : 'POST',
            headers : {
                'Authorization' : 'Bearer ' + accessToken,
            },
            success : function() {
                console.log('다음 트랙으로 이동 성공');
            },
            error : function(error) {
                console.error('다음 트랙으로 이동 실패:', error);
            },
        });
    }
</script>
</head>
<body>

    <h2>Genre Recommendations</h2>

    <c:if test="${not empty recommendations}">
        <ul>
            <c:forEach var="track" items="${recommendations}">
                <li>${track.name} by ${track.artistName} by ${track.uri}<img
                        src="${track.coverImageUrl}" alt="Album Cover" width="100"
                        height="100"> <img id="playPauseImage"
                                    src="<c:url value='/resources/images/play_pl.png'/>"
                                    alt="Play/Pause" width="50" height="50"
                                    onclick="playPause('${track.uri}')">
                </li>
            </c:forEach>
        </ul>
    </c:if>

    <c:if test="${empty recommendations}">
        <p>No recommendations available.</p>
    </c:if>

    <input type="range" min="0" max="100" value="50"
        oninput="setVolume(this.value)">
    <span id="volumeLabel">50</span>

    <button onclick="previousTrack()">이전 트랙</button>
    <button onclick="nextTrack()">다음 트랙</button>

</body>
</html>
