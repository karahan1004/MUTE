<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/test.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>MU:TE</title>
</head>
<body>
	<div class="totaldiv">
	<div class="logodiv">
	<a href="main"><img class="logo" src="resources/images/mutelogo.png"></a>
	</div>
	
	<div class="question">
	    <h1>Q4.<br> 콘서트를 가기로 한 당신! <br>당신이 가고 싶은 콘서트는?</h1>
			<!-- 버튼 클릭시 selectGenre(value) 함수를 통해 각 선택지 별 해당하는 장르 count++ -->
	        <button class="btn" onclick="selectGenre(1)" onmouseover="addShadow(this)" onmouseout="removeShadow(this)">이것이 진정한 페스티벌! 락페스티벌</button>
	        <button class="btn" onclick="selectGenre(2)" onmouseover="addShadow(this)" onmouseout="removeShadow(this)">가슴이 웅장해진다… 영화 오케스트라 콘서트</button>
	        <button class="btn" onclick="selectGenre(3)" onmouseover="addShadow(this)" onmouseout="removeShadow(this)">내 최애 영접! 아이돌 콘서트</button>
	        <button class="btn" onclick="selectGenre(4)" onmouseover="addShadow(this)" onmouseout="removeShadow(this)">Back to the 90's! 안방 1열 테크노 콘서트</button>
    </div>
    
   <script>
   
	   /* 보기 버튼에 마우스 올리면 그림자 생김 */
		function addShadow(element) {
		    element.classList.add('shadow');}
		function removeShadow(element) {
		    element.classList.remove('shadow');}
		/* ---------------------------------- */
	
   		// 길이가 10인 Genres 배열을 선언하고 모든 인덱스값을 0으로 초기화
   		/* 장르 배열 (0:락, 1:발라드, 2:테크노, 3:알앤비, 4:힙합, 5:클래식, 6:인디, 7:디스코, 8:재즈, 9:댄스) */
        let Genres = Array(10).fill(0);
        function selectGenre(value) {
            if (value === 1) {	/* 인덱스 증가 처리 */
            	//장르별 카운트 배열값 다시설정
            	// 락, 힙합, 인디
                Genres[0]++;
                Genres[4]++;
                Genres[6]++;
            } else if (value === 2) {
            	// 클래식, 재즈
                Genres[5]++;
                Genres[8]++;
            } else if (value === 3) {
            	// 발라드, 알앤비, 댄스
                Genres[1]++;
                Genres[3]++;
                Genres[9]++;
            } else if (value === 4) {
            	// 테크노, 디스코
                Genres[2]++;
                Genres[7]++;
            }
            
	       	sendGenresToServer(Genres);//Genres 카운트 후 Genres 배열을 서버로 보내는 함수 작성 필요
	       	console.log(Genres);//콘솔에 배열 찍히는지 확인용
	       	window.location.href = `test5`;// test4에서 해당 장르 배열 인덱스 값 증가 후 스크립트 내에서 페이지 이동하게
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