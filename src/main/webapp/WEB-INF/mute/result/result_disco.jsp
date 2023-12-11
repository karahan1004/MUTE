<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/result.css">
<title>MU:TE</title>
</head>
<body>
	<header>
		<nav>
			<ul class="header-container">
				<li class="header-item"><a href="http://localhost:9088/MUTE/result_classic">다시 테스트하기</a></li>
				<li class="header-item"><a href="">마이페이지</a></li>
			</ul>
		</nav>
	</header>
	<table class="table1">
		<tr>
			<td>	
				<img alt="gom_disco" src="resources/images/gom_disco.png" height="500" width="500">	
			</td>
		</tr>
		<tr>
			<td><a class="disco">디스코를 좋아하는 당신은 아몬드 봉봉!</a></td>
		</tr>
		<tr>
			<td><a class="disco">D.I.S.C.O 미친듯이 춤추고 봉봉!!</a></td>
		</tr>
	</table>
    <br>
    <div class="reco">
        <br>
        <a class="tag">당신을 위한 #힙합 음악</a><br><br>
        <table class="table2">
            <tr>
                <td><div class="cover"></div></td>
                <td>힙합왕</td>
                <td>아티스트명</td>
                <td><a id="toggleButton1" onclick="toggleButton1()">
        			<img id="buttonImage1" src="resources/images/play_pl.png" alt="Start"></a></td>
                <td><a id="toggleStar1" onclick="toggleStar1()">
        			<img id="buttonStar1" src="resources/images/base_star.png" alt="base"></a></td>
            </tr>
            <tr>
                <td><div class="cover"></div></td>
                <td>힙합왕</td>
                <td>아티스트명</td>
                <td><a id="toggleButton2" onclick="toggleButton2()">
        			<img id="buttonImage2" src="resources/images/play_pl.png" alt="Start"></a></td>
                <td><a id="toggleStar2" onclick="toggleStar2()">
        			<img id="buttonStar2" src="resources/images/base_star.png" alt="base"></a></td>
            </tr>
            <tr>
                <td><div class="cover"></div></td>
                <td>힙합왕</td>
                <td>아티스트명</td>
                <td><a id="toggleButton3" onclick="toggleButton3()">
        			<img id="buttonImage3" src="resources/images/play_pl.png" alt="Start"></a></td>
                <td><a id="toggleStar3" onclick="toggleStar3()">
        			<img id="buttonStar3" src="resources/images/base_star.png" alt="base"></a></td>
            </tr>
        </table>
        <br><br><br>
        <a class="rereco" href="">유사한 3곡 다시 추천받기</a>
    </div>

<!--------====-----------!-->
	<script>
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
    </script>
    <script>
        let isPlus = false;

        function toggleStar1() {
            const buttonStar = document.getElementById('buttonStar1');
            isPlus = !isPlus;
            if (isPlus) {
                buttonStar.src = 'resources/images/plus_star.png';
            } else {
                buttonStar.src = 'resources/images/base_star.png';
            }
        }

        function toggleStar2() {
            const buttonStar = document.getElementById('buttonStar2');
            isPlus = !isPlus;
            if (isPlus) {
                buttonStar.src = 'resources/images/plus_star.png';
            } else {
                buttonStar.src = 'resources/images/base_star.png';
            }
        }

        function toggleStar3() {
            const buttonStar = document.getElementById('buttonStar3');
            isPlus = !isPlus;
            if (isPlus) {
                buttonStar.src = 'resources/images/plus_star.png';
            } else {
                buttonStar.src = 'resources/images/base_star.png';
            }
        }
    </script>
	<!-- =============== -->

</body>
</html>