<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>MU:TE</title>
<link rel="stylesheet" href="resources/css/result.css">
<link rel="stylesheet" href="resources/css/modal.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://sdk.scdn.co/spotify-player.js"></script>

</head>
<body>
	<header>
  <div id="navi-container">
    <table id="navi-head">
      <tr>
        <td class="head-ba"><img class="back" src="resources/images/gom_button.png"></td>
      </tr>
      <tr>
        <td class="head-ba" rowspan="3"><a class="backft" style="color: lightgray;" href="http://localhost:9089/mute/mypage">마이페이지</a></td>
      </tr>
    </table>
  </div>
</header>
	<table class="table1">
		<tr>
			<td><img alt="gom_hiphop" src="resources/images/gom_hiphop.png"
				height="500" width="500"></td>
		</tr>
		<tr>
			<td><a class="hiphop" style="color: #00748D;">힙합을 좋아하는 당신은
					민트초콜릿 칩!</a></td>
		</tr>
		<tr>
			<td><a class="hiphop" style="color: #00748D;">어쩔 민초 저쩔 힙합~</a></td>
		</tr>
	</table>
	<br>

	<div class="con">
		<div class="reco">
			<br> <a class="tag">당신을 위한 #힙합 음악</a><br> <br>
			<table class="table2">
			<tr id="trhead">
				<td></td>
				<td>제목</td>
				<td>가수</td>
				<td>재생</td>
				<td>플레이리스트 추가</td>
			</tr>
            <c:if test="${not empty recommendations}">
                <c:forEach var="track" items="${recommendations}">
                    <tr>
                        <td>
                            <div class="cover">
                                <img src="${track.coverImageUrl}" alt="Album Cover" width="100" height="100">
                            </div>
                        </td>
                        <td>
                            ${track.name}
                        </td>
                        <td>
                        	 ${track.artistName}
                        </td>
                        <td>
							<img class="playPauseImage" src="<c:url value='/resources/images/play_pl.png'/>"
						    alt="Play/Pause" width="50" height="50" data-track-uri="${track.uri}"
						    onclick="togglePlayPause('${track.uri}', this);">
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
		<br>
		<table class="table3">
			<tr>
				<td id="tdfoot"><a class="rereco" href="" style="color: black;">유사한 3곡 다시 추천받기</a></td>
				<td id="tdfoot"><a class="rereco" href="http://localhost:9089/mute/main" style="color: black;">다시 테스트하기</a></td>
			</tr>
		</table>
		<br>
		</div>
		<br>
	</div>
	<!-- ================================================ -->
	<!-- The Modal -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <form name="rf" id="rf">
                <table id="modaltable">
						<tr>
							<td class="td"><div class="cover1"></div></td>
							<td class="td"><a class="pltitle text-body" href=""
								onclick="notify()">너무 우울해서 노래 플리 담았어ㅜㅜ
							</a></td>
						</tr>
						<tr>
							<td class="td"><div class="cover1"></div></td>
							<td class="td"><a class="pltitle text-body" href=""
								onclick="notify()">너무 우울해서 노래 플리 담았어ㅜㅜ</a></td>
						</tr>
						<tr>
							<td class="td"><div class="cover1"></div></td>
							<td class="td"><a class="pltitle text-body" href=""
								onclick="notify()">코딩할 때 듣는 노동요</a></td>
						</tr>
						<tr>
							<td class="td"><div class="cover1"></div></td>
							<td class="td"><a class="pltitle text-body" href=""
								onclick="notify()">신나고 싶을 때 듣는 노래</a></td>
						</tr>
					</table>
                <br>
                <button type="button" class="close-btn" onclick="toggleModal('addModal')">닫기</button>
                <div id="add">
                    <button type="button" class="btn text-body large-button" data-toggle="modal" data-target="#modalplus" style="font-size: 24px;">+ 새로운 플레이리스트 </button>
                </div>
            </form>
        </div>
    </div>
</div>
	
	<div class="modal fade" id="modalplus" tabindex="-1" role="dialog" data-target="#alert">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">플레이리스트 이름을 입력하세요</h3>
            </div>
            <div class="modal-body">
                <textarea id="modalContent" rows="1" cols="40" placeholder="제목은 20글자 이내로 입력하세요" maxlength="20" onkeydown="return event.keyCode !== 13;"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="close-btn"  onclick="checkAndSubmit()">확인</button>
                <button type="button" class="close-btn" data-dismiss="modal" >취소</button>
            </div>
        </div>
    </div>
</div>
	
	<div class="modal fade" id="modalAlert" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <h3>플레이리스트 제목은 공백일 수 없습니다</h3>
            </div>
            <div class="modal-footer">
                <button type="button" class="close-btn" data-dismiss="modal" onclick="submitAlert()">확인</button>
            </div>
        </div>
    </div>
</div>

<div class="notification" id="notification">
   음악을 플레이리스트에 저장했습니다!
</div>

<script>
	
	document.addEventListener('DOMContentLoaded', function () {
	    const pltitles = document.querySelectorAll('.pltitle'); // 여러 개의 .pltitle을 선택

	    const notification = document.getElementById('notification');
	    const tareset = document.querySelector('#modalplus .close-btn');
	    const mct = document.getElementById('modalContent');

	    // 각 .pltitle에 대해 이벤트 리스너 등록
	    pltitles.forEach(function (pltitle) {
	        pltitle.addEventListener('click', function (event) {
	            event.preventDefault();
	            console.log('pltitle clicked');
	            notify();
	        });
	    });

	    function notify() {
	        notification.style.display = 'block';

	        setTimeout(function () {
	            notification.style.display = 'none';
	        }, 1000);
	    }

	    tareset.addEventListener('click', function () {
	        mct.value = '';
	    });
	});

	
	function toggleModal(modalId) {
        $('#' + modalId).modal('toggle');
    }

	let isPlus1 = false;
    let isPlus2 = false;
    let isPlus3 = false;

    function toggleModal(modalId) {
        $('#' + modalId).modal('toggle');
    }
    
    function openModalAlert() {
        $('#modalAlert').modal('show');
    }
    
    function checkAndSubmit() {
        const mcv = $('#modalContent').val().trim();
        // textarea 값이 비어있을 경우 modalAlert 모달을 열고, 아닐 경우 다른 로직 수행
        if (mcv === '') {
            openModalAlert();
        } else {
        	$('#modalplus').modal('hide');
        }
    }

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

</script>

</body>
</html>