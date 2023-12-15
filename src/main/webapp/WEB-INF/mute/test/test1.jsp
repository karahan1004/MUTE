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
	    <form action="result_rock" method="get"> <!--값을 보내야하는데 post쓰면 안넘어감 - 수정예정 -->
			<!-- 버튼 클릭시 selectGenre(value) 함수를 통해 각 선택지 별 해당하는 장르 count++ -->
	        <button class="btn" onclick="selectGenre(1)">분위기 바꿔! 기분 전환용 댄스파뤼</button>
	        <button class="btn" onclick="selectGenre(2)">이 감정 그대로 갈래... 말리지마 잔잔한 노래</button>
	        <button class="btn" onclick="selectGenre(3)">집어치워! 난 나의 길을 간다 락스피릿 예아~</button>
	        <button class="btn" onclick="selectGenre(4)">우울할 땐 난 힙합을 춰...</button>
	    </form>
    </div>
    
<script>
   		// 길이가 10인 Genres 배열을 선언하고 모든 인덱스값을 0으로 초기화
   		/* 장르 배열 (0:락, 1:발라드, 2:트로트, 3:알앤비, 4:힙합, 5:클래식, 6:인디, 7:디스코, 8:재즈, 9:댄스) */
        let Genres = Array(10).fill(0);
        function selectGenre(value) {
            if (value === 1) {
            	/* 인덱스 증가 처리 */
            	// 트로트, 디스코, 댄스 
            	Genres[2]++;
            	Genres[7]++;
            	Genres[9]++;
            }else if (value === 2) {
            	// 발라드, 클래식, 인디, 재즈
            	Genres[1]++;
                Genres[5]++;
                Genres[6]++;
                Genres[8]++;
            }else if (value === 3) {
            	// 락
                Genres[0]++;
            }else if (value === 4) {
            	// 알앤비, 힙합 
                Genres[3]++;
                Genres[4]++;
            } 
            
       	sendGenresToServer(Genres);//Genres 카운트 후 Genres 배열을 서버로 보내는 함수 작성 필요
     	// test1에서 해당 장르 배열 인덱스 값 증가 후 스크립트 내에서 페이지 이동하게
         window.location.href = `test2`;
        }
        
        //서버에 배열 전달 하는 함수
        //function sendGenresToServer(Genres) {
        	
        //}
       
</script>
</body>
</html>