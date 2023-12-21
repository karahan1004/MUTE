<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Genre Recommendations</title>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script>
        var selectedTrackId; // 선택한 노래의 ID를 저장하는 변수

        function addTrackToPlaylist(trackId) {
            selectedTrackId = trackId; // 선택한 노래의 ID를 저장
            console.log("addTrackToPlaylist called with trackId:", trackId);

            // 모달을 먼저 삭제
            $('#playlistModal').remove();

            // 플레이리스트 목록을 가져오는 AJAX 요청
            $.ajax({
                type: "GET",
                url: "/mute/getUserPlaylists",
                success: function (playlists) {
                    // 모달을 생성하고 플레이리스트 목록을 표시하는 코드
                    var modalContent = '<div class="modal" id="playlistModal">';
                    modalContent += '<div class="modal-dialog">';
                    modalContent += '<div class="modal-content">';
                    modalContent += '<div class="modal-header">';
                    modalContent += '<h4 class="modal-title">플레이리스트 선택</h4>';
                    modalContent += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
                    modalContent += '</div>';
                    modalContent += '<div class="modal-body">';
                    modalContent += '<ul>';

                    // 플레이리스트 목록을 모달에 추가
                    for (var i = 0; i < playlists.length; i++) {
                        modalContent += '<li><button class="btn btn-link" onclick="addToPlaylist(\'' + playlists[i].id + '\')">' + playlists[i].name + '</button></li>';
                    }

                    modalContent += '</ul>';
                    modalContent += '</div>';
                    modalContent += '</div>';
                    modalContent += '</div>';
                    modalContent += '</div>';

                    // 모달을 동적으로 body에 추가
                    $('body').append(modalContent);

                    // 모달을 보여줌
                    $('#playlistModal').modal('show');
                },
                error: function (error) {
                    alert("에러: Failed to get user playlists: " + error.responseText);
                }
            });
        }

        // 플레이리스트 목록에서 선택한 플레이리스트에 노래 추가
        function addToPlaylist(playlistId) {
            $.ajax({
                type: "POST",
                url: "/mute/addTrackToPlaylist",
                data: { trackId: selectedTrackId, playlistId: playlistId },
                success: function (response) {
                    alert(response);
                    // 모달을 닫음
                    $('#playlistModal').modal('hide');
                },
                error: function (error) {
                    alert("에러 Failed to add track to playlist: " + error.responseText);
                }
            });
        }
    </script>
</head>
<body>

<h2>Genre Recommendations</h2>

<c:if test="${not empty recommendations}">
    <ul>
        <c:forEach var="track" items="${recommendations}">
            <li>
                ${track.name} - ${track.artists[0].name}
                <img src="${track.album.images[0].url}" alt="Album Cover" width="100" height="100">
                <button onclick="addTrackToPlaylist('${track.id}')">추가</button>
            </li>
        </c:forEach>
    </ul>
</c:if>

<c:if test="${empty recommendations}">
    <p>No recommendations available.</p>
</c:if>

</body>
</html>
