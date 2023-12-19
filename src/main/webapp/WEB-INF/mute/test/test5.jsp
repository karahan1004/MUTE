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
    	<h1>Q5.<br> 첫 눈이 내린 날, <br>당신이 들을 노래는?</h1>
			<!-- 버튼 클릭시 selectGenre(value) 함수를 통해 각 선택지 별 해당하는 장르 count++ -->
	        <button class="btn" onclick="selectGenre(1)">Snowman - SIA</button>
	        <button class="btn" onclick="selectGenre(2)">All I Want For Christmas Is You - Mariah Carey</button>
	        <button class="btn" onclick="selectGenre(3)">Last Christmas - Wham!</button>
	        <button class="btn" onclick="selectGenre(4)">Santa Tell Me - Ariana Grande</button>
    </div>
    <!-- test5 에서는 전체 배열의 중복을 방지하기 위해 인덱스 값을 일부러 한 장르만 증가하는 작업 수행 -->
   <script>
   		// 길이가 10인 Genres 배열을 선언하고 모든 인덱스값을 0으로 초기화
   		/* 장르 배열 (0:락, 1:발라드, 2:트로트, 3:알앤비, 4:힙합, 5:클래식, 6:인디, 7:디스코, 8:재즈, 9:댄스) */
        let Genres = Array(10).fill(0);
        function selectGenre(value) {
            if (value === 1) {	/* 인덱스 증가 처리 */
            	//장르별 카운트 배열값 다시설정
            	// 재즈
                Genres[8]++;
            } else if (value === 2) {
           		// 락, 댄스
                Genres[0]++;
                Genres[9]++
            } else if (value === 3) {
            	 // 인디, 디스코 
                Genres[6]++;
                Genres[7]++;
            } else if (value === 4) {
            	// 알앤비
                Genres[3]++;
            }
            
	       	sendGenresToServer(Genres);//Genres 카운트 후 Genres 배열을 서버로 보내는 함수 작성 필요
	       	console.log(Genres);//콘솔에 배열 찍히는지 확인용
	       	window.location.href = `test6`;// test5에서 해당 장르 배열 인덱스 값 증가 후 스크립트 내에서 페이지 이동하게
        }//------------------------------------
        
        //서버에 배열 전달 하는 함수
       function sendGenresToServer(Genres) {
        fetch("updategenres", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(Genres)//Genres 배열을 json형태로 변환하여 서버에 전달
        })
            .then(response => response.json())
            .then(Genres => {
                console.log("서버 응답:", Genres);
            })
            .catch(error => console.error("Error:", error));
    }//------------------------------------
</script>
</body>
</html>