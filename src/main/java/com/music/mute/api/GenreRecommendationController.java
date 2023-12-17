package com.music.mute.api;

import java.util.concurrent.CompletableFuture;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;

@Controller
public class GenreRecommendationController {

    @Autowired
    private SpotifyApi spotifyApi;

    @GetMapping("/recommendations")
    public String getGenreRecommendations(Model model, HttpSession session) {
        // 사용자의 Access Token을 세션에서 가져옴
        String accessToken = (String) session.getAttribute("accessToken");

        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);

                // 사용자의 플레이리스트 목록 가져오기 (예시)
                final GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
                        .getListOfCurrentUsersPlaylists()
                        .limit(10)
                        .build();

                final CompletableFuture<Paging<PlaylistSimplified>> playlistsFuture = playlistsRequest.executeAsync();
                PlaylistSimplified[] playlists = playlistsFuture.join().getItems();

                // 특정 플레이리스트의 장르를 기반으로 음악 추천 받기 (예시)
                String playlistId = playlists[0].getId(); // 첫 번째 플레이리스트 사용 (예시)
                final GetRecommendationsRequest recommendationsRequest = spotifyApi
                        .getRecommendations()
                        .seed_genres("trot") // 원하는 장르를 나열
                        .limit(3)
                        .build();


                final CompletableFuture<Recommendations> recommendationsFuture = recommendationsRequest.executeAsync();
                Track[] recommendations = recommendationsFuture.join().getTracks();

                model.addAttribute("recommendations", recommendations);

            } catch (Exception e) {
                // 예외 처리: 사용자에게 친화적인 메시지 표시
                model.addAttribute("error", "음악 추천을 가져오는 중에 오류가 발생했습니다.");
                return "/errorPage"; // 예시: 오류 페이지로 리다이렉트
            }
        } else {
            // Access Token이 없는 경우, 로그인 페이지로 리다이렉트 또는 에러 처리
            return "redirect:/login"; // 예시: 로그인 페이지로 리다이렉트
        }

        return "/recommendations";
    }
}
