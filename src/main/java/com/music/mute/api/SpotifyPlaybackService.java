package com.music.mute.api;

import java.io.IOException;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.miscellaneous.CurrentlyPlayingContext;
import se.michaelthelin.spotify.model_objects.miscellaneous.Device;
import se.michaelthelin.spotify.requests.data.player.PauseUsersPlaybackRequest;
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

 // 사용자의 Spotify 계정에 연결된 디바이스 목록 가져오기
    public Device[] getUsersDevices(String accessToken) throws ParseException {
        try {
            spotifyApi.setAccessToken(accessToken);
            return spotifyApi.getUsersAvailableDevices().build().execute();
        } catch (IOException | SpotifyWebApiException e) {
            handleException(e);
            return null;
        }
    }

    // 특정 디바이스에서 음악 재생
    public void playOnDevice(String accessToken, String deviceId, String trackUri) throws ParseException {
        try {
            spotifyApi.setAccessToken(accessToken);

            // 트랙 URI를 JsonArray로 변환
            JsonArray urisJsonArray = new JsonArray();
            urisJsonArray.add(trackUri);

            // 노래 재생 요청
            StartResumeUsersPlaybackRequest request = spotifyApi
                    .startResumeUsersPlayback()
                    .uris(urisJsonArray)
                    .device_id(deviceId)
                    .build();

            request.execute();
        } catch (IOException | SpotifyWebApiException e) {
            handleException(e);
        }
    }

    // 일시정지
    public void pausePlayback(String accessToken) throws ParseException {
        try {
            spotifyApi.setAccessToken(accessToken);
            PauseUsersPlaybackRequest request = spotifyApi.pauseUsersPlayback().build();
            request.execute();
        } catch (IOException | SpotifyWebApiException e) {
            handleException(e);
        }
    }

    // 현재 플레이백 정보 가져오기
    public CurrentlyPlayingContext getCurrentPlayback(String accessToken) throws ParseException {
        try {
            spotifyApi.setAccessToken(accessToken);
            return spotifyApi.getInformationAboutUsersCurrentPlayback().build().execute();
        } catch (IOException | SpotifyWebApiException e) {
            handleException(e);
            return null;
        }
    }

    // 예외 처리
    private void handleException(Exception e) {
        // 예외 처리: 에러가 발생하면 적절한 조치를 취함
        e.printStackTrace();
        // 예외 로깅 또는 사용자에게 메시지 표시 등의 추가 작업이 필요합니다.
    }

    public void startOrResumePlayback(String accessToken, String trackUri, String deviceId) throws ParseException {
        try {
            spotifyApi.setAccessToken(accessToken);

            // 트랙 URI를 JsonArray로 변환
            JsonArray urisJsonArray = new JsonArray();
            urisJsonArray.add(trackUri);

            // Spotify의 API 변경으로 builder() 대신 create()를 사용합니다.
            StartResumeUsersPlaybackRequest startResumeRequest = spotifyApi
                    .startResumeUsersPlayback()
                    .uris(urisJsonArray)
                    .device_id(deviceId)
                    .build();

            startResumeRequest.execute();
        } catch (IOException | SpotifyWebApiException e) {
            handleException(e);
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
            handleException(e);
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
            handleException(e);
        }
    }

    public void setVolume(String accessToken, int volume) {
        try {
            spotifyApi.setAccessToken(accessToken);

            // 현재 재생 중인 디바이스 ID 가져오기
            Device device = spotifyApi.getUsersAvailableDevices().build().execute()[0];
            String deviceId = device.getId();

            // 볼륨 조절 요청
            spotifyApi.startResumeUsersPlayback().device_id(deviceId).build().execute();

            // 볼륨을 조절하기 위해 먼저 재생 상태를 유지합니다.
            Thread.sleep(1000);

            // 메서드 이름 수정: setVolumeOnUsersPlayback -> setVolumeOnUserPlayback
            spotifyApi.setVolumeForUsersPlayback(volume).device_id(deviceId).build().execute();
        } catch (IOException | SpotifyWebApiException | InterruptedException | ParseException e) {
            handleException(e);
        }
    }


}
