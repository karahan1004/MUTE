<!-- devices.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page
    import="se.michaelthelin.spotify.model_objects.miscellaneous.Device"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Connected Devices</title>
</head>
<body>

    <h2>Connected Devices</h2>

    <c:if test="${not empty devices}">
        <ul>
            <c:forEach var="device" items="${devices}">
                <li>${device.name} (Type: ${device.type})</li>
            </c:forEach>
        </ul>
    </c:if>

    <c:if test="${empty devices}">
        <p>No connected devices.</p>
    </c:if>

</body>
</html>
