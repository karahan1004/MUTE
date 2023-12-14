<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/test.css">
<meta charset="UTF-8">
    <title>MU:TE</title>
</head>
<body>
	<div class="question">
	    <h1>Q1.<br> 오늘따라 우울한 당신! <br>지금 당신의 플레이리스트는?</h1>
	    <form action="result_rock" method="get"><!-- 값을 보내야하는데 post쓰면 안넘어감 - 수정예정 -->
			<!-- 버튼 클릭시 각 선택지 별 해당하는 장르 count++ -->
	        <button class="btn" onclick="location.href='test2'">분위기 바꿔! 기분 전환용 댄스파뤼</button>
	        <button class="btn" onclick="location.href='test2'">이 감정 그대로 갈래... 말리지마 잔잔한 노래</button>
	        <button class="btn" onclick="location.href='test2'">집어치워! 난 나의 길을 간다 락스피릿 예아~</button>
	        <button class="btn" onclick="selectGenre(value)">우울할 땐 난 힙합을 춰...</button>
	    </form>
    </div>
    
<script>
   		// 길이가 10인 Genres 배열을 선언하고 모든 인덱스값을 0으로 초기화
   		/* [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] */
        let Genres = Array(10).fill(0);
        
        function selectGenre(value) {
            if (value === '첫 번째 버튼 누르면') {
              	 /* 인덱스 증가 처리 */
            }else if (value === '두 번째 버튼 누르면') {
               
            }else if (value === '세 번째 버튼 누르면') {
               
            }else if (value === '네 번째 버튼 누르면') {
                
            } 
         
        // test1에서 해당 장르 배열 인덱스 값 증가 후 스크립트 내에서 페이지 이동하게    
        window.location.href = `test2`;
        
        }
       
</script>
</body>
</html>