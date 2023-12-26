package com.music.mute.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Service
public class SpotifyOAuthService {

    private static final String CLIENT_ID = "61731dfa4f5a4f81a934c76fe09958d8";
    private static final String CLIENT_SECRET = "7b9fbc7d7cb14319b7af63f5c5f18176";
    private static final String REDIRECT_URI = "http://localhost:9089/mute/main";
    private static final String SPOTIFY_AUTH_URL = "https://accounts.spotify.com/authorize";
    private static final String SPOTIFY_TOKEN_URL = "https://accounts.spotify.com/api/token";

    private final RestTemplate restTemplate;

    @Autowired
    public SpotifyOAuthService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public String buildAuthorizationUrl() {
        return UriComponentsBuilder.fromHttpUrl(SPOTIFY_AUTH_URL)
                .queryParam("client_id", CLIENT_ID)
                .queryParam("response_type", "code")
                .queryParam("redirect_uri", REDIRECT_URI)
                .queryParam("scope", "streaming user-read-email user-read-private user-library-read user-library-modify " +
                        "user-read-playback-state user-modify-playback-state playlist-read-collaborative " +
                        "user-read-currently-playing playlist-read-private playlist-modify-public " +
                        "playlist-modify-private ugc-image-upload app-remote-control")

                .build().toUriString();
    }

    public String requestAccessToken(String code) {
        String tokenUrl = SPOTIFY_TOKEN_URL +
                "?grant_type=authorization_code" +
                "&code=" + code +
                "&redirect_uri=" + REDIRECT_URI +
                "&client_id=" + CLIENT_ID +
                "&client_secret=" + CLIENT_SECRET;

        try {
            SpotifyAccessTokenResponse response = restTemplate.postForObject(tokenUrl, null, SpotifyAccessTokenResponse.class);
            return response.getAccess_token();
        } catch (HttpClientErrorException e) {
            // Print detailed error information
            System.out.println("Error response: " + e.getResponseBodyAsString());
            throw e;
        }
    }


    private static class SpotifyAccessTokenResponse {
        private String access_token;
        private String token_type;
        private String expires_in;
        private String refresh_token;
        private String scope;
        public String getAccess_token() {
            return access_token;
        }


        // Getters and setters...
    }
}
