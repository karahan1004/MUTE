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
	    <h1>Q3.<br>친구가 음악을<br> 추천해 달라 했을 때 당신의 반응은?</h1>
			<!-- 버튼 클릭시 selectGenre(value) 함수를 통해 각 선택지 별 해당하는 장르 count++ -->
	        <button class="btn" onclick="selectGenre(1)">너 말해봤자 모를걸?</button>
	        <button class="btn" onclick="selectGenre(2)">너 이거 몰라?</button>
	        <button class="btn" onclick="selectGenre(3)">음악은 역시 클래식이지!</button>
	        <button class="btn" onclick="selectGenre(4)">내가 요즘 노래를 잘 몰라서…ㅜ</button>
    </div>
    
   <script>
   		// 길이가 10인 Genres 배열을 선언하고 모든 인덱스값을 0으로 초기화
   		/* 장르 배열 (0:락, 1:발라드, 2:트로트, 3:알앤비, 4:힙합, 5:클래식, 6:인디, 7:디스코, 8:재즈, 9:댄스) */
        let Genres = Array(10).fill(0);
        function selectGenre(value) {
            if (value === 1) {	/* 인덱스 증가 처리 */
            	//장르별 카운트 배열값 다시설정
            	// 락, 알앤비, 힙합, 인디
                Genres[0]++;
                Genres[3]++;
                Genres[4]++;
                Genres[6]++;
            } else if (value === 2) {
            	// 발라드, 댄스
                Genres[1]++;
                Genres[9]++;
            } else if (value === 3) {
            	// 클래식, 재즈
                Genres[5]++;
                Genres[8]++;
            } else if (value === 4) {
            	// 트로트, 디스코
                Genres[2]++;
                Genres[7]++;
            }
            
	       	sendGenresToServer(Genres);//Genres 카운트 후 Genres 배열을 서버로 보내는 함수 작성 필요
	       	console.log(Genres);//콘솔에 배열 찍히는지 확인용
	       	window.location.href = `test4`;// test3에서 해당 장르 배열 인덱스 값 증가 후 스크립트 내에서 페이지 이동하게
        }//------------------------------------
        
        //서버에 배열 전달 하는 함수
        function sendGenresToServer(Genres) {
        	fetch("/update-genres", {
        		method: "POST",
        	})
        	 .catch(error => console.error("Error:", error));
        }//------------------------------------
       
</script>
</body>
</html>