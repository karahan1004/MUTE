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
    <h1>Q3.    
    <br>친구가 음악을<br> 추천해 달라고 했을 때 당신의 반응은?
    </h1><br>
    <form action="result.jsp" method="post">
		
        <button type="button" class="btn" onclick="location.href='test4'">너 말해봤자 모를걸?</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test4'">너 이거 몰라?</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test4'">음악은 역시 클래식이지!</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test4'">내가 요즘 노래를 잘 몰라서…ㅜ</button>

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