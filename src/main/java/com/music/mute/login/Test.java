package com.music.mute.login;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Test {

    public static void main(String[] args) {
        // 스프링 컨테이너 초기화
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        // MemberDAO 빈을 가져옴
        MemberDAO memberDAO = (MemberDAO) context.getBean("memberDAO");

        // MemberVO 객체 생성 및 값 설정
        MemberVO member = new MemberVO();
        member.setS_NUM(2);
        member.setS_ID("test_user2");
        member.setS_NAME("Test User2");

        // insertMember 메서드 호출하여 데이터베이스에 회원 정보 삽입
       // memberDAO.insertMember(member);

        // getMemberById 메서드 호출하여 데이터베이스에서 회원 정보 조회
        MemberVO retrievedMember = memberDAO.getMemberById("test_user2");

        // 조회된 회원 정보 출력
        if (retrievedMember != null) {
            System.out.println("Retrieved Member: " + retrievedMember);
        } else {
            System.out.println("Member not found.");
        }
    }
}
