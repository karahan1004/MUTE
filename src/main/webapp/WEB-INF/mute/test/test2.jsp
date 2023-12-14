<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/test.css">
<meta charset="UTF-8">
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
    <h1><br>Q2.    
    <br>음악은 이렇게 즐겨야지~
    </h1><br>
    <form action="result.jsp" method="post">
		
        <button type="button" class="btn" onclick="location.href='test3'">클럽에서 신나게! 스피커 볼륨 최대로~</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test3'">와인바에서 잔잔하게! 소음따윈 가볍게 무시한다는 마인드</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test3'">햇살을 맞으며 창가에서 커피 한 잔 할래용~</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test3'">대한민국 음악의 중심은 바로 나! 엄마 난 커서 가수가 될래요!</button>

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