<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>
<body>
	<header>
		<nav>
			<ul class="header-container">
				<li class="header-item"><a href="http://localhost:9089/mute/main" style="color: black;">다시 테스트하기</a></li>
				<li class="header-item"><a href="" style="color: black;">마이페이지</a></li>
			</ul>
		</nav>
	</header>
	
	<table class="table1">
		<tr>
			<td>	
				<img alt="gom_trot" src="resources/images/gom_trot.png" height="500" width="500">	
			</td>
		</tr>
		<tr>
			<td><a class="trot" style="color: #FF3232;">트로트를 좋아하는 당신은 베리베리스트로베리!</a></td>
		</tr>
		<tr>
			<td><a class="trot" style="color: #FF3232;">너 T로트야?</a></td>
		</tr>
		
	</table>
    <br>
    
  <div class="con">  
    <div class="reco">
        <br>
        <a class="tag">당신을 위한 #트로트 음악</a><br><br>
		<table class="table2">
			<tr>
				<td><div class="cover"></div></td>
				<td>힙합왕</td>
				<td>아티스트명</td>
				<td><a id="toggleButton1" onclick="toggleButton1()"> 
					<img id="buttonImage1" src="resources/images/play_pl.png" alt="Start"></a></td>
				<td><a id="togglePlus1" onclick="toggleModal('addModal');">
					<img id="buttonPlus1" src="resources/images/plus_pl.png" alt="plus">
				</a></td>
			</tr>
			<tr>
				<td><div class="cover"></div></td>
				<td>힙합왕</td>
				<td>아티스트명</td>
				<td><a id="toggleButton2" onclick="toggleButton2()"> 
					<img id="buttonImage2" src="resources/images/play_pl.png" alt="Start"></a></td>
				<td><a id="togglePlus2" onclick="toggleModal('addModal');">
					<img id="buttonPlus2" src="resources/images/plus_pl.png" alt="plus">
				</a></td>
			</tr>
			<tr>
				<td><div class="cover"></div></td>
				<td>힙합왕</td>
				<td>아티스트명</td>
				<td><a id="toggleButton3" onclick="toggleButton3()"> 
					<img id="buttonImage3" src="resources/images/play_pl.png" alt="Start"></a></td>
				<td><a id="togglePlus3" onclick="toggleModal('addModal');">
					<img id="buttonPlus3" src="resources/images/plus_pl.png" alt="plus">
				</a></td>
			</tr>
		</table>
		<br>
		
		<br> <a class="rereco" href="" style="color: black;">유사한 3곡 다시 추천받기</a><br><br>
		</div>
		<br>
	</div>
	<!-- ================================================ -->
	<!-- The Modal -->
	<!-- 첫 번째 모달 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <form name="rf" id="rf">
                <!-- 현재 사용자의 플레이리스트 목록을 표시할 테이블 -->
                <table id="modaltable">
                    <c:forEach var="playlist" items="${playlists}">
                        <tr>
                            <td class="td"><div class="cover1"></div></td>
                            <td class="td"><a class="pltitle text-body" href=""
                                    onclick="notify()">${playlist.name}</a></td>
                        </tr>
                    </c:forEach>
                </table>
                <br>
                <button type="button" class="close-btn" onclick="toggleModal('addModal')">닫기</button>
                <div id="add">
                    <button type="button" class="btn text-body large-button" data-toggle="modal" data-target="#modalplus"
                        style="font-size: 24px;">+ 새로운 플레이리스트 </button>
                </div>
            </form>
        </div>
    </div>
</div>


	
	<div class="modal fade" id="modalplus" tabindex="-1" role="dialog" data-target="#alert" onclick="">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="playlistForm" action="addPlaylist" method="get">
                <div class="modal-header">
                    <h3 class="modal-title">플레이리스트 이름을 입력하세요</h3>
                </div>
                <div class="modal-body">
                    <textarea id="modalContent" name="playlistName" rows="1" cols="40" placeholder="제목은 20글자 이내로 입력하세요" maxlength="20" onkeydown="return event.keyCode !== 13;"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="close-btn" onclick="checkAndSubmit()">확인</button>
                    <button type="button" class="close-btn" data-dismiss="modal">취소</button>
                </div>
            </form>
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
    
    /* toggleButton('buttonImage1', isPaused1);
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
    	event.preventDefault();
        const mcv = $('#modalContent').val().trim();
        alert(mcv);
        // textarea 값이 비어있을 경우 modalAlert 모달을 열고, 아닐 경우 다른 로직 수행
        if (mcv === '') {
            openModalAlert();
        } else {
        	alert('here')
            // 사용자가 입력한 플레이리스트를 서버로 전송
            $.ajax({
                type: "POST",
                url: "/mute/addPlaylist", // 수정된 부분: 컨트롤러 매핑 주소 수정
                data: { playlistName: mcv },
                success: function(response) {
                	alert(response)
                    // 서버에서의 처리가 성공하면 추가된 플레이리스트 목록을 갱신
                    $('#modalplus').modal('hide');
                    updatePlaylist(response.playlists);
                },
                error: function(error) {
                	alert('error')
                    console.error('Error submitting playlist:', error);
                }
            });
        }
    }

    // 플레이리스트 목록 업데이트 함수 추가
    function updatePlaylist(playlists) {
        const table2 = $('.table2');
        table2.empty();

        $.each(playlists, function(index, playlist) {
            table2.append('<tr>' +
                '<td><div class="cover"></div></td>' +
                '<td>' + playlist.artist + '</td>' +
                '<td>' + playlist.name + '</td>' +
                '<td><a id="toggleButton' + index + '" onclick="toggleButton(' + index + ')">' +
                '<img id="buttonImage' + index + '" src="resources/images/play_pl.png" alt="Start"></a></td>' +
                '<td><a id="togglePlus' + index + '" onclick="toggleModal(\'addModal\')">' +
                '<img id="buttonPlus' + index + '" src="resources/images/plus_pl.png" alt="plus"></a></td>' +
                '</tr>');
        });
    }
    
    
</script>



</body>
</html>