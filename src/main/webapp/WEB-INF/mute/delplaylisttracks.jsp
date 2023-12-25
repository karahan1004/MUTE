<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <title>Delete Playlist Tracks</title>
</head>
<body>
    <h2>${playlist.name}-[트랙삭제 페이지]</h2>

    <input type="hidden" id="playlistId" value="${playlist.id}">
    <table>
        <c:forEach var="track" items="${trackInfoArray}" varStatus="status">
            <tr>
                <td><c:set var="albumDetailsArray"
                        value="${fn:split(albumInfoArray[status.index], ',')}" /> <img
                    src="<c:url value='${albumDetailsArray[1]}'/>" alt="Album Cover"
                    width="100" height="100"></td>
                <td>${track}</td>
                <td>- ${artistInfoArray[status.index]}</td>
                <td>
                    <!-- 수정된 부분: 삭제 버튼에 onclick 이벤트에서 함수를 직접 호출하는 것이 아니라, 함수의 실행을 스케줄링 -->
                    <button class="delete-button" onclick="scheduleDeleteTrack('${playlist.id}', '${trackIdList[status.index]}')">삭제</button>
                </td>
            </tr>
        </c:forEach>
    </table>

    <script>
    function scheduleDeleteTrack(playlistId, trackId) {
        console.log('trackId : ' + trackId);
        console.log('playlistId : ' + playlistId);

        if (confirm('정말로 이 트랙을 삭제하시겠습니까?')) {
            // 확인을 선택한 경우에만 트랙 삭제 함수 호출
            deleteTrack(playlistId, trackId);
        }
    }

    function deleteTrack(playlistId, trackId) {
        const accessToken = '<%= session.getAttribute("accessToken") %>';
        const url = '/mute/delTrack?playlistId=' + encodeURIComponent(playlistId) + '&trackId=' + encodeURIComponent(trackId);

        fetch(url, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + accessToken
            },
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            // 여기서 필요한 처리를 수행하세요 (예: 성공 메시지 출력 등)
            console.log('Track deleted successfully');
        })
        .catch(error => {
            console.error('에러:', error);
        });
    }
    </script>
</body>
</html>
