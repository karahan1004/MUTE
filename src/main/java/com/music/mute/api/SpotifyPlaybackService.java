package com.music.mute.api;

import java.io.IOException;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.miscellaneous.CurrentlyPlayingContext;
import se.michaelthelin.spotify.requests.data.player.SkipUsersPlaybackToNextTrackRequest;
import se.michaelthelin.spotify.requests.data.player.SkipUsersPlaybackToPreviousTrackRequest;
import se.michaelthelin.spotify.requests.data.player.StartResumeUsersPlaybackRequest;

@Service
public class SpotifyPlaybackService {

    private final SpotifyApi spotifyApi;

    @Autowired
    public SpotifyPlaybackService(SpotifyApi spotifyApi) {
        this.spotifyApi = spotifyApi;
    }

    public void playSong(String accessToken, String trackUri) throws ParseException {
        try {
            spotifyApi.setAccessToken(accessToken);
            

            // 트랙 URI를 JsonArray로 변환
            JsonArray urisJsonArray = new JsonArray();
            urisJsonArray.add(trackUri);

            // 노래 재생 요청
            spotifyApi.startResumeUsersPlayback().uris(urisJsonArray).build().execute();
        } catch (IOException | SpotifyWebApiException e) {
            e.printStackTrace();
        }
    }

    public void pausePlayback(String accessToken) throws ParseException {
        try {
            spotifyApi.setAccessToken(accessToken);

            // 재생 중인 노래 멈춤 요청
            spotifyApi.pauseUsersPlayback().build().execute();
        } catch (IOException | SpotifyWebApiException e) {
            e.printStackTrace();
        }
    }
    
    public void startOrResumePlayback(String accessToken, String trackUri) throws ParseException {
        try {
            spotifyApi.setAccessToken(accessToken);

            // String[]을 JsonArray로 변환
            JsonArray urisJsonArray = new JsonArray();
            urisJsonArray.add(trackUri);

            // 수정: Spotify의 API 변경으로 builder() 대신 create()를 사용합니다.
            StartResumeUsersPlaybackRequest startResumeRequest = spotifyApi
                    .startResumeUsersPlayback()
                    .uris(urisJsonArray)
                    .build();

            startResumeRequest.execute();
        } catch (IOException | SpotifyWebApiException e) {
            e.printStackTrace();
        }
    }

    public CurrentlyPlayingContext getCurrentPlayback(String accessToken) throws ParseException {
        try {
            spotifyApi.setAccessToken(accessToken);
            return spotifyApi.getInformationAboutUsersCurrentPlayback().build().execute();
        } catch (IOException | SpotifyWebApiException e) {
            e.printStackTrace();
            return null;
        }
    }

    public void playPreviousTrack(String accessToken) {
        try {
            spotifyApi.setAccessToken(accessToken);

            // 현재 플레이어 상태를 가져오기
            CurrentlyPlayingContext currentPlayback = spotifyApi
                    .getInformationAboutUsersCurrentPlayback()
                    .build()
                    .execute();

            // 현재 플레이어 상태에서 이전 트랙으로 건너뛰기
            if (currentPlayback != null && currentPlayback.getIs_playing()) {
                SkipUsersPlaybackToPreviousTrackRequest request = spotifyApi
                        .skipUsersPlaybackToPreviousTrack()
                        .build();
                request.execute();
            }
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            e.printStackTrace();
            // 예외 처리: 에러가 발생하면 적절한 조치를 취함
        }
    }


    public void playNextTrack(String accessToken) {
        try {
            spotifyApi.setAccessToken(accessToken);

            // 현재 플레이어 상태를 가져오기
            CurrentlyPlayingContext currentPlayback = spotifyApi
                    .getInformationAboutUsersCurrentPlayback()
                    .build()
                    .execute();

            // 현재 플레이어 상태에서 다음 트랙으로 건너뛰기
            if (currentPlayback != null && currentPlayback.getIs_playing()) {
                SkipUsersPlaybackToNextTrackRequest request = spotifyApi
                        .skipUsersPlaybackToNextTrack()
                        .build();
                request.execute();
            }
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            e.printStackTrace();
            // 예외 처리: 에러가 발생하면 적절한 조치를 취함
        }
    }
    
    


	
}