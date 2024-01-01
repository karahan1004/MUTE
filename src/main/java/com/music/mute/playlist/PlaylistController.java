package com.music.mute.playlist;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionException;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.hc.core5.http.HttpStatus;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.expression.ParseException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.music.mute.api.SpotifyPlaybackService;

import lombok.extern.log4j.Log4j;
import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.miscellaneous.CurrentlyPlayingContext;
import se.michaelthelin.spotify.model_objects.miscellaneous.Device;
import se.michaelthelin.spotify.model_objects.special.SnapshotResult;
import se.michaelthelin.spotify.model_objects.specification.Album;
import se.michaelthelin.spotify.model_objects.specification.AlbumSimplified;
import se.michaelthelin.spotify.model_objects.specification.ArtistSimplified;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.Playlist;
import se.michaelthelin.spotify.model_objects.specification.PlaylistTrack;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.model_objects.specification.TrackSimplified;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumsTracksRequest;
import se.michaelthelin.spotify.requests.data.player.GetInformationAboutUsersCurrentPlaybackRequest;
import se.michaelthelin.spotify.requests.data.player.GetUsersAvailableDevicesRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetPlaylistRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetPlaylistsItemsRequest;
import se.michaelthelin.spotify.requests.data.playlists.RemoveItemsFromPlaylistRequest;
import se.michaelthelin.spotify.requests.data.search.simplified.SearchTracksRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;

@Log4j
@CrossOrigin(origins = "*")
@Controller
public class PlaylistController {
	@Autowired
	private SpotifyApi spotifyApi;
	
	@Autowired
	private SpotifyPlaybackService playbackService;
	
	private static final Logger logger = LoggerFactory.getLogger(PlaylistController.class);
	
	@GetMapping("/playlist")
	public String getPlaylisttracks(Model model, HttpSession session, Locale locale,
			@RequestParam("playlistId") String playlistId) throws org.apache.hc.core5.http.ParseException {
		if (playlistId == null) {
			// playlistId가 없을 경우에 대한 처리
			// 예: 에러 메시지를 모델에 추가하고 에러 페이지로 리다이렉트
			model.addAttribute("error", "Playlist ID is required");
			return "redirect:/errorPage"; // 에러 페이지로 리다이렉트 또는 다른 처리를 수행
		}
		System.out.println(">>>> Playlist ID: " + playlistId);
		String accessToken = (String) session.getAttribute("accessToken");
		String trackName = getPlaylistsItems_Sync(model, playlistId, session);
		if (accessToken != null) {
			try {
				spotifyApi.setAccessToken(accessToken);
				Device currentDevice = getCurrentDevice(accessToken);
				model.addAttribute("currentDevice", currentDevice);
				Playlist clickedPlaylist = getClickedPlaylistInfo(playlistId); // 메서드 이름 및 구현은 적절하게 변경되어야 합니다.
				System.out.println("getGenreRecommendations 메서드가 호출되었습니다.");
				// 클릭한 플레이리스트 정보를 Model에 추가
				model.addAttribute("playlist", clickedPlaylist);

				if (trackName == null)
					return "redirect:/emptyPage";
				Track[] tracks = getTrack(trackName);
				final GetAlbumsTracksRequest tracksRequest = spotifyApi.getAlbumsTracks(tracks[0].getAlbum().getId())
						.limit(10).build();

				final CompletableFuture<Paging<TrackSimplified>> tracksFuture = tracksRequest.executeAsync();

				tracksFuture.join().getItems();

				// model.addAttribute("tracks", tracks);
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("error", "Error fetching playlist tracks");
			}
		} else {
			return "redirect:/login";
		}
		return "playlist";
	}

	private Playlist getClickedPlaylistInfo(String playlistId) throws org.apache.hc.core5.http.ParseException {
		try {
			// GetPlaylistRequest를 사용하여 특정 플레이리스트의 정보를 가져옴
			final GetPlaylistRequest getPlaylistRequest = spotifyApi.getPlaylist(playlistId).build();
			final Playlist clickedPlaylist = getPlaylistRequest.execute();
			System.out.println("clickedPlaylist: " + clickedPlaylist);
			System.out.println("playlistname:" + clickedPlaylist.getName());

			// 가져온 플레이리스트 정보를 반환
			return clickedPlaylist;
		} catch (IOException | SpotifyWebApiException | ParseException e) {
			// 예외 처리
			e.printStackTrace();
			return null;
		}
	}

