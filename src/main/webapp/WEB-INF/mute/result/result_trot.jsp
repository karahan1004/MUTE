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
    
    <div class="reco">
        <br>
        <a class="tag">당신을 위한 #트로트 음악</a><br><br>
		<table class="table2">
			<tr>
				<td><div class="cover"></div></td>
				<td>힙합왕</td>
				<td>아티스트명</td>
				<td><a id="toggleButton1" onclick="toggleButton1()"> <img
						id="buttonImage1" src="resources/images/play_pl.png" alt="Start"></a></td>
				<td><a id="togglePlus1" onclick="toggleModal('addModal');  togglePlus1()">
						<img id="buttonPlus1" src="resources/images/plus_pl.png"
						alt="plus">
				</a></td>
			</tr>
			<tr>
				<td><div class="cover"></div></td>
				<td>힙합왕</td>
				<td>아티스트명</td>
				<td><a id="toggleButton2" onclick="toggleButton2()"> <img
						id="buttonImage2" src="resources/images/play_pl.png" alt="Start"></a></td>
				<td><a id="togglePlus2" onclick="toggleModal('addModal'); togglePlus2();">
						<img id="buttonPlus2" src="resources/images/plus_pl.png"
						alt="plus">
				</a></td>
			</tr>
			<tr>
				<td><div class="cover"></div></td>
				<td>힙합왕</td>
				<td>아티스트명</td>
				<td><a id="toggleButton3" onclick="toggleButton3()"> <img
						id="buttonImage3" src="resources/images/play_pl.png" alt="Start"></a></td>
				<td><a id="togglePlus3" onclick="toggleModal('addModal'); togglePlus3();">
						<img id="buttonPlus3" src="resources/images/plus_pl.png"
						alt="plus">
				</a></td>
			</tr>
		</table>
		<br>
		
		<br> <a class="rereco" href="" style="color: black;">유사한 3곡 다시 추천받기</a><br><br>
		

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
						<td class="td"><a class="pltitle text-body" href="">너무
								우울해서 노래 플리 담았어ㅜㅜ</a></td>
					</tr>
					<tr>
						<td class="td"><div class="cover1"></div></td>
						<td class="td"><a class="pltitle text-body" href="">너무
								우울해서 노래 플리 담았어ㅜㅜ</a></td>
					</tr>
					<tr>
						<td class="td"><div class="cover1"></div></td>
						<td class="td"><a class="pltitle text-body" href="">코딩할 때
								듣는 노동요</a></td>
					</tr>
					<tr>
						<td class="td"><div class="cover1"></div></td>
						<td class="td"><a class="pltitle text-body" href="">신나고
								싶을 때 듣는 노래</a></td>
					</tr>
				</table>
				<br>
				 <button class="close-btn" onclick="toggleModal('addModal')" >닫기</button>
				<div id="add">
					<button type="button" class="btn text-body large-button" data-toggle="modal" data-target="#modalplus"  style="font-size: 24px;">+ 새로운 플레이리스트 </button>
				</div>
			</form>
		</div>
		</div>
	</div>
	
		
	
	<div class="modal fade" id="modalplus" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h3 class="modal-title">플레이리스트 이름을 입력하세요</h3>
			        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button> -->
	      </div>
	      <div class="modal-body">
	         <textarea id="modalContent" rows="1" cols="40" placeholder="제목은 20글자 이내로 입력하세요" maxlength="20" ></textarea>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="close-btn" data-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script>
	document.addEventListener('DOMContentLoaded', function () {
	    var tareset = document.querySelector('#modalplus .close-btn');
	    var mct = document.getElementById('modalContent');
	    
	    tareset.addEventListener('click', function () {
	      mct.value = '';
	    });
	  });
	
	
	
	function toggleModal(modalId) {
        $('#' + modalId).modal('show');
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
	
	function togglePlus1() {
	    if (!isPlus1) {
	        const buttonPlus = document.getElementById('buttonPlus1');
	        isPlus1 = true;
	        // 항목 추가 로직
	    } else {
	        alert("이미 플레이리스트에 추가된 항목입니다");
	    }
	}

	function togglePlus2() {
	    if (!isPlus2) {
	        const buttonPlus = document.getElementById('buttonPlus2');
	        isPlus2 = true;
	     	// 항목 추가 로직
	    } else {
	        alert("이미 플레이리스트에 추가된 항목입니다");
	    }
	}

	function togglePlus3() {
	    if (!isPlus3) {
	        const buttonPlus = document.getElementById('buttonPlus3');
	        isPlus3 = true;
	     	// 항목 추가 로직
	    } else {
	        alert("이미 플레이리스트에 추가된 항목입니다");
	    }
	}
</script>

</body>
</html>