package com.music.mute.login;

import java.io.IOException;
import java.net.URI;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.credentials.AuthorizationCodeCredentials;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.authorization.authorization_code.AuthorizationCodeRequest;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;

@Service
public class SpotifyService {
	@Autowired
    private SpotifyApi spotifyApi;
	
	private String refreshToken;

    public URI generateAuthorizationUrl() {
        return spotifyApi.authorizationCodeUri()
                .state("some-state")
                .scope("user-read-private, ugc-image-upload,user-read-playback-state,user-modify-playback-state,user-read-currently-playing,streaming,playlist-modify-public,playlist-modify-private,playlist-read-private,playlist-read-collaborative,user-library-modify,user-modify-playback-state,app-remote-control")
                //.showDialog(true)
                .build()
                .execute();
    }/////

    public String requestAccessToken(String code) {
        try {
            AuthorizationCodeRequest areq = spotifyApi.authorizationCode(code)
                    .build();

            AuthorizationCodeCredentials authorizationCodeCredentials = areq.execute();
            return authorizationCodeCredentials.getAccessToken();
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            throw new RuntimeException("Error requesting access token", e);
        }
    }
    
    public String refreshAccessToken() {
        try {
            AuthorizationCodeCredentials credentials = spotifyApi.authorizationCodeRefresh()
                    .refresh_token(refreshToken)
                    .build()
                    .execute();

            // SpotifyApi 인스턴스를 새로운 액세스 토큰으로 업데이트합니다.
            spotifyApi.setAccessToken(credentials.getAccessToken());

            // 옵션: 응답에서 리프레시 토큰이 반환되면 업데이트합니다.
            if (credentials.getRefreshToken() != null) {
                refreshToken = credentials.getRefreshToken();
            }

            return credentials.getAccessToken();
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            throw new RuntimeException("액세스 토큰을 리프레시하는 중 오류가 발생했습니다", e);
        }
    
    //////
    
//    public String getSpotifyUserId(String accessToken) {
//        try {
//            // Set the access token in the SpotifyApi instance
//            spotifyApi.setAccessToken(accessToken);
//
//            // Request the current user's profile from Spotify
//            GetCurrentUsersProfileRequest request = spotifyApi.getCurrentUsersProfile().build();
//            User user = null;
//			try {
//				user = request.execute();
//			} catch (ParseException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//
//            // Retrieve and return the user ID
//            return user.getId();
//        } catch (IOException | SpotifyWebApiException e) {
//            throw new RuntimeException("Error retrieving user information", e);
//        }
//    }
    
    }
    
}//=========================