	public void getTrack_Sync(String id) throws org.apache.hc.core5.http.ParseException {
		// 앨범 트랙을 가져오기 위한 요청 작성
		GetAlbumsTracksRequest request = spotifyApi.getAlbumsTracks(id).limit(10).offset(0).build();

		try {
			// 요청 실행 및 앨범 트랙 가져오기
			Paging<TrackSimplified> trackSimplifiedPaging = request.execute();

			System.out.println("총 트랙 수: " + trackSimplifiedPaging.getTotal());

			// 플레이리스트 트랙을 반복하고 트랙 ID 출력
			for (TrackSimplified playlistTrack : trackSimplifiedPaging.getItems()) {
				String trackId = playlistTrack.getId();
				String trackName = playlistTrack.getName(); // 트랙의 이름 로깅
				System.out.println("트랙 ID: " + trackId + ", 트랙 이름: " + trackName);
			}
		} catch (IOException | SpotifyWebApiException | ParseException e) {
			System.out.println("오류: " + e.getMessage());
		}
	}

	public Track[] getTrack(String trackname) throws org.apache.hc.core5.http.ParseException {
		SearchTracksRequest request = spotifyApi.searchTracks(trackname).build();

		try {
			// Execute the request and get the search results
			Track[] tracks = request.execute().getItems();

			if (tracks.length > 0) {
				// Get the ID of the first track in the search results
				String trackId = tracks[0].getId();
				System.out.println("Track ID: " + trackId);

			} else {
				System.out.println("No tracks found.");
			}
			return tracks;
		} catch (IOException | SpotifyWebApiException | ParseException e) {
			System.err.println("Error: " + e.getMessage());
			return null;
		}

	}


	public String getPlaylistsItems_Sync(Model m, String playlistId, HttpSession session) throws org.apache.hc.core5.http.ParseException {
		try {
			final GetPlaylistsItemsRequest getPlaylistsItemsRequest = spotifyApi.getPlaylistsItems(playlistId)
					.build();
			final Paging<PlaylistTrack> playlistTrackPaging = getPlaylistsItemsRequest.execute();
			System.out.println("Total: " + playlistTrackPaging.getTotal());

			if (playlistTrackPaging.getTotal() == 0) {
				return null;
			}

			System.out.println(
					"Track's first artist: " + ((Track) playlistTrackPaging.getItems()[0].getTrack()).getArtists()[0]);
			System.out.println(
					"Track's first name : " + ((Track) playlistTrackPaging.getItems()[0].getTrack()).getName());
			m.addAttribute("trackTotal", playlistTrackPaging.getTotal());
			PlaylistTrack[] arr = playlistTrackPaging.getItems();
			String trackInfo = "";
			String trackId = "";
			String artistInfo = "";
			String albumInfo = "";
			
			List<String> trackIdList = new ArrayList<>();//트랙삭제 구현 중 추가
			for (PlaylistTrack pt : arr) {
				Track tr = (Track) pt.getTrack();// 트랙 정보
				ArtistSimplified[] artists = ((Track) pt.getTrack()).getArtists();
				trackInfo += tr.getName() + "#";
				trackId=tr.getId();
				log.info("====trackId: "+trackId);
				trackIdList.add(trackId);
				if (artists.length > 0) {
					// 가수가 한 명 이상인 경우 쉼표로 구분
					artistInfo += artists[0].getName();
				}

				for (int i = 1; i < artists.length; i++) {
					artistInfo += ", " + artists[i].getName();
				}

				artistInfo += "-";
				// artistInfo+="#";
				albumInfo += tr.getAlbum().getName() + ",";
				albumInfo += tr.getAlbum().getImages()[0].getUrl() + "#";
			}

			// playlistTrackPaging.getItems()[0].getTrack().getName()
			// 컨트롤러의 일부분
			String[] trackInfoArray = trackInfo.split("#");
			String[] artistInfoArray = artistInfo.split("-");
			String[] albumInfoArray = albumInfo.split("#");
			String[] trackIdArray = trackId.split("#");
			
			m.addAttribute("trackInfoArray", trackInfoArray);
			m.addAttribute("artistInfoArray", artistInfoArray);
			m.addAttribute("albumInfoArray", albumInfoArray);
			m.addAttribute("trackIdList", trackIdList);
			session.setAttribute("trackIdArray", trackIdArray);

			return ((Track) playlistTrackPaging.getItems()[0].getTrack()).getName();
		} catch (IOException | SpotifyWebApiException | ParseException e) {
			System.out.println("Error: " + e.getMessage());
			return null;
		}

	}
	

