package com.music.mute.result;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import javax.servlet.http.HttpSession;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.music.mute.api.TrackWithImageUrlVO;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Album;
import se.michaelthelin.spotify.model_objects.specification.AlbumSimplified;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.Playlist;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest;
import se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
import se.michaelthelin.spotify.requests.data.playlists.CreatePlaylistRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;

@Controller
public class TechnoController {

	@Autowired
	private SpotifyApi spotifyApi;

	@GetMapping("/result_techno")
	public String getResultTrot(Model model, HttpSession session) {
		String accessToken = (String) session.getAttribute("accessToken");
        List<TrackWithImageUrlVO> recommendationsList = new ArrayList<>();
        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);
                GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
                        .getListOfCurrentUsersPlaylists()
                        .limit(10)
                        .build();
                CompletableFuture<Paging<PlaylistSimplified>> playlistsFuture = playlistsRequest.executeAsync();
                PlaylistSimplified[] playlists = playlistsFuture.join().getItems();

                model.addAttribute("playlists", playlists);
                
                String playlistId = playlists[0].getId();
                GetRecommendationsRequest recommendationsRequest = spotifyApi
                        .getRecommendations()
                        .seed_genres("techno")
                        .limit(3)
                        .build();
                CompletableFuture<Recommendations> recommendationsFuture = recommendationsRequest.executeAsync();
                Track[] recommendations = recommendationsFuture.join().getTracks();

                for (Track track : recommendations) {
                    String trackAlbumId = getAlbumId(track.getId(), accessToken);
                    String coverImageUrl = getAlbumCoverImageUrl(trackAlbumId, accessToken);
                    TrackWithImageUrlVO newTrack = new TrackWithImageUrlVO(track, coverImageUrl);
                    recommendationsList.add(newTrack);
                }
                
                model.addAttribute("recommendations", recommendations);
				model.addAttribute("recommendationsList", recommendationsList);

                // 추가: 메서드가 호출되었음을 로깅
                System.out.println("getGenreRecommendations 메서드가 호출되었습니다.");
                
            } catch (Exception e) {
            	System.out.println("hi"+e);
                model.addAttribute("error", "음악 추천을 가져오는 중에 오류가 발생했습니다.");
                return "/errorPage";
            }
        } else {
            return "redirect:/login";
        }
	    return "/result/result_techno";
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

	    return "/result/result_techno";
	}

	
	//---------------------------------------------------------------------------
	



	private String getAlbumId(String trackId, String accessToken) throws ParseException {
		try {
			// Spotify API를 초기화하고 트랙 정보를 가져옴

			SpotifyApi spotifyApi = new SpotifyApi.Builder().setAccessToken(accessToken).build();

			GetTrackRequest getTrackRequest = spotifyApi.getTrack(trackId).build();

			Track track = getTrackRequest.execute();

			// 트랙이 존재하면 앨범 ID 반환
			if (track != null) {
				AlbumSimplified album = track.getAlbum();
				if (album != null) {
					return album.getId();
				}
			}

			// 앨범 ID를 찾을 수 없는 경우 예외 처리 또는 기본 값 반환
			return "default-album-id";
		} catch (IOException | SpotifyWebApiException e) {
			// 예외 처리
			e.printStackTrace();
			return "error-album-id";
		}
	}

	private String getAlbumCoverImageUrl(String albumId, String accessToken) throws ParseException {
		try {
			// Spotify API를 초기화하고 앨범 정보를 가져옴
			SpotifyApi spotifyApi = new SpotifyApi.Builder().setAccessToken(accessToken).build();

			GetAlbumRequest getAlbumRequest = spotifyApi.getAlbum(albumId).build();

			Album album = getAlbumRequest.execute();

			// 앨범 정보에서 커버 이미지 URL을 가져옴
			if (album != null && album.getImages() != null && album.getImages().length > 0) {
				return album.getImages()[0].getUrl();
			}

			// 커버 이미지 URL을 찾을 수 없는 경우 예외 처리 또는 기본 값 반환
			return "default-cover-image-url";
		} catch (IOException | SpotifyWebApiException e) {
			// 예외 처리
			e.printStackTrace();
			return "error-cover-image-url";
		}
	}

	public class TrackWithImageUrl {
		private Track track;
		private String coverImageUrl;

		public TrackWithImageUrl(Track track, String coverImageUrl) {
			this.track = track;
			this.coverImageUrl = coverImageUrl;
		}

		public Track getTrack() {
			return track;
		}

		public void setTrack(Track track) {
			this.track = track;
		}

		public String getCoverImageUrl() {
			return coverImageUrl;
		}

		public void setCoverImageUrl(String coverImageUrl) {
			this.coverImageUrl = coverImageUrl;
		}
	}

	@PostMapping("/addTrackToPlaylist")
	@ResponseBody
	public ResponseEntity<String> addTrackToPlaylist(@RequestParam String trackId, @RequestParam String playlistId,
			HttpSession session) {
		String accessToken = (String) session.getAttribute("accessToken");

		if (accessToken != null) {
			try {
				// 트랙을 플레이리스트에 추가하는 API 요청
				String[] uris = { "spotify:track:" + trackId }; // 트랙 URI를 String 배열로 전달
				spotifyApi.addItemsToPlaylist(playlistId, uris).build().execute();

				return new ResponseEntity<>("Track added to playlist successfully", HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<>("Failed to add track to playlist", HttpStatus.INTERNAL_SERVER_ERROR);
			}
		} else {
			return new ResponseEntity<>("User not authenticated", HttpStatus.UNAUTHORIZED);
		}
	}

	
	@RequestMapping(value = "/getUserPlaylists", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<List<PlaylistSimplified>> getUserPlaylists(HttpSession session) {
		String accessToken = (String) session.getAttribute("accessToken");

		if (accessToken != null) {
			try {
				// 사용자의 플레이리스트 목록 가져오기
				final GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
						.getListOfCurrentUsersPlaylists().limit(10).build();

				final CompletableFuture<Paging<PlaylistSimplified>> playlistsFuture = playlistsRequest.executeAsync();
				List<PlaylistSimplified> playlists = Arrays.asList(playlistsFuture.join().getItems());

				// 플레이리스트 목록을 JSON 형식으로 반환
				return new ResponseEntity<>(playlists, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
		} else {
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}
	}


}