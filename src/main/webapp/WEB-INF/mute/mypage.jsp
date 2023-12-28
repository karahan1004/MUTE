<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/mypage.css">
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
<title>MU:TE</title>
</head>
<body>
	<header>
		<table id="navi-head">
			<tr>
				<td class="head-lg" rowspan="2"><a href="main"><img class="logo"
					src="resources/images/mutelogo.png"></a></td><!-- 로고를 눌러도 메인페이지로 이동 -->
				<td class="head-na" rowspan="2"><a class="pl">안녕하세요 ${nickName} 님~</a></td>
				<td class="head-ba"><img class="back"
					src="resources/images/gom_button.png"></td>
			</tr>
			<tr>
				<td class="head-ba" rowspan="3" ><a class="backft" style="color: lightgray;" onclick="openNicknameModal()">닉네임 수정</a></td>
			</tr>
		</table>
	</header>
	<!-- ==================플레이리스트 목록=========================== -->
	        <hr>
	        <!-- input에 넣어서 변경 후 화면 출력 -->
	            <!-- Edit Playlist Form -->
	<div id="editForm" style="display: none;">
		<form id="editPlaylistForm" method="post"
			action="/mute/updatePlaylist">
			<label for="editPlaylistName">Edit Playlist Name:</label> <input
				type="text" id="editPlaylistName" name="editPlaylistName" required>

			<!-- 추가된 부분: playlistId를 담을 hidden input -->
			<input type="text" id="playlistId" name="playlistId">
			<button type="button" onclick="updatePlaylist()">Update
				Playlist</button>
		</form>
	</div>
	<div id="delFormDiv" style="display: none;">
		<form id="delForm" method="delete"
			action="/mute/deletePlaylistmy">
			<input type="text" id="playlistId2" name="playlistId">			
		</form>
	</div>
	        <!-- 원래 마이페이지 플리 목록 불러오는 함수 -->
	       <table class="playListTable">
	       	<tr>
	            <td class="mypl">내 플레이리스트</td>
	            <td></td> 
            </tr>
				<c:forEach var="playlist" items="${playlists}">
                    <tr data-playlist-id="${playlist.id }">    
	        		<td><a href="playlist?playlistId=${playlist.id}" id="move"><img class="cover" src="resources/images/gom_button.png"></a>
	        		<br>
	        		</td>
					<td id="plname"><a href="playlist?playlistId=${playlist.id}" id="move">${playlist.name}</a></td>
					<!-- 이미지에 부트스트랩 모달 적용 -->
					<td class="edit">
						 <a id="edit_plName" onclick="toggleModal('modalplus','${playlist.id}');">
						<img class="edit_img" src="resources/images/more.png"></a>
						<a id="del_pl" onclick="toggleModal2('addModal','${playlist.id}');">
						<img class="del_img" src="resources/images/del_pl.png"></a>
					</td>
					</tr> 
                 </c:forEach>   
         </table> 
	<!-- ======================Modal========================== -->
	
	<!-- 플레이리스트 이름 수정 모달 -->
	<div class="modal fade" id="modalplus" tabindex="-1" role="dialog" data-target="#alert">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 class="modal-title">
	        &nbsp;&nbsp;&nbsp;수정할 플레이리스트 이름을 입력하세요</h2>
	      </div>
	      <div class="modal-body">
	         <textarea required id="modalContent" name="editpl" rows="1" cols="40" placeholder="제목은 20글자 이내로 입력하세요" maxlength="20" onkeydown="return event.keyCode !== 13;"></textarea>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="close-btn" onclick="checkAndSubmit()">확인</button>
	        <button type="button" class="close-btn" data-dismiss="modal" >취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 이름 수정 시 공백 입력 할 경우 모달 다시 띄움 -->
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
	<!-- 플레이리스트 삭제 모달 -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <form name="rf" id="rf">
                    <table id="modaltable">
					<tr>
						<td class="del-td"><a class="singdel text-body">
						&nbsp;&nbsp;&nbsp;&nbsp;플레이리스트를 삭제 하시겠습니까?</a></td>
					</tr>
				</table>
				<br>
				<button type="button" class="close-btn" onclick="deletePlaylist()">삭제</button>
				<button type="button" class="re-btn" onclick="toggleModal('addModal')">취소</button>
				<br><br>
			</form>
		</div>
		</div>
	</div>
<!-- 수정할 이름을 입력하세요 모달 -->
<div class="modal fade" id="modifyNameModal" tabindex="-1" role="dialog" data-target="#alert">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h2 class="modal-title">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        수정할 닉네임을 입력하세요</h2>
      </div>
      <div class="modal-body">
         <textarea required id="modifyContent" rows="1" cols="40" placeholder="닉네임은 최대 10자까지 가능합니다" maxlength="20" onkeydown="return event.keyCode !== 13;"></textarea> 
      </div>
      <div class="modal-footer">
        <button type="button" class="close-btn" onclick="checkAndSubmitModify()">확인</button>
        <button type="button" class="close-btn" data-dismiss="modal" >취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 이름 수정 시 공백 입력 할 경우 모달 다시 띄움 -->
	<div class="modal fade" id="nickAlert" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <h3>수정할 닉네임은 공백일 수 없습니다</h3>
            </div>
            <div class="modal-footer">
                <button type="button" class="close-btn" data-dismiss="modal" onclick="submitAlert()">확인</button>
            </div>
        </div>
    </div>
