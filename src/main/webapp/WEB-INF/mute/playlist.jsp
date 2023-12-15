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

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- jQuery 라이브러리 추가 -->
<!-- <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS와 Popper.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>



<title>MU:TE</title>
</head>
<body>
	<header>
		<table id="navi-head">
			<tr>
				<td class="head-ba"><a href="mypage"><img class="back"
						src="resources/images/gom_button.png"></a></td>
				<td class="head-na" rowspan="2"><a class="pl">플레이리스트란 바로
						이거다</a></td>
				<td class="head-lg" rowspan="2"><img class="logo"
					src="resources/images/mutelogo.png"></td>
			</tr>
			<tr>
				<td class="head-ba"><a class="backft" href="mypage">뒤로가기</a></td>
			</tr>
		</table>
	</header>
	<hr>
	<table id="sing-mi">
		<tr>
			<!-- 임시로 곰버튼 이미지 넣어둠 -->
			<td class="pi"><img class="albumimg"
				src="resources/images/gom_button.png"></td>
			<td class="si">Baddie</td>
			<td class="ga">아이브</td>
			<td class="del"><a onclick="toggleModal('addModal');"><img
					class="del_img" src="resources/images/del_pl.png"></a></td>
		</tr>
		<tr>
			<td class="pi"><img class="albumimg"
				src="resources/images/gom_dance.png"></td>
			<td class="si">Baddie</td>
			<td class="ga">잔나비</td>
			<td class="del"><a onclick="toggleModal('addModal');"><img
					class="del_img" src="resources/images/del_pl.png"></a></td>
		</tr>
		<tr>
			<td class="pi"><img class="albumimg"
				src="resources/images/gom_button.png"></td>
			<td class="si">노래 이름</td>
			<td class="ga">가수 이름</td>
			<td class="del"><a onclick="toggleModal('addModal');"><img
					class="del_img" src="resources/images/del_pl.png"></a></td>
		</tr>
		<tr>
			<td class="pi"><img class="albumimg"
				src="resources/images/gom_button.png"></td>
			<td class="si">노래 이름</td>
			<td class="ga">가수 이름</td>
			<td class="del"><a onclick="toggleModal('addModal');"><img
					class="del_img" src="resources/images/del_pl.png"></a></td>
		</tr>
		<tr>
			<td class="pi"><img class="albumimg"
				src="resources/images/gom_button.png"></td>
			<td class="si">노래 이름</td>
			<td class="ga">가수 이름</td>
			<td class="del"><a onclick="toggleModal('addModal');"><img
					class="del_img" src="resources/images/del_pl.png"></a></td>
		</tr>

		<tr>
			<td class="pi"><img class="albumimg"
				src="resources/images/gom_button.png"></td>
			<td class="si">노래 이름</td>
			<td class="ga">가수 이름</td>
			<td class="del"><a onclick="toggleModal('addModal');"><img
					class="del_img" src="resources/images/del_pl.png"></a></td>
		</tr>

		<tr>
			<td class="pi"><img class="albumimg"
				src="resources/images/gom_button.png"></td>
			<td class="si">노래 이름</td>
			<td class="ga">가수 이름</td>
			<td class="del"><a onclick="toggleModal('addModal');"><img
					class="del_img" src="resources/images/del_pl.png"></a></td>
		</tr>

		<tr>
			<td class="pi"><img class="albumimg"
				src="resources/images/gom_button.png"></td>
			<td class="si">노래 이름</td>
			<td class="ga">가수 이름</td>
			<td class="del"><a onclick="toggleModal('addModal');"><img
					class="del_img" src="resources/images/del_pl.png"></a></td>
		</tr>

		<tr>
			<td class="pi"><img class="albumimg"
				src="resources/images/gom_button.png"></td>
			<td class="si">OMG</td>
			<td class="ga">뉴진스</td>
			<td class="del"><a onclick="toggleModal('addModal');"><img
					class="del_img" src="resources/images/del_pl.png"></a></td>
		</tr>

	</table>
	<hr>
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
				<td class="si_foot">Baddie</td>
				<td class="ga_foot">아이브</td>
				<td class="sa_btn" onclick="toggleVolumeSlider()"><img
					class="so_img" src="resources/images/sound_pl.png"></td>
				<td class="volume-container"><input type="range"
					class="volume-slider" id="volumeSlider" min="0" max="1" step="0.01"
					value="0.5" oninput="setVolume(this.value)"></td>
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

		function confirmDelete() {
			// 여기에 실제 삭제 동작을 추가할 수 있음
			// 삭제가 성공하면 모달을 닫도록 처리
			// 예시: 삭제 성공 후 모달을 닫고 싶다면 toggleModal('addModal')을 호출
			// toggleModal('addModal');

			// 아래는 간단한 예시 코드입니다. 실제 삭제 동작에 맞게 수정하세요.
			alert("노래가 삭제되었습니다."); // 삭제 성공 메시지 (임시)
			toggleModal('addModal'); // 모달 닫기
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

		$(document).ready(function () {
		    var currentIndex = 0;

		    // 초기에 footer 부분 설정
		    updateFooter();

		    // .pi, .si, .ga 클릭 이벤트
		    $('.pi, .si, .ga').on('click', function () {
		        currentIndex = $(this).closest('tr').index();
		        updateFooter();
		        changePlayPauseImage();
		    });

		    // .bt_img(이전), .at_img(다음) 클릭 이벤트
		    $('.bt_img').on('click', function () {
		        if (currentIndex > 0) {
		            currentIndex--;
		            updateFooter();
		            changePlayPauseImage();
		        }
		    });

		    $('.at_img').on('click', function () {
		        var totalRows = $('.pi').length;
		        if (currentIndex < totalRows - 1) {
		            currentIndex++;
		            updateFooter();
		            changePlayPauseImage();
		        }
		    });

		    // footer 부분 업데이트 함수
		    function updateFooter() {
		        var albumImageSrc = $('.pi').eq(currentIndex).find('img').attr('src');
		        var songTitle = $('.si').eq(currentIndex).text();
		        var artistName = $('.ga').eq(currentIndex).text();

		        // footer 부분 변경
		        $('.im_foot').attr('src', albumImageSrc);
		        $('.si_foot').text(songTitle);
		        $('.ga_foot').text(artistName);
		    }

		    // 플레이/일시정지 이미지 변경 함수
		    function changePlayPauseImage() {
		        $('.ft_img').attr('src', 'resources/images/pause_pl.png');
		    }
		});

	</script>



</body>
</html>
