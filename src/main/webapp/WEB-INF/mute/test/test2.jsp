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
	    <h1>Q2.<br>음악은 이렇게 즐겨야지!<br><br></h1>
			<!-- 버튼 클릭시 selectGenre(value) 함수를 통해 각 선택지 별 해당하는 장르 count++ -->
	        <button class="btn" onclick="selectGenre(1)">클럽에서 신나게! 스피커 볼륨 최대로~</button>
	        <button class="btn" onclick="selectGenre(2)">와인바에서 잔잔하게! 소음따윈 가볍게 무시한다는 마인드</button>
	        <button class="btn" onclick="selectGenre(3)">햇살을 맞으며 창가에서 커피 한 잔 할래용</button>
	        <button class="btn" onclick="selectGenre(4)">대한민국 음악의 중심은 바로 나! 엄마 난 커서 가수가 될래요!</button>
    </div>
    
   <script>
   		// 길이가 10인 Genres 배열을 선언하고 모든 인덱스값을 0으로 초기화
   		/* 장르 배열 (0:락, 1:발라드, 2:트로트, 3:알앤비, 4:힙합, 5:클래식, 6:인디, 7:디스코, 8:재즈, 9:댄스) */
        let Genres = Array(10).fill(0);
        function selectGenre(value) {
            if (value === 1) {	/* 인덱스 증가 처리 */
            	//장르별 카운트 배열값 다시설정
                // 락, 힙합, 디스코
                Genres[0]++;
                Genres[4]++;
                Genres[7]++;
            } else if (value === 2) {
                // 발라드, 클래식, 재즈 
                Genres[1]++;
                Genres[5]++;
                Genres[8]++;
            } else if (value === 3) {
                // 알앤비, 인디
                Genres[3]++;
                Genres[6]++;
            } else if (value === 4) {
                // 트로트, 댄스 
                Genres[2]++;
                Genres[9]++;
            }
            
	       	sendGenresToServer(Genres);//Genres 카운트 후 Genres 배열을 서버로 보내는 함수 작성 필요
	       	console.log(Genres);//콘솔에 배열 찍히는지 확인용
	       	window.location.href = `test3`;// test2에서 해당 장르 배열 인덱스 값 증가 후 스크립트 내에서 페이지 이동하게
        }//------------------------------------
        
        //서버에 배열 전달 하는 함수
        function sendGenresToServer(Genres) {
        	fetch("updategenres", {
        		method: "POST",
        		header: {
        			"Content-Type": "application/json"
        		},
        		body: JSON.stringify(Genres) //Genres배열을 json형태로 변환하여 서버에 전달
        	})
	        	 .then(response => response.json())
	        	 
        	 .catch(error => console.error("Error:", error));
        }//------------------------------------
       
</script>
</body>
</html>