package com.music.mute.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {
	@Inject
    private DataSource dataSource;  // 스프링 레거시에서 제공하는 DataSource를 사용

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public void saveSpotifyUserId(MemberVO member) {
    	System.out.println(">>>>"+dataSource);
        String query = "INSERT INTO MEMBER (S_ID,S_NAME) VALUES (?,?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, member.getS_ID());
            preparedStatement.setString(2, "NONAME");
            preparedStatement.executeUpdate();

            // Get the generated S_NUM (Auto Increment) value
            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int sNum = generatedKeys.getInt(1);
                    System.out.println("Auto Incremented S_NUM: " + sNum);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
// =====테스트 코드들============
    public void insertMember(MemberVO member) {
        String query = "INSERT INTO MEMBER (S_NUM, S_ID, S_NAME) VALUES (?, ?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, member.getS_NUM());
            preparedStatement.setString(2, member.getS_ID());
            preparedStatement.setString(3, member.getS_NAME());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public MemberVO getMemberById(String sId) {
        String query = "SELECT * FROM MEMBER WHERE S_ID = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, sId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                MemberVO member = new MemberVO();
                member.setS_NUM(resultSet.getInt("S_NUM"));
                member.setS_ID(resultSet.getString("S_ID"));
                member.setS_NAME(resultSet.getString("S_NAME"));
                return member;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
