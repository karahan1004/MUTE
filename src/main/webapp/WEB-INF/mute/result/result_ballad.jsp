<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/result.css">
<link rel="stylesheet" href="resources/css/modal.css">
<title>MU:TE</title>
<!--CDN 참조  -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<header>
		<nav>
			<ul class="header-container">
				<li class="header-item"><a href="">다시 테스트하기</a></li>
				<li class="header-item"><a href="">마이페이지</a></li>
			</ul>
		</nav>
	</header>
	
	<table class="table1">
		<tr>
			<td>	
				<img alt="gom_ballad" src="resources/images/gom_ballad.png" height="500" width="500">	
			</td>
		</tr>
		<tr>
			<td><a class="ballad">발라드를 좋아하는 당신은 초코, 우리 이제 헤이즐넛!</a></td>
		</tr>
		<tr>
			<td><a class="ballad">ㄴr는 지금 눈물을 흘린ㄷr..</a></td>
		</tr>
	</table>
    <br>
    <div class="reco">
        <br>
			<a class="tag">당신을 위한 #발라드 음악</a></td><br><br>
		<table class="table2">
            <tr>
                <td><div class="cover"></div></td>
                <td>힙합왕</td>
                <td>아티스트명</td>
                <td><a><img src="resources/images/Group 4.png"></a></td>
                <td><a class="star">☆</a></td>
            </tr>
            <tr>
                <td><div class="cover"></div></td>
                <td>힙합왕</td>
                <td>아티스트명</td>
                <td><a><img src="resources/images/Group 4.png"></a></td>
                <td><a class="star">☆</a></td>
            </tr>
            <tr>
                <td><div class="cover"></div></td>
                <td>힙합왕</td>
                <td>아티스트명</td>
                <td><a><img src="resources/images/Group 4.png"></a></td>
                <td><a class="star" data-toggle="modal"
			data-target="#addModal">☆</a></td>
            </tr>
        </table>
        <br><br><br>
        <a class="rereco" href="">유사한 3곡 다시 추천받기</a>
    </div>
    
    <!-- ================================================ -->
	<!-- The Modal -->
	<div class="container py-4">
		<div class="modal" id="addModal">
			<div class="modal-dialog  modal-lg">
				<div class="modal-content">
					<div class="modal-body">

						<form  name="rf" id="rf">
							<table id="modaltable">
								<tr>
									<td class="td"><div class="cover1"></div></td>
									<td class="td"><a class="pltitle" href="">너무 우울해서 노래 플리 담았어ㅜㅜ</a></td>
								</tr>
								<tr>
									<td class="td"><div class="cover1"></div></td>
									<td class="td"><a class="pltitle" href="">너무 우울해서 노래 플리 담았어ㅜㅜ</a></td>
								</tr>
								<tr>
									<td class="td"><div class="cover1"></div></td>
									<td class="td"><a class="pltitle" href="">코딩할 때 듣는 노동요</a></td>
								</tr>
								<tr>
									<td class="td"><div class="cover1"></div></td>
									<td class="td"><a class="pltitle" href="">신나고 싶을 때 듣는 노래</a></td>
								</tr>
							</table>
							
							<br>
							<div id="add">
								<a href="">+ 새로운플레이리스트</a>
							</div>
						</form>
						
					
				</div>
			</div>
		</div>
	</div>
    <script>
        $(document).ready(function () {
            // 별(☆)을 클릭하면 모달이 나타나도록 하는 부분
            $(".star").click(function () {
                $("#addModal").modal();
            });
        });
    </script>

</body>
</html>