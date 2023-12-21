<!-- playlistTracks.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Playlist Tracks</title>
</head>
<body>
	<h2>${playlist.name}</h2>

	<table>
		<c:forEach var="track" items="${trackInfoArray}" varStatus="status">
			<tr>
				<td><c:set var="albumDetailsArray"
						value="${fn:split(albumInfoArray[status.index], ',')}" /> <img
					src="${albumDetailsArray[1]}" alt="Album Cover" width="100"
					height="100"></td>
				<td>${track}</td>
				<td>${artistInfoArray[status.index]}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
