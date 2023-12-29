<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/playlist.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS와 Popper.js -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script src="https://sdk.scdn.co/spotify-player.js"></script>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page
	import="se.michaelthelin.spotify.model_objects.specification.Track"%>



<title>MU:TE</title>
</head>
<body>
	<header>
		<table id="navi-head">
			<tr>
				<td class="head-lg" rowspan="2"><a href="main"><img
						class="logo" src="resources/images/mutelogo.png"></a></td>
				<td class="head-na" rowspan="2"><a class="pl">${playlist.name}</a></td>
				<td class="head-ba"><a href="mypage"><img class="back"
						src="resources/images/gom_button.png"></a></td>

			</tr>
			<tr>
				<td class="head-ba" rowspan="3"><a class="backft" href="mypage">뒤로가기</a></td>
			</tr>
		</table>
	</header>
	<hr>
	<div>
		<table id="menu">
			<tr>
				<!-- 임시로 곰버튼 이미지 넣어둠 -->
				<td class="meal">앨범 표지</td>
				<td class="mesi">노래 제목</td>
				<td class="mega">가수 이름</td>
				<td class="medel">삭제</td>
			</tr>
		</table>

	</div>
	<hr>
	<div id="scroll">
	
		<table id="sing-mi">
		
			<c:forEach var="track" items="${trackInfoArray}" varStatus="status">
				<tr>
					<td class="pi"><c:set var="albumDetailsArray"
							value="${fn:split(albumInfoArray[status.index], ',')}" /> <img
						class="albumimg" src="${albumDetailsArray[1]}" alt="Album Cover"
						width="100" height="100"></td>
					<td class="si" data-track-id="${trackIdList[status.index]}">${track}</td>
					<td class="ga">${artistInfoArray[status.index]}</td>
					<td class="del"><a
						onclick="handleDeleteAction('${playlist.id}', '${trackIdList[status.index]}');">
							<img class="del_img" src="resources/images/del_pl.png">
					</a></td>


				</tr>
			</c:forEach>



		</table>
	</div>

	<footer>
		<table id="navi-foot">
			<tr>
				<td class="si_btn" onclick="previousTrack()"><img
					class="bt_img" src="resources/images/before_pl.png"></td>
				<td class="si_btn"><img class="playPauseImage" id="ft_img"
					src="<c:url value='/resources/images/play_pl.png'/>"
					alt="Play/Pause" width="50" height="50"></td>
				<td class="si_btn" onclick="nextTrack()"><img class="at_img"
					src="resources/images/after_pl.png"></td>
				<td class="si_btn"><img class="im_foot"
					src="resources/images/gom_button.png"></td>
				<td class="si_foot"></td>
				<td class="ga_foot"></td>
				<td class="sa_btn" onclick="toggleVolumeSlider()"><img
					class="so_img" src="resources/images/sound_pl.png"></td>
				<td class="volume-container"><input type="range" min="0"
					max="100" value="50" class="volume-slider" id="volumeSlider"
					onchange="setVolume(this.value)"></td>
				<td></td>
			</tr>
		</table>
	</footer>

	<!-- ================================================ -->
	<!-- The Modal -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-md" role="document">
			<div class="modal-content">
				<form name="rf" id="rf">
					<table id="modaltable">
						<tr>
							<td class="del-td text-center"><a class="singdel text-body">이
									노래를 삭제 하시겠습니까?</a></td>
						</tr>
					</table>
					<br>
					<button type="button" class="close-btn" onclick="confirmDelete()">삭제</button>
					<button type="button" class="close-btn"
						onclick="toggleModal('addModal')">취소</button>
					<br> <br>
				</form>
			</div>
		</div>
	</div>

	<script>
		var originalImgSrc = "resources/images/play_pl.png";
		var altImgSrc = "resources/images/pause_pl.png";

		function toggleImg() {
			var imgElement = document.getElementById("ft_img");
			if (imgElement.getAttribute("src") === originalImgSrc) {
				imgElement.src = altImgSrc;
			} else {
				imgElement.src = originalImgSrc;
			}
		}

		function toggleVolumeSlider() {
			var slider = document.querySelector('.volume-slider');
			slider.style.display = (slider.style.display === 'none' || slider.style.display === '') ? 'block'
					: 'none';
		}

		/* function setVolume(volume) {
			// 여기에서 실제로 음량을 조절하는 코드를 추가할 수 있습니다.
			console.log("Volume set to: " + volume);
		}
 */
		function toggleModal(modalId) {
			$('#' + modalId).modal('toggle');
		}
		
		function scheduleDeleteTrack(playlistId, trackId) {
	        console.log('trackId : ' + trackId);
	        console.log('playlistId : ' + playlistId);

	        if (confirm('정말로 이 트랙을 삭제하시겠습니까?')) {
	            // 확인을 선택한 경우에만 트랙 삭제 함수 호출
	            deleteTrack(playlistId, trackId);
	        }
	    }
		
		function handleDeleteAction(playlistId, trackId) {
		    // 삭제 전이나 후에 수행할 공통 작업을 추가하세요
			console.log('playlistId:', playlistId);
    		console.log('trackId:', trackId);
		    $('#addModal').data('playlistId', playlistId);
		    $('#addModal').data('trackId', trackId);

		    // 삭제 후에 수행할 다른 작업을 추가하세요

		    // 삭제 후 모달을 토글하려면 다음과 같이 할 수 있습니다:
		    toggleModal('addModal');
		}

		function confirmDelete() {
		    // 여기에 실제 삭제 동작을 추가할 수 있음
		    // 삭제가 성공하면 모달을 닫도록 처리
		    // 예시: 삭제 성공 후 모달을 닫고 싶다면 toggleModal('addModal')을 호출

		    // 저장된 playlistId와 trackId 검색
		    var playlistId = $('#addModal').data('playlistId');
		    var trackId = $('#addModal').data('trackId');
			alert(trackId);
		    // Ajax를 이용하여 서버에 삭제 요청을 보낼 수 있습니다.
		    $.ajax({
		        type: 'POST',
		        url: '/mute/deleteTrack',
		        data:`playlistId=\${playlistId}&trackId=\${trackId}`,
		        success: function(response) {
		            // 서버에서 성공적으로 응답을 받으면 모달을 닫습니다.
		            alert(response); // 또는 적절한 메시지를 표시
		            toggleModal('addModal');
		        },
		        error: function(error) {
		            // 에러 처리
		            alert('Error deleting track: ' + error.responseText);
		        }
		    });
		}



		//노래 실행 부분

		$(document).ready(
				function() {
					$('.pi, .si, .ga').on(
							'click',
							function() {
								var albumImageSrc = $(this).closest('tr').find(
										'.pi img').attr('src');
								var songTitle = $(this).closest('tr').find(
										'.si').text();
								var artistName = $(this).closest('tr').find(
										'.ga').text();
								var trackId = $(this).closest('tr').find(
								'.si').attr('data-track-id');

								// 선택한 행에 맞게 footer 부분 변경
								$('#ft_img').attr('data-track-id', trackId);
								$('.im_foot').attr('src', albumImageSrc);
								$('.si_foot').text(songTitle);
								$('.ga_foot').text(artistName);
							});
				});

		$(document).ready(
				function() {
					var currentIndex = 0;

					// 초기에 footer 부분 설정
					updateFooter();

					// .pi, .si, .ga 클릭 이벤트
					$('.pi, .si, .ga').on('click', function() {
						currentIndex = $(this).closest('tr').index();
						updateFooter();
						changePlayPauseImage();
					});

					// .bt_img(이전), .at_img(다음) 클릭 이벤트
					$('.bt_img').on('click', function() {
						if (currentIndex > 0) {
							currentIndex--;
							updateFooter();
							changePlayPauseImage();
						}
					});

					$('.at_img').on('click', function() {
						var totalRows = $('.pi').length;
						if (currentIndex < totalRows - 1) {
							currentIndex++;
							updateFooter();
							changePlayPauseImage();
						}
					});

					// footer 부분 업데이트 함수
					function updateFooter() {
						var albumImageSrc = $('.pi').eq(currentIndex).find(
								'img').attr('src');
						var songTitle = $('.si').eq(currentIndex).text();
						var artistName = $('.ga').eq(currentIndex).text();
						var trackId = $('.si').eq(currentIndex).attr('data-track-id');

						// footer 부분 변경
						$('#ft_img').attr('data-track-id', trackId);
						$('.im_foot').attr('src', albumImageSrc);
						$('.si_foot').text(songTitle);
						$('.ga_foot').text(artistName);
					}

					// 플레이/일시정지 이미지 변경 함수
					function changePlayPauseImage() {
						$('.ft_img').attr('src',
								'resources/images/pause_pl.png');
					}
					
					initMusicPlay();
				});
		
		const initMusicPlay = () => {
			let playBtn = document.querySelector('#ft_img');
			playBtn.setAttribute('isPlay_test', '0'); // 0 정지, 1 재생
			
			playBtn.addEventListener("click", function(e) {
				let trackId =  playBtn.getAttribute('data-track-id');
				var isPlay = e.target.getAttribute('isPlay_test') === '0';
				var playUrl = SPOTIFY_API_BASE + (isPlay ? '/play' : '/pause') + '?device_id=' + device_id;
				
				if (isPlay) {
					$.ajax({
						url: playUrl,
						type: 'PUT',
						headers: {
							'Authorization': 'Bearer ' + accessToken,
							'Content-Type': 'application/json',
						},
						data: JSON.stringify({
							uris: ["spotify:track:" + trackId],
							device_ids: [device_id]
						}),
						success: function () {
							e.target.setAttribute('isPlay_test', '1');
							e.target.setAttribute('src', '/mute/resources/images/pause_pl.png');
						},
						error: function (error) {
							console.error('트랙 재생/일시정지 실패:', error);
							console.error('API 호출 실패 상세 정보:', error.responseText);
						},
					});
				} else {
					$.ajax({
						url: playUrl,
						type: 'PUT',
						headers: {
							'Authorization': 'Bearer ' + accessToken,
							'Content-Type': 'application/json',
						},
						success: function (response) {
							e.target.setAttribute('isPlay_test', '0');
							e.target.setAttribute('src', '/mute/resources/images/play_pl.png');
						},
						error: function (error) {
							console.error('API 호출 실패:', error);
							if (error.status === 401) {
								console.error('토큰이 만료되었거나 잘못되었습니다. 새로운 토큰을 요청하세요.');
							} else {
								console.error('상세 정보:', error.responseText);
							}
						},
					});
				}
			});
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
	    	  player.connect();
	    	   
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
    console.log("Received trackUri: " + trackUri);
    console.log("트랙에 대한 재생/일시정지 클릭: " + trackUri);
    const isPlaying = imageElement.classList.contains('playing');

    // 서버에서 trackId 값을 받아오는 예시
    $.ajax({
        url: SPOTIFY_API_BASE + (isPlaying ? '/play' : '/pause') + '?device_id=' + device_id,
        type: 'PUT',
        headers: {
            'Authorization': 'Bearer ' + accessToken,
            'Content-Type': 'application/json',
        },
        data: JSON.stringify({
            uris: [trackUri],
            device_ids: [device_id]
        }),
        success: function (response) {
            // 이 부분에서 응답을 확인하고 trackId를 추출하는 로직을 추가
            let trackId;
            if (response && response.trackId) {
                trackId = response.trackId;
            } else {
                console.error('trackId를 찾을 수 없습니다. 응답 구조를 확인하세요.');
                return;
            }

            $.ajax({
                url: SPOTIFY_API_BASE + (isPlaying ? '/play' : '/pause') + '?device_id=' + device_id,
                type: 'PUT',
                headers: {
                    'Authorization': 'Bearer ' + accessToken,
                    'Content-Type': 'application/json',
                },
                data: JSON.stringify({
                    uris: ["spotify:track:" + trackId],
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
        },
        error: function (error) {
            console.error('API 호출 실패:', error);
            if (error.status === 401) {
                console.error('토큰이 만료되었거나 잘못되었습니다. 새로운 토큰을 요청하세요.');
            } else {
                console.error('상세 정보:', error.responseText);
            }
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
	     	            'Content-Type': 'application/json', // 헤더에 Content-Type 추가
	     	        },
	     	        success: function () {
	     	            console.log('볼륨 조절 성공');
	     	        },
	     	        error: function (error) {
	     	            console.error('볼륨 조절 실패:', error);
	     	            console.error('API 호출 실패 상세 정보:', error.responseJSON);
	     	            
	     	            // 에러 처리: HTTP 404 Not Found일 때
	     	            if (error.status === 404) {
	     	                console.error('Spotify 장치를 찾을 수 없음');
	     	                // 여기에서 다른 작업을 수행하거나 사용자에게 메시지를 표시할 수 있습니다.
	     	            }
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



</body>
</html>