package com.music.mute.login;

import java.util.List;
import java.util.concurrent.CompletableFuture;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;

@Controller
public class TestPlaylist {

    @Autowired
    private SpotifyApi spotifyApi;

    @GetMapping("/apiTest")
    public String getUserPlaylists(Model model, HttpSession session) {
        // 사용자의 Access Token을 세션에서 가져옴
        String accessToken = (String) session.getAttribute("accessToken");

        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);

                final GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
                        .getListOfCurrentUsersPlaylists()
                        .limit(10)
                        .build();

                final CompletableFuture<Paging<PlaylistSimplified>> playlistsFuture = playlistsRequest.executeAsync();

                // 실제 코드에서는 결과를 처리해야 합니다.
                PlaylistSimplified[] playlists = playlistsFuture.join().getItems();

                model.addAttribute("playlists", playlists);
            } catch (Exception e) {
                // 예외 처리
                e.printStackTrace();
            }
        } else {
            // Access Token이 없는 경우, 로그인 페이지로 리다이렉트 또는 에러 처리
            return "redirect:/login"; // 예시: 로그인 페이지로 리다이렉트
        }

        return "/apiTest";
    }
}