	@RequestMapping("/deleteTrack")
	public ResponseEntity<String> deleteTrack(
	        @RequestParam String playlistId,
	        @RequestParam String trackId,
	        HttpSession session) throws ParseException {
		log.info(">>>>>"+trackId);
	    String accessToken = (String) session.getAttribute("accessToken");
	    //log.info(trackIdArray);
	    // 트랙을 삭제하기 위한 Spotify API 요청 준비
	    String jsonString = "[{\"uri\":\"spotify:track:"+trackId+"\"}]";
        // JsonParser를 사용하여 JSON 배열을 JsonElement로 파싱
        JsonElement jsonElement = JsonParser.parseString(jsonString);
        // JsonElement를 JsonArray로 변환
        JsonArray jsonArray = jsonElement.getAsJsonArray();
        // JsonArray를 순회하면서 각 Track의 URI 값을 활용하여 요청을 보낼 수 있음
        for (JsonElement element : jsonArray) {
            JsonObject jsonObject = element.getAsJsonObject();
            System.out.println(jsonObject);
            String trackUri = jsonObject.getAsJsonPrimitive("uri").getAsString();
            System.out.println("trackUri: "+trackUri);
            // 각 Track의 URI 값을 활용하여 요청을 보내는 로직
            //sendRequest(trackUri);
        }
 
	    RemoveItemsFromPlaylistRequest removeItemsRequest = spotifyApi.removeItemsFromPlaylist(playlistId, jsonArray).build();


	    try {
	        // Spotify API를 통해 트랙 삭제 실행
	        SnapshotResult snapshotResult = removeItemsRequest.execute();
	        System.out.println("snapshotResult: "+snapshotResult);
	        // 트랙 삭제 후, 적절한 응답 반환
	        return ResponseEntity.ok("Track deleted successfully. Snapshot ID: " + snapshotResult.getSnapshotId());
	    } catch (IOException | SpotifyWebApiException | org.apache.hc.core5.http.ParseException e) {
	        // 에러가 발생하면 500 Internal Server Error 반환
	        return ResponseEntity.status(HttpStatus.SC_INTERNAL_SERVER_ERROR)
	                .body("Error deleting track: " + e.getMessage());
	    }
	}
	
	
	private Device getCurrentDevice(String accessToken) throws IOException, SpotifyWebApiException, ParseException {
		try {
			GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
					.getInformationAboutUsersCurrentPlayback().build();
			CompletableFuture<CurrentlyPlayingContext> playbackFuture = playbackRequest.executeAsync();
			CurrentlyPlayingContext playbackContext = null;
			try {
				playbackContext = playbackFuture.join();
			} catch (CompletionException e) { // 비동기 작업 중 예외 발생
				Throwable cause = e.getCause();
				if (cause instanceof IOException) {
					throw (IOException) cause;
				} else if (cause instanceof SpotifyWebApiException) {
					throw (SpotifyWebApiException) cause;
				} else if (cause instanceof ParseException) {
					throw (ParseException) cause;
				} else { // 다른 예외 처리 throw e;
				}
			}
			if (playbackContext != null)
				return playbackContext.getDevice();
			else
				return null;
		} catch (IOException | SpotifyWebApiException | ParseException e) {
			e.printStackTrace();
			// 예외를 다시 던져서 상위에서 처리하도록 함
			throw e;
		}
	}

