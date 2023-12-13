package com.music.mute.login;

import java.net.URI;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

import se.michaelthelin.spotify.SpotifyApi;

@Configuration
public class SpotifyConfig {

	private String clientId = "61731dfa4f5a4f81a934c76fe09958d8";

	private String clientSecret = "7b9fbc7d7cb14319b7af63f5c5f18176";

	private String redirectUri = "http://localhost:9089/mute/main";

			
	@Bean
	public RestTemplate restTemplate() {
		return new RestTemplate();
	}

	@Bean
	public SpotifyApi spotifyApi() {
		return new SpotifyApi
				.Builder()
				.setClientId(clientId)
				.setClientSecret(clientSecret)
				.setRedirectUri(URI.create(redirectUri))
				.build();
	}
}
