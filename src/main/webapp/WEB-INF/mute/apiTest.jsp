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

</body>
</html>