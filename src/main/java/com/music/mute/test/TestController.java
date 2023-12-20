package com.music.mute.test;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TestController {
	
	 @GetMapping("/test1")
	    public String showTestPage1(HttpSession session) {
		 int[] genres = new int[10];
		 session.setAttribute("musicGenres", genres);
		 System.out.println("--------------------------");
		 System.out.println("test1에서 생성되는 장르 배열");
	        return "test/test1";
	    }//---------------------------------------
	 
	 @GetMapping("/test2")
	    public String showTestPage2() { 
		 System.out.println("--------------------------");
		 System.out.println("test2에서 생성되는 장르 배열");
		 return "test/test2"; }
	 @GetMapping("/test3")
	    public String showTestPage3() { 
		 System.out.println("--------------------------");
		 System.out.println("test3에서 생성되는 장르 배열");
		 return "test/test3"; } 
	 @GetMapping("/test4")
	    public String showTestPage4() { 
		 System.out.println("--------------------------");
		 System.out.println("test4에서 생성되는 장르 배열");
		 return "test/test4"; } 
	 @GetMapping("/test5")
	    public String showTestPage5() { 
		 System.out.println("--------------------------");
		 System.out.println("test5에서 생성되는 장르 배열");
		 return "test/test5"; } 
	 @GetMapping("/test6")
	    public String showTestPage6() { 
		 System.out.println("--------------------------");
		 System.out.println("test6에서 생성되는 장르 배열");
		 return "test/test6"; } 
	 @GetMapping("/test7")
	    public String showTestPage7() { 
		 System.out.println("--------------------------");
		 System.out.println("test7에서 생성되는 장르 배열");
		 return "test/test7"; } 
	 @GetMapping("/test8")
	    public String showTestPage8() { 
		 System.out.println("--------------------------");
		 System.out.println("test8에서 생성되는 장르 배열");
		 return "test/test8"; } 
	         
	 @RequestMapping(value = "/updategenres", method = RequestMethod.POST)
	    //GET 요청이 오면 200뜨고 res 출력 / 페이지가 원래 가지고 있던 배열
	 public ResponseEntity<String> updateGenres(@RequestBody int[] genres, HttpSession session) {
	        int[] existingGenres = (int []) (session.getAttribute("musicGenres"));//반환되는 "musicGenres"는 object유형이라 int배열로 강제 형변환
		 
		 System.out.println("1. 각 테스트 페이지 별 배열: ");
		 for (int i=0; i<genres.length; i++) {
	            System.out.print(genres[i] + " ");
	        }
	     System.out.println();
			 
		 System.out.println("2. 기존 장르 배열 : ");
		 for (int i=0; i<existingGenres.length; i++) {
	            System.out.print(existingGenres[i] + " ");
	        }
	     System.out.println();
		
		 //원래 배열에 버튼 눌러서 해당하는 장르 인덱스값 누적
	        for (int i=0; i<genres.length; i++) {
	            existingGenres[i] += genres[i];
	        }
		 
		System.out.println("3. 배열 추가 후 : ");
		for (int i=0; i<existingGenres.length; i++) {
            System.out.print(existingGenres[i] + " ");
        }
        System.out.println();
			
        session.setAttribute("musicGenres", existingGenres);

        return ResponseEntity.ok("good");
	}//---------------------------------------
	
	 // 테스트를 통해 나온 최종 배열 인덱스 중 최댓값에 해당하는 결과페이지로 GetMapping
	 @GetMapping("/result_genres")
	 public String showResultPage(HttpSession session) {
		 int max_index=0;
		 int max_value=0;
		 int [] resultGenres=(int [])(session.getAttribute("musicGenres"));
			 for(int i=0;i<resultGenres[i];i++) {
		            if (max_value < resultGenres[i]) {
		            	max_value=resultGenres[i];
		                max_index = i;
		            }//if-------------------
		           
		        }//for--------------------------------
			  //session.invalidate(); 세션 끊어보니까 페이지 이동 안됨
		   //(0:락, 1:발라드, 2:트로트, 3:알앤비, 4:힙합, 5:클래식, 6:인디, 7:디스코, 8:재즈, 9:댄스)
		   switch (max_index){
		   case 0:
		   		return "result/result_rock";
		   case 1:
		   		return "result/result_ballad";
		   case 2:
			   return "result/result_trot";
		   case 3:
			   return "result/result_rnb";
		   case 4:
			   return "result/result_hiphop";
		   case 5:
			   return "result/result_classic";
		   case 6:
			   return "result/result_indie";
		   case 7:
			   return "result/result_disco";
		   case 8:
			   return "result/result_jazz";
		   case 9:
			   return "result/result_dance";
		   default:
		   	   return "/main";
		   	
	 		}//switch--------------------------
	 		
	 }//---------------------------------------
	 
}///////////////////////////////////

