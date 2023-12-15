<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>


</head>
<body>
	<header>
		<nav>
			<ul class="header-container">
				<li class="header-item"><a
					href="http://localhost:9089/mute/main" style="color: black;">다시
						테스트하기</a></li>
				<li class="header-item"><a
					href="http://localhost:9089/mute/mypage" style="color: black;">마이페이지</a></li>
			</ul>
		</nav>
	</header>
	<table class="table1">
		<tr>
			<td><img alt="gom_ballad" src="resources/images/gom_ballad.png"
				height="500" width="500"></td>
		</tr>
		<tr>
			<td><a class="ballad" style="color: #512626;">발라드를 좋아하는 당신은
					초코, 우리 이제 헤이즐넛!</a></td>
		</tr>
		<tr>
			<td><a class="ballad" style="color: #512626;">ㄴr는 지금 눈물을
					흘린ㄷr..</a></td>
		</tr>
	</table>
	<br>

	<div class="con">
		<div class="reco">
			<br> <a class="tag">당신을 위한 #발라드 음악</a><br> <br>
			<table class="table2">
				<tr>
					<td><div class="cover"></div></td>
					<td>힙합왕힙합왕힙합왕음악추천</td>
					<td>아티스트명</td>
					<td><a id="toggleButton1" onclick="toggleButton1()"> <img
							id="buttonImage1" src="resources/images/play_pl.png" alt="Start"></a></td>
					<td><a id="toggleStar1" onclick="toggleModal('addModal');">
							<img id="buttonStar1" src="resources/images/plus_pl.png"
							alt="base">
					</a></td>
				</tr>
				<tr>
					<td><div class="cover"></div></td>
					<td>힙합왕</td>
					<td>아티스트명</td>
					<td><a id="toggleButton2" onclick="toggleButton2()"> <img
							id="buttonImage2" src="resources/images/play_pl.png" alt="Start"></a></td>
					<td><a id="toggleStar2" onclick="toggleModal('addModal');">
							<img id="buttonStar2" src="resources/images/plus_pl.png"
							alt="base">
					</a></td>
				</tr>
				<tr>
					<td><div class="cover"></div></td>
					<td>힙합왕</td>
					<td>아티스트명</td>
					<td><a id="toggleButton3" onclick="toggleButton3()"> <img
							id="buttonImage3" src="resources/images/play_pl.png" alt="Start"></a></td>
					<td><a id="toggleStar3" onclick="toggleModal('addModal');">
							<img id="buttonStar3" src="resources/images/plus_pl.png"
							alt="base">
					</a></td>
				</tr>
			</table>


			<br> <a class="rereco" href="" style="color: black;">유사한 3곡
				다시 추천받기</a><br> <br>
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
	
    let isPaused = false;
    
    function toggleButton1() {
		const buttonImage = document.getElementById('buttonImage1');
		isPaused = !isPaused;
		if (isPaused) {
			buttonImage.src = 'resources/images/pause_pl.png';
		} else {
			buttonImage.src = 'resources/images/play_pl.png';
		}
	}

	function toggleButton2() {
		const buttonImage = document.getElementById('buttonImage2');
		isPaused = !isPaused;
		if (isPaused) {
			buttonImage.src = 'resources/images/pause_pl.png';
		} else {
			buttonImage.src = 'resources/images/play_pl.png';
		}
	}

	function toggleButton3() {
		const buttonImage = document.getElementById('buttonImage3');
		isPaused = !isPaused;
		if (isPaused) {
			buttonImage.src = 'resources/images/pause_pl.png';
		} else {
			buttonImage.src = 'resources/images/play_pl.png';
		}
	}

	let isPlus1 = false;
    let isPlus2 = false;
    let isPlus3 = false;
    
   /*  toggleButton('buttonImage1', isPaused1);
    toggleButton('buttonImage2', isPaused2);
    toggleButton('buttonImage3', isPaused3);
    
    ctp('buttonPlus1', isPlus1);
    ctp('buttonPlus2', isPlus2);
    ctp('buttonPlus3', isPlus3); */

    function toggleModal(modalId) {
        $('#' + modalId).modal('toggle');
    }

    function toggleButton(buttonId, isPause) {
        const buttonImage = document.getElementById(buttonId);
        isPause = !isPause;

        if (isPause) {
            buttonImage.src = 'resources/images/pause_pl.png';
        } else {
            buttonImage.src = 'resources/images/play_pl.png';
        }
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

    
    
</script>

</body>
</html>