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
				<li class="header-item"><a href="http://localhost:9088/MUTE/main" style="color: black;">다시 테스트하기</a></li>
				<li class="header-item"><a href="" style="color: black;">마이페이지</a></li>
			</ul>
		</nav>
	</header>
	<table class="table1">
		<tr>
			<td>	
				<img alt="gom_indie" src="resources/images/gom_indie.png" height="500" width="500">	
			</td>
		</tr>
		<tr>
			<td><a class="indie" style="color: #F34242;">인디를 좋아하는 당신을 사랑에 빠진 딸기!</a></td>
		</tr>
		<tr>
			<td><a class="indie" style="color: #F34242;">나..꽤나 감성적일지도?</a></td>
		</tr>
	</table>
    <br>
    <div class="reco">
        <br>
        <a class="tag">당신을 위한 #인디 음악</a><br><br>
<table class="table2">
			<tr>
				<td><div class="cover"></div></td>
				<td>힙합왕</td>
				<td>아티스트명</td>
				<td><a id="toggleButton1" onclick="toggleButton1()"> <img
						id="buttonImage1" src="resources/images/play_pl.png" alt="Start"></a></td>
				<td><a id="togglePlus1" onclick="toggleModal('addModal'); togglePlus1()">
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
				 <button class="close-btn" onclick="toggleModal('addModal')">닫기</button>
				<div id="add">
					<button type="button" class="btn text-body" data-toggle="modal" data-target="#modalplus">+ 새로운 플레이리스트 </button>
				</div>
			</form>
		</div>
		</div>
	</div>
	
	
	<script>
	

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

	/* let isPlus = false;

	function togglePlus1() {
		const buttonPlus = document.getElementById('buttonPlus1');
		isPlus = !isPlus;
		if (isPlus) {
			buttonPlus.src = 'resources/images/plus_star.png';
		} else {
			buttonPlus.src = 'resources/images/base_star.png';
		}
	}

	function togglePlus2() {
		const buttonPlus = document.getElementById('buttonPlus2');
		isPlus = !isPlus;
		if (isPlus) {
			buttonPlus.src = 'resources/images/plus_star.png';
		} else {
			buttonPlus.src = 'resources/images/base_star.png';
		}
	}

	function togglePlus3() {
		const buttonPlus = document.getElementById('buttonPlus3');
		isPlus = !isPlus;
		if (isPlus) {
			buttonPlus.src = 'resources/images/plus_star.png';
		} else {
			buttonPlus.src = 'resources/images/base_star.png';
		}
	} */
</script>

</body>
</html>
