package com.music.mute.login;

import java.io.IOException;
import java.net.URI;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.credentials.AuthorizationCodeCredentials;
import se.michaelthelin.spotify.requests.authorization.authorization_code.AuthorizationCodeRequest;

@Service
public class SpotifyService {
	@Autowired
    private SpotifyApi spotifyApi;

    public URI generateAuthorizationUrl() {
        return spotifyApi.authorizationCodeUri()
                .state("some-state")
                .scope("ugc-image-upload,user-read-playback-state,user-modify-playback-state,user-read-currently-playing,streaming,playlist-modify-public,user-library-modify")
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
    }//////
    // refresh Token 받아와야 함!!!!!!// 
//    public String requestRefreshToken(String refresh) {
//    	try {
//    		AuthorizationCodeRequest rreq = spotifyApi.authorizationCode(refresh)
//    			.build();
//    	
//    		AuthorizationCodeCredentials authorizationCodeCredentials = rreq.execute();
//			return authorizationCodeCredentials.getRefreshToken();
//		} catch (ParseException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (SpotifyWebApiException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//    	
//    }
}//=========================