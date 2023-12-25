package com.music.mute.playlist;

import java.io.IOException;
import java.util.Locale;
import java.util.concurrent.CompletableFuture;

import javax.servlet.http.HttpSession;

import org.apache.hc.core5.http.HttpStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.expression.ParseException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.special.SnapshotResult;
import se.michaelthelin.spotify.model_objects.specification.ArtistSimplified;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.Playlist;
import se.michaelthelin.spotify.model_objects.specification.PlaylistTrack;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.model_objects.specification.TrackSimplified;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumsTracksRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetPlaylistRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetPlaylistsItemsRequest;
import se.michaelthelin.spotify.requests.data.playlists.RemoveItemsFromPlaylistRequest;
import se.michaelthelin.spotify.requests.data.search.simplified.SearchTracksRequest;

@CrossOrigin(origins = "http://localhost:9089")
@Controller
public class PlaylistController {
	@Autowired
	private SpotifyApi spotifyApi;
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
		String trackName = getPlaylistsItems_Sync(model, playlistId);
		if (accessToken != null) {
			try {
				spotifyApi.setAccessToken(accessToken);

				Playlist clickedPlaylist = getClickedPlaylistInfo(playlistId); // 메서드 이름 및 구현은 적절하게 변경되어야 합니다.

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
		// Build the request to search for tracks
		// 이 부분 수정해야됩니다
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

	public String getPlaylistsItems_Sync(Model m, String playlistId) throws org.apache.hc.core5.http.ParseException {
		try {
			final GetPlaylistsItemsRequest getPlaylistsItemsRequest = spotifyApi.getPlaylistsItems(playlistId)
//			    		          .fields("description")
//			    		          .limit(10)
//			    		          .offset(0)
//			    		          .market(CountryCode.SE)
//			    		          .additionalTypes("track,episode")
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
			String artistInfo = "";
			String albumInfo = "";
			for (PlaylistTrack pt : arr) {
				Track tr = (Track) pt.getTrack();// 트랙 정보
				ArtistSimplified[] artists = ((Track) pt.getTrack()).getArtists();
				trackInfo += tr.getName() + "#";
				if (artists.length > 0) {
					// 가수가 한 명 이상인 경우 쉼표로 구분
					artistInfo += artists[0].getName();
				}

				for (int i = 1; i < artists.length; i++) {
					artistInfo += ", " + artists[i].getName();
				}
				/*
				 * for(ArtistSimplified as:tr.getArtists()) { artistInfo+=as.getName()+"-"; }
				 */
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

			m.addAttribute("trackInfoArray", trackInfoArray);
			m.addAttribute("artistInfoArray", artistInfoArray);
			m.addAttribute("albumInfoArray", albumInfoArray);

			/*
			 * m.addAttribute("trackArtist", ((Track)
			 * playlistTrackPaging.getItems()[0].getTrack()).getArtists()[0].getName());
			 * m.addAttribute("trackName", ((Track)
			 * playlistTrackPaging.getItems()[0].getTrack()).getName());
			 * m.addAttribute("trackItems", playlistTrackPaging.getItems());
			 * m.addAttribute("trackInfo", trackInfo); m.addAttribute("artistInfo",
			 * artistInfo); m.addAttribute("albumInfo", albumInfo);
			 */
			return ((Track) playlistTrackPaging.getItems()[0].getTrack()).getName();
		} catch (IOException | SpotifyWebApiException | ParseException e) {
			System.out.println("Error: " + e.getMessage());
			return null;
		}

	}
	

	@DeleteMapping("/deleteTrack")
	public ResponseEntity<String> deleteTrack(@RequestParam String playlistId, @RequestParam String trackId,
			HttpSession session) throws ParseException {

		String accessToken = (String) session.getAttribute("accessToken");

		// 트랙을 삭제하기 위한 Spotify API 요청 준비
		JsonArray tracks = JsonParser.parseString("[{\"uri\":\"spotify:track:" + trackId + "\"}]").getAsJsonArray();
		RemoveItemsFromPlaylistRequest removeItemsRequest = spotifyApi.removeItemsFromPlaylist(playlistId, tracks)
				.build();

		try {
			// Spotify API를 통해 트랙 삭제 실행
			SnapshotResult snapshotResult = removeItemsRequest.execute();

			// 트랙 삭제 후, 적절한 응답 반환
			return ResponseEntity.ok("Track deleted successfully. Snapshot ID: " + snapshotResult.getSnapshotId());
		} catch (IOException | SpotifyWebApiException | org.apache.hc.core5.http.ParseException e) {
			e.printStackTrace();

			// 에러가 발생하면 500 Internal Server Error 반환
			return ResponseEntity.status(HttpStatus.SC_INTERNAL_SERVER_ERROR)
					.body("Error deleting track: " + e.getMessage());
		}
	}
	
	@Configuration
	public class WebConfig implements WebMvcConfigurer {

	    @Override
	    public void addCorsMappings(CorsRegistry registry) {
	        registry.addMapping("/deleteTrack")
	            .allowedOrigins("http://localhost:9089")
	            .allowedMethods("DELETE")
	            .allowedHeaders("*")
	            .allowCredentials(true);
	    }
	}

}