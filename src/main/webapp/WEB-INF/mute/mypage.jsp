<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/mypage.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
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
				<td class="head-ba"><a href="main"><img class="back"
					src="resources/images/gom_button.png"></a></td>
				<td class="head-na" rowspan="2"><a class="pl">안녕하세요 USERID님~</a></td>
				<td class="head-lg" rowspan="2"><img class="logo"
					src="resources/images/mutelogo.png"></td>
			</tr>
			<tr>
				<td class="head-ba"><a class="backft" href="main">메인페이지</a></td>
			</tr>
		</table>
	</header>
	<!-- ==================플레이리스트 목록=========================== -->
	    <hr>
	        <table class="playListTable">
	       		<tr>
            <td class="mypl">내 플레이리스트</td>
            <td></td> 
            <br><br>
				</tr>
	        	<tr>
	        		<td><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">너무 우울해서 노래 플리 담았어ㅜㅜ</a></td>
					<!-- 이미지에 부트스트랩 모달 적용-->
					<td class="edit">
						<a id="edit_plName" onclick="toggleModal('modalplus');">
						<img class="edit_img" src="resources/images/more.png"></a>
						<a id="del_pl" onclick="toggleModal('addModal');">
						<img class="del_img" src="resources/images/del_pl.png"></a>
					</td>
				</tr>
				<tr>
	        		<td><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">너무 행복해서 노래 플리 담았어~~</a></td>
					<td class="edit">
						<a id="edit_plName" onclick="toggleModal('modalplus');">
						<img class="edit_img" src="resources/images/more.png"></a>
						<a id="del_pl" onclick="toggleModal('addModal');">
						<img class="del_img" src="resources/images/del_pl.png"></a>
					</td>
				</tr>
				<tr>
	        		<td><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">코딩할 때 듣는 노동요</a></td>
					<td class="edit">
						<a id="edit_plName" onclick="toggleModal('modalplus');">
						<img class="edit_img" src="resources/images/more.png"></a>
						<a id="del_pl" onclick="toggleModal('addModal');">
						<img class="del_img" src="resources/images/del_pl.png"></a>
					</td>
				</tr>
				<tr>
	        		<td><img class="cover" src="resources/images/gom_button.png"></td>
					<td id="plname"><a href="playlist" id="move">신나고 싶을 때 듣는 노래</a></td>
					<td class="edit">
						<a id="edit_plName" onclick="toggleModal('modalplus');">
						<img class="edit_img" src="resources/images/more.png"></a>
						<a id="del_pl" onclick="toggleModal('addModal');">
						<img class="del_img" src="resources/images/del_pl.png"></a>
					</td>
				</tr>
	        </table>
	        
	<!-- ======================Modal========================== -->
	
	<!-- 이름 수정 모달 -->
	<div class="modal fade" id="modalplus" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 class="modal-title">
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;수정할 플레이리스트 이름을 입력하세요</h2>
	      </div>
	      <div class="modal-body">
	         <textarea required id="modalContent" rows="1" cols="40" placeholder="제목은 20글자 이내로 입력하세요" maxlength="20" onkeydown="return event.keyCode !== 13;"></textarea>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="close-btn" data-dismiss="modal" onclick="check()">확인</button>
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
<script>
	<!-- 모달 오픈 함수 -->
	
	function toggleModal(modalId) {
	    $('#' + modalId).modal('toggle');
	}
	function check() {
        var textAreaContent = document.getElementById('modalContent').value.trim();
        if (textAreaContent === '') {
            window.alert('이름을 입력하세요!');
            /* 모달이랑 alert 같이 쓰면 충돌 남 */
        }
    }
	
	function deletePlaylist() {
        $('#addModal').modal('hide');
        window.alert('플레이리스트가 삭제 되었습니다');
        // 삭제 동작을 수행하는 코드를 추가하세요.
	}
</script>
</body>
</html>