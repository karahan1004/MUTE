<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
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
    <a class="tag">당신을 위한 #발라드 음악</a><br><br>
    <table class="table2">
        <tr>
            <td><div class="cover"></div></td>
            <td>힙합왕</td>
            <td>아티스트명</td>
            <td><a><img src="resources/images/Group 4.png"></a></td>
            <td><a class="star" onclick="openModal()">☆</a></td>
        </tr>
        <tr>
            <td><div class="cover"></div></td>
            <td>힙합왕</td>
            <td>아티스트명</td>
            <td><a><img src="resources/images/Group 4.png"></a></td>
            <td><a class="star" onclick="openModal()">☆</a></td>
        </tr>
        <tr>
            <td><div class="cover"></div></td>
            <td>힙합왕</td>
            <td>아티스트명</td>
            <td><a><img src="resources/images/Group 4.png"></a></td>
            <td><a class="star" onclick="openModal()">☆</a></td>
        </tr>
    </table>
    <br><br><br>
    <a class="rereco" href="">유사한 3곡 다시 추천받기</a>
</div>

<!-- ================================================ -->
<!-- The Modal -->
<div class="modal" id="addModal">
    <div class="modal-content modal-lg">
        <span class="close-btn" onclick="closeModal()">x</span>
        <form name="rf" id="rf">
            <table id="modaltable">
                <tr>
                    <td class="td"><div class="cover1"></div></td>
                    <td class="td"><a class="pltitle text-body" href="">너무 우울해서 노래 플리 담았어ㅜㅜ</a></td>
                </tr>
                <tr>
                    <td class="td"><div class="cover1"></div></td>
                    <td class="td"><a class="pltitle text-body" href="">너무 우울해서 노래 플리 담았어ㅜㅜ</a></td>
                </tr>
                <tr>
                    <td class="td"><div class="cover1"></div></td>
                    <td class="td"><a class="pltitle text-body" href="">코딩할 때 듣는 노동요</a></td>
                </tr>
                <tr>
                    <td class="td"><div class="cover1"></div></td>
                    <td class="td"><a class="pltitle text-body" href="">신나고 싶을 때 듣는 노래</a></td>
                </tr>
            </table>
            <br>
            <div id="add">
                <a class="text-body" href="">+ 새로운 플레이리스트</a>
            </div>
        </form>
    </div>
</div>

<script>
    function openModal() {
        document.getElementById("addModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("addModal").style.display = "none";
    }
</script>

</body>
</html>
