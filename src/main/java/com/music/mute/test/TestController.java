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
			 /* setAttribute(String name, Object value):
			  * name은 데이터를 식별하는데 사용되는 이름value는 저장하려는 객체 */
		 System.out.println("test1에서 생성된 장르 배열: ");
	        return "test/test1";
	    }//---------------------------------------
	 
	 @GetMapping("/test2")
	    public String showTestPage2() { return "test/test2"; }
	 @GetMapping("/test3")
	    public String showTestPage3() { return "test/test3"; } 
	 @GetMapping("/test4")
	    public String showTestPage4() { return "test/test4"; } 
	         
	 @RequestMapping(value = "/updategenres", method = RequestMethod.POST)
	 //GET 요청이 오면 200뜨고 res 출력 / 페이지가 원래 가지고 있던 배열 
	   public ResponseEntity<String> updateGenres(@RequestBody int[] genres, HttpSession session) {
		 int[] existingGenres = (int []) (session.getAttribute("musicGenres"));//반환되는 "musicGenres"는 object유형이라 int배열로 강제 형변환
		 
		 System.out.print("1. 초기 배열 확인 용");
			 for(int i=0;i<genres.length;i++) {
				 System.out.println(genres[i]+" ");
		 }//콘솔에 안찍힌다.. post가 전송이 안되나본데
			 
		 System.out.println("2. 기존 장르 배열");
		 for(int i=0;i<existingGenres.length;i++) {
			 System.out.println(existingGenres[i]+" ");
		 }
		 //원래 배열에 버튼 눌러서 해당하는 장르 인덱스값 누적
		 for (int i=0; i<genres.length; i++) {
	            existingGenres[i] += genres[i];
	     }
		 
		 System.out.print("3.추가 후 : ");
        for (int i=0; i<existingGenres.length; i++) {
            System.out.print(existingGenres[i] + " ");
        }
        System.out.println();
			
		session.setAttribute("musicGenres", existingGenres);	 
	    return ResponseEntity.ok("good");
	}//---------------------------------------
	 
	   
	   
	   

}///////////////////////////////////

