package com.music.mute.api;

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

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Album;
import se.michaelthelin.spotify.model_objects.specification.AlbumSimplified;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest;
import se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;

@Controller
public class ZaGenreRecommendationController {

	@Autowired
	private SpotifyApi spotifyApi;

	@GetMapping("/zarecommendations")
	public String getGenreRecommendations(Model model, HttpSession session) {
		// 사용자의 Access Token을 세션에서 가져옴
		String accessToken = (String) session.getAttribute("accessToken");
		List<TrackWithImageUrl> recommendationsList = new ArrayList<>();
		if (accessToken != null) {
			try {
				spotifyApi.setAccessToken(accessToken);

				// 사용자의 플레이리스트 목록 가져오기 (예시)
				final GetListOfCurrentUsersPlaylistsRequest playlistsRequest = spotifyApi
						.getListOfCurrentUsersPlaylists().limit(10).build();

				final CompletableFuture<Paging<PlaylistSimplified>> playlistsFuture = playlistsRequest.executeAsync();
				PlaylistSimplified[] playlists = playlistsFuture.join().getItems();

				// 특정 플레이리스트의 장르를 기반으로 음악 추천 받기 (예시)
				String playlistId = playlists[0].getId(); // 첫 번째 플레이리스트 사용 (예시)
				final GetRecommendationsRequest recommendationsRequest = spotifyApi.getRecommendations()
						.seed_genres("pop") // 원하는 장르를 나열
						.limit(3).build();

				final CompletableFuture<Recommendations> recommendationsFuture = recommendationsRequest.executeAsync();
				Track[] recommendations = recommendationsFuture.join().getTracks();

				// 추천된 트랙 목록에 앨범 커버 이미지 URL 추가
				for (Track track : recommendations) {
					String trackAlbumId = getAlbumId(track.getId(), accessToken);
					String coverImageUrl = getAlbumCoverImageUrl(trackAlbumId, accessToken);
					// TrackWithImageUrl 객체를 생성합니다.
					TrackWithImageUrl newTrack = new TrackWithImageUrl(track, coverImageUrl);

					recommendationsList.add(newTrack);

				}

				model.addAttribute("recommendations", recommendations);
				model.addAttribute("recommendationsList", recommendationsList);

			} catch (Exception e) {
				// 예외 처리: 사용자에게 친화적인 메시지 표시
				model.addAttribute("error", "음악 추천을 가져오는 중에 오류가 발생했습니다.");
				return "/errorPage"; // 예시: 오류 페이지로 리다이렉트
			}
		} else {
			// Access Token이 없는 경우, 로그인 페이지로 리다이렉트 또는 에러 처리
			return "redirect:/login"; // 예시: 로그인 페이지로 리다이렉트
		}

		return "/zarecommendations";
	}

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