<!-- playlistTracks.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Playlist Tracks</title>
</head>
<body>

	<h2>Playlist Tracks</h2>

	<ul>
		<c:forEach items="${tracks}" var="track">
			<li>${track.album.name}- ${track.artists[0].name}</li>
		</c:forEach>
	</ul>

</body>
</html>
