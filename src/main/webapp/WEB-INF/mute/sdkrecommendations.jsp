<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/playlist.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- jQuery 라이브러리 추가 -->
<!-- <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS와 Popper.js -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>



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
					<td class="si">${track}</td>
					<td class="ga">${artistInfoArray[status.index]}</td>
					<td class="del"><a
						onclick="handleDeleteAction('${playlist.id}', '${fn:split(trackIdList[status.index], '#')}');">
							<img class="del_img" src="resources/images/del_pl.png">
					</a></td>


				</tr>
			</c:forEach>



		</table>
	</div>

	<footer>
		<table id="navi-foot">
			<tr>
				<td class="si_btn"><img class="bt_img"
					src="resources/images/before_pl.png"></td>
				<td class="si_btn"><img id="ft_img" onclick="toggleImg()"
					src="resources/images/play_pl.png"></td>
				<td class="si_btn"><img class="at_img"
					src="resources/images/after_pl.png"></td>
				<td class="si_btn"><img class="im_foot"
					src="resources/images/gom_button.png"></td>
				<td class="si_foot"></td>
				<td class="ga_foot"></td>
				<td class="sa_btn" onclick="toggleVolumeSlider()"><img
					class="so_img" src="resources/images/sound_pl.png"></td>
				<td class="volume-container"><input type="range"
					class="volume-slider" id="volumeSlider" min="0" max="100"
					value="50" oninput="setVolume(this.value)"></td>
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

		function setVolume(volume) {
			// 여기에서 실제로 음량을 조절하는 코드를 추가할 수 있습니다.
			console.log("Volume set to: " + volume);
		}

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

		    // Ajax를 이용하여 서버에 삭제 요청을 보낼 수 있습니다.
		    $.ajax({
		        type: 'DELETE',
		        url: '/deleteTrack',
		        data: {
		            playlistId: playlistId,
		            trackId: trackId
		        },
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

								// 선택한 행에 맞게 footer 부분 변경
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

						// footer 부분 변경
						$('.im_foot').attr('src', albumImageSrc);
						$('.si_foot').text(songTitle);
						$('.ga_foot').text(artistName);
					}

					// 플레이/일시정지 이미지 변경 함수
					function changePlayPauseImage() {
						$('.ft_img').attr('src',
								'resources/images/pause_pl.png');
					}
				});
	</script>



</body>
</html> --%>