	@ExceptionHandler(Exception.class)
	public String handleException(Exception e, Model model) {
		e.printStackTrace();
		model.addAttribute("error", "알 수 없는 오류가 발생했습니다: " + e.getMessage());
		return "/errorPage";
	}
	
	
	@GetMapping("/play/{trackId}")
	public String playTrack(@PathVariable String trackId, HttpSession session) {
		log.info(">>>>>2:"+trackId);
		System.out.println("Received trackId: " + trackId);
		try {
			String accessToken = (String) session.getAttribute("accessToken");
			if (accessToken != null) {
				// 현재 사용자의 활성 디바이스 ID 가져오기
				GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
						.getInformationAboutUsersCurrentPlayback().build();
				CompletableFuture<CurrentlyPlayingContext> playbackFuture = playbackRequest.executeAsync();
				CurrentlyPlayingContext playbackContext = playbackFuture.join();
				Device currentDevice = playbackContext.getDevice();
				String deviceId = (currentDevice != null) ? currentDevice.getId() : null;
				session.setAttribute("deviceId", deviceId);
				System.out.println("trackId:"+trackId);
				System.out.println("device: " + deviceId);
				// 노래 재생 시 디바이스 ID 사용
				if (deviceId != null) {
					playbackService.startOrResumePlayback(accessToken, "spotify:track:" + trackId, deviceId);
					System.out.println("Play track: " + trackId);
				} else {
					System.out.println("No active device found.");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/playlist";
	}
	
	@GetMapping("/pause")
	public String pausePlayback(@PathVariable String trackId, HttpSession session) {
	    try {
	        String accessToken = (String) session.getAttribute("accessToken");
	        if (accessToken != null) {
	            // 현재 사용자의 활성 디바이스 ID 가져오기
	            GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
	                    .getInformationAboutUsersCurrentPlayback().build();
	            CompletableFuture<CurrentlyPlayingContext> playbackFuture = playbackRequest.executeAsync();
	            CurrentlyPlayingContext playbackContext = playbackFuture.join();
	            Device currentDevice = playbackContext.getDevice();
	            String deviceId = (currentDevice != null) ? currentDevice.getId() : null;
	            // 세션에 저장된 액세스 토큰 및 디바이스 ID를 사용하여 pausePlayback 호출
	            playbackService.pausePlayback(accessToken, deviceId);
	            System.out.println("Pause playback for track " + trackId);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return "redirect:/track";
	}
	
	@GetMapping("/previous")
	public String playPreviousTrack(HttpSession session) throws ParseException {
		String accessToken = (String) session.getAttribute("accessToken");
		if (accessToken != null) {
			playbackService.playPreviousTrack(accessToken);
		}
		return "redirect:/playlist";
	}
	@GetMapping("/next")
	public String playNextTrack(HttpSession session) throws ParseException {
		String accessToken = (String) session.getAttribute("accessToken");
		if (accessToken != null) {
			playbackService.playNextTrack(accessToken);
		}
		return "redirect:/playlist";
	}
	
	@GetMapping("/devices/{trackId}")
    public String getDevices(@PathVariable String trackId, Model model, HttpSession session) {
        String accessToken = (String) session.getAttribute("accessToken");
        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);
                GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
                        .getInformationAboutUsersCurrentPlayback().build();
                CompletableFuture<CurrentlyPlayingContext> playbackFuture = playbackRequest.executeAsync();
                CurrentlyPlayingContext playbackContext = playbackFuture.join();
                // 현재 재생 중인 기기 가져오기
                Device currentDevice = playbackContext.getDevice();
                model.addAttribute("currentDevice", currentDevice);
                session.setAttribute("currentDevice", currentDevice);
                // 추가: 모든 연결된 기기 가져오기
                GetUsersAvailableDevicesRequest devicesRequest = spotifyApi.getUsersAvailableDevices().build();
                CompletableFuture<Device[]> devicesFuture = devicesRequest.executeAsync();
                Device[] devices = devicesFuture.join();
                model.addAttribute("devices", Arrays.asList(devices));
                // 추가: 메서드가 호출되었음을 로깅
                System.out.println("getDevices 메서드가 호출되었습니다.");
            } catch (Exception e) {
                model.addAttribute("error", "기기 목록을 가져오는 중에 오류가 발생했습니다.");
                return "/errorPage";
            }
        } else {
            return "redirect:/login";
        }
        return "/devices/"+trackId;
    }
	
	@GetMapping("/setVolume/{volume}")
	public String setVolume(@PathVariable int volume, HttpSession session) throws ParseException {
		String accessToken = (String) session.getAttribute("accessToken");
		if (accessToken != null) {
			playbackService.setVolume(accessToken, volume);
		}
		return "redirect:/playlist";
	}
	private String getAlbumId(String trackId, String accessToken) throws ParseException, org.apache.hc.core5.http.ParseException {
		try {
			SpotifyApi spotifyApi = new SpotifyApi.Builder().setAccessToken(accessToken).build();
			GetTrackRequest getTrackRequest = spotifyApi.getTrack(trackId).build();
			Track track = getTrackRequest.execute();
			if (track != null) {
				AlbumSimplified album = track.getAlbum();
				if (album != null) {
					return album.getId();
				}
			}
			return "default-album-id";
		} catch (IOException | SpotifyWebApiException e) {
			e.printStackTrace();
			return "error-album-id";
		}
	}
	private String getAlbumCoverImageUrl(String albumId, String accessToken) throws ParseException, org.apache.hc.core5.http.ParseException {
		try {
			SpotifyApi spotifyApi = new SpotifyApi.Builder().setAccessToken(accessToken).build();
			GetAlbumRequest getAlbumRequest = spotifyApi.getAlbum(albumId).build();
			Album album = getAlbumRequest.execute();
			if (album != null && album.getImages() != null && album.getImages().length > 0) {
				return album.getImages()[0].getUrl();
			}
			return "default-cover-image-url";
		} catch (IOException | SpotifyWebApiException e) {
			e.printStackTrace();
			return "error-cover-image-url";
		}
	}
	
	@GetMapping("/getCurrentPlayback/{userId}")
    public String getCurrentPlayback(@PathVariable String userId, Model model, HttpSession session) {
        String accessToken = (String) session.getAttribute("accessToken");
        if (accessToken != null) {
            try {
                spotifyApi.setAccessToken(accessToken);
                GetInformationAboutUsersCurrentPlaybackRequest playbackRequest = spotifyApi
                        .getInformationAboutUsersCurrentPlayback()
                        .build();
                CompletableFuture<CurrentlyPlayingContext> playbackFuture = playbackRequest.executeAsync();
                CurrentlyPlayingContext playbackContext = playbackFuture.join();

                // 현재 재생 중인 기기 가져오기
                Device currentDevice = playbackContext.getDevice();
                model.addAttribute("currentDevice", currentDevice);

                // 추가: 모든 연결된 기기 가져오기
                GetUsersAvailableDevicesRequest devicesRequest = spotifyApi
                        .getUsersAvailableDevices()
                        .build();
                CompletableFuture<Device[]> devicesFuture = devicesRequest.executeAsync();
                Device[] devices = devicesFuture.join();

                model.addAttribute("devices", Arrays.asList(devices));

                // 추가: userId를 모델에 추가
                model.addAttribute("userId", userId);

                // 추가: 메서드가 호출되었음을 로깅
                System.out.println("getCurrentPlayback 메서드가 호출되었습니다.");

            } catch (Exception e) {
                model.addAttribute("error", "현재 재생 상태를 가져오는 중에 오류가 발생했습니다.");
                return "/errorPage";
            }
        } else {
            return "redirect:/login";
        }
        return "redirect:/getCurrentPlayback/" + userId; 
    }
	
	@Configuration
	public class WebConfig implements WebMvcConfigurer {

	    @Override
	    public void addCorsMappings(CorsRegistry registry) {
	        registry.addMapping("/**")
	                .allowedOrigins("http://localhost:9089/mute")
	                .allowedMethods("GET", "POST", "PUT", "DELETE");
	    }
	}


}