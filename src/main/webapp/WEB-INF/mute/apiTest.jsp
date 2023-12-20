<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Playlists</title>
</head>
<body>

    <h2>User Playlists</h2>

    <ul>
        <c:forEach items="${playlists}" var="playlist">
            <li>
                <a href="<c:url value='/playlisttracks'/>?playlistId=${playlist.id}">
                    ${playlist.name}
                </a>
                <button onclick="editPlaylist('${playlist.id}', '${playlist.name}')">Edit</button>
            </li>
        </c:forEach>
    </ul>

    <form action="/mute/addPlaylist" method="post">
        <label for="playlistName">New Playlist Name:</label>
        <input type="text" id="playlistName" name="playlistName" required>
        <button type="submit">Create Playlist</button>
    </form>

    <!-- Show success or error messages -->
    <c:if test="${not empty message}">
        <p style="color: green;">${message}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>

    <!-- Edit Playlist Form -->
    <div id="editForm" style="display: none;">
        <form id="editPlaylistForm" method="post" action="/mute/updatePlaylist">
            <label for="editPlaylistName">Edit Playlist Name:</label>
            <input type="text" id="editPlaylistName" name="editPlaylistName" required>
            
            <!-- 추가된 부분: playlistId를 담을 hidden input -->
            <input type="hidden" id="playlistId" name="playlistId">

            <button type="button" onclick="updatePlaylist()">Update Playlist</button>
        </form>
    </div>

    <script>
        // 플레이리스트 ID를 저장하는 전역 변수 생성
        var currentPlaylistId;

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
            var playlistId = currentPlaylistId;

            // 요청 매개변수 생성
            var params = new URLSearchParams();
            params.append('playlistId', playlistId);
            params.append('editPlaylistName', updatedName);

            // fetch API를 사용하여 POST 요청 보내기
            fetch('/mute/updatePlaylist', {
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
            })
            .catch(error => {
                console.error('에러:', error);
            });
        }
    </script>

</body>
</html>
