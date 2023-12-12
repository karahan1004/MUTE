<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/test.css">
    <title>MU:TE</title>
    <script>
   		 /* 장르별 value 변수 설정 */
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
        /* 버튼 클릭시 value값 증가 script함수 -- 함수명 재설정, onclick시 증가처리 해야함 */
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
    <h1>Q5.<br> 첫 눈이 내린 날, <br>당신이 들을 노래는?</h1>
    <form action="result.jsp" method="post">
		<!-- 버튼 클릭시 다음 test페이지 이동 + 각 선택지 별 해당하는 장르 count++(구현 예정..어렵다) -->
        <button type="button" class="btn" onclick="location.href='test6'">Snowman - SIA</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test6'">All I Want For Christmas Is You - Mariah Carey</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test6'">Last Christmas - Wham!</button>
        <br>
        <button type="button" class="btn" onclick="location.href='test6'">Santa Tell Me - Ariana Grande</button>


		<!-- count 값을 hidden으로 전달... 다시 알아보자 -->
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