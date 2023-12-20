<!-- playlistTracks.jsp -->
<!-- playlist.jsp에 응용하면 됩니다 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Playlist Tracks</title>
</head>
<body>
   <h2>${playlist.name}</h2>



    <table>
        <tr>
            <td>
                <c:forTokens items="${trackInfo}" delims="#" var="a">${a}<br></c:forTokens>
            </td>
        
            <td>
                <c:forTokens items="${artistInfo}" delims="-" var="b">${b}<br></c:forTokens>
            </td>
        </tr>
    </table>
</body>
</html>
