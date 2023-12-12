<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/test.css">
    <title>MU:TE</title>
    <script>
        var danceValue = 0;
        var discoValue = 0;
        var trotValue = 0;
        var jazzValue = 0;
        var classicValue = 0;
        var indieValue = 0;
        var balladValue = 0;
        var rockValue = 0;
        var hipHopValue = 0;
        var rnbValue = 0;

        function selectPlaylist(value) {
            if (value === '댄스') {
                danceValue++;
                discoValue++;
                trotValue++;
            } else if (value === '재즈') {
                jazzValue++;
                classicValue++;
                indieValue++;
                balladValue++;
            } else if (value === '락') {
                rockValue++;
            } else if (value === '힙합') {
                hipHopValue++;
                rnbValue++;
            }

            document.getElementById("danceValue").value = danceValue;
            document.getElementById("discoValue").value = discoValue;
            document.getElementById("trotValue").value = trotValue;
            document.getElementById("jazzValue").value = jazzValue;
            document.getElementById("classicValue").value = classicValue;
            document.getElementById("indieValue").value = indieValue;
            document.getElementById("balladValue").value = balladValue;
            document.getElementById("rockValue").value = rockValue;
            document.getElementById("hipHopValue").value = hipHopValue;
            document.getElementById("rnbValue").value = rnbValue;
        }
        
       
    </script>
</head>
<body>
<div class="question">
    <h1>Q4.    
    <br>콘서트를 가기로 한 당신!<br> 당신이 가고 싶은 콘서트는?
    </h1><br>
    <form action="result.jsp" method="post">
		
        <button type="button" class="btn" onclick="location.href='test5'">이것이 진정한 페스티벌! 락페스티벌</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test5'">가슴이 웅장해진다.. 영화 오케스트라 콘서트</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test5'">내 최애 영접! 아이돌 콘서트</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test5'">이번년도 효도완 트로트 콘서트</button>

        <input type="hidden" id="danceValue" name="danceValue" value="">
        <input type="hidden" id="discoValue" name="discoValue" value="">
        <input type="hidden" id="trotValue" name="trotValue" value="">
        <input type="hidden" id="jazzValue" name="jazzValue" value="">
        <input type="hidden" id="classicValue" name="classicValue" value="">
        <input type="hidden" id="indieValue" name="indieValue" value="">
        <input type="hidden" id="balladValue" name="balladValue" value="">
        <input type="hidden" id="rockValue" name="rockValue" value="">
        <input type="hidden" id="hipHopValue" name="hipHopValue" value="">
        <input type="hidden" id="rnbValue" name="rnbValue" value="">

    </form>
    </div>
</body>
</html>