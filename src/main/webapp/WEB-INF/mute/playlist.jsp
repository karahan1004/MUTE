<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/playlist.css">
<title>MU:TE</title>
</head>
<body>
	<header>
		<table id="navi-head">
			<tr>
				<td><img class="back" href=""
					src="resources/images/gom_button.png"></td>
				<td rowspan="2"><a class="pl">플레이리스트 이름</a></td>
				<td rowspan="2"><img class="logo"
					src="resources/images/mutelogo.png"></td>
			</tr>
			<tr>
				<td><a class="backft" href="">뒤로가기</a></td>
			</tr>
		</table>
	</header>
	<hr>
	<table id="sing-mi">
		<tr>
		<!-- 임시로 곰버튼 이미지 넣어둠 -->
			<td class="pi">
			<img class="back" src="resources/images/gom_button.png"></td>
			<td class="si">노래 이름</td>
			<td class="ga">가수 이름</td>
			<td class="del"><img class="del_img" src="resources/images/del_pl.png"></td>
		</tr>
		<tr>
			<td class="pi"><img class="back"
				src="resources/images/gom_button.png"></td>
			<td class="si">노래 이름</td>
			<td class="ga">가수 이름</td>
			<td class="del"><img class="del_img" src="resources/images/del_pl.png"></td>
		</tr>
		<tr>
			<td class="pi"><img class="back"
				src="resources/images/gom_button.png"></td>
			<td class="si">노래 이름</td>
			<td class="ga">가수 이름</td>
			<td class="del"><img class="del_img" src="resources/images/del_pl.png"></td>
		</tr>
		<tr>
			<td class="pi"><img class="back"
				src="resources/images/gom_button.png"></td>
			<td class="si">노래 이름</td>
			<td class="ga">가수 이름</td>
			<td class="del"><img class="del_img" src="resources/images/del_pl.png"></td>
		</tr>
	</table>
	<hr>
	<footer>
		<table id="navi-foot">
			<tr>
			<!-- 클래스명 정리 싹 해야됨 -->
				<td class="si_btn"><img class="bt_img" src="resources/images/beforre_pl.png"></td>
				<td class="si_btn"><img id="ft_img" onclick="toggleImg()" src="resources/images/play_pl.png"></td>
				<td class="si_btn"><img class="at_img" src="resources/images/afterr_pl.png"></td>
				<td class="si_btn"><img class="back" src="resources/images/gom_button.png"></td>
				<td class="si_foot">노래 이름</td>
				<td class="ga_foot">가수 이름</td>
				<td class="sa_btn"><img class="so_img" src="resources/images/sound_pl.png"></td>
			</tr>
		</table>
	</footer>
	
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
</script>

	
</body>
</html>
