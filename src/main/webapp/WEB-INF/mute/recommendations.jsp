<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Genre Recommendations</title>
</head>
<body>

<h2>Genre Recommendations</h2>

<c:if test="${not empty recommendations}">
    <ul>
        <c:forEach var="track" items="${recommendations}">
            <li>
                ${track.name} by ${track.artists[0].name}
                <img src="${track.album.images[0].url}" alt="Album Cover" width="100" height="100">
            </li>
        </c:forEach>
    </ul>
</c:if>

<c:if test="${empty recommendations}">
    <p>No recommendations available.</p>
</c:if>

</body>
</html>