</div>
<script>
/* 플리 이름 변경하는 api 폼 표시 */
function editPlaylist(playlistId, playlistName) {
        // 수정 폼을 표시
        document.getElementById("editForm").style.display = "block";
        // 편집 폼에 현재 플레이리스트 이름 설정
        document.getElementById("editPlaylistName").value = playlistName;
        // hidden input 필드의 값을 현재 플레이리스트 ID로 업데이트
        currentPlaylistId = playlistId;
        document.getElementById("playlistId").value = currentPlaylistId;
    }
    function updatePlaylist() {
        // 업데이트된 플레이리스트 이름 가져오기
        var updatedName = document.getElementById("editPlaylistName").value;
        // hidden input 필드에서 플레이리스트 ID 가져오기
        //currentPlaylistId=document.getElementById("playlistId").value; 
        var playlistId =document.getElementById("playlistId").value;
        
        // 요청 매개변수 생성
        var params = new URLSearchParams();
        params.append('playlistId', playlistId);
        params.append('editPlaylistName', updatedName);
        // fetch API를 사용하여 POST 요청 보내기
        fetch('/mute/updatePlaylistmy', {
            method: 'POST',
            body: params,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
        })
        .then(response => response.text())
        .then(data => {
            // 여기서 응답 처리
            console.log(data);
            document.body.innerHTML='';
            document.body.innerHTML=data;
            //reloadPlaylists();
        })
        .catch(error => {
            console.error('에러:', error);
        });
    }
	<!-- 모달 오픈 함수 -->
	
	function toggleModal(modalId, playlistId) {
		//alert(modalId)
		$('#playlistId').val(playlistId);
	    $('#' + modalId).modal('toggle');
	}//수정폼
	
	function toggleModal2(modalId, playlistId) {
		//alert(modalId+"<<<")
		$('#playlistId2').val(playlistId);
	    $('#' + modalId).modal('toggle');
	}//삭제폼
	
	function checkAndSubmit() {
        const mcv = $('#modalContent').val().trim();
        // textarea 값이 비어있을 경우 modalAlert 모달을 열고, 아닐 경우 다른 로직 수행
        if (mcv === '') {
            openModalAlert();
        } else {
        	//alert(mcv);
        	$('#editPlaylistName').val(mcv);
        	updatePlaylist();
        	$('#modalplus').modal('hide');
        	//location.reload();
        }
    }
	
	function openModalAlert() {
        $('#modalAlert').modal('show');
    }
    
	function deletePlaylist() {
		let playlistId=$('#playlistId2').val();
		//alert(playlistId)
        $('#addModal').modal('hide');
        
        fetch('/mute/deletePlaylistmy?playlistId=' + encodeURIComponent(playlistId), {
	        method: 'DELETE',
	        headers: {
	            'Content-Type': 'application/x-www-form-urlencoded',
	        },
	    })
	    .then(response => {
	        if (!response.ok) {
	            throw new Error('Network response was not ok');
	        }
	        
	        return response.text();
	    })
	    .then(data => {
	        // 여기서 응답 처리 (예: 성공 메시지 출력 등)
	        //alert(data);
	        // 삭제된 플레이리스트를 화면에서 제거
	        var playlistElement = document.querySelector('tr[data-playlist-id="' + playlistId + '"]');
	        //alert(playlistElement)
	        if (playlistElement) {
	            playlistElement.remove();
	            // 서버에서 플레이리스트 목록을 다시 불러오는 요청	            
                //reloadPlaylists();
                window.alert('플레이리스트가 삭제 되었습니다');
	        }
	    })
	    .catch(error => {
	        console.error('에러:', error);
	    });
	}
	/* 닉네임 수정 처리 */
	function openNicknameModal() {
	    $('#modifyNameModal').modal('show');
	}
	
	function checkAndSubmitModify(){
        const mcv1 = $('#modifyContent').val().trim();
        // textarea 값이 비어있을 경우 modalAlert 모달을 열고, 아닐 경우 다른 로직 수행
        if (mcv1 === '') {
            openModalnickAlert();
        } else {
        	updateNickname(mcv1);
        	$('#modifyNameModal').modal('hide');
        }
    }
	function openModalnickAlert() {
        $('#nickAlert').modal('show');
    }
	function updateNickname(mcv1){
		fetch('/mute/updateNickNameJson', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/x-www-form-urlencoded',
	        },
	        body:'nickName='+mcv1,
	    })
	    .then(response => {
	        if (!response.ok) {
	            throw new Error('Network response was not ok');
	        }
	        
	        return response.text();
	    })
	    .then(data => {
	        if(data.result=='success'){
                window.alert('닉네임이 변경 되었습니다');
                
	        }
	        location.reload();
	    })
	    .catch(error => {
	        console.error('에러:', error);
	    });
	}
	
</script>
</body>
</html>