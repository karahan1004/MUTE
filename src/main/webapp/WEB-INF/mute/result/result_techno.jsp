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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>
<body>
	<header>
		<nav>
			<ul class="header-container">
				<li class="header-item"><a href="http://localhost:9089/mute/main" style="color: black;">다시 테스트하기</a></li>
				<li class="header-item"><a href="http://localhost:9089/mute/mypage" style="color: black;">마이페이지</a></li>
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
			<td><a class="trot" style="color: #FF3232;">테크노를 좋아하는 당신은 베리베리스트로베리!</a></td>
		</tr>
		<tr>
			<td><a class="trot" style="color: #FF3232;">너 T크노야?</a></td>
		</tr>
		
	</table>
    <br>
    
  <div class="con">  
    <div class="reco">
        <br>
        <a class="tag">당신을 위한 #테크노 음악</a><br><br>
		<table class="table2">
			<tr id="trhead">
				<td></td>
				<td>제목</td>
				<td>가수</td>
				<td>재생</td>
				<td>플레이리스트 추가</td>
			</tr>
		<c:if test="${not empty recommendations}">
		    <c:forEach var="track" items="${recommendations}" varStatus="i">
		        <tr>
		            <td><img src="${track.album.images[0].url}" alt="Album Cover" width="100" height="100"></td>
		            <td>${track.name}</td>
		            <td>${track.artists[0].name}</td>
		            <td>
		                <a id="toggleButton${i.index + 1}" onclick="toggleButton${i.index + 1}"> 
		                    <img id="buttonImage${i.index + 1}" src="resources/images/play_pl.png" alt="Start">
		                </a>
		            </td>
		            <td>
		                <a id="togglePlus${i.index + 1}" data-track-id="${track.id}" onclick="openPlaylistModal('${track.id}'); toggleModal('addModal')">
		                    <img id="buttonPlus${i.index + 1}" src="resources/images/plus_pl.png" alt="plus">
		                </a>
		            </td>
		        </tr>
		    </c:forEach>
		</c:if>
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
            	<div id="scroll">
                <!-- 현재 사용자의 플레이리스트 목록을 표시할 테이블 -->
                <table class="modaltable" id="modaltable">
                      <c:forEach var="playlist" items="${playlists}">
                        <tr>
                            <td class="td"><img alt="gom_trot" src="resources/images/gom_button.png" height="65" width="65"></td>
                            <td class="td"><a class="pltitle text-body" href=""
                                    onclick="addTrackToPlaylist('${track.id}', '${playlist.id}')">${playlist.name}</a></td>
                        </tr>
                    </c:forEach> 
                </table>
                </div>
                <br>
                <button type="button" class="close-btn" onclick="toggleModal('addModal')">닫기</button>
                <div id="add">
                    <button type="button" class="btn text-body large-button" data-toggle="modal" data-target="#modalplus"
                        style="font-size: 24px;">+ 새로운 플레이리스트 </button>
                </div>
            </form>
        </div>
    </div>
    <div class="notification" id="notification">
    	음악을 플레이리스트에 저장했습니다!
	</div>
</div>


	
	<div class="modal fade" id="modalplus" tabindex="-1" role="dialog" data-target="#alert" onclick="">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <!-- <form id="playlistForm" action="addPlaylist" method="get"> -->
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
            <!-- </form> -->
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

        if (mcv === '') {
            openModalAlert();
        } else {
            // 사용자가 입력한 플레이리스트를 서버로 전송
            $.ajax({
                type: "POST",
                url: "/mute/addPlaylist", // 수정된 부분: 컨트롤러 매핑 주소 수정
                data: { playlistName: mcv },
                success: function (res) {
                    $('#modalplus').modal('hide');
                    // 서버로부터 받은 응답으로 플레이리스트 목록 업데이트
                    addPlaylistToTable(mcv);
                },
                error: function (err) {
                    alert('error');
                    console.error('Error submitting playlist:', err);
                }
            });
        }
    }

 // 플레이리스트를 테이블에 동적으로 추가하는 함수
    function addPlaylistToTable(playlistName) {
        // 새로운 행을 생성
        var newRow = $('<tr>');

        var coverCell = $('<td>').addClass('td').append($('<img>').attr({
            'alt': 'gom_trot',
            'src': 'resources/images/gom_button.png',
            'height': '65',
            'width': '65'
        }));
        newRow.append(coverCell);

        var titleCell = $('<td>').addClass('td');
        var playlistLink = $('<a>').addClass('pltitle text-body').attr('href', '').text(playlistName);

        titleCell.append(playlistLink);
        newRow.append(titleCell);

        newRow.find('.pltitle').click(function (event) {
            event.preventDefault();
            notify();
        });

        $('#modaltable').prepend(newRow);
    }

 
 	//알림
    function notify() {
        var notification = $('#notification');
        notification.css('display', 'block');

        setTimeout(function() {
            notification.css('display', 'none');
        }, 1000);
    }


//-------------------------------------------------------------------

    //var selectedTrackId; // 선택한 노래의 ID를 저장하는 변수
    var trackId;
    var playlistId;

    function openPlaylistModal(trackId) {
        console.log("Track ID:" + trackId);
        window.trackId = trackId; // 전역 변수에 선택한 노래의 ID를 저장
        toggleModal('addModal', trackId);
    }
    
    function toggleModal(modalId, trackId) {
        // 모달을 열 때 선택한 노래의 ID를 전달
        $('#' + modalId).data('track-id', trackId).modal('toggle');
    }

    function addTrackToPlaylist(trackId, playlistId) {
        	console.log("a Track ID:"+trackId); 
        	console.log("a playlist ID:"+playlistId); 
        	//console.log("a selected Track ID:" + selectedTrackId);
        // 선택한 노래의 ID와 플레이리스트의 ID를 서버로 전송
        $.ajax({
            type: "POST",
            url: "/mute/addTrackToPlaylist",
            data: { trackId: trackId, playlistId: playlistId },
            success: function (response) {
                $('#addModal').modal('hide');
                alert(response); // 성공적으로 추가되었음을 알리는 메시지 표시
            },
            error: function (error) {
                alert("에러: Failed to add track to playlist - " + error.responseText);
            }
        });
    }
    </script>


</body>
</html>