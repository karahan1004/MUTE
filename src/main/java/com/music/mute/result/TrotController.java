package com.music.mute.result;

import java.util.concurrent.CompletableFuture;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.Playlist;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.playlists.CreatePlaylistRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;

@Controller
public class TrotController {

	@Autowired
	private SpotifyApi spotifyApi;

	@GetMapping("/result_trot")
	public String getUserPlaylists(Model model, HttpSession session) {
		// 사용자의 Access Token을 세션에서 가져옴
		String accessToken = (String) session.getAttribute("accessToken");
		

		if (accessToken != null) {
			try {
				spotifyApi.setAccessToken(accessToken);

				final GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
						.getListOfCurrentUsersPlaylists().limit(10).build();

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

		return "/result/result_trot";
	}


	@PostMapping("/addPlaylist")
	 public String addPlaylist(Model model, HttpSession session, @RequestParam String playlistName) {
        String accessToken = (String) session.getAttribute("accessToken");
        
        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);

                final GetCurrentUsersProfileRequest profileRequest = spotifyApi.getCurrentUsersProfile().build();
                final CompletableFuture<User> privateUserFuture = profileRequest.executeAsync();
                User privateUser = privateUserFuture.join();
                String userId = privateUser.getId();

                final CreatePlaylistRequest createPlaylistRequest = spotifyApi.createPlaylist(userId, playlistName)
                        .public_(false)
                        .build();

                final CompletableFuture<Playlist> playlistFuture = createPlaylistRequest.executeAsync();
                Playlist newPlaylist = playlistFuture.join();

                model.addAttribute("message", "Playlist added successfully: " + newPlaylist.getName());
            } catch (Exception e) {
                e.printStackTrace();
                model.addAttribute("error", "Error adding playlist");
            }
        } else {
            return "redirect:/login";
        }

	    return "/result/result_trot";
	}

}