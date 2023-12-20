package com.music.mute.api;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import lombok.Data;

@Controller
public class OAuthController {

    private static final String CLIENT_ID = "61731dfa4f5a4f81a934c76fe09958d8";
    private static final String CLIENT_SECRET = "7b9fbc7d7cb14319b7af63f5c5f18176";
    private static final String REDIRECT_URI = "http://localhost:9089/mute/main";
    private static final String SPOTIFY_AUTH_URL = "https://accounts.spotify.com/authorize";
    private static final String SPOTIFY_TOKEN_URL = "https://accounts.spotify.com/api/token";

    @RequestMapping("/spotify/login")
    public String login() {
        // Redirect the user to the Spotify authorization URL
        String redirectUrl = SPOTIFY_AUTH_URL +
                "?client_id=" + CLIENT_ID +
                "&response_type=code" +
                "&redirect_uri=" + REDIRECT_URI +
                "&scope=streaming user-read-email user-read-private user-library-read user-library-modify " +
               "user-read-playback-state user-modify-playback-state playlist-read-collaborative " +
               "user-read-currently-playing playlist-read-private playlist-modify-public " +
               "playlist-modify-private";
        return "redirect:" + redirectUrl;
    }

    @RequestMapping("/callback")
    @ResponseBody
    public String callback(@RequestParam("code") String code) {
        // Exchange the authorization code for an access token
        String tokenUrl = SPOTIFY_TOKEN_URL +
                "?grant_type=authorization_code" +
                "&code=" + code +
                "&redirect_uri=" + REDIRECT_URI +
                "&client_id=" + CLIENT_ID +
                "&client_secret=" + CLIENT_SECRET;
        RestTemplate restTemplate = new RestTemplate();
        SpotifyAccessTokenResponse response = restTemplate.postForObject(tokenUrl, null, SpotifyAccessTokenResponse.class);

        // Now you can use response.getAccessToken() to access Spotify API on behalf of the user

        return "Success! Access Token: " + response.getAccess_token();
    }

    // Define a class to represent the response from the Spotify token endpoint
	/* @Data */
    private static class SpotifyAccessTokenResponse {
        public String getAccess_token() {
			return access_token;
		}
		public void setAccess_token(String access_token) {
			this.access_token = access_token;
		}
		public String getToken_type() {
			return token_type;
		}
		public void setToken_type(String token_type) {
			this.token_type = token_type;
		}
		public String getExpires_in() {
			return expires_in;
		}
		public void setExpires_in(String expires_in) {
			this.expires_in = expires_in;
		}
		public String getRefresh_token() {
			return refresh_token;
		}
		public void setRefresh_token(String refresh_token) {
			this.refresh_token = refresh_token;
		}
		public String getScope() {
			return scope;
		}
		public void setScope(String scope) {
			this.scope = scope;
		}
		private String access_token;
        private String token_type;
        private String expires_in;
        private String refresh_token;
        private String scope;

        // Getters and setters...
        
    }
    
}

