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
                .scope("user-read-private,user-read-email")
                //.showDialog(true)
                .build()
                .execute();
    }

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
}